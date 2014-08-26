# Decompress pkg, if needed
source_pkg <- function(path, subdir = NULL, before_install = NULL) {
  if (!file.info(path)$isdir) {
    bundle <- path
    outdir <- tempfile(pattern = "devtools")
    dir.create(outdir)

    path <- decompress(path, outdir)
  } else {
    bundle <- NULL
  }

  pkg_path <- if (is.null(subdir)) path else file.path(path, subdir)

  # Check it's an R package
  if (!file.exists(file.path(pkg_path, "DESCRIPTION"))) {
    stop("Does not appear to be an R package (no DESCRIPTION)", call. = FALSE)
  }

  # Check configure is executable if present
  config_path <- file.path(pkg_path, "configure")
  if (file.exists(config_path)) {
    Sys.chmod(config_path, "777")
  }

  # Call before_install for bundles (if provided)
  if (!is.null(bundle) && !is.null(before_install))
    before_install(bundle, pkg_path)

  pkg_path
}


decompress <- function(src, target) {
  stopifnot(file.exists(src))

  if (grepl("\\.zip$", src)) {
    my_unzip(src, target)
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
  slashes <- nchar(gsub("[^/]", "", file_list))
  if (min(slashes) == 0) return("")

  getdir(file_list[which.min(slashes)])
}

my_unzip <- function(src, target, unzip = getOption("unzip")) {
  if (unzip == "internal") {
    return(unzip(src, exdir = target))
  }

  args <- paste(
    "-oq", shQuote(src),
    "-d", shQuote(target)
  )

  system_check(unzip, args, quiet = TRUE)
}
