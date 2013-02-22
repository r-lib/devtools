#' Build package in specified directory.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param path path in which to produce package.  If \code{NULL}, defaults to
#'   the parent directory of the package.
#' @param binary Produce a binary (\code{--binary}) or source (
#'   \code{--no-manual --no-resave-data}) version of the package.
#' @param vignettes For source packages: if \code{FALSE}, don't build PDF
#'   vignettes (\code{--no-vignettes}).
#' @param quiet if \code{TRUE} suppresses output from this function.
#' @export
#' @family build functions
#' @return a string giving the location (including file name) of the built
#'  package
build <- function(pkg = ".", path = NULL, binary = FALSE, vignettes = TRUE,
                  quiet = FALSE) {
  pkg <- as.package(pkg)
  if (is.null(path)) {
    path <- dirname(pkg$path)
  }

  compile_rcpp_attributes(pkg)

  if (binary) {
    cmd <- paste("CMD INSTALL ", shQuote(pkg$path), " --build", sep = "")
    ext <- if (.Platform$OS.type == "windows") "zip" else "tgz"
  } else {
    args <- " --no-manual --no-resave-data"

    if (!vignettes) {
      args <- paste(args, "--no-vignettes")

    } else if (!nzchar(Sys.which("pdflatex"))) {
      message("pdflatex not found. Not building PDF vignettes.")
      args <- paste(args, "--no-vignettes")
    }

    cmd <- paste("CMD build ", shQuote(pkg$path), args, sep = "")

    ext <- "tar.gz"
  }
  R(cmd, path, quiet = quiet)

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
#' @param quiet if \code{TRUE} suppresses output from this function.
#' @importFrom RCurl ftpUpload
#' @export
#' @family build functions
build_win <- function(pkg = ".", version = "R-release", quiet = FALSE) {
  pkg <- as.package(pkg)
  if (!quiet) message("Building windows version of ", pkg$package,
    " with win-builder.r-project.org.\n")

  built_path <- build(pkg, tempdir(), quiet = quiet)
  on.exit(unlink(built_path))

  ftpUpload(built_path, paste("ftp://win-builder.r-project.org/", version,
    "/", basename(built_path), sep = ""))

  message("Check your email for a link to the built package in 30-60 mins.")
  invisible()
}
