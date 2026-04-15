# Suppress R CMD check note. memoise is used at build time!
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

  nms <- map_chr(result, `[[`, 1)
  values <- map_chr(result, function(x) utils::URLdecode(x[[2]]))

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

r_release <- function() {
  R_system_version(rversions::resolve("release")$version)
}

#' Report package development situation
#'
#' @description
#' Call this function if things seem weird and you're not sure
#' what's wrong or how to fix it. It reports:
#'
#' * If R is up to date.
#' * If RStudio or Positron is up to date.
#' * If compiler build tools are installed and available for use.
#' * If devtools and its dependencies are up to date.
#' * If the package's dependencies are up to date.
#'
#' @return A named list, with S3 class `dev_sitrep` (for printing purposes).
#' @template devtools
#' @inheritParams pkgbuild::has_build_tools
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
    devtools_cran_version = pak::pkg_deps(
      "devtools",
      dependencies = FALSE
    )$version,
    devtools_deps = pkg_dep_status("devtools", dependencies = NA),
    pkg_deps = if (!is.null(pkg)) pkg_dep_status(pkg, dependencies = TRUE),
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
  devtools_cran_version = devtools_version,
  devtools_deps = NULL,
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
      devtools_cran_version = devtools_cran_version,
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
    all_ok <- FALSE
    cli::cli_bullets(c(
      "!" = "{.field R} is out of date ({.val {x$r_version}} vs {.val {x$r_release_version}})"
    ))
  }

  if (x$is_windows) {
    cli::cli_rule("Rtools")
    if (x$has_build_tools) {
      kv_line("path", x$rtools_path, path = TRUE)
    } else {
      all_ok <- FALSE
      cli::cli_bullets(c(
        "!" = "{.field Rtools} is not installed.",
        " " = "Download and install it from: {.url https://cloud.r-project.org/bin/windows/Rtools/}"
      ))
    }
  }

  if (!is.null(x$rstudio_version)) {
    cli::cli_rule(if (is_positron()) "Positron" else "RStudio")
    kv_line("version", x$rstudio_version)

    if (!is.null(x$rstudio_msg)) {
      all_ok <- FALSE
      cli::cli_bullets(c("!" = "{x$rstudio_msg}"))
    }
  }

  cli::cli_rule("devtools")
  kv_line("version", x$devtools_version)

  devtools_version <- package_version(x$devtools_version)
  devtools_cran_version <- package_version(x$devtools_cran_version)
  if (devtools_version < devtools_cran_version) {
    all_ok <- FALSE
    cli::cli_bullets(c(
      "!" = "{.field devtools} is out of date ({.val {devtools_version}} vs {.val {devtools_cran_version}}).",
      " " = "Update it with {.run pak::pak(\"devtools\")}."
    ))
  } else if (devtools_version > devtools_cran_version) {
    cli::cli_bullets(c(
      "i" = "{.field devtools} is ahead of CRAN ({.val {devtools_version}} vs {.val {devtools_cran_version}})."
    ))
  }

  devtools_not_ok <- any(x$devtools_deps$status != "ok")
  if (devtools_not_ok) {
    all_ok <- FALSE
    report_deps_ahead_behind(
      x$devtools_deps,
      pkg_name = "devtools",
      update_code = 'pak::pak("devtools")'
    )
  }

  cli::cli_rule("dev package")
  kv_line("package", x$pkg$package)
  kv_line("path", x$pkg$path, path = TRUE)

  dev_pkg_not_ok <- any(x$pkg_deps$status != "ok")
  if (dev_pkg_not_ok) {
    all_ok <- FALSE
    report_deps_ahead_behind(
      x$pkg_deps,
      pkg_name = x$pkg$package,
      update_code = "pak::local_install_dev_deps()"
    )
  }

  if (all_ok) {
    cli::cli_bullets(c("v" = "All checks passed"))
  }

  invisible(x)
}

# Helpers -----------------------------------------------------------------

#' Get dependency status for a package, excluding the package itself
#'
#' @param pkg A package name or a package object, as returned by `as.package()`.
#' @param dependencies Which dependency types to include. Passed along to
#'   `pak::pkg_deps()` or `pak::local_dev_deps()`.
#' @returns A data frame with one row per dependency and columns:
#'   * package (name)
#'   * latest (version)
#'   * installed (version)
#'   * status (one of: missing, behind, ok, ahead)
#' @noRd
pkg_dep_status <- function(pkg, dependencies = NA) {
  if (is_string(pkg)) {
    pkg_name <- pkg
    deps <- pak::pkg_deps(pkg, dependencies = dependencies)
  } else if (inherits(pkg, "package")) {
    pkg_name <- pkg$package
    deps <- pak::local_dev_deps(pkg$path, dependencies = dependencies)
  } else {
    cli::cli_abort(
      "{.arg pkg} must be a string package name or a package object."
    )
  }
  deps <- deps[deps$package != pkg_name, ]

  installed <- map_chr(deps$package, function(p) {
    tryCatch(
      as.character(utils::packageVersion(p)),
      error = function(e) NA_character_
    )
  })
  status <- map2_chr(installed, deps$version, function(inst, latest) {
    if (is.na(inst)) {
      return("missing")
    }
    switch(
      as.character(utils::compareVersion(inst, latest)),
      "-1" = "behind",
      "0" = "ok",
      "1" = "ahead"
    )
  })
  data.frame(
    package = deps$package,
    latest = deps$version,
    installed = installed,
    status = status
  )
}

#' Emit cli messages about ahead/behind dependencies
#'
#' @param dep_status A data frame as returned by `compare_deps()`, with
#'   columns `package`, `latest`, `installed`, `status`.
#' @param pkg_name Package name to mention in the message.
#' @param update_code Code suggestion for updating behind deps.
#' @return Called for its side effects.
#' @noRd
report_deps_ahead_behind <- function(dep_status, pkg_name, update_code) {
  missing <- dep_status[dep_status$status == "missing", ]
  if (nrow(missing) > 0) {
    n <- nrow(missing)
    cli::cli_bullets(c(
      "!" = "{n} {.field {pkg_name}} {cli::qty(n)}{?dependency is/dependencies are} not installed.",
      " " = "Install {cli::qty(n)}{?it/them} with {.run {update_code}}."
    ))
    cli::cli_verbatim(paste("  ", dep_labels(missing)))
  }

  behind <- dep_status[dep_status$status == "behind", ]
  if (nrow(behind) > 0) {
    n <- nrow(behind)
    cli::cli_bullets(c(
      "!" = "{n} {.field {pkg_name}} {cli::qty(n)}{?dependency is/dependencies are} out of date.",
      " " = "Update {cli::qty(n)}{?it/them} with {.run {update_code}}."
    ))
    cli::cli_verbatim(paste("  ", dep_labels(behind)))
  }

  ahead <- dep_status[dep_status$status == "ahead", ]
  if (nrow(ahead) > 0) {
    n <- nrow(ahead)
    cli::cli_bullets(c(
      "i" = "{n} {.field {pkg_name}} {cli::qty(n)}{?dependency is/dependencies are} ahead of CRAN."
    ))
    cli::cli_verbatim(paste(" ", dep_labels(ahead)))
  }
}


dep_labels <- function(deps) {
  # helps with readability
  deps$package <- format(deps$package, justify = "left")
  labels <- list_c(pmap(deps, format_dep_line))
  stats::setNames(labels, rep(" ", length(labels)))
}

format_dep_line <- function(package, installed, latest, status) {
  if (is.na(installed)) {
    paste0(package, " (", cli::col_red("missing"), ")")
  } else {
    status_styled <- if (status == "behind") {
      cli::col_red(status)
    } else {
      cli::col_cyan(status)
    }
    paste0(package, " (", status_styled, ": ", installed, " vs ", latest, ")")
  }
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
