# Tools for indexing package documentation by alias, and for finding
# the rd file for a given topic (alias).

find_topic <- function(pkg, topic) {
  pkg <- as.package(pkg)
  
  # First see if a man file of that name exists
  man <- file.path(pkg$path, "man", topic)
  if (file.exists(man)) return(basename(man))
  
  # Next, look in index  
  index <- topic_index(pkg)
  if (topic %in% names(index)) return(index[[topic]])
  
  # Finally, try adding .Rd to name
  man_rd <- file.path(pkg$path, "man", paste(topic, ".Rd"))
  if (file.exists(man)) return(basename(man))
  
  NULL
}

topic_indices <- new.env(parent = emptyenv())
topic_index <- function(pkg) {
  pkg <- as.package(pkg)
  
  if (!exists(pkg$package, topic_indices)) {    
    topic_indices[[pkg$package]] <- build_topic_index(pkg)
  }
  topic_indices[[pkg$package]]
}

clear_topic_index <- function(pkg) {
  pkg <- as.package(pkg)
  topic_indices[[pkg$package]] <- NULL
  
  invisible(TRUE)
}

build_topic_index <- function(pkg) {
  pkg <- as.package(pkg)
  
  rds <- dir(file.path(pkg, "man"), full.names = TRUE)
  names(rds) <- basename(rds)
  
  aliases <- function(path) {
    parsed <- parse_Rd(path)
    tags <- vapply(parsed, function(x) attr(x, "Rd_tag")[[1]], character(1))
    unlist(parsed[tags == "\\alias"])
  }
  
  invert(lapply(rds, aliases))
}

invert <- function(L) {
  t1 <- unlist(L)
  names(t1) <- rep(names(L), lapply(L, length))
  tapply(names(t1), t1, c)
}
