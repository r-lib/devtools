#' @title Bump build version
#' @description Increase the build version of the package on DESCRIPTION
#' @param file path and name of the description file
#' @param sep character separating major_minor.patch version from build
#' identifier
#' @param test if `FALSE`, actually change the contents of DESCRIPTION
#' @importFrom utils packageVersion
#' @examples increase_version(test=TRUE)
#' @return Textual output informing of version change plus, by default, actual
#' change on the DESCRIPTION file.
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
  reg_sep     <- paste0("\\",  sep)
  str_split   <- strsplit(str, reg_sep)[[1]]
  dev_version <- as.numeric(str_split[length(str_split)])

  # ============================================================================
  # Update build version numver
  # ============================================================================
  dev_version_updated <- dev_version + 1

  # ============================================================================
  # Reassembling new number into description
  # ============================================================================
  fixed_str         <- str_split[1:(length(str_split) - 1)]
  str_updated       <- paste(c(fixed_str, dev_version_updated), collapse = sep)
  description[line] <- str_updated

  message(
    gsub("Package: " , "", pkg), " updated from ",
    gsub(":", "", tolower(str)), " to ", gsub(":", "", tolower(str_updated))
  )
  # ============================================================================
  # Output
  # ============================================================================
  if (test) {
    message("Change not saved because test == TRUE")
  } else {
    writeLines(description, file)
  }
}
