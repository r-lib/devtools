#' @rdname devtools-deprecated
#' @export
check_cran <- function(pkgs, libpath = file.path(tempdir(), "R-lib"),
                       srcpath = libpath, check_libpath = libpath,
                       bioconductor = FALSE,
                       type = getOption("pkgType"),
                       threads = getOption("Ncpus", 1),
                       check_dir = tempfile("check_cran"),
                       install_dir = tempfile("check_cran_install"),
                       env_vars = NULL,
                       quiet_check = TRUE) {
  .Deprecated("rcmdcheck::revdep_check()", package = "devtools")
}

parse_check_time <- function(path) {
  utils::read.table(file = path, header = FALSE)[[3]]
}
