bitbucket_pat <- function () {
  pat <- Sys.getenv("BITBUCKET_PAT")
  if (nzchar(pat)) {
    if (!quiet) {
      message("Using Bitbucket PAT from envvar BITBUCKET_PAT")
    }
    return(pat)
  } else {
    return(NULL)
  }
}
