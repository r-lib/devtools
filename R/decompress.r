decompress <- function(src, target) {
  stopifnot(file.exists(src))

  if (grepl("\\.zip$", src)) {
    unzip(src, exdir = target, unzip = getOption("unzip"))
    outdir <- getrootdir(as.vector(unzip(src, list = TRUE)$Name))

  } else if (grepl("\\.tar$", src)) {
    untar(src, exdir = target)
    outdir <- getrootdir(untar(src, list = TRUE))

  } else if (grepl("\\.(tar\\.gz|tgz)$", src)) {
    untar(src, exdir = target, compressed = "gzip")
    outdir <- getrootdir(untar(src, compressed = "gzip", list = TRUE))

  } else if (grepl("\\.(tar\\.bz2|tbz)$", src)) {
    untar(src, exdir = target, compressed = "bzip2")
    outdir <- getrootdir(untar(src, compressed = "bzip2", list = TRUE))

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

# Given a list of files, returns the root (the topmost folder) 
# getrootdir(c("path/to/file", "path/to/other/thing")) returns "path/to"
getrootdir <- function(file_list) {
  getdir(file_list[which.min(nchar(gsub("[^/]", "", file_list)))])
}
