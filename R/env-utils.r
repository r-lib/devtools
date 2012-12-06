# Copy all objects from one environment to another.
#
# Returns the destination environment
#
# @param dest Destination environment. If not specified, create a new
#   environment.
# @param ignore Names of objects that should not be copied.
copy_env <- function(src, dest = new.env(parent = emptyenv()),
  ignore = NULL) {

  srclist <- as.list(src, all.names = TRUE)
  srclist <- srclist[ !(names(srclist) %in% ignore) ]
  list2env(srclist, envir = dest)

  dest
}
