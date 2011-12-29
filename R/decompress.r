decompress <- function(src, target = tempdir()) {
  filename <- basename(src)
  ext <- gsub("^[^.]*\\.", "", filename)
  
  if (ext == "zip") {
    expand <- unzip
  } else if (ext %in% c("tar.gz", "tgz")) {
    expand <- function(...) untar(..., compressed = "gzip")
  } else if (ext %in% c("tar.bz2", "tbz")) {
    expand <- function(...) untar(..., compressed = "bzip2")
  } else {
    stop("Don't know how to decompress files with extension ", ext, 
      call. = FALSE)
  }
  outdir <- basename(as.character(expand(src, list = TRUE)$Name[1]))
  expand(src, exdir = tempdir())
  
  file.path(target, outdir)
}
