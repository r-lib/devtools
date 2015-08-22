#' Initialise a git repository.
#'
#' @param message Message to use for first commit.
#' @param pkg Path to package. See \code{\link{as.package}} for more
#'   information.
#' @family git infrastructure
#' @export
#' @examples
#' \dontrun{use_git()}
use_git <- function(message = "Initial commit", pkg = ".") {
  pkg <- as.package(pkg)

  if (uses_git(pkg$path))
    return(invisible())

  message("* Initialising repo")
  r <- git2r::init(pkg$path)

  message("* Adding .Rproj.user, .Rhistory, and .RData to .gitignore")
  add_git_ignore(pkg, c(".Rproj.user", ".Rhistory", ".RData"))

  message("* Adding files and committing")
  paths <- unlist(git2r::status(r))
  git2r::add(r, paths)
  git2r::commit(r, message)

  invisible()
}

#' Connect a local repo with GitHub.
#'
#' If the current repo does not use git, calls \code{\link{use_git}}
#' automatically. \code{\link{use_github_links}} is called to populate the
#' \code{URL} and \code{BugReports} fields of DESCRIPTION.
#'
#' @section Authentication:
#'
#'   A new GitHub repo will be created via the GitHub API, therefore you must
#'   provide a GitHub personal access token via the argument \code{auth_token},
#'   which defaults to the value of the \code{GITHUB_PAT} environment variable.
#'   Obtain a personal access token from
#'   \url{https://github.com/settings/applications}.
#'
#'   The argument \code{protocol} reflects how you wish to authenticate with
#'   GitHub for this repo in the long run. For either \code{protocol}, a remote
#'   named "origin" is created, an initial push is made using \code{auth_token}
#'   for authentication, and a remote tracking branch is set. The URL of the
#'   "origin" remote has the form
#'   \code{https://github.com/<USERNAME>/<REPO>.git} (\code{protocol = "https"})
#'   or \code{git@@github.com:<USERNAME>/<REPO>.git} (\code{protocol = "ssh"},
#'   the default). Read GitHub's help
#'   \href{https://help.github.com/articles/which-remote-url-should-i-use/}{Which
#'    remote URL should I use?} for more information.
#'
#' @inheritParams install_github
#' @inheritParams use_git
#' @param private If \code{TRUE}, creates a private repository.
#' @param protocol transfer protocol, either "ssh" (the default) or "https"
#' @family git infrastructure
#' @keywords internal
#' @export
#' @examples
#' \dontrun{
#' create("testpkg")
#' use_github(pkg = "testpkg", protocol = "https", private = TRUE)
#' }
use_github <- function(auth_token = github_pat(), private = FALSE, pkg = ".",
                       protocol = c("ssh", "https")) {
  if (is.null(auth_token)) {
    stop("GITHUB_PAT required to create new repo")
  }

  protocol <- match.arg(protocol)

  pkg <- as.package(pkg)
  use_git(pkg = pkg)

  if (uses_github(pkg$path))
    return(invisible())

  message("* Creating GitHub repository")
  create <- github_POST("user/repos", pat = auth_token, body = list(
    name = jsonlite::unbox(pkg$package),
    description = jsonlite::unbox(pkg$description),
    private = jsonlite::unbox(private)
  ))

  message("* Adding GitHub remote")
  r <- git2r::repository(pkg$path)
  ## use https universally at this point! we deal with ssh case below
  git2r::remote_add(r, "origin", create$clone_url)

  message("* Adding GitHub links to DESCRIPTION")
  suppressMessages(use_github_links(pkg$path))
  git2r::add(r, "DESCRIPTION")
  git2r::commit(r, "Add GitHub links to DESCRIPTION")

  message("* Pushing to GitHub and setting remote tracking branch")
  ## in https case, when GITHUB_PAT is passed as password,
  ## the username is immaterial, but git2r doesn't know that
  cred <- git2r::cred_env("DUMMY_EMAIL", "PAT")
  with_envvar(c("DUMMY_EMAIL" = "whatever", "PAT" = auth_token),
              git2r::push(r, "origin", "refs/heads/master", credentials = cred))
  ## now change remote URL if user requested ssh
  if(protocol == "ssh") {
    git2r::remote_remove(r, "origin") # git2r doesn't expose URL modification :(
    git2r::remote_add(r, "origin", create$ssh_url)
  }

  git2r::branch_set_upstream(git2r::head(r), "origin/master")

  invisible(NULL)
}


#' Add a git hook.
#'
#' @param hook Hook name. One of "pre-commit", "prepare-commit-msg",
#'   "commit-msg", "post-commit", "applypatch-msg", "pre-applypatch",
#'   "post-applypatch", "pre-rebase", "post-rewrite", "post-checkout",
#'   "post-merge", "pre-push", "pre-auto-gc".
#' @param script Text of script to run
#' @inheritParams use_git
#' @export
#' @family git infrastructure
#' @keywords internal
use_git_hook <- function(hook, script, pkg = ".") {
  pkg <- as.package(pkg)

  hook_dir <- file.path(pkg$path, ".git", "hooks")
  if (!file.exists(hook_dir)) {
    stop("This project doesn't use git", call. = FALSE)
  }

  hook_path <- file.path(hook_dir, hook)
  writeLines(script, hook_path)
  Sys.chmod(hook_path, "0744")
}


add_git_ignore <- function(pkg = ".", ignores) {
  pkg <- as.package(pkg)

  path <- file.path(pkg$path, ".gitignore")
  union_write(path, ignores)

  invisible(TRUE)
}

#' Add GitHub links to DESCRIPTION.
#'
#' Populates the URL and BugReports fields of DESCRIPTION with
#' \code{https://github.com/<USERNAME>/<REPO>} AND
#' \code{https://github.com/<USERNAME>/<REPO>/issues}, respectively. If package
#' does not already use GitHub (and therefore git), the above links will be used
#' quite literally.
#'
#' @inheritParams use_git
#' @family git infrastructure
#' @keywords internal
#' @export
use_github_links <- function(pkg = ".") {

  if (!uses_github(pkg)) {
    message(paste("Cannot detect that package already uses GitHub.",
                  "You might want to run use_github().",
                  "Adding the links to DESCRIPTION anyway."))
  }

  gh_info <- github_info(pkg)
  pkg <- as.package(pkg)

  desc_path <- file.path(pkg$path, "DESCRIPTION")
  desc <- read_dcf(desc_path)

  desc[["URL"]] <-
    paste("https://github.com", gh_info$username, gh_info$repo, sep = "/")
  desc[["BugReports"]] <- paste(desc[["URL"]], "issues", sep = "/")

  write_dcf(desc_path, desc)

  desc[c("URL", "BugReports")]
}
