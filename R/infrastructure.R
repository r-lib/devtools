#' Add useful infrastructure to a package.
#'
#' @param pkg package description, can be path or package name. See
#'   \code{\link{as.package}} for more information.
#' @name infrastructure
#' @family infrastructure
NULL

#' @section \code{use_testthat}:
#' Add testing infrastructure to a package that does not already have it.
#' This will create \file{tests/testthat.R}, \file{tests/testthat/} and
#' add \pkg{testthat} to the suggested packages. This is called
#' automatically from \code{\link{test}} if needed.
#' @rdname infrastructure
#' @export
use_testthat <- function(pkg = ".") {
  pkg <- as.package(pkg)

  check_suggested("testthat")
  if (uses_testthat(pkg = pkg)) {
    message("* testthat is already initialized")
    return(invisible(TRUE))
  }

  message("* Adding testthat to Suggests")
  add_desc_package(pkg, "Suggests", "testthat")

  use_directory("tests/testthat", pkg = pkg)
  use_template(
    "testthat.R",
    "tests/testthat.R",
    data = list(name = pkg$package),
    pkg = pkg
  )

  invisible(TRUE)
}

#' @section \code{use_test}:
#' Add a test file, also add testing infrastructure if necessary.
#' This will create \file{tests/testthat/test-<name>.R} with a user-specified
#' name for the test.  Will fail if the file exists.
#' @rdname infrastructure
#' @export
use_test <- function(name, pkg = ".") {
  pkg <- as.package(pkg)

  check_suggested("testthat")
  if (!uses_testthat(pkg = pkg)) {
    use_testthat(pkg = pkg)
  }

  use_template("test-example.R",
    sprintf("tests/testthat/test-%s.R", name),
    data = list(test_name = name),
    open = TRUE,
    pkg = pkg
  )

  invisible(TRUE)
}

#' @export
#' @rdname infrastructure
use_rstudio <- function(pkg = ".") {
  pkg <- as.package(pkg)

  use_template(
    "template.Rproj",
    paste0(pkg$package, ".Rproj"),
    pkg = pkg
  )

  use_git_ignore(c(".Rproj.user", ".Rhistory", ".RData"), pkg = pkg)
  use_build_ignore(c("^.*\\.Rproj$", "^\\.Rproj\\.user$"), escape = FALSE, pkg = pkg)

  invisible(TRUE)
}

#' @section \code{use_vignette}:
#' Adds needed packages to \code{DESCRIPTION}, and creates draft vignette
#' in \code{vignettes/}. It adds \code{inst/doc} to \code{.gitignore}
#' so you don't accidentally check in the built vignettes.
#' @param name File name to use for new vignette. Should consist only of
#'   numbers, letters, _ and -. I recommend using lower case.
#' @export
#' @rdname infrastructure
use_vignette <- function(name, pkg = ".") {
  pkg <- as.package(pkg)
  check_suggested("rmarkdown")

  add_desc_package(pkg, "Suggests", "knitr")
  add_desc_package(pkg, "Suggests", "rmarkdown")
  add_desc_package(pkg, "VignetteBuilder", "knitr")

  use_directory("vignettes", pkg = pkg)
  use_git_ignore("inst/doc", pkg = pkg)

  path <- file.path(pkg$path, "vignettes", paste0(name, ".Rmd"))
  rmarkdown::draft(path, "html_vignette", "rmarkdown",
    create_dir = FALSE, edit = FALSE)

  open_in_rstudio(path)
}

#' @section \code{use_rcpp}:
#' Creates \code{src/} and adds needed packages to \code{DESCRIPTION}.
#' @export
#' @rdname infrastructure
use_rcpp <- function(pkg = ".") {
  pkg <- as.package(pkg)
  check_suggested("Rcpp")

  message("Adding Rcpp to LinkingTo and Imports")
  add_desc_package(pkg, "LinkingTo", "Rcpp")
  add_desc_package(pkg, "Imports", "Rcpp")

  use_directory("src/", pkg = pkg)

  message("* Ignoring generated binary files.")
  ignore_path <- file.path(pkg$path, "src", ".gitignore")
  union_write(ignore_path, c("*.o", "*.so", "*.dll"))

  message(
    "Next, include the following roxygen tags somewhere in your package:\n\n",
    "#' @useDynLib ", pkg$package, "\n",
    "#' @importFrom Rcpp sourceCpp\n",
    "NULL\n\n",
    "Then run document()"
  )
}

#' @rdname infrastructure
#' @section \code{use_travis}:
#' Add basic travis template to a package. Also adds \code{.travis.yml} to
#' \code{.Rbuildignore} so it isn't included in the built package.
#' @export
#' @aliases add_travis
use_travis <- function(pkg = ".") {
  pkg <- as.package(pkg)

  use_template("travis.yml", ".travis.yml", ignore = TRUE, pkg = pkg)

  gh <- github_info(pkg$path)
  message("Next: \n",
    " * Turn on travis for this repo at https://travis-ci.org/profile\n",
    " * Add a travis shield to your README.md:\n",
    "[![Travis-CI Build Status]",
       "(https://travis-ci.org/", gh$fullname, ".svg?branch=master)]",
       "(https://travis-ci.org/", gh$fullname, ")"
  )

  invisible(TRUE)
}

#' @rdname infrastructure
#' @param type CI tool to use. Currently supports codecov and coverall.
#' @section \code{use_coverage}:
#' Add test code coverage to basic travis template to a package.
#' @export
use_coverage <- function(pkg = ".", type = c("codecov", "coveralls")) {
  pkg <- as.package(pkg)
  check_suggested("covr")

  path <- file.path(pkg$path, ".travis.yml")
  if (!file.exists(path)) {
    use_travis()
  }

  message("* Adding covr to Suggests")
  add_desc_package(pkg, "Suggests", "covr")

  gh <- github_info(pkg$path)
  type <- match.arg(type)

  message("Next:")
  switch(type,
    codecov = {
      message("* Add to `README.md`: \n",
        "[![Coverage Status]",
        "(https://img.shields.io/codecov/c/github/", gh$fullname, "/master.svg)]",
        "(https://codecov.io/github/", gh$fullname, "?branch=master)"
      )
      message("* Add to `.travis.yml`:\n",
        "after_success:\n",
        "  - Rscript -e 'covr::codecov()'"
      )
    },

    coveralls = {
      message("* Turn on coveralls for this repo at https://coveralls.io/repos/new")
      message("* Add to `README.md`: \n",
        "[![Coverage Status]",
        "(https://img.shields.io/coveralls/", gh$fullname, ".svg)]",
        "(https://coveralls.io/r/", gh$fullname, "?branch=master)"
      )
      message("* Add to `.travis.yml`:\n",
        "after_success:\n",
        "  - Rscript -e 'covr::coveralls()'"
      )
    })

  invisible(TRUE)
}

#' @rdname infrastructure
#' @section \code{use_appveyor}:
#' Add basic AppVeyor template to a package. Also adds \code{appveyor.yml} to
#' \code{.Rbuildignore} so it isn't included in the built package.
#' @export
use_appveyor <- function(pkg = ".") {
  pkg <- as.package(pkg)

  use_template("appveyor.yml", ignore = TRUE, pkg = pkg)

  gh <- github_info(pkg$path)
  message("Next: \n",
          " * Turn on AppVeyor for this repo at https://ci.appveyor.com/projects\n",
          " * Add an AppVeyor shield to your README.md:\n",
          "[![AppVeyor Build Status]",
          "(https://ci.appveyor.com/api/projects/status/github/", gh$username, "/", gh$repo, "?branch=master&svg=true)]",
          "(https://ci.appveyor.com/project/", gh$username, "/", gh$repo, ")"
  )

  invisible(TRUE)
}

#' @rdname infrastructure
#' @section \code{use_package_doc}:
#' Adds a roxygen template for package documentation
#' @export
use_package_doc <- function(pkg = ".") {
  pkg <- as.package(pkg)

  use_template(
    "packagename-package.r",
    file.path("R", paste(pkg$package, "-package.r", sep = "")),
    data = list(name = pkg$package),
    open = TRUE,
    pkg = pkg
  )
}

#' Use specified package.
#'
#' This adds a dependency to DESCRIPTION and offers a little advice
#' about how to best use it.
#'
#' @param package Name of package to depend on.
#' @param type Type of dependency: must be one of "Imports", "Suggests",
#'   "Depends", "Suggests", "Enhances", or "LinkingTo" (or unique abbreviation)
#' @param pkg package description, can be path or package name. See
#'   \code{\link{as.package}} for more information.
#' @family infrastructure
#' @export
#' @examples
#' \dontrun{
#' use_package("ggplot2")
#' use_package("dplyr", "suggests")
#'
#' }
use_package <- function(package, type = "Imports", pkg = ".") {
  stopifnot(is.character(package), length(package) == 1)
  stopifnot(is.character(type), length(type) == 1)

  if (!is_installed(package)) {
    stop(package, " must be installed before you can take a dependency on it",
      call. = FALSE)
  }

  types <- c("Imports", "Depends", "Suggests", "Enhances", "LinkingTo")
  names(types) <- tolower(types)

  type <- types[[match.arg(tolower(type), names(types))]]

  message("* Adding ", package, " to ", type)
  add_desc_package(pkg, type, package)

  msg <- switch(type,
    Imports = paste0("Refer to functions with ", package, "::fun()"),
    Depends = paste0("Are you sure you want Depends? Imports is almost always",
      " the better choice."),
    Suggests = paste0("Use requireNamespace(\"", package, "\", quietly = TRUE)",
      " to test if package is installed,\n",
      "then use ", package, "::fun() to refer to functions."),
    Enhances = "",
    LinkingTo = show_includes(package)
  )
  message("Next: ")
  message(msg)
  invisible()
}

show_includes <- function(package) {
  incl <- system.file("include", package = package)
  h <- dir(incl, "\\.(h|hpp)$")
  if (length(h) == 0) return()

  message("Possible includes are:\n",
    paste0("#include <", h, ">", collapse = "\n"))

}

add_desc_package <- function(pkg = ".", field, name) {
  pkg <- as.package(pkg)
  desc_path <- file.path(pkg$path, "DESCRIPTION")

  desc <- read_dcf(desc_path)
  old <- desc[[field]]
  if (is.null(old)) {
    new <- name
    changed <- TRUE
  } else {
    if (!grepl(name, old)) {
      new <- paste0(old, ",\n    ", name)
      changed <- TRUE
    } else {
      changed <- FALSE
    }
  }
  if (changed) {
    desc[[field]] <- new
    write_dcf(desc_path, desc)
  }
  invisible(changed)
}

#' Use data in a package.
#'
#' This function makes it easy to save package data in the correct format.
#'
#' @param ... Unquoted names of existing objects to save.
#' @param pkg Package where to store data. Defaults to package in working
#'   directory.
#' @param internal If \code{FALSE}, saves each object in individual
#'   \code{.rda} files in the \code{data/} directory. These are available
#'   whenever the package is loaded. If \code{TRUE}, stores all objects in
#'   a single \code{R/sysdata.rda} file. These objects are only available
#'   within the package.
#' @param overwrite By default, \code{use_data} will not overwrite existing
#'   files. If you really want to do so, set this to \code{TRUE}.
#' @param compress Choose the type of compression used by \code{\link{save}}.
#'   Should be one of "gzip", "bzip2" or "xz".
#' @export
#' @family infrastructure
#' @examples
#' \dontrun{
#' x <- 1:10
#' y <- 1:100
#'
#' use_data(x, y) # For external use
#' use_data(x, y, internal = TRUE) # For internal use
#' }
use_data <- function(..., pkg = ".", internal = FALSE, overwrite = FALSE,
                     compress = "bzip2") {
  pkg <- as.package(pkg)

  objs <- get_objs_from_dots(dots(...))

  if (internal) {
    dir_name <- file.path(pkg$path, "R")
    paths <- file.path(dir_name, "sysdata.rda")
    objs <- list(objs)
  } else {
    dir_name <- file.path(pkg$path, "data")
    paths <- file.path(dir_name, paste0(objs, ".rda"))
  }

  check_data_paths(paths, overwrite)

  message("Saving ", paste(unlist(objs), collapse = ", "),
          " as ", paste(basename(paths), collapse = ", "),
          " to ", dir_name)
  envir <- parent.frame()
  mapply(save, list = objs, file = paths,
         MoreArgs = list(envir = envir, compress = compress))

  invisible()
}

get_objs_from_dots <- function(.dots) {
  if (length(.dots) == 0L) {
    stop("Nothing to save", call. = FALSE)
  }

  is_name <- vapply(.dots, is.symbol, logical(1))
  if (any(!is_name)) {
    stop("Can only save existing named objects", call. = FALSE)
  }

  objs <- vapply(.dots, as.character, character(1))
  duplicated_objs <- which(stats::setNames(duplicated(objs), objs))
  if (length(duplicated_objs) > 0L) {
    objs <- unique(objs)
    warning("Saving duplicates only once: ",
            paste(names(duplicated_objs), collapse = ", "),
            call. = FALSE)
  }
  objs
}

check_data_paths <- function(paths, overwrite) {
  data_path <- dirname(paths[[1]])
  if (!file.exists(data_path)) dir.create(data_path)

  if (!overwrite) {
    paths_exist <- which(stats::setNames(file.exists(paths), paths))

    if (length(paths_exist) > 0L) {
      paths_exist <- unique(names(paths_exist))
      existing_names <- basename(paths_exist)
      stop(paste(existing_names, collapse = ", "), " already exists in ",
           dirname(paths_exist[[1L]]),
           ". ",
           "Use overwrite = TRUE to overwrite", call. = FALSE)
    }
  }
}

#' Use \code{data-raw} to compute package datasets.
#'
#' @param pkg Package where to create \code{data-raw}. Defaults to package in
#'   working directory.
#' @export
#' @family infrastructure
use_data_raw <- function(pkg = ".") {
  pkg <- as.package(pkg)

  use_directory("data-raw", ignore = TRUE, pkg = pkg)

  message("Next: \n",
    "* Add data creation scripts in data-raw\n",
    "* Use devtools::use_data() to add data to package")
}

#' Add a file to \code{.Rbuildignore}
#'
#' \code{.Rbuildignore} has a regular expression on each line, but it's
#' usually easier to work with specific file names. By default, will (crudely)
#' turn a filename into a regular expression that will only match that
#' path. Repeated entries will be silently removed.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param files Name of file.
#' @param escape If \code{TRUE}, the default, will escape \code{.} to
#'   \code{\\.} and surround with \code{^} and \code{$}.
#' @return Nothing, called for its side effect.
#' @export
#' @aliases add_build_ignore
#' @family infrastructure
#' @keywords internal
use_build_ignore <- function(files, escape = TRUE, pkg = ".") {
  pkg <- as.package(pkg)

  if (escape) {
    files <- paste0("^", gsub("\\.", "\\\\.", files), "$")
  }

  path <- file.path(pkg$path, ".Rbuildignore")
  union_write(path, files)

  invisible(TRUE)
}

#' Create README files.
#'
#' Use \code{Rmd} if you want a rich intermingling of code and data. Use
#' \code{md} for a basic README. \code{README.Rmd} will be automatically
#' added to \code{.Rbuildignore}.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @export
#' @family infrastructure
use_readme_rmd <- function(pkg = ".") {
  pkg <- as.package(pkg)

  use_template("README.Rmd", ignore = TRUE, open = TRUE, pkg = pkg)
  use_build_ignore("^README-.*\\.png$", escape = FALSE, pkg = pkg)

  if (uses_git(pkg$path) && !file.exists(pkg$path, ".git", "hooks", "pre-commit")) {
    message("* Adding pre-commit hook")
    use_git_hook("pre-commit", render_template("readme-rmd-pre-commit.sh"),
      pkg = pkg)
  }

  invisible(TRUE)
}

#' @export
#' @rdname use_readme_rmd
use_readme_md <- function(pkg = ".") {
  pkg <- as.package(pkg)
  if (uses_github(pkg$path)) {
    pkg$github <- github_info(pkg$path)
  }

  use_template("README.md", data = pkg, open = TRUE, pkg = pkg)
}

#' Use NEWS.md
#'
#' This creates \code{NEWS.md} from a template.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @export
#' @family infrastructure
use_news_md <- function(pkg = ".") {
  pkg <- as.package(pkg)

  use_template("NEWS.md", data = pkg, open = TRUE, pkg = pkg)
}

#' @rdname infrastructure
#' @section \code{use_revdep}:
#' Add \code{revdep} directory and basic check template.
#' @export
#' @aliases add_travis
use_revdep <- function(pkg = ".") {
  pkg <- as.package(pkg)

  use_directory("revdep", ignore = TRUE, pkg = pkg)
  use_template(
    "revdep.R",
    "revdep/check.R",
    data = list(name = pkg$package),
    pkg = pkg
  )
}

#' @rdname infrastructure
#' @section \code{use_cran_comments}:
#' Add \code{cran-comments.md} template.
#' @export
#' @aliases add_travis
use_cran_comments <- function(pkg = ".") {
  pkg <- as.package(pkg)

  use_template(
    "cran-comments.md",
    data = list(rversion = paste0(version$major, ".", version$minor)),
    ignore = TRUE,
    open = TRUE,
    pkg = pkg
  )

  invisible()
}

#' @rdname infrastructure
#' @section \code{use_code_of_conduct}:
#' Add a code of conduct to from \url{http://contributor-covenant.org}.
#'
#' @export
#' @aliases add_travis
use_code_of_conduct <- function(pkg = ".") {
  pkg <- as.package(pkg)

  use_template(
    "CONDUCT.md",
    ignore = TRUE,
    pkg = pkg
  )

  message("* Don't forget to describe the code of conduct in your README.md:")
  message("Please note that this project is released with a ",
    "[Contributor Code of Conduct](CONDUCT.md). ", "By participating in this ",
    "project you agree to abide by its terms.")
}

add_build_ignore <- function(pkg = ".", files, escape = TRUE) {
  use_build_ignore(files, escape = escape, pkg = pkg)
}

union_write <- function(path, new_lines) {
  if (file.exists(path)) {
    lines <- readLines(path, warn = FALSE)
  } else {
    lines <- character()
  }

  all <- union(lines, new_lines)
  writeLines(all, path)
}


#' @rdname infrastructure
#' @section \code{use_cran_badge}:
#' Add a badge to show CRAN status and version number on the README
#' @export
use_cran_badge <- function(pkg = ".") {
  pkg <- as.package(pkg)
  message(
    " * Add a CRAN status shield by adding the following line to your README:\n",
    "[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/", pkg$package, ")](https://cran.r-project.org/package=", pkg$package, ")"
  )
  invisible(TRUE)
}

#' @rdname infrastructure
#' @section \code{use_mit_license}:
#' Adds the necessary infrastructure to declare your package as
#' distributed under the MIT license.
#' @param copyright_holder The copyright holder for this package. Defaults to
#'   \code{getOption("devtools.name")}.
#' @export
use_mit_license <- function(pkg = ".", copyright_holder = getOption("devtools.name", "<Author>")) {
  pkg <- as.package(pkg)

  # Update the DESCRIPTION
  message("* Updating license field in DESCRIPTION.")
  descPath <- file.path(pkg$path, "DESCRIPTION")
  DESCRIPTION <- read_dcf(descPath)
  DESCRIPTION$License <- "MIT + file LICENSE"
  write_dcf(descPath, DESCRIPTION)

  use_template(
    "mit-license.txt",
    "LICENSE",
    data = list(
      year = format(Sys.Date(), "%Y"),
      copyright_holder = copyright_holder
    ),
    open = identical(copyright_holder, "<Author>"),
    pkg = pkg
  )
}

use_directory <- function(path, ignore = FALSE, pkg = ".") {
  pkg <- as.package(pkg)
  pkg_path <- file.path(pkg$path, path)

  if (file.exists(pkg_path)) {
    if (!is_dir(pkg_path)) {
      stop("`", path, "` exists but is not a directory.", call. = FALSE)
    }
  } else {
    message("* Creating `", path, "`.")
    dir.create(pkg_path, showWarnings = FALSE, recursive = TRUE)
  }

  if (ignore) {
    message("* Adding `", path, "` to `.Rbuildignore`.")
    use_build_ignore(path, pkg = pkg)
  }

  invisible(TRUE)
}

use_template <- function(template, save_as = template, data = list(),
                         ignore = FALSE, open = FALSE, pkg = ".") {
  pkg <- as.package(pkg)

  path <- file.path(pkg$path, save_as)
  if (!can_overwrite(path)) {
    stop("`", save_as, "` already exists.", call. = FALSE)
  }

  template_path <- system.file("templates", template, package = "devtools",
    mustWork = TRUE)
  template_out <- whisker::whisker.render(readLines(template_path), data)

  message("* Creating `", save_as, "` from template.")
  writeLines(template_out, path)

  if (ignore) {
    message("* Adding `", save_as, "` to `.Rbuildignore`.")
    use_build_ignore(save_as, pkg = pkg)
  }

  if (open) {
    message("* Modify `", save_as, "`.")
    open_in_rstudio(save_as)
  }

  invisible(TRUE)
}

open_in_rstudio <- function(path) {
  if (!rstudioapi::isAvailable())
    return()

  if (!rstudioapi::hasFun("navigateToFile"))
    return()

  rstudioapi::navigateToFile(path)

}

can_overwrite <- function(path) {
  name <- basename(path)

  if (!file.exists(path)) {
    TRUE
  } else if (interactive() && !yesno("Overwrite `", name, "`?")) {
    TRUE
  } else {
    FALSE
  }
}


