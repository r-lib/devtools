#' Complete development session
#'
#' helps complete a session by checking if NEWS(.md), version, and date are up-to-date
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @export
complete <- function(pkg = ".") {

  pkg <- as.package(pkg)

  if (file.exists("NEWS.md")) {
    rule("Git: last commit message")
    try( print( readLines(file.path(pkg$path, ".git/COMMIT_EDITMSG"), n = 1) ) )
    rule("NEWS.md file")
    print( readLines("NEWS.md", n = 10) )
    if (yesno("Is NEWS.md file up-to-date?"))
      return(invisible())
  } else if (file.exists("NEWS")) {
    rule("Git: last commit message")
    try( print( readLines(file.path(pkg$path, ".git/COMMIT_EDITMSG"), n = 1) ) )
    rule("NEWS file")
    try(print(show_news(pkg)))
    rule("NEWS file up-to-date")
    if (yesno("Is NEWS file up-to-date?"))
      return(invisible())
  }

  rule("Version number")
  print(pkg$version)
  if (yesno("Is the version number up to date?"))
    return(invisible())

  if ( exists("date", envir = 1) & pkg$date != Sys.Date() ) {
    rule('current Date in DESCRIPTION file')
    try( print(pkg$date) )
    if(!yesno(paste("Today's date is ", Sys.Date(), ", update the DESCRIPTION file with today's date?", sep=""))) {
      desc <- readLines(file.path(pkg$path, "DEScRIPTION"))
      desc[grep("Date", desc)] <- paste("Date:", Sys.Date())
      writeLines(desc, file.path(pkg$path, "DESCRIPTION") )
    }

  }

  print("All done here! In case your repository has a remote, don't forget to push your changes there.")



}
