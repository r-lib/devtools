#' Update packages that are missing or out-of-date.
#'
#' Works similarly to \code{install.packages()} but doesn't install packages
#' that are already installed, and also upgrades out dated dependencies. Can
#' also update packages installed from remote repositories. Currently only
#' works with packages installed from git and GitHub repositories. This feature
#' does not require git to be installed.
#'
#' @param pkgs Character vector of packages to update. Leave out to update all
#'   installed packages.
#' @param repos character vector, the base URL(s) of the repositories to use.
#' @param type character, indicating the type of package to download and install.
#' @param include_remote A logical flag to update packages installed from git
#'   and GitHub repositories.
#' @param ... Additional parameters to pass to \code{update_remotes}
#'   (e.g. \code{ask}).
#' @seealso \code{\link{package_deps}} to see which packages are out of date/
#'   missing.
#' @examples
#' \dontrun{
#' update_packages("ggplot2")
#'
#' # install_git("git://github.com/hadley/stringr.git")
#' update_remotes("stringr")
#'
#' # A mix of CRAN and git-installed packages:
#' update_packages(c("plyr", "ggplot2", "stringr"), ask = FALSE)
#' }
#' @export
update_packages <- function(pkgs = NULL,
                            repos = getOption("repos"),
                            type = getOption("pkgType"),
                            include_remote = FALSE,
                            ...) {
  if (!is.null(pkgs)) {
    message("Updating all installed packages.")
    pkgs <- unname(installed.packages()[, 'Package'])
  }
  pkgs <- package_deps(pkgs, repos = repos, type = type)
  status <- update(pkgs)
  if (include_remote) {
    update_remotes(pkgs$package[is.na(pkgs$available)], ...)
  }
}

#' @title Update packages installed from remote repositories.
#' @description It is vectorised so you can update multiple packages
#'   with a single command. Currently only works with packages
#'   installed from git and GitHub. You do not need to have git installed.
#' @param pkgs Character vector of package names. If omitted,
#'   will find all packages installed from remote repositories.
#' @param ask Forces the process to ask the user for confirmation.
#' @examples
#' \dontrun{
#' # install_git("git://github.com/hadley/stringr.git")
#' update_remotes("stringr")
#'
#' update_remotes(ask = FALSE)
#'}
#' @export
update_remotes <- function(pkgs = NULL, ask = TRUE) {

  if (is.null(pkgs)) {
    if (ask) {
      user_response <- readline(prompt = "Are you sure you can't provide specific packages? y/n: ")
      if (user_response != "y") {
        return(invisible())
      }
    }
    message("Checking ALL installed packages for remote-ness.")
    pkgs <- installed.packages()[, 'Package']
  }

  message("Acquiring local and remote metadata.")
  local_info <- get_local_info(pkgs)
  local_info <- local_info[local_info$git, ]
  local_info$remote_sha1 <- get_remote_sha1(local_info$url)
  sha1_different <- local_info$sha1 != local_info$remote_sha1

  if (!any(sha1_different)) {
    message("None of the packages need to be updated.")
    return(invisible())
  }

  if (sum(sha1_different) == 1) {
    message(paste("1 package has a different SHA-1 and will be reinstalled from its remote repository:",
                  rownames(local_info)[sha1_different]))
  } else {
    message(sum(sha1_different), " packages have different SHA-1's and will be reinstalled from their remote repositories: ",
            paste0(rownames(local_info)[sha1_different], collapse =', '))
  }

  if (ask) {
    user_response <- readline(prompt = "Reinstall? y/n: ")
    if (user_response != "y") {
      return(invisible())
    }
  }

  temp <- apply(local_info[sha1_different, ], 1, function(package) {
    if (grepl('github', package['url'])) {
      return(tryCatch(install_github(sub('https://github.com/', '', package['url']), ref = package['ref']),
                      error = function(e) { return(FALSE) }))
    } else {
      return(tryCatch(return(install_git(package['url'])),
                      error = function(e) { return(FALSE) }))
    }
  })
  if (any(temp)) {
    message(sum(temp), " package(s) installed successfully: ", paste(names(temp), collapse = ', '))
  }
  if (any(!temp)) {
    message(sum(!temp), " package(s) failed to install: ", paste(names(temp), collapse = ', '))
  }
  return(invisible())
}
