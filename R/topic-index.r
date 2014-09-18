# Tools for indexing package documentation by alias, and for finding
# the rd file for a given topic (alias).

# @return path to rd file within package
find_pkg_topic <- function(pkg = ".", topic) {
  pkg <- as.package(pkg)

  # First see if a man file of that name exists
  man <- file.path(pkg$path, "man", topic)
  if (file.exists(man)) return(basename(man))

  # Next, look in index
  index <- topic_index(pkg)
  if (topic %in% names(index)) return(index[[topic]])

  # Finally, try adding .Rd to name
  man_rd <- file.path(pkg$path, "man", paste0(topic, ".Rd"))
  if (file.exists(man_rd)) return(basename(man_rd))

  NULL
}

#' Find the rd file that documents a topic.
#'
#' Only packages loaded by devtools are searched.
#'
#' @param topic The topic, a string.
#' @return A named string. The values gives the path to file; the name gives
#'   the path to package.
#' @export
#' @keywords internal
#' @examples
#' find_topic("help")
find_topic <- function(topic) {
  if (is.null(topic) || topic == "") return(NULL)

  pieces <- strsplit(topic, "::")[[1]]
  if (length(pieces) == 1) {
    pkgs <- dev_packages()
  } else {
    pkgs <- pieces[1]
    topic <- pieces[2]
  }

  for (pkg in pkgs) {
    path <- getNamespaceInfo(pkg, "path")
    rd <- find_pkg_topic(path, topic)
    if (!is.null(rd)) return(setNames(file.path(path, "man", rd), path))
  }

  NULL
}

topic_indices <- new.env(parent = emptyenv())
topic_index <- function(pkg = ".") {
  pkg <- as.package(pkg)

  if (!exists(pkg$package, topic_indices)) {
    topic_indices[[pkg$package]] <- build_topic_index(pkg)
  }
  topic_indices[[pkg$package]]
}

clear_topic_index <- function(pkg = ".") {
  pkg <- as.package(pkg)
  if (exists(pkg$package, topic_indices)) {
    rm(list = pkg$package, envir = topic_indices)
  }

  invisible(TRUE)
}

build_topic_index <- function(pkg = ".") {
  pkg <- as.package(pkg)
  rds <- rd_files(pkg)

  aliases <- function(path) {
    parsed <- tools::parse_Rd(path)
    tags <- vapply(parsed, function(x) attr(x, "Rd_tag")[[1]], character(1))
    unlist(parsed[tags == "\\alias"])
  }

  invert(lapply(rds, aliases))
}

invert <- function(L) {
  if (length(L) == 0) return(L)
  t1 <- unlist(L)
  names(t1) <- rep(names(L), lapply(L, length))
  tapply(names(t1), t1, c)
}
