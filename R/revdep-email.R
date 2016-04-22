#' Experimental email notification system.
#'
#' This currently assumes that you use github and gmail, and you have a
#' \code{revdep/email.md} email template.
#'
#' @inheritParams revdep_check
#' @param date Date package will be submitted to CRAN
#' @param author Name used to sign email
#' @param draft If \code{TRUE}, creates as draft email; if \code{FALSE},
#'   sends immediately.
#' @param template Path of template to use
#' @param only_problems Only inform authors with problems?
#' @param unsent If some emails fail to send, in a previous
#' @keywords internal
#' @export
revdep_email <- function(pkg = ".", date,
                         author = getOption("devtools.name"),
                         draft = TRUE,
                         unsent = NULL,
                         template = "revdep/email.md",
                         only_problems = FALSE) {

  pkg <- as.package(pkg)
  force(date)
  if (is.null(author)) {
    stop("Please supply `author`", call. = FALSE)
  }

  if (is.null(unsent)) {
    results <- readRDS(revdep_check_path(pkg))$results
  } else {
    results <- unsent
  }

  if (only_problems) {
    results <- Filter(has_problems, results)
  }

  if (length(results) == 0) {
    message("No emails to send")
    return(invisible())
  }

  template_path <- file.path(pkg$path, template)
  if (!file.exists(template_path)) {
    stop("`", template, "` does not exist", call. = FALSE)
  }
  template <- readLines(template_path)

  maintainers <- vapply(results, function(x) x$maintainer, character(1))
  orphaned <- grepl("ORPHAN", maintainers)
  if (any(orphaned)) {
    orphans <- paste(names(results)[orphaned], collapse = ", ")
    message("Dropping ", sum(orphaned), " orphaned packages: ", orphans)

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

  emails <- Map(maintainer_email, maintainers, bodies, subjects)

  message("Testing first email")
  send_email(emails[[1]], draft = TRUE)

  if (yesno("Did first draft email look ok?"))
    return(invisible())

  sent <- vapply(emails, send_email, draft = draft, FUN.VALUE = logical(1))

  if (all(sent)) {
    message("All emails successfully sent")
  } else {
    message(sum(!sent), " failed. Call again with unsent = .Last.value")
  }

  results <- results[!sent]
  invisible(results)
}

send_email <- function(email, draft = TRUE) {
  send <- if (draft) gmailr::create_draft else gmailr::send_message
  msg <- if (draft) "Drafting" else "Sending"
  tryCatch(
    {
      message(msg, ": ", gmailr::subject(email))
      send(email)
      TRUE
    },
    interrupt = function(e) {
      message("Aborted by user")
      invokeRestart("abort")
    },
    error = function(e) {
      message("Failed")
      FALSE
    }
  )
}

maintainer_data <- function(result, pkg, gh, date, author) {
  problems <- result$results

  summary <- indent(paste(trunc_middle(unlist(problems)), collapse = "\n\n"))
  list(
    your_package = result$package,
    your_version = result$version,
    your_summary = summarise_check_results(problems),
    your_results = summary,

    you_have_problems = length(unlist(problems)) > 0,

    me = author,
    date = date,
    my_package = pkg$package,
    my_github = gh$fullname
  )
}

maintainer_email <- function(to, body, subject) {
  gmailr::mime(To = to, Subject = subject, body = body)
}
