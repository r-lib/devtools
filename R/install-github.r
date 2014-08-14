#' Attempts to install a package directly from github.
#'
#' This function is vectorised on \code{repo} so you can install multiple
#' packages in a single command.
#'
#' @param repo Repository address in the format
#'   \code{username/repo[/subdir][@@ref|#pull]}. Alternatively, you can
#'   specify \code{subdir} and/or \code{ref} using the respective parameters
#'   (see below); if both is specified, the values in \code{repo} take
#'   precedence.
#' @param username User name. Deprecate: please include username in the
#'   \code{repo}
#' @param ref Desired git reference. Could be a commit, tag, or branch
#'   name, or a call to \code{\link{github_pull}}. Defaults to \code{"master"}.
#' @param subdir subdirectory within repo that contains the R package.
#' @param auth_token To install from a private repo, generate a personal
#'   access token (PAT) in \url{https://github.com/settings/applications} and
#'   supply to this argument. This is safer than using a password because
#'   you can easily delete a PAT without affecting any others. Defaults to
#'   the \code{GITHUB_PAT} environment variable.
#' @param ... Other arguments passed on to \code{\link{install}}.
#' @param dependencies By default, installs all dependencies so that you can
#'   build vignettes and use all functionality of the package.
#' @export
#' @family package installation
#' @seealso \code{\link{github_pull}}
#' @examples
#' \dontrun{
#' install_github("roxygen")
#' install_github("wch/ggplot2")
#' install_github(c("rstudio/httpuv", "rstudio/shiny"))
#' install_github(c("hadley/httr@@v0.4", "klutometis/roxygen#142",
#'   "mfrasca/r-logging/pkg"))
#'
#' # Update devtools to the latest version, on Linux and Mac
#' # On Windows, this won't work - see ?build_github_devtools
#' install_github("hadley/devtools")
#'
#' # To install from a private repo, use auth_token with a token
#' # from https://github.com/settings/applications. You only need the
#' # repo scope. Best practice is to save your PAT in env var called
#' # GITHUB_PAT.
#' install_github("hadley/private", auth_token = "abc")
#'
#' }
install_github <- function(repo, username = NULL,
                           ref = "master", subdir = NULL,
                           auth_token = github_pat(), ...,
                           dependencies = TRUE) {

  pkgs <- lapply(repo, github_pkg, username = username, ref = ref,
    subdir = subdir, auth_token = auth_token, ..., dependencies = dependencies)

  lapply(pkgs, install_pkg)

}

github_pkg <- function(repo, username = NULL, ref = NULL, subdir = NULL,
                       auth_token = github_pat(), ...) {

  meta <- parse_git_repo(repo)

  if (is.null(meta$username)) {
    meta$username <- username %||% getOption("github.user")
    warning("Relying on default username is deprecated. Please use ",
      username, "/", repo, call. = FALSE)
  } else {
    username <- meta$username
  }
  meta$subdir <- meta$subdir %||% subdir
  if (is.null(meta$ref) && !is.null(ref)) {
    meta <- resolve_ref(ref, meta)
  }

  if (!is.null(auth_token)) {
    auth <- httr::authenticate(
      user = auth_token,
      password = "x-oauth-basic",
      type = "basic"
    )
  } else {
    auth <- NULL
  }

  meta$SHA1 <- github_commit(meta$username, meta$repo, meta$ref)$sha

  url <- file.path("https://api.github.com", "repos", meta$username,
    meta$repo, "zipball", meta$ref)

  msg <- paste0("Downloading github repo ", meta$username, "/", meta$repo,
    "@", meta$ref)

  list(url = url, name = meta$repo, config = auth, meta = meta, message = msg,
    type = "zip")
}

install_pkg <- function(pkg, ..., quiet = FALSE) {
  bundle <- tempfile(fileext = paste0(".", pkg$type))
  if (!quiet) {
    message(pkg$message)
  }
  download(bundle, pkg$url, pkg$config)
  on.exit(unlink(bundle), add = TRUE)

  pkg_path <- source_pkg(bundle, subdir = pkg$meta$subdir)
  on.exit(unlink(pkg_path, recursive = TRUE), add = TRUE)

  meta <- pkg$meta
  names(meta) <- paste0("Github", first_upper(names(meta)))
  add_metadata(pkg_path, meta)

  install(pkg_path, ..., quiet = quiet)
}

# Add metadata
add_metadata <- function(pkg_path, meta) {
  path <- file.path(pkg_path, "DESCRIPTION")
  desc <- read_dcf(path)

  desc <- modifyList(desc, meta)

  write_dcf(path, desc)
}


#' Install a specific pull request from GitHub
#'
#' Use as \code{ref} parameter to \code{\link{install_github}}.
#'
#' @param pull The pull request to install
#' @seealso \code{\link{install_github}}
#' @export
github_pull <- function(pull) structure(pull, class = "github_pull")

resolve_ref <- function(x, params) UseMethod("github_ref")

resolve_ref.default <- function(x, params) {
  params$ref <- x
  params
}

resolve_ref.github_pull <- function(x, params) {
  # GET /repos/:user/:repo/pulls/:number
  path <- file.path("repos", param$username, param$repo, "pulls", x)
  response <- github_GET(path)

  params$username <- response$user$login
  params$ref <- response$head$ref
  ref
}


# Parse concise git repo specification: username/repo[/subdir][#pull|@ref]
parse_git_repo <- function(path) {
  username_rx <- "(?:([^/]+)/)"
  repo_rx <- "([^/@#]+)"
  subdir_rx <- "(?:/([^@#]*[^@#/]))?"
  ref_rx <- "(?:@(.+))"
  pull_rx <- "(?:#([0-9]+))"
  ref_or_pull_rx <- sprintf("(?:%s|%s)?", ref_rx, pull_rx)
  github_rx <- sprintf("^(?:%s%s%s%s|(.*))$",
    username_rx, repo_rx, subdir_rx, ref_or_pull_rx)

  param_names <- c("username", "repo", "subdir", "ref", "pull", "invalid")
  replace <- setNames(sprintf("\\%d", seq_along(param_names)), param_names)
  params <- lapply(replace, function(r) gsub(github_rx, r, path, perl = TRUE))
  if (params$invalid != "")
    stop(sprintf("Invalid git repo: %s", path))
  params <- params[sapply(params, nchar) > 0]

  if (!is.null(params$pull)) {
    params$ref <- github_pull(params$pull)
    params$pull <- NULL
  }
  if (is.null(params$ref)) {
    params$ref <- "master"
  }

  params
}

