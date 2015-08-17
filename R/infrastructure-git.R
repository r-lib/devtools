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
#' If the current repo does not use git, calls \code{use_git} automatically.
#'
#' @inheritParams install_github
#' @inheritParams use_git
#' @param private If \code{TRUE}, creates a private repository.
#' @param protocol transfer protocol, either ssh (the default) or https
#' @family git infrastructure
#' @keywords internal
#' @export
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

  message("Creating GitHub repository")

  create <- github_POST("user/repos", pat = auth_token, body = list(
    name = jsonlite::unbox(pkg$package),
    description = jsonlite::unbox(pkg$description),
    private = jsonlite::unbox(private)
  ))

  message("Adding GitHub remote and creating a remote tracking branch")
  r <- git2r::repository(pkg$path)
  if(protocol == "ssh") {
    git2r::remote_add(r, "origin", create$ssh_url)
    cred <- git2r::cred_ssh_key("~/.ssh/id_rsa.pub", "~/.ssh/id_rsa")
  } else { # protocol == "https"
    git2r::remote_add(r, "origin", create$clone_url)
    cred <- git2r::cred_env("DUMMY_EMAIL", "GITHUB_PAT")
  }
  ## in https case, if PAT passed as password, the username is immaterial
  with_envvar(c("DUMMY_EMAIL" = "whatever"),
              git2r::push(r, "origin", "refs/heads/master", credentials = cred))
  git2r::branch_set_upstream(git2r::head(r), "origin/master")

  message("Adding GitHub links to DESCRIPTION")
  use_github_links(pkg$path)

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
#' \code{https://github.com/USERNAME/PKG} AND
#' \code{https://github.com/USERNAME/PKG/issues}, respectively. If package does
#' not already use GitHub (and therefore git), nothing will be done.
#'
#' @inheritParams use_git
#' @family git infrastructure
#' @keywords internal
#' @export
use_github_links <- function(pkg = ".") {

  if (!uses_github(pkg)) {
    message(paste("Cannot detect that package already uses GitHub.",
                  "Try use_github() first."))
    return(invisible(NULL))
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
