#' @title Replace a value for a given tag on file in memory
#' @description Scan the lines and change the value for the named tag if one line has this tag, 
#'    add a line at the end if no line has this tag and return a warning if several lines
#'    matching the tag
#' @param fileStrings A vector with each string containing a line of the file
#' @param tag The tag to be searched for 
#' @param newVal The new value for the tag
#' @return The vector of strings with the new value
#' @examples
#' fakeFileStrings <- c("Hello = world","SURE\t= indeed","Hello = you")
#' 
#' expect <- warning(ReplaceTag(fakeFileStrings,"Hello","me"))
#' 
#' newFake <- ReplaceTag(fakeFileStrings,"SURE","me")
#' expect <- equal(length(newFake), length(fakeFileStrings))
#' expect <- equal(length(grep("SURE",newFake)), 1)
#' expect <- equal(length(grep("me",newFake)), 1)
#' 
#' newFake <- ReplaceTag(fakeFileStrings,"Bouh","frightened?")
#' expect <- equal(length(newFake), length(fakeFileStrings)+1)
#' expect <- equal(length(grep("Bouh",newFake)), 1)
#' expect <- equal(length(grep("frightened?",newFake)), 1)

ReplaceTag <- function(fileStrings,tag,newVal){
    iLine <- grep(paste0("^",tag,"\\>"),fileStrings)
    nLines <- length(iLine)
    if(nLines == 0){
        line <- paste0(tag,"\t= ",newVal)
        iLine <- length(fileStrings)+1
    }else if (nLines > 0){
        line <- gsub("=.*",paste0("= ",newVal),fileStrings[iLine])
        if(nLines >1){
            warning(paste0("File has",nLines,"for key",tag,"check it up manually"))
        }
    }
    fileStrings[iLine] <- line
    return(fileStrings)
}
#' Prepares the R package structure for use with doxygen
#' @description Makes a configuration file in inst/doxygen
#'     and set a few options: 
#'     \itemize{
#'        \item{EXTRACT <- ALL = YES}
#'        \item{INPUT = src/}
#'        \item{OUTPUT <- DIRECTORY = inst/doxygen/}
#'     }
#' @param rootFolder The root of the R package
#' @return NULL
#' @examples 
#' \dontrun{
#' doxumentinit()
#' }
#' @export
doxumentinit <- function(rootFolder="."){
    doxyFileName <- "Doxyfile"
    initFolder <- getwd()
    if(rootFolder != "."){
        setwd(rootFolder)
    }
    rootFileYes <- length(grep("DESCRIPTION",dir()))>0
    # prepare the doxygen folder
    doxDir <- "inst/doxygen"
    if(!file.exists(doxDir)){
        dir.create(doxDir,recursive=TRUE)
    }
    setwd(doxDir)

    # prepare the doxygen configuration file
    system(paste0("doxygen -g ",doxyFileName))
    doxyfile <- readLines("Doxyfile")
    doxyfile <- ReplaceTag(doxyfile,"EXTRACT_ALL","YES")
    doxyfile <- ReplaceTag(doxyfile,"INPUT","src/")
    doxyfile <- ReplaceTag(doxyfile,"OUTPUT_DIRECTORY","inst/doxygen/")
    cat(doxyfile,file=doxyFileName,sep="\n")
    setwd(initFolder)
    return(NULL)
}

#' devtools document function when using doxygen
#' @description Overwrites devtools::document() to include the treatment of 
#'    doxygen documentation in src/
#' @param doxygen A boolean: should doxygen be ran on documents in src?
#'     the default is TRUE if a src folder exist and FALSE if not
#' @return The value returned by devtools::document()
#' @example
#' \dontrun{
#' document()
#' @export
document <- function(doxygen=file.exists("src")){
    if(doxygen){
        doxyFileName<-"inst/doxygen/Doxyfile"
        if(!file.exists(doxyFileName)){
            doxumentinit()
        }
        system(paste("doxygen",doxyFileName))
    }
    devtools::document()
}
