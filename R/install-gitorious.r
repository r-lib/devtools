#' Attempts to install a package directly from gitorious.
#'
#' @param project Gitorious project name
#' @param repo Repo name
#' @param branch Desired branch - defaults to \code{"master"}
#' @export
#' @examples
#' \dontrun{
#' install_gitorious("r-mpc-package")
#' }
install_gitorious <- function(repo, project = repo, branch = "master") {
  message("Installing gitorious repo ", repo, " from ", project)

  repo <- tolower(repo)
  project <- tolower(project)  

  url <- paste("https://gitorious.org/", project, "/", repo,
    "/archive-tarball/", branch, sep = "")
    
  install_url(url, paste(repo, ".tar.gz", sep = ""))
}
