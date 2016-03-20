#' Spell checking
#'
#' Runs a spell check on text fields in the package description file and
#' manual pages.
#'
#' @export
#' @rdname spell_check
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param ignore character vector with words to ignore. See
#'   \code{\link[hunspell:hunspell]{hunspell}} for more information
spell_check <- function(pkg = ".", ignore = character()){
  pkg <- as.package(pkg)
  ignore <- c(pkg$package, hunspell::en_stats, ignore)

  # Check Rd manual files
  rd_files <- list.files(file.path(pkg$path, "man"), "\\.Rd$", full.names = TRUE)
  rd_lines <- lapply(sort(rd_files), spell_check_rd, ignore = ignore)

  # Check 'DESCRIPTION' fields
  pkg_fields <- c("title", "description")
  pkg_lines <- lapply(pkg_fields, function(x){
    spell_check_file(textConnection(pkg[[x]]), ignore = ignore)
  })

  # Combine
  all_sources <- c(rd_files, pkg_fields)
  all_lines <- c(rd_lines, pkg_lines)
  words_by_file <- lapply(all_lines, names)
  bad_words <- sort(unique(unlist(words_by_file)))

  # Find all occurences for each word
  out <- lapply(bad_words, function(word) {
    index <- which(vapply(words_by_file, `%in%`, x = word, logical(1)))
    reports <- vapply(index, function(i){
      paste0(basename(all_sources[i]), ":", all_lines[[i]][word])
    }, character(1))
  })
  structure(out, names = bad_words, class = "spellcheck")
}

#' @export
print.spellcheck <- function(x, ...){
  words <- names(x)
  fmt <- paste0("%-", max(nchar(words)) + 3, "s")
  pretty_names <- sprintf(fmt, words)
  cat(sprintf(fmt, "  WORD"), "  FOUND IN\n", sep = "")
  for(i in seq_along(x)){
    cat(pretty_names[i])
    cat(paste(x[[i]], collapse = ", "))
    cat("\n")
  }
}

spell_check_text <- function(text, ignore){
  bad_words <- hunspell::hunspell(text, ignore = ignore)
  vapply(sort(unique(unlist(bad_words))), function(word) {
    line_numbers <- which(vapply(bad_words, `%in%`, x = word, logical(1)))
    paste(line_numbers, collapse = ",")
  }, character(1))
}

spell_check_file <- function(file, ignore){
  spell_check_text(readLines(file), ignore = ignore)
}

spell_check_rd <- function(rdfile, ignore){
  text <- tools::RdTextFilter(rdfile)
  spell_check_text(text, ignore = ignore)
}
