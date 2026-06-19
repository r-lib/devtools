test_that("check_bug_reports() passes when BugReports is present", {
  dir <- local_package_create()
  desc::desc_set(
    "BugReports",
    "https://github.com/example/pkg/issues",
    file = dir
  )
  expect_snapshot(check_bug_reports(dir))
})

test_that("check_bug_reports() warns when BugReports is missing", {
  dir <- local_package_create()
  expect_snapshot(check_bug_reports(dir))
})
