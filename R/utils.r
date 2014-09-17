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

rule <- function(...) {
  title <- paste0(...)
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
  whisker::whisker.render(template, data)
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

dots <- function(...) {
  eval(substitute(alist(...)))
}

first_upper <- function(x) {
  substr(x, 1, 1) <- toupper(substr(x, 1, 1))
  x
}

download <- function(path, url, ...) {
  request <- httr::GET(url, ...)
  httr::stop_for_status(request)
  writeBin(httr::content(request, "raw"), path)
  path
}

last <- function(x) x[length(x)]

# Modified version of utils::file_ext. Instead of always returning the text
# after the last '.', as in "foo.tar.gz" => ".gz", if the text that directly
# precedes the last '.' is ".tar", it will include also, so
# "foo.tar.gz" => ".tar.gz"
file_ext <- function (x) {
    pos <- regexpr("\\.((tar\\.)?[[:alnum:]]+)$", x)
    ifelse(pos > -1L, substring(x, pos + 1L), "")
}
