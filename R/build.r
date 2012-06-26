#' Build package in specified directory.
#' 
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param path path in which to produce package.  If \code{NULL}, defaults to
#'   the parent directory of the package.
#' @param binary Produce a binary (\code{--binary}) or source (
#'   \code{--no-manual --no-vignettes}) version of the package.
#' @export
#' @family build functions
#' @return a string giving the location (including file name) of the built
#'  package
build <- function(pkg = NULL, path = NULL, binary = FALSE) {
  pkg <- as.package(pkg)
  if (is.null(path)) {
    path <- dirname(pkg$path)
  }
  
  if (binary) {
    cmd <- paste("CMD INSTALL ", shQuote(pkg$path), " --build", sep = "")
    ext <- if (.Platform$OS.type == "windows") "zip" else "tgz"
  } else {
    cmd <- paste("CMD build ", shQuote(pkg$path), 
      " --no-manual --no-vignettes", sep = "")
    ext <- "tar.gz"
  }
  R(cmd, path)

  targz <- paste(pkg$package, "_", pkg$version, ".", ext, sep = "")
  file.path(path, targz)
}


#' Build windows binary package.
#'
#' Works by building source package, and then uploading to
#' \url{http://win-builder.r-project.org/}.  Once building is complete you'll
#' receive a link to the built package in the email address listed in the 
#' maintainer field.  It usually takes around 30 minutes.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param version directory to upload to on the win-builder, controlling
#'   which version of R is used to build the package. Possible options are
#'   listed on \url{http://win-builder.r-project.org/}. Defaults to the 
#'   released version of R.
#' @importFrom RCurl ftpUpload
#' @export
#' @family build functions
build_win <- function(pkg = NULL, version = "R-release") {
  pkg <- as.package(pkg)
  message("Building windows version of ", pkg$package, 
    " with win-builder.org.\nCheck your email for link to package.")

  built_path <- build(pkg, tempdir())
  on.exit(unlink(built_path))
  
  ftpUpload(built_path, paste("ftp://win-builder.r-project.org/", version,
    "/", basename(built_path), sep = ""))
  invisible()
}
