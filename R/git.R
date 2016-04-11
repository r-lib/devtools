uses_git <- function(path = ".") {
  !is.null(git2r::discover_repository(path))
}

git_sha1 <- function(n = 10, path = ".") {
  r <- git2r::repository(path, discover = TRUE)
  sha <- git2r::branch_target(git2r::head(r)) # sha of most recent commit
  substr(sha, 1, n)
}

git_uncommitted <- function(path = ".") {
  r <- git2r::repository(path, discover = TRUE)
  st <- vapply(git2r::status(r), length, integer(1))
  any(st != 0)
}

git_sync_status <- function(path = ".") {
  r <- git2r::repository(path, discover = TRUE)

  r_head <- git2r::head(r)
  if (!methods::is(r_head, "git_branch")) {
    return(invisible(FALSE))
  }

  upstream <- git2r::branch_get_upstream(r_head)
  # fetch(r, branch_remote_name(upstream))

  if (is.null(upstream)) {
    return(invisible(FALSE))
  }

  c1 <- git2r::lookup(r, git2r::branch_target(r_head))
  c2 <- git2r::lookup(r, git2r::branch_target(upstream))
  ab <- git2r::ahead_behind(c1, c2)

#   if (ab[1] > 0)
#     message(ab[1], " ahead of remote")
#   if (ab[2] > 0)
#     message(ab[2], " behind remote")

  invisible(any(ab != 0))
}

# Retrieve the current running path of the git binary.
# @param git_binary_name The name of the binary depending on the OS.
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


# GitHub ------------------------------------------------------------------

uses_github <- function(path = ".") {
  if (!uses_git(path))
    return(FALSE)

  r <- git2r::repository(path, discover = TRUE)
  r_remote_urls <- git2r::remote_url(r)

  any(grepl("github", r_remote_urls))
}

github_info <- function(path = ".", remote_name = NULL) {
  if (!uses_github(path))
    return(github_dummy)

  r <- git2r::repository(path, discover = TRUE)
  r_remote_urls <- grep("github", remote_urls(r), value = TRUE)

  if (!is.null(remote_name) && !remote_name %in% names(r_remote_urls))
    stop("no github-related remote named ", remote_name, " found")

  remote_name <- c(remote_name, "origin", names(r_remote_urls))
  x <- r_remote_urls[remote_name]
  x <- x[!is.na(x)][1]

  github_remote_parse(x)
}

github_dummy <- list(username = "<USERNAME>", repo = "<REPO>")

remote_urls <- function(r) {
  remotes <- git2r::remotes(r)
  stats::setNames(git2r::remote_url(r, remotes), remotes)
}

github_remote_parse <- function(x) {
  if (length(x) == 0) return(github_dummy)
  if (!grepl("github", x)) return(github_dummy)

  if (grepl("^https", x)) {
    # https://github.com/hadley/devtools.git
    re <- "github.com/(.*?)/(.*)\\.git"
  } else if (grepl("^git", x)) {
    # git@github.com:hadley/devtools.git
    re <- "github.com:(.*?)/(.*)\\.git"
  } else {
    stop("Unknown GitHub repo format", call. = FALSE)
  }

  m <- regexec(re, x)
  match <- regmatches(x, m)[[1]]
  list(
    username = match[2],
    repo = match[3],
    fullname = paste0(match[2], "/", match[3])
  )
}

# Extract the commit hash from a git archive. Git archives include the SHA1
# hash as the comment field of the zip central directory record
# (see https://www.kernel.org/pub/software/scm/git/docs/git-archive.html)
# Since we know it's 40 characters long we seek that many bytes minus 2
# (to confirm the comment is exactly 40 bytes long)
git_extract_sha1 <- function(bundle) {

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
