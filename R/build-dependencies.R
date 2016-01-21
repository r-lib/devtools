has_src <- function(pkg = ".") {
  pkg <- as.package(pkg)

  src_path <- file.path(pkg$path, "src")
  file.exists(src_path)
}

has_latex <- function() {
  nzchar(Sys.which("pdflatex"))
}

check_build_tools <- function(pkg = ".") {
  if (!has_src(pkg)) {
    return(TRUE)
  }

  # RStudio provides a dialog that can prompt the user to install the tools.
  check <- getOption("buildtools.check", NULL)
  if (!is.null(check)) {
    can_build <- check("Building R package from source")
    setup_rtools()
  } else {
    # Outside of Rstudio, check on Windows, otherwise assume they're present
    can_build <- setup_rtools()
  }

  if (!can_build) {
    stop("Could not find build tools necessary to build ", pkg$package,
      call. = FALSE)
  }
}

