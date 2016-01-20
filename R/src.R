has_src <- function(pkg = ".") {
  pkg <- as.package(pkg)

  src_path <- file.path(pkg$path, "src")
  file.exists(src_path)
}

