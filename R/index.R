# Makes the package index, so help files and vignettes exist in development
# packages like they would for an installed package
build_package_index <- function(pkg) {

  usethis_use_directory(pkg, "Meta", ignore = TRUE)
  usethis_use_directory(pkg, "help", ignore = TRUE)
  usethis_use_directory(pkg, "html", ignore = TRUE)

  db <- tools::Rd_db(dir = pkg$path)
  names(db) <- sub("\\.[Rr]d$", "", basename(as.character(names(db))))
  ("tools" %:::% "makeLazyLoadDB")(db, file.path(pkg$path, "help", pkg$package))
  ("tools" %:::% ".writePkgIndices")(pkg$path, pkg$path)
}
