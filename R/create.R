#' Create a package
#'
#' @param path A path. If it exists, it is used. If it does not exist, it is
#'   created, provided that the parent path exists.
#' @inheritParams usethis::use_description
#' @param rstudio If `TRUE`, calls [use_rstudio()] to make the new package or
#'   into an [RStudio
#'   Project](https://support.rstudio.com/hc/en-us/articles/200526207-Using-Projects).
#' @param open If `TRUE`, [activates][proj_activate()] the new project:
#'
#'   * If RStudio desktop, the package is opened in a new session.
#'   * If on RStudio server, the current RStudio project is activated.
#'   * Otherwise, the working directory and active project is changed.
#'
#' @importFrom usethis create_package
#' @return The path to the created package, invisibly.
#' @export
create <- create_package
