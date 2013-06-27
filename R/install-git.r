#' Install a package from a git repository
#'
#' This function requires \code{git} to be installed on your system in order to
#' be used.
#'
#' It is vectorised so you can install multiple packages with
#' a single command.
#'
#' @inheritParams install_git_single
#' @param branch  Name of branch or tag to use, if not master.
#' @param ...        Other arguments passed on to \code{\link{install}}
#' @export
#' @family package installation
#' @examples
#' \dontrun{
#' install_git("git://github.com/hadley/stringr.git")
#' install_git("git://github.com/hadley/stringr.git", branch = "stringr-0.2")
#'}
install_git <- function(git_url, name = NULL, subdir = NULL,
  branch = NULL, git_args = character(0), git_binary = NULL, ...) {

  if (is.null(name)) {
    name <- rep(list(NULL), length(git_url))
  }

  invisible(mapply(install_git_single, git_url, name,
    MoreArgs = list(
      subdir = subdir,
      git_args = git_args,
      git_binary = git_binary,
      branch = branch,
      ...
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
#' @param git_args A character vector providing extra arguments to pass on to
#    git.
#' @param git_binary A custom git-binary to use instead of default system's git
#'                   version.
#' @param ... passed on to \code{\link{install}}
#' @keywords internal
install_git_single <- function(git_url, name = NULL, subdir = NULL,
  branch = NULL, git_args = character(), git_binary = NULL, ...) {

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
  args <- c('clone', '--depth', '1', '--no-hardlinks')
  if (!is.null(branch)) args <- c(args, "--branch", branch)
  args <- c(args, git_args, git_url, bundle)

  message(shQuote(git_binary_path), paste0(args, collapse = " "))
  request <- system2(git_binary_path, args, stdout = FALSE, stderr = FALSE)

  # This is only looking for an error code above 0-success
  if (request > 0) {
    stop("There seems to be a problem retrieving this Git-URL.", call. = FALSE)
  }

  install_local_single(bundle, subdir = subdir, ...)
}


#' Retrieve the current running path of the git binary.
#' @param git_binary_name The name of the binary depending on the OS.
git_path <- function(git_binary_name = NULL) {
  # Use user supplied path
  if (!is.null(git_binary_name)) {
    if (!file.exists(git_binary_name)) {
      stop("Path ", git_binary_name, " does not exist", .call = FALSE)
    }
    return(git_binary_name)
  }

  # Look on path
  git_path <- Sys.which("git")[[1]]
  if (git_path != "") return(git_path)

  # On Windows, look in common locations
  if (.Platform$OS.type == "windows") {
    look_in <- c(
      "C:/Program Files/Git/bin/git.exe",
      "C:/Program Files (x86)/Git/bin/git.exe"
    )
    found <- file.exists(look_in)
    if (any(found)) return(look_in[found][1])
  }

  stop("Git does not seem to be installed on your system.", call. = FALSE)
}
