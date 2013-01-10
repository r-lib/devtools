# Insert shim objects into a package's imports environment
#
# @param pkg A path or package object
insert_shims <- function(pkg = ".") {
  pkg <- as.package(pkg)
  assign("system.file", shim_system.file(pkg$package), pos = imports_env(pkg))
}


# This function is called with the name of the package being loaded, and returns
# a replacement function for system.file.
# @param pkg_name The name of the package loaded with load_all
shim_system.file <- function(pkg_name) {

  function(..., package = "base", lib.loc = NULL, mustWork = FALSE) {

    # If package is not the same as pkg_name, pass through to base::system.file.
    # If package is the same as the pkg_name (the package loaded with load_all)
    # search for files a bit differently.
    if (package != pkg_name) {
      base::system.file(..., package = package, lib.loc = lib.loc,
        mustWork = mustWork)

    } else {
      pkg_path <- find.package(pkg_name)

      # First look in inst/
      files_inst <- file.path(pkg_path, "inst", ...)
      present_inst <- file.exists(files_inst)

      # For any files that weren't present in inst/, look in the base path
      files_top <- file.path(pkg_path, ...)
      present_top <- file.exists(files_top)

      # Merge them together. Here are the different possible conditions, and the
      # desired result. NULL means to drop that element from the result.
      #
      # files_inst:   /inst/A  /inst/B  /inst/C  /inst/D
      # present_inst:    T        T        F        F
      # files_top:      /A       /B       /C       /D
      # present_top:     T        F        T        F
      # result:       /inst/A  /inst/B    /C       NULL
      #
      files <- files_top
      files[present_inst] <- files_inst[present_inst]
      # Drop cases where not present in either location
      files <- files[present_inst | present_top]
      if (length(files) > 0) {
        # Make sure backslahses are replaced with slashes on Windows
        normalizePath(files, winslash = "/")
      } else {
        ""
      }
      # Note that the behavior isn't exactly the same as base::system.file with an
      # installed package; in that case, C and D would not be installed and so
      # would not be found. Some other files (like DESCRIPTION, data/, etc) would
      # be installed. To fully duplicate R's package-building and installation
      # behavior would be complicated, so we'll just use this simple method.
    }
  }
}
