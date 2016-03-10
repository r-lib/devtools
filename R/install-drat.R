#' Install a package from a \code{drat} repository
#'
#' Install packages released through a \href{https://github.com/eddelbuettel/drat}{drat} repository hosted on \code{github}.
#'
#'
#' @param repo location of the package in the form \code{[github username]/[package name]}
#' @param quiet if \code{TRUE} suppresses output from this function.
#'
#' @examples
#' \dontrun{
#'  install_drat("markvanderloo/stringdist")
#' }
#'
#' @export
install_drat <- function(repo, quiet=FALSE, ...){
  pieces <- strsplit(repo,"/")[[1]]
  remote <- drat_remote(username=pieces[1], package=pieces[2])
  install_remote(remote, quiet=quiet, ...)
}


# username: a github username
# package : name of dependency
drat_remote <- function(username, package){
  remote("drat", username=username, package=package)
}

#' @export
remote_download.drat_remote <- function(x, quiet=FALSE){
  repo <- get_drat_repo(x)
  if (!quiet) {
    message("Downloading drat package ",x$username,"/", x$package)
  }
  download.packages(x$package, destdir=tempdir(), repos = repo, type="source", quiet=quiet)[,2]
}

# get drat repo url without the side effect of drat::addRepo
#' @importFrom drat addRepo
get_drat_repo <- function(x){
  r <- getOption("repos")
  drat_repo <- drat::addRepo(x$username)
  options(repos = r)
  drat_repo
}

#' @export
remote_metadata.drat_remote <- function(x, bundle=NULL, source=NULL){
  list(
    RemoteType = "drat",
    RemoteUsername = x$username
  )
}




