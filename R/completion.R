install_github_completer <- function(env) {
  if (!(
      completeme::current_function(env) == "install_github" &&
        completeme::inside_quotes(env) &&
        (completeme::is_first_argument(env) ||
          completeme::current_argument(env) == "repo"))) {
    return()
  }

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
