library(plyr)
library(tools)

run_examples <- function(path) {
  files <- dir(path, full = TRUE)

  parsed <- llply(files, parse_Rd)
  names(parsed) <- basename(files)

  extract_examples <- function(rd) {
    tags <- tools:::RdTags(rd)
    paste(unlist(rd[tags == "\\examples"]), collapse = "")
  }

  examples <- llply(parsed, extract_examples)
  m_ply(cbind(file = names(examples), example = examples), 
    function(file, example) {
      cat("Checking ", file, "...\n", sep = "")
      eval(parse(text = example))
    }
  )  
}
