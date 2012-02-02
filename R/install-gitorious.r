#' Attempts to install a package directly from gitorious.
#'
#' This function is vectorised so you can install multiple packages in 
#' a single command.
#'
#' @param project Gitorious project name
#' @param repo Repo name
#' @param branch Desired branch - defaults to \code{"master"}
#' @param ... Other arguments passed on to \code{\link{install.packages}}.
#' @export
#' @family package installation
#' @examples
#' \dontrun{
#' install_gitorious("r-mpc-package")
#' }
install_gitorious <- function(repo, project = repo, branch = "master", ...) {
  message("Installing gitorious repo(s) ", 
    paste(repo, collapse = ", "), 
    " from ", 
    paste(project, collapse = ", "))

  repo <- tolower(repo)
  project <- tolower(project)  

  url <- paste("https://gitorious.org/", project, "/", repo,
    "/archive-tarball/", branch, sep = "")
    
  install_url(url, paste(repo, ".tar.gz", sep = ""), ...)
}
