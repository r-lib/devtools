#' Run all examples in a package.
#'
#' One of the most frustrating parts of `R CMD check` is getting all of your
#' examples to pass - whenever one fails you need to fix the problem and then
#' restart the whole process.  This function makes it a little easier by
#' making it possible to run all examples from an R function.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @keywords programming
#' @export
run_examples <- function(pkg, start = NULL) {
  pkg <- as.package(pkg)
  
  path_man <- file.path(pkg$path, "man")
  files <- dir(path_man, pattern = "\\.[Rr]d$", full = TRUE)
  names(files) <- basename(files)
  files <- sort(files)
  
  if (!is.null(start)) {
    start_pos <- which(names(files) == start)
    if (length(start_pos) == 1) {
      files <- files[- seq(1, start_pos - 1)]
    }
  }
  
  suppressWarnings(parsed <- lapply(files, tools::parse_Rd))

  extract_examples <- function(rd) {
    tags <- tools:::RdTags(rd)
    paste(unlist(rd[tags == "\\examples"]), collapse = "")
  }

  examples <- lapply(parsed, extract_examples)
  examples <- examples[examples != ""]

  message("Running ", length(examples), " examples")
  message(paste(rep("-", getOption("width"), collapse = "")))
  mapply(run_example, names(examples), examples, 
    MoreArgs = list(parent.frame()))  
}

run_example <- function(name, example, env = parent.frame()) {
  message("Checking ", name, "...")
  message(paste(rep("-", getOption("width"), collapse = "")))
  
  # Write out to temporary file to circumvent bug in source + echo = T
  tmp <- tempfile()
  on.exit(unlink(tmp))

  writeLines(example, tmp)
  source(tmp, echo = TRUE, keep.source = TRUE, max.deparse.length = Inf)
  cat("\n\n")
}

# If an error occurs, should print out the suspect line of code, and offer
# the following options:
#   * skip to the next example
#   * quit
#   * browser
#   * rerun example and rerun
#   * reload code and rerun