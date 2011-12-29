#' Attempts to install a package directly from github.
#'
#' @param username Github username
#' @param repo Repo name
#' @param branch Desired branch - defaults to \code{"master"}
#' @export
#' @importFrom RCurl getBinaryURL
#' @examples
#' \dontrun{
#' install_github("roxygen")
#' }
install_github <- function(repo, username = "hadley", branch = "master") {
  
  message("Installing github repo ", repo, " from ", username)
  name <- paste(username, "-", repo, sep = "")
  
  url <- paste("https://github.com/", username, "/", repo,
    "/zipball/master", sep = "")

  install_url(url, paste(repo, ".zip", sep = ""))  
}
