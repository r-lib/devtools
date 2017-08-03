#' @details
#' Instead of the use_xyz functions from devtools use \link[pkg:usethis]{use_testthat}.
#' @rdname devtools-deprecated
#' @export
use_testthat <- function(..., pkg = ".") {
  .Deprecated("usethis::use_testthat()", package = "devtools")
  usethis::use_testthat(..., base_path = pkg)
}

#' @rdname devtools-deprecated
#' @export
use_test <- function(..., pkg = ".") {
  .Deprecated("usethis::use_test()", package = "devtools")
  usethis::use_test(..., base_path = pkg)
}

#' @rdname devtools-deprecated
#' @export
use_rstudio <- function(..., pkg = ".") {
  .Deprecated("usethis::use_rstudio()", package = "devtools")
  usethis::use_rstudio(..., base_path = pkg)
}

#' @rdname devtools-deprecated
#' @export
use_vignette <- function(..., pkg = ".") {
  .Deprecated("usethis::use_vignette()", package = "devtools")
  usethis::use_vignette(..., base_path = pkg)
}

#' @rdname devtools-deprecated
#' @export
use_rcpp <- function(..., pkg = ".") {
  .Deprecated("usethis::use_rcpp()", package = "devtools")
  usethis::use_rcpp(..., base_path = pkg)
}

#' @rdname devtools-deprecated
#' @export
use_travis <- function(..., pkg = ".") {
  .Deprecated("usethis::use_travis()", package = "devtools")
  usethis::use_travis(..., base_path = pkg)
}

#' @rdname devtools-deprecated
#' @export
use_coverage <- function(..., pkg = ".") {
  .Deprecated("usethis::use_coverage()", package = "devtools")
  usethis::use_coverage(..., base_path = pkg)
}

#' @rdname devtools-deprecated
#' @export
use_appveyor <- function(..., pkg = ".") {
  .Deprecated("usethis::use_appveyor()", package = "devtools")
  usethis::use_appveyor(..., base_path = pkg)
}

#' @rdname devtools-deprecated
#' @export
use_package_doc <- function(..., pkg = ".") {
  .Deprecated("usethis::use_package_doc()", package = "devtools")
  usethis::use_package_doc(..., base_path = pkg)
}

#' @rdname devtools-deprecated
#' @export
use_package <- function(..., pkg = ".") {
  .Deprecated("usethis::use_package()", package = "devtools")
  usethis::use_package(..., base_path = pkg)
}

#' @rdname devtools-deprecated
#' @export
use_data <- function(..., pkg = ".") {
  .Deprecated("usethis::use_data()", package = "devtools")
  usethis::use_data(..., base_path = pkg)
}

#' @rdname devtools-deprecated
#' @export
use_data_raw <- function(..., pkg = ".") {
  .Deprecated("usethis::use_data_raw()", package = "devtools")
  usethis::use_data_raw(..., base_path = pkg)
}

#' @rdname devtools-deprecated
#' @export
use_build_ignore <- function(..., pkg = ".") {
  .Deprecated("usethis::use_build_ignore()", package = "devtools")
  usethis::use_build_ignore(..., base_path = pkg)
}

#' @rdname devtools-deprecated
#' @export
use_readme_rmd <- function(..., pkg = ".") {
  .Deprecated("usethis::use_readme_rmd()", package = "devtools")
  usethis::use_readme_rmd(..., base_path = pkg)
}

#' @rdname devtools-deprecated
#' @export
use_readme_md <- function(..., pkg = ".") {
  .Deprecated("usethis::use_readme_md()", package = "devtools")
  usethis::use_readme_md(..., base_path = pkg)
}

#' @rdname devtools-deprecated
#' @export
use_news_md <- function(..., pkg = ".") {
  .Deprecated("usethis::use_news_md()", package = "devtools")
  usethis::use_news_md(..., base_path = pkg)
}

#' @rdname devtools-deprecated
#' @export
use_revdep <- function(..., pkg = ".") {
  .Deprecated("usethis::use_revdep()", package = "devtools")
  usethis::use_revdep(..., base_path = pkg)
}

#' @rdname devtools-deprecated
#' @export
use_cran_comments <- function(..., pkg = ".") {
  .Deprecated("usethis::use_cran_comments()", package = "devtools")
  usethis::use_cran_comments(..., base_path = pkg)
}

#' @rdname devtools-deprecated
#' @export
use_code_of_conduct <- function(..., pkg = ".") {
  .Deprecated("usethis::use_code_of_conduct()", package = "devtools")
  usethis::use_code_of_conduct(..., base_path = pkg)
}

#' @rdname devtools-deprecated
#' @export
use_cran_badge <- function(..., pkg = ".") {
  .Deprecated("usethis::use_cran_badge()", package = "devtools")
  usethis::use_cran_badge(..., base_path = pkg)
}

#' @rdname devtools-deprecated
#' @export
use_mit_license <- function(..., pkg = ".") {
  .Deprecated("usethis::use_mit_license()", package = "devtools")
  usethis::use_mit_license(..., base_path = pkg)
}

#' @rdname devtools-deprecated
#' @export
use_gpl3_license <- function(..., pkg = ".") {
  .Deprecated("usethis::use_gpl3_license()", package = "devtools")
  usethis::use_gpl3_license(..., base_path = pkg)
}

#' @rdname devtools-deprecated
#' @export
use_dev_version <- function(..., pkg = ".") {
  .Deprecated("usethis::use_dev_version()", package = "devtools")
  usethis::use_dev_version(..., base_path = pkg)
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
