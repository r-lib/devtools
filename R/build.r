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
build <- function(pkg = ".", path = NULL, binary = FALSE) {
  pkg <- as.package(pkg)
  if (is.null(path)) {
    path <- dirname(pkg$path)
  }
  
  if (binary) {
    cmd <- paste("CMD INSTALL ", shQuote(pkg$path), " --build", sep = "")
    ext <- if (.Platform$OS.type == "windows") "zip" else "tgz"
  } else {
    cmd <- paste("CMD build ", shQuote(pkg$path), 
      " --no-manual --no-vignettes --no-resave-data", sep = "")
    ext <- "tar.gz"
  }
  R(cmd, path)

  targz <- paste(pkg$package, "_", pkg$version, ".", ext, sep = "")

  check_pkg_extra_files(pkg$package, file.path(path, targz))

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
build_win <- function(pkg = ".", version = "R-release") {
  pkg <- as.package(pkg)
  message("Building windows version of ", pkg$package, 
    " with win-builder.r-project.org.\nCheck your email for link to package.")

  built_path <- build(pkg, tempdir())
  on.exit(unlink(built_path))
  
  ftpUpload(built_path, paste("ftp://win-builder.r-project.org/", version,
    "/", basename(built_path), sep = ""))
  invisible()
}


# This checks for extra files in a built package source .tar.gz file
#
# @param pkgname The name of the package
# @param pkg_targz An R source package tar.gz file
check_pkg_extra_files <- function(pkgname, pkg_targz) {
  message("devtools is checking for any extra files in built .tar.gz file... ",
    appendLF = FALSE)

  # Get unique second-level paths of all files in the tar.gz file.
  # If file is "gtable/man/gtable.Rd", second-level path is "man"
  files <- untar(pkg_targz, compressed = "gzip", list = TRUE)
  files <- sub(paste("^", pkgname, "/", sep=""), "", files)
  files <- sub("/.*$", "", files)
  files <- unique(files)

  # These are the files that are officially required in a source package,
  # according to "Writing R Extensions"
  req_files <- c("DESCRIPTION", "R", "data", "demo", "exec", "inst",
    "man", "po", "src", "tests")
  # Files that are optional in a source package, according to the doc
  opt_files <- c("INDEX", "NAMESPACE", "configure", "cleanup", "LICENSE",
    "LICENCE", "NEWS")

  # These are other common files in a source package
  other_files <- c("", "build", "CHANGELOG", "INSTALL", "README",
    "README.md")

  # Now remove all the OK paths from the list; what remains are bad paths
  files <- files[!(files %in% c(req_files, opt_files, other_files))]

  if (length(files) > 0) {
    message("\n  Non-standard files found:\n    ",
      paste(files, collapse="\n    "),
      "\n  Did you intend to include these files?\n")
  } else {
    message("OK")
  }

  invisible()
}
