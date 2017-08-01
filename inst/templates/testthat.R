if (requireNamespace("testthat", quietly = TRUE)) {
  library(testthat)
  library({{{ name }}})

  test_check("{{{ name }}}")
} else {
    warning("Tests not run. testthat package not present.", call. = FALSE)
}


