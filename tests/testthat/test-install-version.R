context("Install specific version")

local_archive <- function(x) {
  if (x == "http://cran.r-project.org")
    readRDS("archive.rds")
  else
    NULL
}
