context("Check")

test_that("aspell environment variables", {
  with_mock(
    `utils:::aspell_find_program` = function (...) "/bin/aspell",
    expect_equal(names(aspell_env_var()), "_R_CHECK_CRAN_INCOMING_USE_ASPELL_")
  )
  with_mock(
    `utils:::aspell_find_program` = function (...) NA,
    expect_warning(aspell_env_var(), "Skipping spell check")
  )
})
