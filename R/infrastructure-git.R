#' @rdname devtools-deprecated
#' @export
use_git <- function(..., pkg = ".") {
  .Deprecated("usethis::use_git()", package = "devtools")
  usethis::use_git(..., base_path = pkg)
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
use_github <- function(..., pkg = ".") {
  .Deprecated("usethis::use_github()", package = "devtools")
  usethis::use_github(..., base_path = pkg)
}

#' @rdname devtools-deprecated
#' @export
use_git_hook <- function(..., pkg = ".") {
  .Deprecated("usethis::use_git_hook()", package = "devtools")
  usethis::use_git_hook(..., base_path = pkg)
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
use_github_links <- function(..., pkg = ".") {
  .Deprecated("usethis::use_github_links()", package = "devtools")
  usethis::use_github_links(..., base_path = pkg)
}
