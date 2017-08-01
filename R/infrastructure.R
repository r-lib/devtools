#' Add useful infrastructure to a package.
#'
#' @param pkg package description, can be path or package name. See
#'   \code{\link{as.package}} for more information.
#' @name infrastructure
#' @family infrastructure
NULL

#' @importFrom usethis use_testthat
#' @export
usethis::use_testthat

#' @importFrom usethis use_test
#' @export
usethis::use_test

#' @export
#' @importFrom usethis use_rstudio
usethis::use_rstudio

#' @export
#' @importFrom usethis use_vignette
usethis::use_vignette

#' @export
#' @importFrom usethis use_rcpp
usethis::use_rcpp

#' @export
#' @importFrom usethis use_travis
usethis::use_travis
#' @export
#' @importFrom usethis use_coverage
usethis::use_coverage

#' @export
#' @importFrom usethis use_appveyor
usethis::use_appveyor

#' @export
#' @importFrom usethis use_package_doc
usethis::use_package_doc

#' @export
#' @importFrom usethis use_package
usethis::use_package

#' @export
#' @importFrom usethis use_data
usethis::use_data

#' @export
#' @importFrom usethis use_data_raw
usethis::use_data_raw

#' @export
#' @importFrom usethis use_build_ignore
usethis::use_build_ignore

#' @export
#' @importFrom usethis use_readme_rmd
usethis::use_readme_rmd

#' @export
#' @importFrom usethis use_readme_md
usethis::use_readme_md

#' @export
#' @importFrom usethis use_news_md
usethis::use_news_md

#' @export
#' @importFrom usethis use_revdep
usethis::use_revdep

#' @export
#' @importFrom usethis use_cran_comments
usethis::use_cran_comments

#' @export
#' @importFrom usethis use_code_of_conduct
usethis::use_code_of_conduct

#' @export
#' @importFrom usethis use_cran_badge
usethis::use_cran_badge

#' @export
#' @importFrom usethis use_mit_license
usethis::use_mit_license

#' @export
#' @importFrom usethis use_gpl3_license
usethis::use_gpl3_license

#' @export
#' @importFrom usethis use_dev_version
usethis::use_dev_version

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
