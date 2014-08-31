uses_git <- function(pkg = ".") {
  if (!file.info(pkg)$isdir) return(FALSE)
  pkg <- as.package(pkg)
  file.exists(file.path(pkg$path, ".git"))
}

git <- function(args, quiet = TRUE, path = ".") {
  full <- paste0(shQuote(git_path()), " ", paste(args, collapse = ""))
  if (!quiet) {
    message(full)
  }

  result <- in_dir(path, system(full, intern = TRUE, ignore.stderr = quiet))

  status <- attr(result, "status") %||% 0
  if (!identical(as.character(status), "0")) {
    stop("Command failed (", status, ")", call. = FALSE)
  }

  result
}

git_sha1 <- function(n = 10, path = ".") {
  sha <- git(c("rev-parse", " --short=", n, " HEAD"), path = path)
  if (uncommitted(path)) sha <- paste0(sha, "*")
  sha
}

uncommitted <- function(path = ".") {
  in_dir(path, system("git diff-index --quiet --cached HEAD") == 1 ||
    system("git diff-files --quiet") == 1)
}


github_info <- function(pkg = ".") {
  pkg <- as.package(pkg)
  if (!uses_git(pkg$path)) return(github_dummy)

  remotes <- git("remote -v", path = pkg$path)
  remotes_df <- read.table(text = remotes, stringsAsFactors = FALSE)
  names(remotes_df) <- c("name", "url", "type")

  github_url <- remotes_df[remotes_df$name == "origin", ]$url[[1]]
  parse_github_remote(github_url)
}

github_dummy <- list(username = "<USERNAME>", repo = "<REPO>")

parse_github_remote <- function(x) {
  if (length(x) == 0) return(github_dummy)
  if (!grepl("github", x)) return(github_dummy)

  if (grepl("^https", x)) {
    # https://github.com/hadley/devtools.git
    re <- "github.com/(.*?)/(.*)\\.git"
  } else if (grepl("^git", x)) {
    # git@github.com:hadley/devtools.git
    re <- "github.com:(.*?)/(.*)\\.git"
  } else {
    stop("Unknown github repo format", call. = FALSE)
  }

  m <- regexec(re, x)
  match <- regmatches(x, m)[[1]]
  list(username = match[2], repo = match[3])
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
