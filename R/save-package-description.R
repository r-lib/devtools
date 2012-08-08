#' Writes the DESCRIPTION parameters to the given package.
#' @param path to the package
#' @param description names vector of description values
#' @export
save_package_description <- function(path, description) {

  fields <- names(description)

  description.matrix <-
    matrix(description, ncol=length(fields),dimnames=list(NULL,fields))
  write.dcf(x=description.matrix, file=file.path(path, 'DESCRIPTION'))

}
