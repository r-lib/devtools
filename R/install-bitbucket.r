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
install_bitbucket <- function(repo, username, ref = "master", branch = NULL, ...)
{
  if (!is.null(branch)) {
    warning("'branch' is deprecated. In the future, please use 'ref' instead.")
    ref <- branch
  }
  message("Installing bitbucket repo(s) ",
    paste(repo, ref, sep = "/", collapse = ", "),
    " from ",
    paste(username, collapse = ", "))

  url <- paste("https://bitbucket.org/", username, "/", repo, "/get/", 
    ref, ".zip", sep = "")
  install_url(url, paste(ref, ".zip", sep = ""), ...)
}
