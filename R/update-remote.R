#' @param pkgs Package names to update
#' @param force Force installation even if the git SHA1 has not changed since
#'   the previous install.
#' @param ... Other arguments passed on to \code{\link{install}}.
#' @export
update_remotes <- function(pkgs = NULL, force = FALSE, quiet = FALSE, ...) {

  if (is.null(pkgs)) {
    if (!yesno("Are you sure you want to update all installed packages with remotes?")) {
      pkgs <- installed.packages()[, "Package"]
    } else {
      return(invisible())
    }
  }

  remotes <- compact(lapply(pkgs, package2remote))

  if (!isTRUE(force)) {
    remotes <- Filter(function(x) different_sha(x, quiet = quiet), remotes)
  }

  # explicitly pass `force = TRUE` so we don't re-lookup the SHA1
  install_remotes(remotes, ..., force = TRUE)
}
