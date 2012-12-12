available_packages <- memoise(function(repos, type) {
  suppressWarnings(available.packages(contrib.url(repos, type)))
})

package_url <- function(package, repos, available = available.packages(contrib.url(repos, "source"))) {

  ok <- (available[, "Package"] == package)
  ok <- ok & !is.na(ok)

  vers <- package_version(available[ok, "Version"])
  keep <- vers == max(vers)
  keep[duplicated(keep)] <- FALSE
  ok[ok][!keep] <- FALSE

  name <- paste(package, "_", available[ok, "Version"], ".tar.gz", sep = "")
  url <- file.path(available[ok, "Repository"], name)

  list(name = name, url = url)
}
