record_use <- function(hook) {
  function(...) {
    h <- globalenv()$hooks
    h$events <- c(h$events, hook)
  }
}

.onLoad <-   record_use("pkg_load")
.onUnload <- record_use("pkg_unload")
.onAttach <- record_use("pkg_attach")
.onDetach <- record_use("pkg_detach")
