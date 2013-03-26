#' Load R code.
#'
#' Load all R code in the \code{R} directory. The first time the code is
#' loaded, \code{.onLoad} will be run if it exists.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @keywords programming
#' @export
load_code <- function(pkg = ".") {
  pkg <- as.package(pkg)
  env <- ns_env(pkg)

  r_files <- find_code(pkg)
  paths <- changed_files(r_files)
  if (length(paths) == 0L) return()

  success <- FALSE
  cleanup <- function() {
    if (success) return()
    clear_cache()
    unload(pkg)
  }
  on.exit(cleanup())

  in_dir(file.path(pkg$path, "R"), source_many(paths, env))
  success <- TRUE

  invisible(r_files)
}

#' Parse collate string into vector of function names.
#' @keywords internal
parse_collate <- function(string) {
  con <- textConnection(string)
  on.exit(close(con))
  scan(con, "character", sep = " ", quiet = TRUE)
}

#' Find all R files in given directory.
#' @keywords internal
find_code <- function(pkg = ".") {
  path_r <- file.path(pkg$path, "R")

  code_paths <- dir(path_r, "\\.[Rrq]$", full.names = TRUE)
  r_files <- with_collate("C", sort(code_paths))

  if (!is.null(pkg$collate)) {
    collate <- file.path(path_r, parse_collate(pkg$collate))

    missing <- setdiff(collate, r_files)
    files <- function(x) paste(basename(x), collapse = ", ")
    if (length(missing) > 0) {
      message("Skipping missing files: ", files(missing))
    }
    collate <- setdiff(collate, missing)

    extra <- setdiff(r_files, collate)
    if (length(extra) > 0) {
      message("Adding files missing in collate: ", files(extra))
    }

    r_files <- union(collate, r_files)
  }
  r_files
}


source_many <- function(files, envir = parent.frame()) {
  stopifnot(is.character(files))
  stopifnot(is.environment(envir))

  oop <- options(
    keep.source = TRUE,
    show.error.locations = TRUE,
    topLevelEnvironment = as.environment(envir))
  on.exit(options(oop))

  for (file in files) {
    source_one(file, envir = envir)
  }
  invisible()
}

source_one <- function(file, envir = parent.frame()) {
  stopifnot(file.exists(file))
  stopifnot(is.environment(envir))

  lines <- readLines(file, warn = FALSE)
  srcfile <- srcfilecopy(file, lines, file.info(file)[1, "mtime"],
    isFile = TRUE)
  exprs <- parse(text = lines, n = -1)

  n <- length(exprs)
  if (n == 0L) return(invisible())

  for (i in seq_len(n)) {
    eval(exprs[i], envir)
  }
  invisible()
}
