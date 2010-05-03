.file_cache <- character()

#' Generate checksums for a vector of file paths
#' @keywords internal
md5 <- function(paths) {
  unlist(llply(paths, tools::md5sum))
}

#' Given vector of paths, return only those paths that have changed since the
#' last invocation.
#' @keyword internal
changed_files <- function(paths) {
  paths <- path.expand(paths)
  new_hash <- md5(paths)
  old_hash <- .file_cache[paths]
  
  changed <- is.na(old_hash) | new_hash != old_hash
  .file_cache[paths[changed]] <<- new_hash[changed]
  
  paths[changed]
}

#' Clear file cache
#' @keywords internal
clear_cache <- function() {
  .file_cache <<- character()
}