decompress <- function(src, target = tempdir()) {
  filename <- basename(src)
  
  if (grepl("\\.zip$", filename)) {
    expand <- unzip
    outdir <- function() {
      basename(as.character(expand(src, list = TRUE)$Name[1]))
    }
  } else if (grepl("\\.(tar\\.gz|tgz)$", filename)) {
    expand <- function(...) untar(..., compressed = "gzip")
    outdir <- function() expand(src, list = TRUE)[1]
  } else if (grepl("\\.(tar\\.bz2|tbz)$", filename)) {
    expand <- function(...) untar(..., compressed = "bzip2")
    outdir <- function() expand(src, list = TRUE)[1]
  } else {
    ext <- gsub("^[^.]*\\.", "", filename)
    stop("Don't know how to decompress files with extension ", ext, 
      call. = FALSE)
  }
  expand(src, exdir = tempdir())
  
  file.path(target, outdir())
}
