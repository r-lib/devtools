
context("With")

test_that("with_env sets and unsets variables", {
  
  # Make sure the "set_env_testvar" environment var is not set.
  Sys.unsetenv("set_env_testvar")
  expect_false("set_env_testvar" %in% names(Sys.getenv()))
  
  # Use with_env (which calls set_env) to temporarily set it to 1
  expect_identical("1", with_env(c("set_env_testvar" = 1), 
    Sys.getenv("set_env_testvar")))
  
  # set_env_testvar shouldn't stay in the list of environment vars 
  expect_false("set_env_testvar" %in% names(Sys.getenv()))
})