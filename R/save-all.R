#' Save all documents in an active IDE session.
#'
#' Helper function wrapping IDE-specific calls to save all documents in the
#' active session. In this form, callers of \code{save_all()} don't need to
#' execute any IDE-specific code. This function can be extened to include
#' other IDE implementations of their equivalent
#' \code{rstudioapi::documentSaveAll()} methods.
#' @return NULL
save_all <- function() {
  if (rstudioapi::hasFun("documentSaveAll")) {
    rstudioapi::documentSaveAll()
  }
}
