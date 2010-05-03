# Possibile specifications of package:
#   * name (look up in .Rpackages)
#   * path
#   * package object

# load_code
# load_data
# load_c
# load_dependencies

# run_examples
# run_tests
# run_benchmarks
# run_roxygen

# load_from_git?
# load_from_svn?

# Think about caching - particularly for data (tools::md5sum)
# Should everything go in it's own environment?
#   name devel::package_name
#   use sys.source
#   attach and detach

load_package <- function(path) {
  pkg <- load_pkg_description(path)
  
  load_dependecies(pkg)
  load_data(pkg)
  load_code(pkg)
  load_c(pkg)

  # Load data
  datasets <- find_data(file.path(path, "data"))
  load_data(datasets)

  # Load code
  if (is.null(desc$collate)) {
    code_paths <- find_data(file.path(path, "R"))
    code_paths <- dir(, "\\.[Rr]$", full = TRUE)  
    code_paths <- with_locale("C", sort(code_paths))
  } else {
    files <- gsub("^'|'$", "", strsplit(desc$collate, "'\\s'")[[1]])
    code_paths <- file.path(path, "R", files)
  }
  lapply(code_paths, source)

  invisible()  
}


