#' Attempts to install a package directly from github.
#'
#' This function is vectorised on \code{repo} so you can install multiple
#' packages in a single command.
#'
#' @param repo Repository address in the format
#'   \code{[username/]repo[/subdir][@@ref|#pull]}. Alternatively, you can
#'   specify \code{username}, \code{subdir} and/or \code{ref} using the
#'   respective parameters (see below); if both is specified, the values in
#'   \code{repo} take precedence.
#' @param username User name
#' @param ref Desired git reference. Could be a commit, tag, or branch
#'   name, or a call to \code{\link{github_pull}}. Defaults to \code{"master"}.
#' @param subdir subdirectory within repo that contains the R package.
#' @param auth_user your account username if you're attempting to install
#'   a package hosted in a private repository (and your username is different
#'   to \code{username})
#' @param password your password
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
#' install_github(c("devtools@@devtools-1.4", "klutometis/roxygen#142", "mfrasca/r-logging/pkg))
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
install_github <- function(repo, username = getOption("github.user"),
                           ref = "master", subdir = NULL,
                           auth_user = NULL, password = NULL,
                           auth_token = github_pat(), ...,
                           dependencies = TRUE) {

  invisible(vapply(repo, install_github_single, FUN.VALUE = logical(1),
    username = username, ref = ref, subdir = subdir,
    auth_user = auth_user, password = password, auth_token = auth_token, ...,
    dependencies = dependencies))
}

github_get_conn <- function(repo, username = getOption("github.user"),
                            ref = "master", pull = NULL, subdir = NULL,
                            branch = NULL, auth_user = NULL, password = NULL,
                            auth_token = NULL, ...) {

  if (!is.null(branch)) {
    warning("'branch' is deprecated. In the future, please use 'ref' instead.")
    ref <- branch
  }

  if (!is.null(pull)) {
    warning("'pull' is deprecated. In the future, please use 'ref = github_pull(...)' instead.")
    ref <- github_pull(pull)
  }

  params <- github_parse_path(repo)
  params <- github_assign_ref(params)
  username <- params$username %||% username
  repo <- params$repo
  ref <- params$ref %||% ref
  subdir <- params$subdir %||% subdir

  if (!is.null(password)) {
    warning("'password' is deprecated. Please use 'auth_token' instead",
      call. = FALSE)
    auth <- httr::authenticate(
      user = auth_user %||% username,
      password = password,
      type = "basic"
    )
  } else if (!is.null(auth_token)) {
    auth <- httr::authenticate(
      user = auth_token,
      password = "x-oauth-basic",
      type = "basic"
    )
  } else {
    auth <- list()
  }

  param <- list(
    auth = auth, repo = repo, username = username,
    ref = ref, subdir = subdir,
    auth_user = auth_user, password = password
  )

  param <- modifyList(param, github_ref(param$ref, param))

  param$msg <- paste(
    "Installing github repo",
    paste(param$repo, param$ref, sep = "/", collapse = ", "),
    "from",
    paste(username, collapse = ", "))

  param$url <- paste(
    "https://api.github.com", "repos", param$username, param$repo,
    "zipball", param$ref, sep = "/")

  param
}

install_github_single <- function(repo, username = getOption("github.user"),
                                  ref = "master", pull = NULL, subdir = NULL,
                                  branch = NULL, auth_user = NULL,
                                  password = NULL, auth_token = NULL, ...) {
  conn <- github_get_conn(repo, username, ref, pull, subdir, branch,
    auth_user, password, auth_token, ...)
  message(conn$msg)

  # define before_install function that captures the arguments to
  # install_github and appends the to the description file
  github_before_install <- function(bundle, pkg_path) {

    desc <- file.path(pkg_path, "DESCRIPTION")

    # Remove any blank lines from DESCRIPTION -- this protects users from
    # 'Error: contains a blank line' errors thrown by R CMD INSTALL
    DESCRIPTION <- readLines(desc, warn = FALSE)
    if (any(DESCRIPTION == "")) {
      DESCRIPTION <- DESCRIPTION[DESCRIPTION != ""]
    }
    cat(DESCRIPTION, file = desc, sep = "\n")

    # Function to append a field to the DESCRIPTION if it's not null
    append_field <- function(name, value) {
      if (!is.null(value)) {
        cat("Github", name, ":", value, "\n", sep = "", file = desc, append = TRUE)
      }
    }

    # Append fields
    append_field("Repo", conn$repo)
    append_field("Username", conn$username)
    append_field("Ref", conn$ref)
    append_field("SHA1", github_extract_sha1(bundle))
    append_field("Pull", conn$pull)
    append_field("Subdir", conn$subdir)
    append_field("Branch", conn$branch)
    append_field("AuthUser", conn$auth_user)
    # Don't record password for security reasons
    #append_field("Password", conn$password)
  }

  # The downloaded file is always named by the package's name with extension .zip.
  # install_github("shiny", "rstudio", "v/0/2/1")
  #  URL: https://api.github.com/repos/rstudio/shiny/zipball/v/0/2/1
  #  Output file: shiny.zip
  install_url(conn$url, name = paste(conn$repo, ".zip", sep = ""), subdir = conn$subdir,
    config = conn$auth, before_install = github_before_install, ...)
}

github_ref <- function(x, param) UseMethod("github_ref")
github_ref.default <- function(x, param) list(ref=x)
github_ref.pull <- function(x, param) {
  github_pull_info(param$repo, param$username, x)
}

#' Install a specific pull request from GitHub
#'
#' Use as \code{ref} parameter to \code{\link{install_github}}.
#'
#' @param pull The pull request to install
#' @seealso \code{\link{install_github}}
#' @export
github_pull <- function(pull) structure(pull, class = "pull")


# Retrieve the username and ref for a pull request
github_pull_info <- function(repo, username, pull) {
  host <- "https://api.github.com"
  # GET /repos/:user/:repo/pulls/:number
  path <- paste("repos", username, repo, "pulls", pull, sep = "/")
  r <- GET(host, path = path)
  stop_for_status(r)
  response <- httr::content(r, as = "parsed")

  list(repo = repo, username = response$user$login, ref = response$head$ref)
}

# Extract the commit hash from a github bundle and append it to the
# package DESCRIPTION file. Git archives include the SHA1 hash as the
# comment field of the zip central directory record
# (see https://www.kernel.org/pub/software/scm/git/docs/git-archive.html)
# Since we know it's 40 characters long we seek that many bytes minus 2
# (to confirm the comment is exactly 40 bytes long)
github_extract_sha1 <- function(bundle) {

  # open the bundle for reading
  conn <- file(bundle, open = "rb", raw = TRUE)
  on.exit(close(conn))

  # seek to where the comment length field should be recorded
  seek(conn, where = -0x2a, origin = "end")

  # verify the comment is length 0x28
  len <- readBin(conn, "raw", n = 2)
  if (len[1] == 0x28 && len[2] == 0x00) {
    # read and return the SHA1
    rawToChar(readBin(conn, "raw", n = 0x28))
  } else {
    NULL
  }
}

# Parse a GitHub path of the form [username/]repo[/subdir][#pull|@ref]
github_parse_path <- function(path) {
  username_rx <- "(?:([^/]+)/)?"
  repo_rx <- "([^/@#]+)"
  subdir_rx <- "(?:/([^@#]*[^@#/]))?"
  ref_rx <- "(?:@(.+))"
  pull_rx <- "(?:#([0-9]+))"
  ref_or_pull_rx <- sprintf("(?:%s|%s)?", ref_rx, pull_rx)
  github_rx <- sprintf("^(?:%s%s%s%s|(.*))$",
    username_rx, repo_rx, subdir_rx, ref_or_pull_rx)

  params <- c("username", "repo", "subdir", "ref", "pull", "invalid")
  replace <- setNames(sprintf("\\%d", seq_along(params)), params)
  ret <- lapply(replace, function(r) gsub(github_rx, r, path, perl = TRUE))
  if (ret$invalid != "")
    stop(sprintf("Invalid GitHub path: %s", path))
  ret[sapply(ret, nchar) > 0]
}

github_assign_ref <- function(params) {
  if (!is.null(params$pull)) {
    params$ref <- github_pull(params$pull)
    params$pull <- NULL
  }

  params
}

#' Retrieve Github personal access token.
#'
#' Looks in env var \code{GITHUB_PAT}.
#'
#' @keywords internal
#' @export
github_pat <- function() {
  pat <- Sys.getenv('GITHUB_PAT')
  if (identical(pat, "")) return(NULL)

  message("Using github PAT from envvar GITHUB_PAT")
  pat
}
