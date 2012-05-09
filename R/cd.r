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
	if(levels > 1 && dir == '..'){		
		for(i in 1:levels)
			setwd(normalizePath('..'))				
	} else setwd(normalizePath(dir))    
}
