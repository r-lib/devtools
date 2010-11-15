#' Generate checksums for a vector of file paths.
#' @keywords internal
md5 <- function(paths) {
  unlist(lapply(paths, tools::md5sum))
}

make_cache <- function() {
  .file_cache <- character()

  make <- function(paths) {
    paths <- path.expand(paths)
    new_hash <- md5(paths)
    old_hash <- .file_cache[paths]
  
    changed <- is.na(old_hash) | new_hash != old_hash
    .file_cache[paths[changed]] <<- new_hash[changed]
  
    paths[changed]
  }
  
  clear <- function() { 
    .file_cache <<- character()
  }
  
  list(make = make, clear = clear)
}
.cache <- make_cache()

#' Given vector of paths, return only those paths that have changed since the
#' last invocation.
#' @keywords internal
changed_files <- .cache$make

#' Clear file cache.
#' @keywords internal
clear_cache <- .cache$clear