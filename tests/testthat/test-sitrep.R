test_that("print shows all checks passed", {
  local_reproducible_output(width = 60)
  x <- new_dev_sitrep(
    r_version = R_system_version("4.4.0"),
    r_path = "/usr/lib/R",
    devtools_version = package_version("2.4.6")
  )
  expect_snapshot(print(x))
})

test_that("print warns when R is out of date", {
  local_reproducible_output(width = 60)
  x <- new_dev_sitrep(
    r_version = R_system_version("4.3.0"),
    r_path = "/usr/lib/R",
    r_release_version = R_system_version("4.4.0"),
    devtools_version = package_version("2.4.6")
  )
  expect_snapshot(print(x))
})

test_that("print warns about outdated devtools deps", {
  local_reproducible_output(width = 60)
  x <- new_dev_sitrep(
    r_version = R_system_version("4.4.0"),
    r_path = "/usr/lib/R",
    devtools_version = package_version("2.4.6"),
    devtools_deps = data.frame(
      package = c("rlang", "cli"),
      latest = c("1.0.0", "1.0.0"),
      installed = c("1.0.0", "0.5.0"),
      status = c("ok", "behind")
    )
  )
  expect_snapshot(print(x))
})

test_that("print warns about missing devtools deps", {
  local_reproducible_output(width = 60)
  x <- new_dev_sitrep(
    r_version = R_system_version("4.4.0"),
    r_path = "/usr/lib/R",
    devtools_version = package_version("2.4.6"),
    devtools_deps = data.frame(
      package = c("rlang", "somepkg"),
      latest = c("1.0.0", "1.0.0"),
      installed = c("1.0.0", NA_character_),
      status = c("ok", "behind")
    )
  )
  expect_snapshot(print(x))
})

test_that("print notes dev versions of devtools deps", {
  local_reproducible_output(width = 60)
  x <- new_dev_sitrep(
    r_version = R_system_version("4.4.0"),
    r_path = "/usr/lib/R",
    devtools_version = package_version("2.4.6"),
    devtools_deps = data.frame(
      package = "usethis",
      latest = "3.2.1",
      installed = "3.2.1.9000",
      status = "ahead"
    )
  )
  expect_snapshot(print(x))
})

test_that("print warns about outdated package deps", {
  local_reproducible_output(width = 60)
  x <- new_dev_sitrep(
    r_version = R_system_version("4.4.0"),
    r_path = "/usr/lib/R",
    devtools_version = package_version("2.4.6"),
    pkg = list(package = "mypkg", path = "/tmp/mypkg"),
    pkg_deps = data.frame(
      package = c("dplyr", "tidyr"),
      latest = c("1.1.0", "1.1.0"),
      installed = c("1.0.0", "1.0.0"),
      status = c("behind", "behind")
    )
  )
  expect_snapshot(print(x))
})

test_that("print notes dev versions of package deps", {
  local_reproducible_output(width = 60)
  x <- new_dev_sitrep(
    r_version = R_system_version("4.4.0"),
    r_path = "/usr/lib/R",
    devtools_version = package_version("2.4.6"),
    pkg = list(package = "mypkg", path = "/tmp/mypkg"),
    pkg_deps = data.frame(
      package = "usethis",
      latest = "3.2.1",
      installed = "3.2.1.9000",
      status = "ahead"
    )
  )
  expect_snapshot(print(x))
})

test_that("print shows RStudio update message", {
  local_reproducible_output(width = 60)
  withr::local_envvar(POSITRON = "")
  x <- new_dev_sitrep(
    r_version = R_system_version("4.4.0"),
    r_path = "/usr/lib/R",
    devtools_version = package_version("2.4.6"),
    rstudio_version = "2024.04.0",
    rstudio_msg = "RStudio is out of date."
  )
  expect_snapshot(print(x))
})

test_that("compare_deps detects ahead packages", {
  result <- compare_deps(data.frame(
    package = c("rlang", "cli"),
    version = c("0.0.1", "0.0.1")
  ))
  expect_equal(result$status, c("ahead", "ahead"))
  expect_equal(result$latest, c("0.0.1", "0.0.1"))
})

test_that("compare_deps detects behind packages", {
  result <- compare_deps(data.frame(
    package = "rlang",
    version = "99999.0.0"
  ))
  expect_equal(result$status, "behind")
})

test_that("compare_deps reports missing packages", {
  result <- compare_deps(data.frame(
    package = c("rlang", "thereIsNoSuchPackage"),
    version = c("0.0.1", "1.0.0")
  ))
  expect_equal(result$status, c("ahead", "behind"))
  expect_true(is.na(result$installed[[2]]))
})

test_that("check_for_rstudio_updates", {
  skip_if_offline()
  skip_on_cran()
  withr::local_envvar(POSITRON = "")

  # the IDE ends up calling this with `os = "mac"` on macOS, but we would send
  # "darwin" in that case, so I test with "darwin"
  # also mix in some "windows"

  # returns nothing rstudio not needed
  expect_null(check_for_rstudio_updates("darwin", "1.0.0", FALSE))

  # returns nothing if the version is ahead of the current version
  expect_null(check_for_rstudio_updates("windows", "2030.12.0+123", TRUE))

  # returns something if ...
  local_edition(3)
  scrub_current_version <- function(message) {
    sub("(?<=^RStudio )[0-9\\.\\+]+", "{VERSION}", message, perl = TRUE)
  }

  # version is not understood by the service
  expect_snapshot(
    writeLines(check_for_rstudio_updates("windows", "haha-no-wut", TRUE))
  )

  # version is behind the current version

  # truly ancient
  expect_snapshot(
    writeLines(check_for_rstudio_updates("darwin", "0.0.1", TRUE)),
    transform = scrub_current_version
  )

  # Juliet Rose, does not have long_version, last before numbering changed
  expect_snapshot(
    writeLines(check_for_rstudio_updates("windows", "1.4.1717", TRUE)),
    transform = scrub_current_version
  )

  # new scheme, introduced 2021-08
  # YYYY.MM.<patch>[-(daily|preview)]+<build number>[.pro<pro suffix>]
  # YYY.MM is th expected date of release for dailies and previews

  # an out-of-date preview
  expect_snapshot(
    writeLines(check_for_rstudio_updates("darwin", "2021.09.1+372", TRUE)),
    transform = scrub_current_version
  )

  # an out-of-date daily
  expect_snapshot(
    writeLines(check_for_rstudio_updates(
      "windows",
      "2021.09.0-daily+328",
      TRUE
    )),
    transform = scrub_current_version
  )
})
