find_active_file <- function(arg = "file", call = parent.frame()) {
  if (!is_rstudio_running()) {
    cli::cli_abort(
      "Argument {.arg {arg}} is missing, with no default",
      call = call
    )
  }
  normalizePath(rstudioapi::getSourceEditorContext()$path)
}

find_test_file <- function(path, call = parent.frame()) {
  type <- test_file_type(path)
  if (any(is.na(type))) {
    file <- path_file(path[is.na(type)])
    cli::cli_abort(
      "Don't know how to find tests associated with the active file {.file {file}}",
      call = call
    )
  }

  pkg <- as.package(dirname(path))

  is_test <- type == "test"
  path[!is_test] <- paste0(
    pkg$path,
    "/tests/testthat/test-",
    name_source(path[!is_test]),
    ".R"
  )
  path <- unique(path[file_exists(path)])

  if (length(path) == 0) {
    cli::cli_abort("No test files found", call = call)
  }
  path
}

test_file_type <- function(path) {
  dir <- path_file(path_dir(path))
  name <- path_file(path)
  ext <- tolower(path_ext(path))

  src_ext <- c("c", "cc", "cpp", "cxx", "h", "hpp", "hxx")

  type <- rep(NA_character_, length(path))
  type[dir == "R" & ext == "r"] <- "R"
  type[dir == "testthat" & ext == "r" & grepl("^test", name)] <- "test"
  type[dir == "src" & ext %in% src_ext] <- "src"
  type
}

# Figure out "name" of a test or source file
name_test <- function(path) {
  gsub("^test[-_]", "", name_source(path))
}
name_source <- function(path) {
  path_ext_remove(path_file(path))
}
