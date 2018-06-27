# adapted from https://github.com/ropenscilabs/tic/blob/dceaff9c6f49274dacab729083dbf34dbf5ec099/R/git2r.R
git2r_attrib <- function(x, name) {
  if (utils::packageVersion("git2r") > "0.21.0") {
    x[[name]]
  } else {
    methods::slot(x, name)
  }
}

git2r_head <- function(x) {
  if (utils::packageVersion("git2r") > "0.21.0") {
    (utils::getFromNamespace("repository_head", "git2r"))(x)
  } else {
    (utils::getFromNamespace("head", "git2r"))(x)
  }
}
