source_many <- function(files, envir = parent.frame(), fileEncoding = "UTF-8") {
  stopifnot(is.character(files))
  stopifnot(is.environment(envir))

  oop <- options(
    keep.source = TRUE,
    show.error.locations = TRUE,
    topLevelEnvironment = as.environment(envir))
  on.exit(options(oop))

  for (file in files) {
    source_one(file, envir = envir, fileEncoding = fileEncoding)
  }
  invisible()
}

source_one <- function(file, envir = parent.frame(), fileEncoding = "UTF-8") {
  stopifnot(file.exists(file))
  stopifnot(is.environment(envir))

  con <- file(file, encoding = fileEncoding)
  on.exit(close(con), add = TRUE)
  lines <- readLines(con, warn = FALSE, encoding = fileEncoding)
  lines <- enc2native(lines)
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
