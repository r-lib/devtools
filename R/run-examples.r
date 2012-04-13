#' Run all examples in a package.
#'
#' One of the most frustrating parts of `R CMD check` is getting all of your
#' examples to pass - whenever one fails you need to fix the problem and then
#' restart the whole process.  This function makes it a little easier by
#' making it possible to run all examples from an R function.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param start name of \code{Rd} file to start with - if omitted, will start
#'   with the (lexicographically) first file.  This is useful if you have a 
#'   lot of examples and don't want to rerun them every time when you fix a 
#'   problem.
#' @param strict if \code{TRUE}, the package is first installed, and then each
#'   example is run in a clean R environment somewhat mimicking what 
#'   \code{R CMD check} does.  Since this involves installing the package
#'   you should probably be in \code{\link{dev_mode}}
#' @keywords programming
#' @export
run_examples <- function(pkg = NULL, start = NULL, strict = TRUE) {
  pkg <- as.package(pkg)
  document(pkg)
  
  path_man <- file.path(pkg$path, "man")
  files <- dir(path_man, pattern = "\\.[Rr]d$", full.names = TRUE)
  names(files) <- basename(files)
  files <- sort(files)
  
  if (!is.null(start)) {
    start_pos <- which(names(files) == start)
    if (length(start_pos) == 1) {
      files <- files[- seq(1, start_pos - 1)]
    }
  }
  
  suppressWarnings(rd <- lapply(files, tools::parse_Rd))
  has_examples <- function(rd) {
    tags <- tools:::RdTags(rd)
    any(tags == "\\examples")
  }
  rd <- Filter(has_examples, rd)

  if (strict) install(pkg)

  message("Running ", length(rd), " examples in ", pkg$package)
  message(paste(rep("-", getOption("width"), collapse = "")))
  mapply(run_example, names(rd), rd, 
    MoreArgs = list(env = parent.frame(), strict = strict, pkg = pkg))  
  invisible()
}

run_example <- function(name, rd, pkg, env = parent.frame(), strict = TRUE) {
  message("Checking ", name, "...")
  message(paste(rep("-", getOption("width"), collapse = "")))
  
  # Need to write out to temporary file to circumvent bug in source + echo = T
  tmp <- tempfile()
  on.exit(unlink(tmp))

  # Use internal Rd2ex code which strips out \dontrun etc
  tools:::Rd2ex(rd, tmp)
  
  if (strict) {
    ex <- c(paste("library('", pkg$package, "')", sep = ""), readLines(tmp))
    writeLines(ex, tmp)
    clean_source(tmp)
  } else {
    source(tmp, echo = TRUE, keep.source = TRUE, max.deparse.length = Inf,
      skip.echo = 6)    
  }
  cat("\n\n")
}

# If an error occurs, should print out the suspect line of code, and offer
# the following options:
#   * skip to the next example
#   * quit
#   * browser
#   * rerun example and rerun
#   * reload code and rerun
