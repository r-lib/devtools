#' Install a package from a Bioconductor repository
#'
#' This function requires \code{svn} to be installed on your system in order to
#' be used.
#'
#' It is vectorised so you can install multiple packages with
#' a single command.
#'
#' '
#' @inheritParams install_git
#' @param repo Repository address in the format
#'   \code{[username:password@@][release/]repo[#revision]}. Valid values for
#'   the release are \sQuote{devel} (the default if none specified),
#'   \sQuote{release} or numeric release numbers (e.g. \sQuote{3.3}).
#' @param mirror The bioconductor SVN mirror to use
#' @param ... Other arguments passed on to \code{\link{install}}
#' @export
#' @family package installation
#' @examples
#' \dontrun{
#' install_bioc("SummarizedExperiment")
#' install_bioc("user@SummarizedExperiment")
#' install_bioc("user:password@release/SummarizedExperiment")
#' install_bioc("user:password@3.3/SummarizedExperiment")
#' install_bioc("user:password@3.3/SummarizedExperiment#117513")
#'}
install_bioc <- function(repo, mirror = getOption("BioC_svn", "https://hedgehog.fhcrc.org/bioconductor"), ..., quiet = FALSE) {

  remotes <- lapply(repo, bioc_remote, mirror = mirror)

  install_remotes(remotes, ..., quiet = quiet)
}

# Parse concise SVN repo specification: [username[:password]@][branch/]repo[#revision]
parse_bioc_repo <- function(path) {
  user_pass_rx <- "(?:(?:([^:]+):)?([^:@]+)@)?"
  release_rx <- "(?:(devel|release|[0-9.]+)/)?"
  repo_rx <- "([^/@#]+)"
  revision_rx <- "(?:[#][Rr]?([0-9]+))?"
  bioc_rx <- sprintf("^(?:%s%s%s%s|(.*))$", user_pass_rx, release_rx, repo_rx, revision_rx)

  param_names <- c("username", "password", "release", "repo", "revision", "invalid")
  replace <- stats::setNames(sprintf("\\%d", seq_along(param_names)), param_names)
  params <- lapply(replace, function(r) gsub(bioc_rx, r, path, perl = TRUE))
  if (params$invalid != "")
    stop(sprintf("Invalid bioc repo: %s", path))
  params <- params[sapply(params, nchar) > 0]

  if (!is.null(params$password) && is.null(params$username)) {
    params$username <- params$password
    params$password <- NULL
  }

  params
}

bioc_remote <- function(repo, mirror = getOption("BioC_svn", "https://hedgehog.fhcrc.org/bioconductor")) {
  meta <- parse_bioc_repo(repo)

  meta$username <- meta$username %||% "readonly"

  if (meta$username == "readonly") {
    meta$password <- "readonly"
  }

  remote("bioc",
    mirror = mirror,
    username = meta$username,
    password = meta$password,
    repo = meta$repo,
    release = meta$release %||% "devel",
    revision = meta$revision
  )
}

#' @export
remote_download.bioc_remote <- function(x, quiet = FALSE) {
  if (!quiet) {
    message("Downloading Bioconductor repo ", x$repo)
  }

  bundle <- tempfile()
  svn_binary_path <- svn_path()

  args <- c(
    "co",
    bioc_args(x),
    bioc_url(x),
    bundle)

  if (!quiet) {
    message(svn_binary_path, " ", paste0(args, collapse = " "))
  }
  request <- system2(svn_binary_path, args, stdout = FALSE, stderr = FALSE)

  # This is only looking for an error code above 0-success
  if (request > 0) {
    stop("Error retrieving Bioc Remote `", x$repo, "`", call. = FALSE)
  }

  bundle
}

#' @export
remote_metadata.bioc_remote <- function(x, bundle = NULL, source = NULL) {

  if (!is.null(bundle)) {
    withr::with_dir(bundle, {
      revision <- svn_revision()
    })
  } else {
    revision <- NULL
  }

  list(
    RemoteType = "bioc",
    RemoteRepo = x$repo,
    RemoteMirror = x$mirror,
    RemoteRelease = x$release,
    RemoteUsername = x$username,
    RemotePassword = x$password,
    RemoteRevision = revision,
    RemoteSha = revision # for compatibility with other remotes
  )
}

#' @export
remote_package_name.bioc_remote <- function(remote, ...) {
  remote$repo
}

#' @export
remote_sha.bioc_remote <- function(remote, ...) {
  svn_revision(paste(c(bioc_args(remote), bioc_url(remote)), collapse = " "))
}

bioc_args <- function(x) {
  args <- c(
    if (!interactive()) {
      "--non-interactive"
    },
    if (!is.null(x$revision)) {
      c("--revision", x$revision)
    },
    "--username", x$username,
    if (!is.null(x$password)) {
      c("--password", x$password)
    })
}

bioc_url <- function(x) {
  to_svn_release <- function(x) {
    sprintf("RELEASE_%s", sub("[.]", "_", x))
  }

  switch(tolower(x$release),
    devel = file.path(x$mirror, "trunk", "madman", "Rpacks", x$repo),
    release = file.path(x$mirror, "branches", to_svn_release(bioconductor_release()), "madman", "Rpacks", x$repo),
    file.path(x$mirror, "branches", to_svn_release(x$release), "madman", "Rpacks", x$repo))
}

bioconductor_release <- memoise::memoise(function() {
  tmp <- tempfile()
  download.file("http://bioconductor.org/config.yaml", tmp, quiet = TRUE)

  gsub("release_version:[[:space:]]+\"([[:digit:].]+)\"", "\\1",
    grep("release_version:", readLines(tmp), value = TRUE))
})

format.bioc_remote <- function(x, ...) {
  "Bioc"
}
