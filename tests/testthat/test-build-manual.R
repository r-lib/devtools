test_that("build_manual() shows stderr on failure", {
  pkg <- local_package_create()
  pkg <- normalizePath(pkg)

  # Create a mock error similar to what callr::rcmd produces
  mock_error <- function(...) {
  cnd <- rlang::error_cnd(
      message = "System command 'R' failed",
      stderr = "! LaTeX Error: File `inconsolata.sty' not found."
    )
    stop(cnd)
  }
  local_mocked_bindings(rcmd = mock_error, .package = "callr")

  expect_snapshot(build_manual(pkg), error = TRUE, transform = function(x) {
    x <- gsub(pkg, "<pkgdir>", x, fixed = TRUE)
    x
  })
})
