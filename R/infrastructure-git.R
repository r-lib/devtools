#' @rdname devtools-deprecated
#' @export
use_git <- function(message = "Initial commit", pkg = ".") {
  .Deprecated("usethis::use_git()", package = "devtools")
  warn_unless_current_dir(pkg)
  usethis::use_git(message = message)
}

# This is still used internally in the devtools tests
use_git_with_config <- function(message, pkg, add_user_config = FALSE, quiet = FALSE) {
  pkg <- as.package(pkg)

  if (uses_git(pkg$path)) {
    message("* Git is already initialized")
    return(invisible())
  }

  if (!quiet) {
    message("* Initialising repo")
  }
  r <- git2r::init(pkg$path)

  if (add_user_config) {
    git2r::config(r, global = FALSE, user.name = "user", user.email = "user@email.xx")
  }

  use_git_ignore(c(".Rproj.user", ".Rhistory", ".RData"), pkg = pkg, quiet = quiet)

  if (!quiet) {
    message("* Adding files and committing")
  }
  paths <- unlist(git2r::status(r))
  git2r::add(r, paths)
  git2r::commit(r, message)

  invisible()
}

#' @rdname devtools-deprecated
#' @export
use_github <- function(auth_token = github_pat(), private = FALSE, pkg = ".",
                       host = "https://api.github.com",
                       protocol = c("ssh", "https"), credentials = NULL, ...) {
  .Deprecated("usethis::use_github()", package = "devtools")
  warn_unless_current_dir(pkg)
  usethis::use_github(
    auth_token = auth_token, private = private, host = host,
    protocol = protocol, credentials = credentials, ...
  )
}

#' @rdname devtools-deprecated
#' @export
use_git_hook <- function(hook, script, pkg = ".") {
  .Deprecated("usethis::use_git_hook()", package = "devtools")
  warn_unless_current_dir(pkg)
  usethis::use_git_hook(hook = hook, script = script)
}

# This is still used internally in the devtools tests
use_git_ignore <- function(ignores, directory = ".", pkg = ".", quiet = FALSE) {
  pkg <- as.package(pkg)

  paths <- paste0("`", ignores, "`", collapse = ", ")
  if (!quiet) {
    message("* Adding ", paths, " to ", file.path(directory, ".gitignore"))
  }

  path <- file.path(pkg$path, directory, ".gitignore")
  union_write(path, ignores)

  invisible(TRUE)
}

#' @rdname devtools-deprecated
#' @export
use_github_links <- function(pkg = ".", auth_token = github_pat(),
                             host = "https://api.github.com") {
  .Deprecated("usethis::use_github_links()", package = "devtools")
  warn_unless_current_dir(pkg)
  usethis::use_github_links(auth_token = auth_token, host = host)
}
