#' Attempts to install a package directly from github.
#'
#' This function is vectorised so you can install multiple packages in 
#' a single command.
#'
#' @param username Github username
#' @param repo Repo name
#' @param branch Desired branch - defaults to \code{"master"}
#' @param ... Other arguments passed on to \code{\link{install.packages}}.
#' @export
#' @family package installation
#' @examples
#' \dontrun{
#' install_github("roxygen")
#' }
install_github <- function(repo, username = "hadley", branch = "master", ...) {
  message("Installing github repo(s) ", 
    paste(repo, branch, sep = "/", collapse = ", "), 
    " from ", 
    paste(username, collapse = ", "))
  name <- paste(username, "-", repo, sep = "")
  
  url <- paste("https://github.com/", username, "/", repo,
    "/zipball/", branch, sep = "")

  install_url(url, paste(repo, ".zip", sep = ""), ...)
}
