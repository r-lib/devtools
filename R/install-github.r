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

  params <- github_parse_path(repo)
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
    
    # Ensure the DESCRIPTION ends with a newline
    desc <- file.path(pkg_path, "DESCRIPTION")
    if (!ends_with_newline(desc))
      cat("\n", sep="", file = desc, append = TRUE)
    
    # Function to append a field to the DESCRIPTION if it's not null
    append_field <- function(name, value) {
      if (!is.null(value)) {
        cat("Github", name, ":", value, "\n", sep = "", file = desc, append = TRUE)
      }
    }
    
    # Append fields
    append_field("Repo", repo)
    append_field("Username", username)
    append_field("Ref", ref)
    append_field("SHA1", github_extract_sha1(bundle))
    append_field("Pull", pull)
    append_field("Subdir", subdir)
    append_field("Branch", branch)
    append_field("AuthUser", auth_user)
    # Don't record password for security reasons
    #append_field("Password" password)
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
  subdir_rx <- "(?:/([^@#]+))?"
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
