a <- 1

# This is a wrapper for system.file
# When this package is loaded with load_all, devtools should add a
# replacement system.file function that behaves differently from
# base::system.file. When installed and loaded, this just calls
# base:system.file.
sysfile_wrap <- function(...) {
  system.file(...)
}
