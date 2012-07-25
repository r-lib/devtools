#' Writes the DESCRIPTION parameters to the given package.
#' @param path to the package
#' @param description names vector of description values
#' @export
write_description <- function(path, description) {

  fields <- names(description)

  description.matrix <-
    matrix(as.vector(description), ncol=length(fields),dimnames=list(NULL,fields))
  write.dcf(description.matrix, file.path(path, 'DESCRIPTION'))

}
