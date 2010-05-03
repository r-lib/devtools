.file_cache <- character()

md5 <- function(paths) {
  unlist(llply(paths, tools::md5sum))
}

changed_files <- function(paths) {
  paths <- path.expand(paths)
  new_hash <- md5(paths)
  old_hash <- .file_cache[paths]
  
  changed <- is.na(old_hash) | new_hash != old_hash
  .file_cache[paths[changed]] <<- new_hash[changed]
  
  paths[changed]
}

clear_cache <- function() {
  .file_cache <<- character()
}