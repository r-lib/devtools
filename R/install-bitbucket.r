#' Install a package directly from bitbucket
#'
#' This function is vectorised so you can install multiple packages in
#' a single command.
#'
#' @param repo repo name
#' @param username  bitbucket username
#' @seealso Bitbucket API docs:
#'   \url{https://confluence.atlassian.com/display/BITBUCKET/Use+the+Bitbucket+REST+APIs}
#' @inheritParams install_github
#' @family package installation
#' @export
#' @examples
#' \dontrun{
#' install_bitbucket("paulhiemstra")
#' install_bitbucket(c("testrepo", "testrepo2"))
#' }
install_bitbucket <- function(repo, username, ref = "master", branch = NULL,
                              auth_user = NULL, password = NULL, ...)
{
  if (!is.null(branch)) {
    warning("'branch' is deprecated. In the future, please use 'ref' instead.")
    ref <- branch
  }

  if (!is.null(password)) {
    auth <- httr::authenticate(
      user = auth_user %||% username,
      password = password,
      type = "basic")
  } else {
    auth <- list()
  }

  message("Installing bitbucket repo(s) ",
    paste(repo, ref, sep = "/", collapse = ", "),
    " from ",
    paste(username, collapse = ", "))

  url <- paste("https://bitbucket.org/", username, "/", tolower(repo), "/get/",
    ref, ".zip", sep = "")
  install_url(url, paste(ref, ".zip", sep = ""), config = auth, ...)
}
