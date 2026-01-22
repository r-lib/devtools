#' Open bash shell in package directory
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' `bash()` is deprecated because we no longer use or recommend this workflow.
#'
#' @template devtools
#' @export
#' @keywords internal
bash <- function(pkg = ".") {
  lifecycle::deprecate_warn("2.5.0", "bash()")
  pkg <- as.package(pkg)

  withr::with_dir(pkg$path, system("bash"))
}
