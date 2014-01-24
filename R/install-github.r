#' Attempts to install a package directly from github.
#'
#' This function is vectorised on \code{repo} so you can install multiple 
#' packages in a single command.
#'
#' @param repo Repository address in the format
#'   \code{[username/]repo[/subdir][@@ref|#pull]}. Alternatively, you can
#'   specify \code{username}, \code{subdir}, \code{ref} or \code{pull} using the
#'   respective parameters (see below); if both is specified, the values in
#'   \code{repo} take precedence.
#' @param username User name
#' @param ref Desired git reference. Could be a commit, tag, or branch
#'   name. Defaults to \code{"master"}.
#' @param pull Desired pull request. A pull request refers to a branch,
#'   so you can't specify both \code{branch} and \code{pull}; one of
#'   them must be \code{NULL}.
#' @param subdir subdirectory within repo that contains the R package.
#' @param branch Deprecated. Use \code{ref} instead.
#' @param auth_user your account username if you're attempting to install
#'   a package hosted in a private repository (and your username is different
#'   to \code{username})
#' @param password your password
#' @param ... Other arguments passed on to \code{\link{install}}.
#' @export
#' @family package installation
#' @examples
#' \dontrun{
#' install_github("roxygen")
#' install_github("wch/ggplot2")
#' install_github(c("rstudio/httpuv", "rstudio/shiny"))
#' install_github(c("devtools@@devtools-1.4", "klutometis/roxygen#142", "mfrasca/r-logging/pkg))
#'
#' # Update devtools to the latest version, on Linux and Mac
#' # On Windows, this won't work - see ?build_github_devtools
#' install_github("hadley/devtools")
#'
#' }
#' @importFrom httr authenticate
install_github <- function(repo, username = getOption("github.user"),
  ref = "master", pull = NULL, subdir = NULL, branch = NULL, auth_user = NULL,
  password = NULL, ...) {

  invisible(vapply(repo, install_github_single, FUN.VALUE = logical(1),
    username, ref, pull, subdir, branch, auth_user, password, ...))
}


install_github_single <- function(repo, username = getOption("github.user"),
  ref = "master", pull = NULL, subdir = NULL, branch = NULL, auth_user = NULL,
  password = NULL, ...) {

  if (!is.null(branch)) {
    warning("'branch' is deprecated. In the future, please use 'ref' instead.")
    ref <- branch
  }

  params <- parse_repo_param(repo)
  username <- params$username %||% username
  repo <- params$repo
  ref <- params$ref %||% ref
  pull <- params$pull %||% pull
  subdir <- params$subdir %||% subdir

  if (!xor(is.null(pull), is.null(ref))) {
    stop("Must specify either a ref or a pull request, not both. ",
     "Perhaps you want to use 'ref=NULL'?")
  }
  if(!is.null(pull)) {
    pullinfo <- github_pull_info(repo, username, pull)
    username <- pullinfo$username
    ref <- pullinfo$ref
  }

  if (!is.null(password)) {
    auth <- authenticate(
      user = auth_user %||% username,
      password = password,
      type = "basic")
  } else {
    auth <- list()
  }

  message("Installing github repo ",
    paste(repo, ref, sep = "/", collapse = ", "),
    " from ",
    paste(username, collapse = ", "))
  name <- paste(username, "-", repo, sep = "")

  url <- paste("https://github.com/", username, "/", repo,
    "/archive/", ref, ".zip", sep = "")

  # define before_install function that captures the arguments to 
  # install_github and appends the to the description file
  github_before_install <- function(bundle, pkg_path) {
     update_description(bundle = bundle,
                        pkg_path = pkg_path,
                        prefix = 'Github', 
                        Repo = repo, 
                        Username = username,
                        Ref = ref,
                        SHA1 = extract_sha1(bundle),
                        Pull = pull,
                        Subdir = subdir,
                        Branch = branch,
                        AuthUser = auth_user)
  }
  
  # If there are slashes in the ref, the URL will have extra slashes, but the
  # downloaded file shouldn't have them.
  # install_github("shiny", "rstudio", "v/0/2/1")
  #  URL: https://github.com/rstudio/shiny/archive/v/0/2/1.zip
  #  Output file: shiny.zip
  install_url(url, name = paste(repo, ".zip", sep=""), subdir = subdir,
    config = auth, before_install = github_before_install, ...)
}

# Retrieve the username and ref for a pull request
#' @importFrom httr parsed_content
github_pull_info <- function(repo, username, pull) {
  host <- "https://api.github.com"
  # GET /repos/:user/:repo/pulls/:number
  path <- paste("repos", username, repo, "pulls", pull, sep = "/")
  r <- GET(host, path = path)
  stop_for_status(r)
  head <- parsed_content(r)$head

  list(repo = head$repo$name, username = head$repo$owner$login,
    ref = head$ref)
}
