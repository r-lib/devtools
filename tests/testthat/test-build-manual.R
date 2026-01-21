test_that("build_manual() shows stderr on failure", {
  skip_on_os("windows")

  pkg <- local_package_create()
  pkg <- normalizePath(pkg)

  # Too hard to replicate actual error, so we just simulate
  local_mocked_bindings(rd2pdf = function(...) {
    rlang::abort(
      "System command 'R' failed",
      stderr = "! LaTeX Error: File `inconsolata.sty' not found."
    )
  })

  expect_snapshot(build_manual(pkg), error = TRUE, transform = function(x) {
    x <- gsub(pkg, "<pkgdir>", x, fixed = TRUE)
    x
  })
})
