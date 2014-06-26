# Given the name or vector of names, returns a named vector reporting
# whether each exists and is a directory.
dir.exists <- function(x) {
  res <- file.exists(x) & file.info(x)$isdir
  setNames(res, x)
}

compact <- function(x) {
  Filter(Negate(is.null), x)
}

"%||%" <- function(a, b) if (!is.null(a)) a else b

"%:::%" <- function(p, f) {
  get(f, envir = asNamespace(p))
}

rule <- function(title = "") {
  width <- getOption("width") - nchar(title) - 1
  message(title, paste(rep("-", width, collapse = "")))
}

# check whether the specified file ends with newline
ends_with_newline <- function(path) {
  conn <- file(path, open = "rb", raw = TRUE)
  on.exit(close(conn))
  seek(conn, where = -1, origin = "end")
  lastByte <- readBin(conn, "raw", n = 1)
  lastByte == 0x0a
}

render_template <- function(name, data) {
  path <- system.file("templates", name, package = "devtools")
  template <- readLines(path)
  whisker.render(template, data)
}

is_installed <- function(pkg, version = 0) {
  system.file(package = pkg) != "" && packageVersion(pkg) > version
}

read_dcf <- function(path) {
  fields <- colnames(read.dcf(path))
  as.list(read.dcf(path, keep.white = fields)[1, ])
}

write_dcf <- function(path, desc) {
  text <- paste0(names(desc), ": ", desc, collapse = "\n")

  if (substr(text, nchar(text), 1) != "\n") {
    text <- paste0(text, "\n")
  }

  cat(text, file = path)
}
