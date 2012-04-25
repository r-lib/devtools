#' Change directory
#'
#' \code{cd} changes the current working directory similar to how a 
#' bash shell changes relative directories. 
#'
#' @param dir a string indicating the relative or absolute directory to be set.
#' If \code{dir = '..'} then the working directory is moved up the directory
#' path, otherwise the directory is moved to a lower or absolute directory. 
#' @param levels number of levels that can be moved up when \code{dir='..'}.
#' Default is to move 1 level up.
#' @export
cd <- function(dir, levels = 1){
    dir <- normalizePath(dir, winslash='/')
    if(substr(dir, 1, 1) == '/' || substr(dir, 1, 1) == '~' || substr(dir, 2, 3) == ':/'){ 
        setwd(dir)
        return(invisible())
    }    
    old <- paste(normalizePath(getwd(), winslash='/'), '/', sep = '')     
    if(dir == '..'){
        new <- old
        for(i in 1:levels){
            forward_slash <- gregexpr('/', new)[[1]]
            new <- substr(new, 1, forward_slash[length(forward_slash) - 1])            
        }        
    } else {
        new <- paste(old, dir, sep='')    
    }
    setwd(new)    
}
