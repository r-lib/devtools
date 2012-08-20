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
