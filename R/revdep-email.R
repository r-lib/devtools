#' @export
#' @rdname revdep_check
#' @usage NULL
revdep_email <- function(pkg = ".", date, author = getOption("devtools.name"),
                         draft = TRUE) {
  pkg <- as.package(pkg)

  if (is.null(author)) {
    stop("Must supply a name", call. = FALSE)
  }

  template_path <- file.path(pkg$path, "revdep", "email.md")
  if (!file.exists(template_path)) {
    stop("Can't find template `revdep/email.md`", call. = FALSE)
  }
  template <- readLines(template_path)

  results <- readRDS(revdep_check_path(pkg))$results

  maintainers <- vapply(results, function(x) x$maintainer, character(1))
  orphaned <- grepl("ORPHAN", maintainers)
  if (any(orphaned)) {
    orphans <- paste(names(results)[orphaned], collapse = ", ")
    message("Dropping ", sum(orphaned), " packages: ", orphans)

    results <- results[!orphaned]
    maintainers <- maintainers[!orphaned]
  }

  gh <- github_info(pkg$path)
  data <- lapply(results, maintainer_data, pkg = pkg, gh = gh, date = date,
    author = author)
  bodies <- lapply(data, whisker::whisker.render, template = template)
  subjects <- lapply(data, function(x) {
    paste0(x$your_package, " and " , x$my_package, " release")
  })

  emails <- Map(maintainer_email, bodies, maintainers, subjects)

  if (draft) {
    httr::with_verbose(lapply(emails, gmailr::create_draft), data_in = TRUE)
  } else {
    lapply(emails, gmailr::send_message)
  }

  invisible(TRUE)
}

maintainer_data <- function(result, pkg, gh, date, author) {
  problems <- result$results
  list(
    your_package = result$package,
    your_version = result$version,
    your_summary = summarise_check_results(problems),
    your_results = indent(trunc_middle(unlist(problems))),

    you_have_problems = length(unlist(problems)) > 0,

    me = author,
    date = date,
    my_package = pkg$package,
    my_github = gh$fullname
  )
}

maintainer_email <- function(to, body, subject) {
  email <- gmailr::mime()
  email <- gmailr::to(email, to)
  email <- gmailr::text_body(email, body)
  gmailr::subject(email, subject)
}
