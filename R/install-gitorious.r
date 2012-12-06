#' Attempts to install a package directly from gitorious.
#'
#' This function is vectorised so you can install multiple packages in
#' a single command.
#'
#' @param project Gitorious project name
#' @param repo Repo name
#' @param ref Desired git ref - defaults to \code{"master"}
#' @param subdir subdirectory within repo that contains the R package.
#' @param branch Deprecated. Use \code{ref} instead.
#' @param ... Other arguments passed on to \code{\link{install}}.
#' @export
#' @family package installation
#' @examples
#' \dontrun{
#' install_gitorious("r-mpc-package")
#' }
install_gitorious <- function(repo, project = repo, ref = "master",
  subdir = NULL, branch = NULL, ...) {

  if (!is.null(branch)) {
    warning("'branch' is deprecated. In the future, please use 'ref' instead.")
    ref <- branch
  }
  message("Installing gitorious repo(s) ",
    paste(repo, collapse = ", "),
    " from ",
    paste(project, collapse = ", "))

  repo <- tolower(repo)
  project <- tolower(project)

  url <- paste("https://gitorious.org/", project, "/", repo,
    "/archive-tarball/", ref, sep = "")

  install_url(url, paste(repo, ".tar.gz", sep = ""), subdir = subdir, ...)
}
