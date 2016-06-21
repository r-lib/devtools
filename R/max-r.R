# Given a package object, returns the maximum version of R required by
# that package's imports.
max_R <- function(pkg) {
  max_version <- do.call("rbind", Map(function(x) parse_deps(packageDescription(x)$Depends, remove_r = FALSE), parse_deps(pkg$imports)$name))
  max_version <- max_version[max_version$name == "R", ]
  max(max_version$version)
}

# Update the minimum required version of R in the DESCRIPTION to be the
# maximum version of R required by a package's imports.
check_max_r_version <- function(pkg){
  # Find the max required version and do nothing if search is unsuccessful
  max_version <- max_R(pkg)
  if(!is.character(max_version)) return()

  # Read the DESCRIPTION
  desc_path <- file.path(pkg$path, "DESCRIPTION")
  desc <- read_dcf(desc_path)

  # Extract the R version in the DESCRIPTION and compare it to the maximum
  # version of the imports.
  old_deps <- parse_deps(desc$Depends, remove_r = FALSE)
  current_version <- old_deps[old_deps$name == "R", "version"]

  # Rewrite the DESCRIPTION if necessary, otherwise do nothing
  if(max_version > current_version) {
    old_deps[old_deps$name == "R", "version"] <- max_version
    desc$Depends <- unparse_deps(old_deps)
    write_dcf(desc_path, desc)
  }
}


