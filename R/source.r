source_many <- function(files, envir = parent.frame()) {
  stopifnot(is.character(files))
  stopifnot(is.environment(envir))

  oop <- options(
    keep.source = TRUE,
    show.error.locations = TRUE,
    topLevelEnvironment = as.environment(envir))
  on.exit(options(oop))

  for (file in files) {
    source_one(file, envir = envir)
  }
  invisible()
}

source_one <- function(file, envir = parent.frame()) {
  stopifnot(file.exists(file))
  stopifnot(is.environment(envir))

  lines <- readLines(file, warn = FALSE)
  srcfile <- srcfilecopy(file, lines, file.info(file)[1, "mtime"],
    isFile = TRUE)
  exprs <- parse(text = lines, n = -1, srcfile = srcfile)

  n <- length(exprs)
  if (n == 0L) return(invisible())

  for (i in seq_len(n)) {
    eval(exprs[i], envir)
  }
  invisible()
}
