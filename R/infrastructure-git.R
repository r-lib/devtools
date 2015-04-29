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
  paths <- unlist(git2r::status(r, verbose = FALSE))
  git2r::add(r, paths)
  git2r::commit(r, message)

  invisible()
}

#' Connect a local repo with github.
#'
#' If the current repo does not use git, calls \code{use_git} automatically.
#'
#' @inheritParams install_github
#' @inheritParams use_git
#' @param private If \code{TRUE}, creates a private repository.
#' @family git infrastructure
#' @keywords internal
#' @export
use_github <- function(auth_token = github_pat(), private = FALSE, pkg = ".") {
  if (is.null(auth_token)) {
    stop("GITHUB_PAT required to create new repo")
  }

  pkg <- as.package(pkg)
  use_git(pkg = pkg)

  r <- git2r::repository(pkg$path)
  if ("origin" %in% git2r::remotes(r))
    return(invisible())

  message("Creating github repository")

  create <- github_POST("user/repos", pat = auth_token, body = list(
    name = jsonlite::unbox(pkg$package),
    description = jsonlite::unbox(pkg$description),
    private = jsonlite::unbox(private)
  ))

  message("Adding remote to github")
  git2r::remote_add(r, "origin", create$ssh_url)
  # git2r::branch_set_upstream(head(r), "origin/master")
  # git2r::push(r, "origin", "refs/heads/master")
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

