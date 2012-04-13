#' Change directory
#'
#' \code{cd} changes the current working directory similar to how a 
#' bash shell changes relative directories. 
#'
#' @param dir a string indicating where to change the directory to.
#' If \code{dir = '..'} then the working directory is moved up the directory
#' chain, otherwise the directory is moved to a lower directory name. If  
#' \code{dir} begins with \code{/} (unix) or contains a \code{:} (windows) 
#' then \code{setwd()} is invoked.
#' @param levels number of levels that can be moved up when \code{dir='..'}.
#' Default is to move 1 level up.
#' @export
cd <- function(dir, levels = 1){
    if(substr(dir, 1, 1) == '/' || grepl(':', dir)){ 
        setwd(dir)
    } else {
        old <- getwd()    
        if(dir == '..'){
            new <- old
            for(i in 1:levels){
                forward_slash <- gregexpr('/', new)[[1]]
                new <- substr(new, 1, forward_slash[length(forward_slash)]-1)            
            }        
        } else {            
            new <- paste(old, '/', dir, sep='')
        }    
        setwd(new)    
    }
}
