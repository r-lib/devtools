#' Install a package from a git repository
#'
#' This function requires \code{git} to be installed on your system in order to
#' be used.
#'
#' It is vectorised so you can install multiple packages with
#' a single command.
#'
#' @param git_url Location of package. The url should point to a public or
#'                private repository.
#' @param name    Optional package name, used to provide more informative
#'                messages.
#' @param subdir  A sub-directory withing a git repository that may
#'                contain the package we are interested in installing.
#' @param git_binary A custom git-binary to use instead of default system's git
#'                   version.
#' @param ...        Other arguments passed on to \code{\link{install}}.
#' @export
#' @family package installation
install_git <- function(git_url, name = NULL, subdir = NULL,
  git_binary = NULL, ...) {

  if (is.null(name)) {
    name <- rep(list(NULL), length(git_url))
  }

  invisible(mapply(install_git_single, git_url, name,
    MoreArgs = list(
      subdir = subdir, git_binary = git_binary, ...
    )
  ))
}

#' Install a single package from a git repository
#'
#' This function allows you to install a single package from a git repository.
#'
#' See \code{\link{install_git}} for more information about the paraemeters.
#'
#' @param git_url Location of package. The url should point to a public or
#'                private repository.
#' @param name    Optional package name, used to provide more informative
#'                messages.
#' @param subdir  A sub-directory withing a git repository that may
#'                contain the package we are interested in installing.
#' @param git_binary A custom git-binary to use instead of default system's git
#'                   version.
#' @param ... passed on to \code{\link{install}}
#' @keywords internal
install_git_single <- function(git_url, name = NULL, subdir = NULL,
  git_binary = NULL, ...) {

  if (is.null(name)) {
    name <- gsub("\\.git$", "", basename(git_url))
  }

  message("Preparing installation of ", name, " using the Git-URL: ", git_url)

  # Unique temporary file-name.
  bundle <- tempfile()

  # \code{git_path} will handle the NULL and return the system default.
  git_binary_path <- git_path(git_binary)

  # Clone the package file from the git repository.
  # @TODO: Handle configs, this currently only supports public repos
  #        and repositories with the public SSH key set.
  request <- system2(
    git_binary_path,
    args = c('clone', '--depth', '1', '--no-hardlinks', git_url,  bundle),
    stdout = FALSE, stderr = FALSE
  )

  # This is only looking for an error code above 0-success
  if (request > 0) {
    stop("There seems to be a problem retrieving this Git-URL.", call. = FALSE)
  }

  pkg_path <- if (is.null(subdir)) bundle else file.path(bundle, subdir)
  on.exit(unlink(bundle), add = TRUE)

  # Check it's an R package
  if (!file.exists(file.path(pkg_path, "DESCRIPTION"))) {
    stop("Does not appear to be an R package", call. = FALSE)
  }

  config_path <- file.path(pkg_path, "configure")
  if (file.exists(config_path)) {
    Sys.chmod(config_path, "755")
  }

  # Install
  install(pkg_path, ...)
}


#' Retrieve the current running path of the git binary.
#' @param git_binary_name The name of the binary depending on the OS.
git_path <- function(git_binary_name = NULL) {
  os_type     <- .Platform$OS.type

  if (!is.null(git_binary_name)) {
    if (!file.exists(git_binary_name)) {
      stop(
        "The Git binary you specified ",
        "does not appear to be installed on ",
        "your system.", call. = FALSE
      )
    }
    git_path <- git_binary_name
  } else {
    # Decide on system default.
    binary_name <- if (.Platform$OS.type == "windows") "git.exe" else "git"
    git_path    <- unname(Sys.which(binary_name))

    if (git_path == "") {
      stop("Git does not seem to be installed on your system.", call. = FALSE)
    }
  }

  git_path
}
