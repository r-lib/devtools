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
#' @aliases add_test_infrastructure
#' @export
use_testthat <- function(pkg = ".") {
  pkg <- as.package(pkg)

  check_testthat()
  if (uses_testthat(pkg)) {
    stop("Package already has testing infrastructure", call. = FALSE)
  }

  # Create tests/testthat and install file for R CMD CHECK
  dir.create(file.path(pkg$path, "tests", "testthat"),
    showWarnings = FALSE, recursive = TRUE)
  writeLines(render_template("testthat.R", list(name = pkg$package)),
    file.path(pkg$path, "tests", "testthat.R"))

  add_desc_package(pkg, "Suggests", "testthat")

  invisible(TRUE)
}

#' @export
add_test_infrastructure <- use_testthat

#' @section \code{use_test}:
#' Add a test file, also add testing infrastructure if necessary.
#' This will create \file{tests/testthat/test-<name>.R} with a user-specified
#' name for the test.  Will fail if the file exists.
#' @rdname infrastructure
#' @aliases add_test_infrastructure
#' @export
use_test <- function(name, pkg = ".") {
  pkg <- as.package(pkg)

  check_testthat()
  if (!uses_testthat(pkg)) {
    use_testthat(pkg)
  }

  path <- sprintf("tests/testthat/test-%s.R", name)
  if (file.exists(file.path(pkg$path, path))) {
    stop("File ", path, " exists", call. = FALSE)
  }

  writeLines(
    render_template("test-example.R", list(test_name = name)),
    file.path(pkg$path, path))

  message("Test file created in ", path)
}

#' @section \code{use_rstudio}:
#' Does not modify \code{.Rbuildignore} as RStudio will do that when
#' opened for the first time.
#' @export
#' @rdname infrastructure
#' @aliases add_rstudio_project
use_rstudio <- function(pkg = ".") {
  pkg <- as.package(pkg)

  path <- file.path(pkg$path, paste0(pkg$package, ".Rproj"))
  if (file.exists(path)) {
    stop(pkg$package, ".Rproj already exists", call. = FALSE)
  }
  message("Adding RStudio project file to ", pkg$package)

  template_path <- system.file("templates/template.Rproj", package = "devtools")
  file.copy(template_path, path)

  add_git_ignore(pkg, c(".Rproj.user", ".Rhistory", ".RData"))
  add_build_ignore(pkg, c("^.*\\.Rproj$", "^\\.Rproj\\.user$"), escape = FALSE)

  invisible(TRUE)
}

#' @export
add_rstudio_project <- use_rstudio


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

  add_desc_package(pkg, "Suggests", "knitr")
  add_desc_package(pkg, "VignetteBuilder", "knitr")
  dir.create(file.path(pkg$path, "vignettes"), showWarnings = FALSE)

  add_git_ignore(pkg, "inst/doc")

  path <- file.path(pkg$path, "vignettes", paste0(name, ".Rmd"))
  rmarkdown::draft(path, "html_vignette", "rmarkdown",
    create_dir = FALSE, edit = FALSE)

  message("Draft vignette created in ", path)
}

#' @section \code{use_rcpp}:
#' Creates \code{src/} and adds needed packages to \code{DESCRIPTION}.
#' @export
#' @rdname infrastructure
use_rcpp <- function(pkg = ".") {
  pkg <- as.package(pkg)

  message("Adding Rcpp to LinkingTo and Imports")
  add_desc_package(pkg, "LinkingTo", "Rcpp")
  add_desc_package(pkg, "Imports", "Rcpp")

  message("Creating src/ and src/.gitignore")
  dir.create(file.path(pkg$path, "src"), showWarnings = FALSE)
  union_write(file.path(pkg$path, "src", ".gitignore"),
              c("*.o", "*.so", "*.dll"))

  message(
    "Next, include the following roxygen tags somewhere in your package:\n",
    "#' @useDynLib ", pkg$package, "\n",
    "#' @importFrom Rcpp sourceCpp"
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

  path <- file.path(pkg$path, ".travis.yml")
  if (file.exists(path)) {
    stop(".travis.yml already exists", call. = FALSE)
  }

  gh <- github_info(pkg$path)
  message("Adding .travis.yml to ", pkg$package, ". Next: \n",
    " * Turn on travis for this repo at https://travis-ci.org/profile\n",
    " * Add a travis shield to your README.md:\n",
    "[![Travis-CI Build Status]",
       "(https://travis-ci.org/", gh$username, "/", gh$repo, ".svg?branch=master)]",
       "(https://travis-ci.org/", gh$username, "/", gh$repo, ")"
  )

  template_path <- system.file("templates/travis.yml", package = "devtools")
  file.copy(template_path, path)

  add_build_ignore(pkg, ".travis.yml")

  invisible(TRUE)
}

#' @rdname infrastructure
#' @section \code{use_coveralls}:
#' Add coveralls to basic travis template to a package.
#' @export
use_coveralls <- function(pkg = ".") {
  pkg <- as.package(pkg)

  path <- file.path(pkg$path, ".travis.yml")
  if (!file.exists(path)) {
    stop(".travis.yml does not exist, please run `use_travis()` to create it", call. = FALSE)
  }

  travis_content <- readLines(file.path(pkg$path, ".travis.yml"))

  if (any(grepl("coveralls()", travis_content))) {
    stop("coveralls information already added to .travis.yml", call. = FALSE)
  }

  gh <- github_info(pkg$path)
  message("Adding coveralls information into .travis.yml for ", pkg$package, ". Next: \n",
    " * Turn on coveralls for this repo at https://coveralls.io/repos/new\n",
    " * Add a coveralls shield to your README.md:\n",
    "[![Coverage Status]",
      "(https://img.shields.io/coveralls/", gh$username, "/", gh$repo, ".svg)]",
      "(https://coveralls.io/r/", gh$username, "/", gh$repo, "?branch=master)\n",
    " * Add the following to .travis.yml:\n",
    "r_github_packages:\n",
    "  - jimhester/covr\n",
    "after_success:\n",
    "  - Rscript -e 'library(covr);coveralls()'")

  invisible(TRUE)
}

#' @export
add_travis <- use_travis

#' @rdname infrastructure
#' @section \code{use_appveyor}:
#' Add basic AppVeyor template to a package. Also adds \code{appveyor.yml} to
#' \code{.Rbuildignore} so it isn't included in the built package.
#' @export
use_appveyor <- function(pkg = ".") {
  pkg <- as.package(pkg)

  path <- file.path(pkg$path, "appveyor.yml")
  if (file.exists(path)) {
    stop("appveyor.yml already exists", call. = FALSE)
  }

  gh <- github_info(pkg$path)
  message("Adding appveyor.yml to ", pkg$package, ". Next: \n",
          " * Turn on AppVeyor for this repo at https://ci.appveyor.com/projects\n",
          " * Add an AppVeyor shield to your README.md:\n",
          "[![AppVeyor Build Status]",
          "(https://ci.appveyor.com/api/projects/status/github/", gh$username, "/", gh$repo, "?branch=master)]",
          "(https://ci.appveyor.com/project/", gh$username, "/", gh$repo, ")"
  )

  template_path <- system.file("templates/appveyor.yml", package = "devtools")
  file.copy(template_path, path)

  add_build_ignore(pkg, "appveyor.yml")

  invisible(TRUE)
}

#' @rdname infrastructure
#' @section \code{use_package_doc}:
#' Adds a roxygen template for package documentation
#' @export
use_package_doc <- function(pkg = ".") {
  pkg <- as.package(pkg)

  path <- file.path("R", paste(pkg$package, "-package.r", sep = ""))
  if (file.exists(file.path(pkg$path, path))) {
    stop(path, " already exists", call. = FALSE)
  }

  message("Creating ", path)
  out <- render_template("packagename-package.r", list(name = pkg$package))
  writeLines(out, file.path(pkg$path, path))
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

  message("Adding ", package, " to ", type)
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
  message(msg)
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

  to_save <- dots(...)
  is_name <- vapply(to_save, is.symbol, logical(1))
  if (any(!is_name)) {
    stop("Can only save existing named objects", call. = FALSE)
  }
  objs <- vapply(to_save, as.character, character(1))

  if (internal) {
    data_path <- file.path(pkg$path, "R", "sysdata.rda")
    if (file.exists(data_path) && !overwrite) {
      stop("R/sysdata.rda exists. Use overwrite = TRUE to overwrite",
        call. = FALSE)
    }

    message("Saving ", paste(objs, collapse = ", "), " to R/sysdata.rda")
    save(..., file = data_path, envir = parent.frame(), compress = compress)
  } else {
    data_path <- file.path(pkg$path, "data")
    if (!file.exists(data_path)) dir.create(data_path)

    paths <- file.path(pkg$path, "data", paste0(objs, ".rda"))
    if (any(file.exists(paths)) && !overwrite) {
      stop(paste(basename(paths), collapse = ", "), " already exist. ",
        "Use overwrite = TRUE to overwrite", call. = FALSE)
    }
    message("Saving ", paste(objs, collapse = ", "), " to ",
      paste0("data/", basename(paths), collapse = ", "))
    save_one <- function(name, path) {
      save(list = name, file = path, envir = parent.frame(), compress = compress)
    }
    Map(save_one, objs, paths)

  }
  invisible()
}

#' Use \code{data-raw} to compute package datasets.
#'
#' @param pkg Package where to create \code{data-raw}. Defaults to package in
#'   working directory.
#' @export
#' @family infrastructure
use_data_raw <- function(pkg = ".") {
  pkg <- as.package(pkg)

  path <- file.path(pkg$path, "data-raw")
  if (file.exists(path)) {
    stop("data-raw/ already exists", call. = FALSE)
  }

  message("Creating data-raw/")
  dir.create(path)
  add_build_ignore(pkg, "data-raw")

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

#' Use README.Rmd
#'
#' This creates `README.Rmd` from template and adds to \code{.Rbuildignore}.
#'
#' @param hook Hook name. One of "pre-commit", "prepare-commit-msg",
#'   "commit-msg", "post-commit", "applypatch-msg", "pre-applypatch",
#'   "post-applypatch", "pre-rebase", "post-rewrite", "post-checkout",
#'   "post-merge", "pre-push", "pre-auto-gc".
#' @param script Text of script to run
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @export
#' @family infrastructure
#' @keywords internal
use_readme_rmd <- function(pkg = ".") {
  pkg <- as.package(pkg)

  readme_path <- file.path(pkg$path, "README.Rmd")
  template <- render_template("README.Rmd")

  if (!file.exists(readme_path)) {
    message("Creating README.Rmd")
    writeLines(template, readme_path)
  } else {
    rule("README.Rmd exists. Please check that it starts with:")
    message(template)
    rule()
  }
  use_build_ignore("README.Rmd", pkg = pkg)
  use_build_ignore("^README-.*\\.png$", escape = FALSE, pkg = pkg)

  if (uses_git(pkg) && file.exists(pkg$path, ".git", "hooks", "pre-commit")) {
    message("Adding pre-commit hook")
    use_git_hook("pre-commit", render_template("readme-rmd-pre-commit.sh"),
      pkg = pkg)
  }

  invisible(TRUE)
}

#' @rdname infrastructure
#' @section \code{use_revdep}:
#' Add \code{revdep} directory and basic check template.
#' @export
#' @aliases add_travis
use_revdep <- function(pkg = ".") {
  pkg <- as.package(pkg)

  message("Creating revdep/ & adding to .Rbuildignore")
  dir.create(file.path(pkg$path, "revdep"), showWarnings = FALSE)
  use_build_ignore("revdep", pkg = pkg)

  message("Add revdep subdirectories to .gitignore")
  path <- file.path(pkg$path, "revdep", ".gitignore")
  union_write(path, "**/")

  if (!file.exists(file.path(pkg$path, "revdep/check.R"))) {
    message("Adding revdep/check.R template")
    writeLines(render_template("revdep.R", list(name = pkg$package)),
      file.path(pkg$path, "revdep", "check.R"))
  }
}

#' @rdname infrastructure
#' @section \code{use_cran_comments}:
#' Add \code{cran-comments.md} template.
#' @export
#' @aliases add_travis
use_cran_comments <- function(pkg = ".") {
  pkg <- as.package(pkg)

  use_build_ignore("cran-comments.md")

  comments <- file.path(pkg$path, "cran-comments.md")
  if (file.exists(comments))
    stop("cran-comments.md already exists", call. = FALSE)

  message("Adding cran-comments.md template")
  writeLines(render_template("cran-comments.md", list()), comments)
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

  comments <- file.path(pkg$path, "CONDUCT.md")
  if (file.exists(comments))
    stop("CONDUCT.md already exists", call. = FALSE)

  message("* Creating CONDUCT.md")
  writeLines(render_template("CONDUCT.md", list()), comments)

  message("* Adding CONDUCT.md to .Rbuildignore")
  use_build_ignore("CONDUCT.md")

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
    "[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/", pkg$package, ")](http://cran.r-project.org/web/packages/", pkg$package, ")"
  )
  invisible(TRUE)
}
