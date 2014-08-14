uses_git <- function(pkg = ".") {
  pkg <- as.package(pkg)
  file.exists(file.path(pkg$path, ".git"))
}

git <- function(pkg = ".", args, quiet = FALSE) {
  pkg <- as.package(pkg)

  full <- paste(shQuote(git_path()), " ", paste(args, collapse = ", "), sep = "")
  result <- in_dir(pkg$path, system(full, intern = TRUE, ignore.stderr = quiet))

  status <- attr(result, "status") %||% 0
  if (!identical(as.character(status), "0")) {
    stop("Command failed (", status, ")", call. = FALSE)
  }

  result
}

github_info <- function(pkg = ".") {
  pkg <- as.package(pkg)
  if (!uses_git(pkg)) return(github_dummy)

  remotes <- git(pkg, "remote -v")
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
