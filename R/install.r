#' Install a package.
#'
#' Uses \code{R CMD install} to install the package. Will also try to install
#' dependencies of the package from CRAN, if they're not already installed.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param reload if \code{TRUE} (the default), will automatically reload the 
#'   package after installing.
#' @export
install <- function(pkg = NULL, reload = TRUE) {
  pkg <- as.package(pkg)
  message("Installing ", pkg$package)
  install_deps(pkg)  
  
  in_dir(dirname(pkg$path), {
    system_check(paste("R CMD INSTALL ", shQuote(basename(pkg$path)), 
      sep = ""))    
  })

  if (reload) reload(pkg)
  invisible(TRUE)
}

install_deps <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  deps <- c(parse_deps(pkg$depends), parse_deps(pkg$imports), 
    parse_deps(pkg$suggests), parse_deps(pkg$enhances),
    parse_deps(pkg$linkingto))
  
  # Remove packages that are already installed
  not.installed <- function(x) length(find.package(x, quiet = TRUE)) == 0
  deps <- Filter(not.installed, deps)
  
  if (length(deps) == 0) return(invisible())
  
  message("Installing dependencies for ", pkg$package, ":\n", 
    paste(deps, collapse = ", "))
  install.packages(deps)
  invisible(deps)
}

#' Attempts to install a package directly from github.
#'
#' @param username Github username
#' @param repo Repo name
#' @export
#' @examples
#' \dontrun{
#' install_github("roxygen")
#' }
install_github <- function(repo, username = "hadley") {
  message("Installing ", repo, " from ", username)
  name <- paste(username, "-", repo, sep = "")
  url <- paste("https://github.com/", username, "/", repo, sep = "")
  
  # Download and unzip repo zip
  zip_url <- paste("https://nodeload.github.com/", username, "/", repo,
    "/zipball/master", sep = "")
  src <- file.path(tempdir(), paste(name, ".zip", sep = ""))
  download.file(zip_url, src, method = "wget", quiet = TRUE)
  on.exit(unlink(src), add = TRUE)
  
  out_path <- file.path(tempdir(), unzip(src, list = TRUE)$Name[1])
  unzip(src, exdir = tempdir())
  on.exit(unlink(out_path), add = TRUE)
  
  # Check it's an R package
  if (!file.exists(file.path(out_path, "DESCRIPTION"))) {
    stop("Does not appear to be an R package", call. = FALSE)
  }
  
  # Install
  install(out_path, reload = FALSE)
}