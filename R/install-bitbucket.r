#' Install a package directly from bitbucket
#'
#' This function is vectorised so you can install multiple packages in
#' a single command.
#'
#' @param username  bitbucket username
#' @inheritParams install_github
#' @family package installation
#' @export
#' @examples
#' \dontrun{
#' install_bitbucket("paulhiemstra")
#' install_bitbucket(c("testrepo", "testrepo2")
#' }
#'
install_bitbucket <- function(repo, username, branch = "master", ...)
{
  message("Installing bitbucket repo(s) ",
    paste(repo, branch, sep = "/", collapse = ", "),
    " from ",
    paste(username, collapse = ", "))

  url <- paste("https://bitbucket.org/", username, "/", repo, "/get/", 
    branch, ".zip", sep = "")
  install_url(url, paste(branch, ".zip", sep = ""), ...)
}
