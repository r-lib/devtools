
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

load_all <- function(pkg, reset = FALSE) {
  pkg <- as.package(pkg)

  if (reset) {
    clear_cache()
    clear_pkg_env(pkg)
  }
  
  env <- pkg_env(pkg)
  
  load_deps(pkg)
  load_data(pkg, env)
  load_code(pkg, env)
  load_c(pkg)

  invisible()  
}


