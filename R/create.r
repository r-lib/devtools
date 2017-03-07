#' Creates a new package, following all devtools package conventions.
#'
#' Similar to \code{\link{package.skeleton}}, except that it only creates
#' the standard devtools directory structures; it doesn't try and create
#' source code and data files by inspecting the global environment.
#'
#' \code{create} requires that the directory doesn't exist yet; it will be
#' created but deleted upon failure. \code{setup} assumes an existing
#' directory from which it will infer the package name.
#'
#' @param path location to create new package.  The last component of the path
#'   will be used as the package name.
#' @param description list of description values to override default values or
#'   add additional values.
#' @param check if \code{TRUE}, will automatically run \code{\link{check}}
#' @param rstudio Create an Rstudio project file?
#'   (with \code{\link{use_rstudio}})
#' @param quiet if \code{FALSE}, the default, prints informative messages.
#' @seealso Text with \code{\link{package.skeleton}}
#' @export
#' @examples
#' \dontrun{
#' # Create a package using all defaults:
#' path <- file.path(tempdir(), "myDefaultPackage")
#' create(path)
#'
#' # Override a description attribute.
#' path <- file.path(tempdir(), "myCustomPackage")
#' my_description <- list("Maintainer" =
#'   "'Yoni Ben-Meshulam' <yoni@@opower.com>")
#' create(path, my_description)
#' }
create <- function(path, description = getOption("devtools.desc"),
                   check = FALSE, rstudio = TRUE, quiet = FALSE) {
  check_package_name(path)

  # ensure the parent directory exists
  parent_dir <- normalizePath(dirname(path), winslash = "/", mustWork = FALSE)
  if (!file.exists(parent_dir)) {
    stop("Parent directory '", parent_dir, "' does not exist", call. = FALSE)
  }

  # allow 'create' to create a new directory, or populate
  # an empty directory, as long as the parent directory exists
  if (!file.exists(path)) {
    if (!dir.create(path)) {
      stop("Failed to create package directory '", basename(path), "'",
           call. = FALSE)
    }
  }

  # if the directory exists but is not empty, bail
  files <- list.files(path)
  if (length(files)) {

    valid <- length(files) == 1 && tools::file_ext(files) == "Rproj"
    if (!valid)
      stop("Directory exists and is not empty", call. = FALSE)
  }

  path <- normalizePath(path, winslash = "/", mustWork = TRUE)
  setup(path = path, description = description, rstudio = rstudio,
        check = check, quiet = quiet)

  invisible(TRUE)
}

#' @rdname create
#' @export
setup <- function(path = ".", description = getOption("devtools.desc"),
                  check = FALSE, rstudio = TRUE, quiet = FALSE) {
  check_package_name(path)

  parent_dir <- normalizePath(dirname(path), winslash = "/", mustWork = TRUE)
  if (!quiet) {
    message("Creating package '", extract_package_name(path), "' in '", parent_dir, "'")
  }

  dir.create(file.path(path, "R"), showWarnings = FALSE)
  create_description(path, extra = description, quiet = quiet)
  create_namespace(path)

  if (rstudio) use_rstudio(path)

  if (check) check(path)
  invisible(TRUE)
}

#' Create a default DESCRIPTION file for a package.
#'
#' @details
#' To set the default author and licenses, set \code{options}
#' \code{devtools.desc.author} and \code{devtools.desc.license}.  I use
#' \code{options(devtools.desc.author = '"Hadley Wickham <h.wickham@@gmail.com> [aut,cre]"',
#'   devtools.desc.license = "GPL-3")}.
#' @param path path to package root directory
#' @param extra a named list of extra options to add to \file{DESCRIPTION}.
#'   Arguments that take a list
#' @param quiet if \code{TRUE}, suppresses output from this function.
#' @export
create_description <- function(path = ".", extra = getOption("devtools.desc"),
                               quiet = FALSE) {
  # Don't call check_dir(path) here (#803)
  desc_path <- file.path(path, "DESCRIPTION")

  if (file.exists(desc_path)) return(FALSE)

  subdir <- file.path(path, c("R", "src", "data"))
  if (!any(file.exists(subdir))) {
    stop("'", path, "' does not look like a package: no R/, src/ or data directories",
      call. = FALSE)
  }

  desc <- build_description(extract_package_name(path), extra)

  if (!quiet) {
    message("No DESCRIPTION found. Creating with values:\n\n")
    write_dcf("", desc)
  }

  write_dcf(desc_path, desc)

  TRUE
}

build_description <- function(name, extra = list()) {
  check_package_name(name)

  defaults <- compact(list(
    Package = name,
    Title = "What the Package Does (one line, title case)",
    Version = "0.0.0.9000",
    "Authors@R" = getOption("devtools.desc.author"),
    Description = "What the package does (one paragraph).",
    Depends = paste0("R (>= ", as.character(getRversion()) ,")"),
    License = getOption("devtools.desc.license"),
    Suggests = getOption("devtools.desc.suggests"),
    Encoding = "UTF-8",
    LazyData = "true"
  ))

  # Override defaults with user supplied options
  desc <- modifyList(defaults, extra)
  # Collapse all vector arguments to single strings
  desc <- lapply(desc, function(x) paste(x, collapse = ", "))

  desc
}


extract_package_name <- function(path) {
  basename(normalizePath(path, mustWork = FALSE))
}

check_package_name <- function(path) {
  name <- extract_package_name(path)
  if (!valid_name(name)) {
    stop(
      name, " is not a valid package name: it should contain only\n",
      "ASCII letters, numbers and dot, have at least two characters\n",
      "and start with a letter and not end in a dot.",
      call. = FALSE
    )
  }
}


valid_name <- function(x) {
  grepl("^[[:alpha:]][[:alnum:].]+$", x) && !grepl("\\.$", x)
}

create_namespace <- function(path) {
  ns_path <- file.path(path, "NAMESPACE")
  if (file.exists(ns_path)) return()

  cat(
    '# Generated by roxygen2: fake comment so roxygen2 overwrites silently.\n',
    'exportPattern("^[^\\\\.]")\n',
    sep = "",
    file = ns_path
  )
}
