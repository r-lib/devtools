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

