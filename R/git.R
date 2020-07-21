uses_git <- function(path = ".") {
  dir.exists(file.path(path, ".git"))
}

git_branch <- function(path = ".") {
  withr::local_dir(path)

  system2("git", c("rev-parse", "--abbrev-ref", "HEAD"), stdout = TRUE)
}

git_uncommitted <- function(path = ".") {
  withr::local_dir(path)

  out <- system2("git", c("status", "--porcelain=v1"), stdout = TRUE)
  length(out) > 0
}
