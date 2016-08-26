#' @export
remote_metadata.package <- function(x, bundle = NULL, source = NULL) {
  remotes:::remote_metadata(
    structure(
      list(path = x$path, subdir = NULL),
      class = c("local_remote", "remote")),
    bundle = bundle, source = source)
}
