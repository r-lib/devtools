#' @importFrom completeme return_unless current_function inside_quotes is_first_argument current_argument
install_github_completer <- function(env) {
  return_unless(
    current_function(env) == "install_github" && inside_quotes(env) &&
    (is_first_argument(env) || current_argument(env) == "repo"))

  res <- tryCatch(
    httr::content(as = "parsed", simplifyVector = TRUE,
      httr::GET("http://rpkg-api.gepuro.net/rpkg",
        httr::timeout(5), query = list(q = env$token))),
    error = function(e) NULL)

  if (length(res) == 0) {
    return()
  }

  # The query searches the description as well, so return only packages that actually contain the current token
  pkg_names <- grep(env$token, res$pkg_name, value = TRUE)
  if (length(pkg_names) > 0) {
    return(pkg_names)
  }
}
