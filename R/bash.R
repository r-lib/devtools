#' Open bash shell in package directory
#'
#' @template devtools
#' @export
bash <- function(pkg = ".") {
  pkg <- as.package(pkg)

  withr::with_dir(pkg$path, system("bash"))
}
