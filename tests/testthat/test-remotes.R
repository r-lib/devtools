test_that("github_ functions are deprecated", {
  expect_snapshot({
    . <- github_pull(1)
    . <- github_release()
  })
})

test_that("update_packages() recommends remotes for installed packages", {
  withr::local_options(lifecycle_verbosity = "warning")
  local_mocked_bindings(
    check_installed = function(...) invokeRestart("skip_package_update")
  )

  expect_snapshot(
    withRestarts(
      update_packages(),
      skip_package_update = function() invisible(NULL)
    )
  )
})
