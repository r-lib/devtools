#' Check documentation, as `R CMD check` does
#'
#' This function attempts to run the documentation related checks in the
#' same way that `R CMD check` does. Unfortunately it can't run them
#' all because some tests require the package to be loaded, and the way
#' they attempt to load the code conflicts with how devtools does it.
#'
#' @template devtools
#' @return Nothing. This function is called purely for it's side effects: if
#' no errors there will be no output.
#' @export
#' @examples
#' \dontrun{
#' check_man("mypkg")
#' }
check_man <- function(pkg = ".") {
  pkg <- as.package(pkg)
  document(pkg)

  old <- options(warn = -1)
  on.exit(options(old))

  cli::cli_inform(c(i = "Checking documentation..."))

  check_Rd_contents <- if (getRversion() < "4.1") {
    asNamespace("tools")$.check_Rd_contents
  } else {
    asNamespace("tools")$checkRdContents
  }

  ok <-
    all(
      man_message(("tools" %:::% ".check_package_parseRd")(dir = pkg$path)),
      man_message(("tools" %:::% ".check_Rd_metadata")(dir = pkg$path)),
      man_message(("tools" %:::% ".check_Rd_xrefs")(dir = pkg$path)),
      man_message(check_Rd_contents(dir = pkg$path)),
      man_message(tools::checkDocFiles(dir = pkg$path)),
      man_message(tools::checkDocStyle(dir = pkg$path)),
      man_message(tools::checkReplaceFuns(dir = pkg$path)),
      man_message(tools::checkS3methods(dir = pkg$path)),
      man_message(tools::undoc(dir = pkg$path))
    )

  if (ok) {
    cli::cli_inform(c(v = "No issues detected"))
  }

  invisible()
}

man_message <- function(x) {
  if (inherits(x, "undoc") && length(x$code) == 0) {
    # Returned by tools::undoc()
    TRUE
  } else if ("bad" %in% names(x) && length(x$bad) == 0) {
    # Returned by check_Rd_xrefs()
    TRUE
  } else if (length(x) == 0) {
    TRUE
  } else {
    print(x)
    FALSE
  }
}

#' Check for missing documentation fields
#'
#' Checks all Rd files in `man/` and looks for any that have a `\usage` section
#' (i.e. a function) but that *don't* have `\value` and `\examples` sections.
#' These missing fields are flagged by CRAN on initial submission.
#'
#' @template devtools
#' @param fields A character vector of Rd field names to check for.
#' @returns A named list of character vectors, one for each field, containing
#'   the names of Rd files missing that field. Returned invisibly.
#' @export
#' @examples
#' \dontrun{
#' check_doc_fields(".")
#' }
check_doc_fields <- function(pkg = ".", fields = c("value", "examples")) {
  pkg <- as.package(pkg)
  fields <- stats::setNames(fields, fields)

  paths <- dir_ls(path(pkg$path, "man"), regexp = "\\.Rd$")
  names(paths) <- path_rel(paths, pkg$path)
  rd <- lapply(paths, tools::parse_Rd, permissive = TRUE)
  rd_tags <- lapply(rd, \(x) unlist(lapply(x, attr, "Rd_tag")))

  has_tag <- function(tags, this) {
    any(paste0("\\", this) %in% tags)
  }

  has_usage <- vapply(rd_tags, has_tag, logical(1), this = "usage")
  rd_tags <- rd_tags[has_usage]

  results <- lapply(fields, function(field) {
    missing <- !vapply(rd_tags, has_tag, logical(1), this = field)
    names(rd_tags)[missing]
  })

  for (field in fields) {
    missing <- results[[field]]
    if (length(missing) > 0) {
      cli::cli_inform(c(
        "!" = "Missing {.code \\{field}} section in {length(missing)} file{?s}:",
        stats::setNames(missing, rep("*", length(missing)))
      ))
    } else {
      cli::cli_inform(c("v" = "All Rd files have a {.code \\{field}} section."))
    }
  }

  invisible(results)
}
