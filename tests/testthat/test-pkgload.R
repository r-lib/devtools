test_that("load_all() errors if called recursively", {
  local_mocked_bindings(is_loading = function() TRUE)
  expect_snapshot(load_all(), error = TRUE)
})
