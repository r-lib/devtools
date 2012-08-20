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
#' @family example functions
#' @param show if \code{TRUE}, code in \code{\\dontshow{}} will be commented
#'   out
#' @param test if \code{TRUE}, code in \code{\\donttest{}} will be commented
#'   out. If \code{FALSE}, code in \code{\\testonly{}} will be commented out.
#' @param run if \code{TRUE}, code in \code{\\donrun{}} will be commented out.
#' @keywords programming
#' @export
run_examples <- function(pkg = NULL, start = NULL, show = TRUE, test = FALSE, run = TRUE) {
  pkg <- as.package(pkg)
  load_all(pkg, reset = TRUE, export_all = FALSE)
  on.exit(load_all(pkg, reset = TRUE))
  document(pkg)
  
  path_man <- file.path(pkg$path, "man")
  files <- dir(path_man, pattern = "\\.[Rr]d$", full.names = TRUE)
  names(files) <- basename(files)
  files <- with_collate("C", sort(files)) 
  
  if (!is.null(start)) {
    start_pos <- which(names(files) == start)
    if (length(start_pos) == 1) {
      files <- files[- seq(1, start_pos - 1)]
    }
  }
  
  message("Running ", length(files), " example files in ", pkg$package)
  rule()
  lapply(files, run_example, show = show, test = test, run = run)
  
  invisible()
}
# If an error occurs, should print out the suspect line of code, and offer
# the following options:
#   * skip to the next example
#   * quit
#   * browser
#   * rerun example and rerun
#   * reload code and rerun

#' @importFrom evaluate evaluate replay
#' @importFrom tools parse_Rd
run_example <- function(path, show = TRUE, test = FALSE, run = TRUE, env = new.env(parent = globalenv())) {  
  rd <- parse_Rd(path)
  ex <- rd[rd_tags(rd) == "examples"]
  code <- process_ex(ex, show = show, test = test, run = run)
  if (is.null(code)) return()
  
  message("Running examples in ", basename(path))
  rule()  

  code <- paste(code, collapse = "")
  results <- evaluate(code, env)
  replay(results)
}

# cat(extract_example("man/reload.Rd", run = F))
# cat(extract_example("man/reload.Rd", run = T))
# cat(extract_example("man/dev_mode.Rd", test = F))
# cat(extract_example("man/dev_mode.Rd", test = T))

process_ex <- function(rd, show = TRUE, test = FALSE, run = TRUE) {
  tag <- rd_tag(rd)
  
  recurse <- function(rd) {
    unlist(lapply(rd, process_ex, show = show, test = test, run = run))
  }
  
  if (is.null(tag) || tag == "examples") {
    return(recurse(rd))
  }

  # Base case
  if (tag %in% c("RCODE", "COMMENT", "TEXT", "VERB")) {
    return(rd[[1]])
  }
  
  # Conditional execution
  if (tag %in% c("dontshow", "dontrun", "donttest", "testonly")) {
    out <- recurse(rd)
    
    if ((tag == "dontshow" && show) ||
        (tag == "dontrun" && run) ||
        (tag == "donttest" && test) ||
        (tag == "testonly" && !test)) {
      type <- paste("\n# ", toupper(tag), "\n", sep = "")
      out <- c(type, out)
      out <- gsub("\n", "\n# ", out)
    }
    return(out)
  }
  
  if (tag %in% c("dots", "ldots")) {
    return("...")
  }
  
  warning("Unknown tag ", tag, call. = FALSE)
  tag
}

#' Run a examples for an in-development function.
#'
#' @inheritParams run_examples 
#' @param topic Name or topic (or name of Rd) file to run examples for
#' @export
#' @family example functions
#' @examples
#' \dontrun{
#' # Runs installed example:
#' library("ggplot2")
#' example("ggplot")
#'
#' # Runs develoment example:
#' load_all("ggplot2")
#' dev_example("ggplot")
#' }
dev_example <- function(topic, strict = FALSE) {
  path <- find_topic(topic)
  
  if (is.null(path)) {
    stop("Can't find development example for topic ", topic, call. = FALSE)
  }
  
  pkg <- as.package(names(path)[[1]])
  load_all(pkg)
  
  run_one_example(topic, path, pkg, strict = strict)
}

# If an error occurs, should print out the suspect line of code, and offer
# the following options:
#   * skip to the next example
#   * quit
#   * browser
#   * rerun example and rerun
#   * reload code and rerun
rd_tag <- function(x) {
  tag <- attr(x, "Rd_tag")
  if (is.null(tag)) return()
  
  gsub("\\", "", tag, fixed = TRUE)
}

rd_tags <- function(x) {
  vapply(x, function(x) rd_tag(x) %||% "", character(1))
}

remove_tag <- function(x) {
  attr(x, "Rd_tag") <- NULL
  x
}
