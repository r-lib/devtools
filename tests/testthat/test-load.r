context("Loading")

test_that("Package root and subdirectory is working directory when loading", {
  expect_message(load_all("testLoadDir"), "[|].*/testLoadDir[|]")
  expect_message(load_all(file.path("testLoadDir", "R")), "[|].*/testLoadDir[|]")
})

test_that("user is queried if no package structure present", {
  with_mock(
    `devtools::interactive` = function() TRUE,
    `devtools::menu` = function(...) stop("menu() called"),
    `devtools::setup` = function(...) stop("setup() called"),
    `devtools::package_file` = function(..., path) file.path(path, ...),
    expect_error(load_all(file.path("testLoadDir", "R")),
                 "menu[(][)] called")
  )
})

test_that("setup is called upon user consent if no package structure present", {
  with_mock(
    `devtools::interactive` = function() TRUE,
    `devtools::menu` = function(choices, ...) match("Yes", choices),
    `devtools::setup` = function(...) stop("setup() called"),
    `devtools::package_file` = function(..., path) file.path(path, ...),
    expect_error(load_all(file.path("testLoadDir", "R")),
                 "setup[(][)] called")
  )
})

test_that("setup is called if no package structure present", {
  with_mock(
    `devtools::menu` = function(...) stop("menu() called"),
    `devtools::setup` = function(...) stop("setup() called"),
    `devtools::package_file` = function(..., path) file.path(path, ...),
    expect_error(load_all(file.path("testLoadDir", "R"), create = TRUE),
               "setup[(][)] called")
  )
})

test_that("error is thrown if no package structure present", {
  with_mock(
    `devtools::menu` = function(...) stop("menu() called"),
    `devtools::setup` = function(...) stop("setup() called"),
    `devtools::package_file` = function(..., path) file.path(path, ...),
    expect_error(load_all(file.path("testLoadDir", "R"), create = FALSE),
                 "No description at")
  )
})
