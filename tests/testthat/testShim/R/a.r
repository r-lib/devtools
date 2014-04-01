a <- 1

# When this package is loaded with load_all, devtools should add a
# replacement system.file function.
# When the package is loaded with load_all, this returns devtools::system.file
# When installed and loaded, this returns base:system.file.
get_system.file <- function(...) {
  system.file
}
