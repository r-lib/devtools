a <- 1
b <- 1
c <- 1

.onLoad <- function(lib, pkg) {
  a <<- a + 1
}

.onAttach <- function(lib, pkg) {
  # Attempt to modify b in namespace. This should throw an error
  # in a real install+load because namespace is locked. But with
  # load_all, it will work because the namespace doesn't get locked.
  try(b <<- b + 1, silent = TRUE)

  # Now modify c in package environment
  env <- as.environment("package:loadhooks")
  env$c <- env$c + 1
}

.onUnload <- function(libpath) {
  # Increment this variable if it exists in the global env
  if (exists(".__loadhooks__", .GlobalEnv)) {
    .GlobalEnv$.__loadhooks__ <- .GlobalEnv$.__loadhooks__ + 1
  }
}
