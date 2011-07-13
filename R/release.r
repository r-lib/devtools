#' Release package to CRAN.
#'
#' Run automated and manual tests, then ftp to CRAN.
#'
#' The package release process will:
#'
#' \itemize{
#'
#'   \item Confirm that the package passes \code{R CMD check}
#'   \item Confirm that news is up-to-date
#'   \item Confirm that DESCRIPTION is ok
#'   \item Build the package
#'   \item Upload the pakcage to CRAN
#'   \item Draft an email to the CRAN maintainer.
#' }
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param check if \code{TRUE}, run checking, otherwise omit it.  This
#'   is useful if you've just checked your package and you're ready to
#'   release it.
#' @export
#' @importFrom RCurl ftpUpload
release <- function(pkg = NULL, check = TRUE) {
  pkg <- as.package(pkg)

  if (check) {
    check(pkg)
    cat("Was package check successful?")
    if(menu(c("Yes", "No")) == 2) return(invisible())    
  }
  
  try(print(show_news(pkg)))
  cat("Is package news up-to-date?")
  if(menu(c("Yes", "No")) == 2) return(invisible())
  
  cat(readLines(file.path(pkg$path, "DESCRIPTION")), sep = "\n")
  cat("Is DESCRIPTION up-to-date?")
  if(menu(c("Yes", "No")) == 2) return(invisible())
  
  message("Building and uploading")
  built_path <- build(pkg, tempdir())

  ftpUpload(built_path, paste("ftp://cran.R-project.org/incoming/",
    basename(built_path), sep = ""))
  
  message("Preparing email")
  msg <- paste(
    "Dear Kurt,\n",
    "\n",
    "I have just uploaded a new version of ", pkg$package, " to CRAN.\n",
    "\n",
    "Thanks!\n",
    "INSERT YOUR NAME", "\n\n\n", sep = "")
  subject <- paste("CRAN upload: ", pkg$package, " ", pkg$version, sep = "")
  create.post(msg, subject = subject, address = "cran@r-project.org")
  
  invisible(TRUE)
}  
