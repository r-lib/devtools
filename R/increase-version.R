#' @title Bump build version
#' @description Increase the build version of the package on DESCRIPTION
#' @param file path and name of the description file
#' @param sep character separating major.minor.patch version from build
#'   identifier
#' @param test if `FALSE`, actually change the contents of DESCRIPTION
#' @importFrom utils packageVersion
#' @examples increase_version(test=TRUE)
#' @export
#'
increase_version <- function(file = "DESCRIPTION", sep = ".", test = FALSE) {
  # ============================================================================
  # Extract information
  # ============================================================================
  description <- readLines(file)
  for (line in 1:length(description)) {
    if (substr(description[line], 1, 7) == "Package") pkg <- description[line]
    if (substr(description[line], 1, 7) == "Version") {
      str <- description[line]
      break
    }
  }
  reg.sep      <- paste0("\\", sep)
  str.split   <- strsplit(str, reg.sep)[[1]]
  dev.version <- as.numeric(str.split[length(str.split)])

  # ============================================================================
  # Update build version numver
  # ============================================================================
  dev.version.updated <- dev.version + 1

  # ============================================================================
  # Reassembling new number into description
  # ============================================================================
  fixed.str   <- str.split[1:(length(str.split) - 1)]
  str.updated <- paste(c(fixed.str, dev.version.updated), collapse = sep)
  description[line] <- str.updated

  message(gsub("Package: " , "", pkg),
          " updated from ", str, " to ", str.updated)
  # ============================================================================
  # Output
  # ============================================================================
  if (test) {
    message("Change not saved because test == TRUE")
  } else {
    writeLines(description, file)
  }
}
