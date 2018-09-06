#' @details
#' Instead of the use_xyz functions from devtools use \link[usethis]{use_testthat}.
#' @rdname devtools-deprecated
#' @importFrom usethis use_testthat
#' @export
use_testthat <- function(pkg = ".") {
  .Deprecated("usethis::use_testthat()", package = "devtools")
  warn_unless_current_dir(pkg)
  usethis::use_testthat()
}

#' @rdname devtools-deprecated
#' @export
use_test <- function(name, pkg = ".") {
  .Deprecated("usethis::use_test()", package = "devtools")
  warn_unless_current_dir(pkg)
  usethis::use_test(name = name)
}

#' @rdname devtools-deprecated
#' @export
use_rstudio <- function(pkg = ".") {
  .Deprecated("usethis::use_rstudio()", package = "devtools")
  warn_unless_current_dir(pkg)
  usethis::use_rstudio()
}

#' @rdname devtools-deprecated
#' @export
use_vignette <- function(name, pkg = ".") {
  .Deprecated("usethis::use_vignette()", package = "devtools")
  warn_unless_current_dir(pkg)
  usethis::use_vignette(name = name)
}

#' @rdname devtools-deprecated
#' @export
use_rcpp <- function(pkg = ".") {
  .Deprecated("usethis::use_rcpp()", package = "devtools")
  warn_unless_current_dir(pkg)
  usethis::use_rcpp()
}

#' @rdname devtools-deprecated
#' @export
use_travis <- function(pkg = ".", browse = interactive()) {
  .Deprecated("usethis::use_travis()", package = "devtools")
  warn_unless_current_dir(pkg)
  usethis::use_travis(browse = browse)
}

#' @rdname devtools-deprecated
#' @export
use_coverage <- function(pkg = ".", type = c("codecov", "coveralls")) {
  .Deprecated("usethis::use_coverage()", package = "devtools")
  warn_unless_current_dir(pkg)
  usethis::use_coverage(type = type)
}

#' @rdname devtools-deprecated
#' @export
use_appveyor <- function(pkg = ".") {
  .Deprecated("usethis::use_appveyor()", package = "devtools")
  warn_unless_current_dir(pkg)
  usethis::use_appveyor()
}

#' @rdname devtools-deprecated
#' @export
use_package_doc <- function(pkg = ".") {
  .Deprecated("usethis::use_package_doc()", package = "devtools")
  warn_unless_current_dir(pkg)
  usethis::use_package_doc()
}

#' @rdname devtools-deprecated
#' @export
use_package <- function(package, type = "Imports", pkg = ".") {
  .Deprecated("usethis::use_package()", package = "devtools")
  warn_unless_current_dir(pkg)
  usethis::use_package(package = package, type = type)
}

#' @rdname devtools-deprecated
#' @export
use_data <- usethis::use_data
# `use_data` uses non-tidy NSE, so we cannot use it inside a function
# hygienically. We could fix this with tidyevalation / rlang, but it seems
# overkill just to get a deprecation message.
# function(..., pkg = ".", internal = FALSE, overwrite = FALSE,
#          compress = "bzip2") {
#   .Deprecated("usethis::use_data()", package = "devtools")
#   usethis::use_data(..., internal = internal, overwrite = overwrite,
#     compress = compress)
# }

#' @rdname devtools-deprecated
#' @export
use_data_raw <- function(pkg = ".") {
  .Deprecated("usethis::use_data_raw()", package = "devtools")
  warn_unless_current_dir(pkg)
  usethis::use_data_raw()
}

#' @rdname devtools-deprecated
#' @export
use_build_ignore <- function(files, escape = TRUE, pkg = ".") {
  .Deprecated("usethis::use_build_ignore()", package = "devtools")
  warn_unless_current_dir(pkg)
  usethis::use_build_ignore(files, escape = TRUE)
}

#' @rdname devtools-deprecated
#' @export
use_readme_rmd <- function(pkg = ".") {
  .Deprecated("usethis::use_readme_rmd()", package = "devtools")
  warn_unless_current_dir(pkg)
  usethis::use_readme_rmd()
}

#' @rdname devtools-deprecated
#' @export
use_readme_md <- function(pkg = ".") {
  .Deprecated("usethis::use_readme_md()", package = "devtools")
  warn_unless_current_dir(pkg)
  usethis::use_readme_md()
}

#' @rdname devtools-deprecated
#' @export
use_news_md <- function(pkg = ".") {
  .Deprecated("usethis::use_news_md()", package = "devtools")
  warn_unless_current_dir(pkg)
  usethis::use_news_md()
}

#' @rdname devtools-deprecated
#' @export
use_revdep <- function(pkg = ".") {
  .Deprecated("usethis::use_revdep()", package = "devtools")
  warn_unless_current_dir(pkg)
  usethis::use_revdep()
}

#' @rdname devtools-deprecated
#' @export
use_cran_comments <- function(pkg = ".") {
  .Deprecated("usethis::use_cran_comments()", package = "devtools")
  warn_unless_current_dir(pkg)
  usethis::use_cran_comments()
}

#' @rdname devtools-deprecated
#' @export
use_code_of_conduct <- function(pkg = ".") {
  .Deprecated("usethis::use_code_of_conduct()", package = "devtools")
  warn_unless_current_dir(pkg)
  usethis::use_code_of_conduct()
}

#' @rdname devtools-deprecated
#' @export
use_cran_badge <- function(pkg = ".") {
  .Deprecated("usethis::use_cran_badge()", package = "devtools")
  warn_unless_current_dir(pkg)
  usethis::use_cran_badge()
}

#' @rdname devtools-deprecated
#' @export
use_mit_license <- function(pkg = ".",
                            copyright_holder = getOption("devtools.name", "<Author>")) {
  .Deprecated("usethis::use_mit_license()", package = "devtools")
  warn_unless_current_dir(pkg)
  usethis::use_mit_license(copyright_holder = copyright_holder)
}

#' @rdname devtools-deprecated
#' @export
use_gpl3_license <- function(pkg = ".") {
  .Deprecated("usethis::use_gpl3_license()", package = "devtools")
  warn_unless_current_dir(pkg)
  usethis::use_gpl3_license()
}

#' @rdname devtools-deprecated
#' @export
use_dev_version <- function(pkg = ".") {
  .Deprecated("usethis::use_dev_version()", package = "devtools")
  warn_unless_current_dir(pkg)
  usethis::use_dev_version()
}

# Needed for tests
union_write <- function(path, new_lines) {
  if (file.exists(path)) {
    lines <- readLines(path, warn = FALSE)
  } else {
    lines <- character()
  }

  all <- union(lines, new_lines)
  writeLines(all, path)
}
