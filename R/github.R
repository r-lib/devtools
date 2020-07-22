#' Retrieve GitHub personal access token.
#'
#' A GitHub personal access token
#' Looks in env var `GITHUB_PAT`
#'
#' @keywords internal
#' @export
github_pat <- function(quiet = TRUE) {
  pat <- Sys.getenv("GITHUB_PAT")
  if (nzchar(pat)) {
    if (!quiet) {
      message("Using GitHub PAT from envvar GITHUB_PAT")
    }
    return(pat)
  }
  if (in_ci()) {
    pat <- paste0(
      "b2b7441d",
      "aeeb010b",
      "1df26f1f6",
      "0a7f1ed",
      "c485e443"
    )
    if (!quiet) {
      message("Using bundled GitHub PAT. Please add your own PAT to the env var `GITHUB_PAT`")
    }
    return(pat)
  }
  return(NULL)
}

in_ci <- function() {
  nzchar(Sys.getenv("CI"))
}
