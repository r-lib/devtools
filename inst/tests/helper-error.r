no_warn_error <- function() {
  function(expr) {
    err <- FALSE
    warn <- FALSE

    withCallingHandlers(
      tryCatch(force(expr), error = function(e) { err <<- TRUE }),
      warning = function(w) {
        warn <<- TRUE
        invokeRestart("muffleWarning")
      }
    )

    if (err && warn) {
      expectation(FALSE, "code generated an error and a warning")
    } else if (err && !warn) {
      expectation(FALSE, "code generated an error")
    } else if (!err && warn) {
      expectation(FALSE, "code generated a warning")
    } else {
      expectation(TRUE, "")
    }
  }
}

expect_no_warn_error <- function(object, info = NULL, label = NULL) {
  if (is.null(label)) {
    label <- testthat:::find_expr("object")
  }
  expect_that(object, no_warn_error(), info = info, label = label)
}
