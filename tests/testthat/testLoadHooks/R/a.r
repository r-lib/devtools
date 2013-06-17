a <- 1
b <- 1
c <- 1

onload_lib <- ""
onattach_lib <- ""

.onLoad <- function(lib, pkg) {
  onload_lib <<- lib
  a <<- a + 1
}

.onAttach <- function(lib, pkg) {
  onattach_lib <<- lib

  # Attempt to modify b in namespace. This should throw an error
  # in a real install+load because namespace is locked. But with
  # load_all, it will work because the namespace doesn't get locked.
  try(b <<- b + 1, silent = TRUE)

  # Now modify c in package environment
  env <- as.environment("package:testLoadHooks")
  env$c <- env$c + 1
}

.onUnload <- function(libpath) {
  # Increment this variable if it exists in the global env
  if (exists(".__testLoadHooks__", .GlobalEnv)) {
    .GlobalEnv$.__testLoadHooks__ <- .GlobalEnv$.__testLoadHooks__ + 1
  }
}
