
# load_code
# load_data
# load_c
# load_dependencies

# run_examples
# run_tests
# run_benchmarks
# make_docs

# install_package
# build_package

# Think about caching - particularly for data (tools::md5sum)
# Should everything go in it's own environment?
#   name devel::package_name
#   use sys.source
#   attach and detach

load_all <- function(pkg) {
  pkg <- as.package(pkg)
  
  load_deps(pkg)
  load_data(pkg)
  load_code(pkg)
  load_c(pkg)

  invisible()  
}


