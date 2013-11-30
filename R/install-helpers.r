#' Appends new fields to DESCRIPTION file
#' 
#' This is used by the suite of \code{install_*} functions mainly to reduce 
#' code duplication.
#' 
#' @param bundle the package bundle (zip) location
#' @param pkg_path the package (unzipped bundle) location
#' @param prefix The repository name (e.g. Github, Bitbucket). A character 
#' object
#' @param ... the fields to append to the \code{DESCRIPTION} file
#' @return Return a function which will append information related to the source
#' repository (e.g. GitHub, Bitbucket) to the package \code{DESCRIPTION} file.

update_description <- function (bundle, pkg_path, prefix, ...) {  
  
  # Ensure the DESCRIPTION ends with a newline
  desc <- file.path(pkg_path, "DESCRIPTION")
  if (!ends_with_newline(desc))
    cat("\n", sep="", file = desc, append = TRUE)
  
  # Function to append a field to the DESCRIPTION if it's not null
  append_field <- function (name, value) {
    if (!is.null(value)) {
      cat(prefix, name, ":", value, "\n", sep = "", file = desc, 
          append = TRUE)
    }
  }
  
  fields <- list(...)
  Map(append_field, names(fields), fields)    
  
}

# Extract the commit hash from a github bundle and append it to the
# package DESCRIPTION file. Git archives include the SHA1 hash as the 
# comment field of the zip central directory record 
# (see https://www.kernel.org/pub/software/scm/git/docs/git-archive.html)
# Since we know it's 40 characters long we seek that many bytes minus 2 
# (to confirm the comment is exactly 40 bytes long)
extract_sha1 <- function(bundle) {
  
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

# Parse repo_param of the form [username/]repo[/subdir][#pull|@ref] 
# Called from eg. install_github(repo=repo_param)
parse_repo_param <- function (path) {
  username_rx <- "(?:([^/]+)/)?"
  repo_rx <- "([^/@#]+)"
  subdir_rx <- "(?:/([^@#]+))?"
  ref_rx <- "(?:@(.+))"
  pull_rx <- "(?:#([0-9]+))"
  ref_or_pull_rx <- sprintf("(?:%s|%s)?", ref_rx, pull_rx)
  rx <- sprintf("^(?:%s%s%s%s|(.*))$",
                username_rx, repo_rx, subdir_rx, ref_or_pull_rx)
  
  params <- c("username", "repo", "subdir", "ref", "pull", "invalid")
  replace <- setNames(sprintf("\\%d", seq_along(params)), params)
  ret <- lapply(replace, function(r) gsub(rx, r, path, perl = TRUE))
  if (ret$invalid != "")
    stop(sprintf("Invalid GitHub path: %s", path))
  ret[sapply(ret, nchar) > 0]
}

