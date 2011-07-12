os <- function() {
  os <- R.Version()$os
  if (length(grep("linux", os)) == 1) {
    "lin"
  } else if (length(grep("darwin", os)) == 1) {
    "mac"
  } else {
    "win"    
  }  
}
