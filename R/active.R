find_active_file <- function(arg = "file") {
  if (!rstudioapi::isAvailable()) {
    stop("Argument `", arg, "` is missing, with no default", call. = FALSE)
  }
  rstudioapi::getSourceEditorContext()$path
}

find_test_file <- function(file) {
  dir <- tolower(basename(dirname(file)))
  switch(dir,
    r = find_test_file_r(file),
    src = find_test_file_src(file),
    stop("Open file is not in `R/` or `src/` directories", call. = FALSE)
  )
}

find_test_file_r <- function(file) {
  if (!grepl("\\.[Rr]$", file)) {
    stop("Open file is does not end in `.R`", call. = FALSE)
  }

  file.path("tests", "testthat", paste0("test-", basename(file)))
}

src_ext <- c("c", "cc", "cpp", "cxx", "h", "hpp", "hxx")

find_test_file_src <- function(file) {
  ext <- tolower(tools::file_ext(file))
  if (!ext %in% src_ext) {
    stop(paste0(
        "Open file is does not end in a valid extension:\n",
        "* Must be one of ", paste0("`.", src_ext, "`", collapse = ", ")), call. = FALSE)
  }

  file.path("tests", "testthat", paste0("test-", basename(tools::file_path_sans_ext(file)), ".R"))
}

find_source_file <- function(file) {
  dir <- basename(dirname(file))

  if (dir != "testthat") {
    stop("Open file not in `tests/testthat/` directory", call. = FALSE)
  }

  if (!grepl("\\.[Rr]$", file)) {
    stop("Open file is does not end in `.R`", call. = FALSE)
  }

  file.path("R", gsub("^test-", "", basename(file)))
}
