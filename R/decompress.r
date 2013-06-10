decompress <- function(src, target = tempdir()) {
  stopifnot(file.exists(src))

  if (grepl("\\.zip$", src)) {
    unzip(src, exdir = target)
    outdir <- getdir(as.character(unzip(src, list = TRUE)$Name[1]))

  } else if (grepl("\\.tar$", src)) {
    untar(src, exdir = target)
    outdir <- getdir(untar(src, list = TRUE)[1])

  } else if (grepl("\\.(tar\\.gz|tgz)$", src)) {
    untar(src, exdir = target, compressed = "gzip")
    outdir <- getdir(untar(src, compressed = "gzip", list = TRUE)[1])

  } else if (grepl("\\.(tar\\.bz2|tbz)$", src)) {
    untar(src, exdir = target, compressed = "bzip2")
    outdir <- getdir(untar(src, compressed = "bzip2", list = TRUE)[1])

  } else {
    ext <- gsub("^[^.]*\\.", "", src)
    stop("Don't know how to decompress files with extension ", ext,
      call. = FALSE)
  }

  file.path(target, outdir)
}


# Returns everything before the last slash in a filename
# getdir("path/to/file") returns "path/to"
# getdir("path/to/dir/") returns "path/to/dir"
getdir <- function(path)  sub("/[^/]*$", "", path)
