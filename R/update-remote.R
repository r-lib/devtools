#' @param pkgs Package names to update
#' @param ... Other arguments passed on to \code{\link{install}}.
#' @export
update_remotes <- function(pkgs = NULL, ...) {

  if (is.null(pkgs)) {
    if (!yesno("Are you sure you want to update all installed packages with remotes?")) {
      pkgs <- installed.packages()[, "Package"]
    } else {
      return(invisible())
    }
  }

  remotes <- compact(lapply(pkgs, package2remote))

  # explicitly pass `force = TRUE` so we don't re-lookup the SHA1
  install_remotes(remotes, ...)
}
