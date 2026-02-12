# Supress R CMD check note
#' @importFrom memoise memoise
NULL

rstudio_version_string <- function() {
  if (!is_rstudio_running()) {
    return(character())
  }
  rvi <- rstudioapi::versionInfo()
  rvi$long_version %||% as.character(rvi$version)
}

check_for_rstudio_updates <- function(
  os = tolower(Sys.info()[["sysname"]]),
  version = rstudio_version_string(),
  in_rstudio = is_rstudio_running()
) {
  if (!in_rstudio) {
    return()
  }

  url <- sprintf(
    "https://www.rstudio.org/links/check_for_update?version=%s&os=%s&format=%s&manual=true",
    utils::URLencode(version, reserved = TRUE),
    os,
    "kvp"
  )

  tmp <- file_temp()
  withr::defer(file_exists(tmp) && nzchar(file_delete(tmp)))
  suppressWarnings(
    download_ok <- tryCatch(
      {
        utils::download.file(url, tmp, quiet = TRUE)
        TRUE
      },
      error = function(e) FALSE
    )
  )
  if (!download_ok) {
    return(
      sprintf("Unable to check for RStudio updates (you're using %s).", version)
    )
  }
  result <- readLines(tmp, warn = FALSE)

  result <- strsplit(result, "&")[[1]]

  result <- strsplit(result, "=")

  # If no values then we are current
  if (length(result[[1]]) == 1) {
    return()
  }

  nms <- vcapply(result, `[[`, 1)
  values <- vcapply(result, function(x) utils::URLdecode(x[[2]]))

  result <- stats::setNames(values, nms)

  if (!nzchar(result[["update-version"]])) {
    return()
  }

  return(
    sprintf(
      "%s.\nDownload at: %s",
      result[["update-message"]],
      result[["update-url"]]
    )
  )
}

.r_release <- function() {
  R_system_version(rversions::r_release()$version)
}

r_release <- memoise::memoise(.r_release)

#' Report package development situation
#'
#' @template devtools
#' @inheritParams pkgbuild::has_build_tools
#' @description `dev_sitrep()` reports
#'   * If R is up to date
#'   * If RStudio is up to date
#'   * If compiler build tools are installed and available for use
#'   * If devtools and its dependencies are up to date
#'   * If the package's dependencies are up to date
#'
#' @description Call this function if things seem weird and you're not sure
#'   what's wrong or how to fix it. If this function returns no output
#'   everything should be ready for package development.
#'
#' @return A named list, with S3 class `dev_sitrep` (for printing purposes).
#' @export
#' @examples
#' \dontrun{
#' dev_sitrep()
#' }
dev_sitrep <- function(pkg = ".", debug = FALSE) {
  pkg <- tryCatch(as.package(pkg), error = function(e) NULL)

  has_build_tools <- !is_windows || pkgbuild::has_build_tools(debug = debug)

  new_dev_sitrep(
    pkg = pkg,
    r_version = getRversion(),
    r_path = path_real(R.home()),
    r_release_version = r_release(),
    is_windows = is_windows,
    has_build_tools = has_build_tools,
    rtools_path = if (has_build_tools) pkgbuild::rtools_path(),
    devtools_version = utils::packageVersion("devtools"),
    devtools_deps = outdated_deps(pak::pkg_deps("devtools", dependencies = NA)),
    pkg_deps = if (!is.null(pkg)) {
      outdated_deps(pak::local_dev_deps(pkg$path, dependencies = TRUE))
    },
    rstudio_version = if (is_rstudio_running()) rstudioapi::getVersion(),
    rstudio_msg = if (!is_positron()) check_for_rstudio_updates()
  )
}

new_dev_sitrep <- function(
  pkg = NULL,
  r_version = getRversion(),
  r_path = path_real(R.home()),
  r_release_version = r_version,
  is_windows = FALSE,
  has_build_tools = TRUE,
  rtools_path = NULL,
  devtools_version = utils::packageVersion("devtools"),
  devtools_deps = data.frame(package = character(), diff = numeric()),
  pkg_deps = NULL,
  rstudio_version = NULL,
  rstudio_msg = NULL
) {
  structure(
    list(
      pkg = pkg,
      r_version = r_version,
      r_path = r_path,
      r_release_version = r_release_version,
      is_windows = is_windows,
      has_build_tools = has_build_tools,
      rtools_path = rtools_path,
      devtools_version = devtools_version,
      devtools_deps = devtools_deps,
      pkg_deps = pkg_deps,
      rstudio_version = rstudio_version,
      rstudio_msg = rstudio_msg
    ),
    class = "dev_sitrep"
  )
}

#' @export
print.dev_sitrep <- function(x, ...) {
  all_ok <- TRUE

  cli::cli_rule("R")
  kv_line("version", x$r_version)
  kv_line("path", x$r_path, path = TRUE)
  if (x$r_version < x$r_release_version) {
    cli::cli_bullets(c(
      "!" = "{.field R} is out of date ({.val {x$r_version}} vs {.val {x$r_release_version}})"
    ))
    all_ok <- FALSE
  }

  if (x$is_windows) {
    cli::cli_rule("Rtools")
    if (x$has_build_tools) {
      kv_line("path", x$rtools_path, path = TRUE)
    } else {
      cli::cli_bullets(c(
        "!" = "{.field Rtools} is not installed.",
        " " = "Download and install it from: {.url https://cloud.r-project.org/bin/windows/Rtools/}"
      ))
    }
    all_ok <- FALSE
  }

  if (!is.null(x$rstudio_version)) {
    cli::cli_rule(if (is_positron()) "Positron" else "RStudio")
    kv_line("version", x$rstudio_version)

    if (!is.null(x$rstudio_msg)) {
      cli::cli_bullets(c("!" = "{x$rstudio_msg}"))
      all_ok <- FALSE
    }
  }

  cli::cli_rule("devtools")
  kv_line("version", x$devtools_version)

  devtools_deps_old <- x$devtools_deps$diff < 0
  if (any(devtools_deps_old)) {
    cli::cli_bullets(c(
      "!" = "{.pkg devtools} or its dependencies out of date:",
      " " = "{.val {x$devtools_deps$package[devtools_deps_old]}}",
      " " = "Update them with {.code pak::pak(\"devtools\")}"
    ))
    all_ok <- FALSE
  }

  cli::cli_rule("dev package")
  kv_line("package", x$pkg$package)
  kv_line("path", x$pkg$path, path = TRUE)

  pkg_deps_old <- x$pkg_deps$diff < 0
  if (any(pkg_deps_old)) {
    cli::cli_bullets(c(
      "!" = "{.field {x$pkg$package}} dependencies out of date:",
      " " = "{.val {x$pkg_deps$package[pkg_deps_old]}}",
      " " = "Update them with {.code pak::local_install_dev_deps()}"
    ))
    all_ok <- FALSE
  }

  if (all_ok) {
    cli::cli_bullets(c("v" = "All checks passed"))
  }

  invisible(x)
}


# Helpers -----------------------------------------------------------------

outdated_deps <- function(deps) {
  installed <- vapply(
    deps$package,
    function(p) {
      tryCatch(
        as.character(utils::packageVersion(p)),
        error = function(e) NA_character_
      )
    },
    character(1)
  )
  diff <- mapply(
    function(inst, avail) {
      if (is.na(inst)) {
        return(-1L)
      }
      as.integer(utils::compareVersion(inst, avail))
    },
    installed,
    deps$version,
    USE.NAMES = FALSE
  )
  data.frame(package = deps$package, diff = diff)
}

kv_line <- function(key, value, path = FALSE) {
  if (is.null(value)) {
    cli::cli_inform(c("*" = "{key}: {.silver <unset>}"))
  } else if (path) {
    cli::cli_inform(c("*" = "{key}: {.path {value}}"))
  } else {
    cli::cli_inform(c("*" = "{key}: {.val {value}}"))
  }
}
