context("update.package_deps")

## -2 = not installed, but available on CRAN
## -1 = installed, but out of date
##  0 = installed, most recent version
##  1 = installed, version ahead of CRAN
##  2 = package not on CRAN

test_that("update.package_deps", {

  object <- data.frame(
    stringsAsFactors = FALSE,
    package = c("dotenv", "falsy", "magrittr"),
    installed = c("1.0", "1.0", "1.0"),
    available = c("1.0", NA, "1.0"),
    diff = c(0L, 2L, 0L),
    remote = c("dotenv", "falsy", "magrittr") # these are not actual remotes
  )
  class(object) <- c("package_deps", "data.frame")

  expect_message(
    update(object, quiet = FALSE, upgrade = FALSE),
    "Skipping 1 unavailable package: falsy"
  )

  object <- data.frame(
    stringsAsFactors = FALSE,
    package = c("dotenv", "falsy", "magrittr"),
    installed = c("1.0", "1.1", "1.0"),
    available = c("1.0", "1.0", "1.0"),
    diff = c(0L, 1L, 0L),
    remote = c("dotenv", "falsy", "magrittr") # these are not actual remotes
  )
  class(object) <- c("package_deps", "data.frame")

  expect_message(
    update(object, quiet = FALSE, upgrade = FALSE),
    "Skipping 1 package ahead of CRAN: falsy"
  )

  object <- data.frame(
    stringsAsFactors = FALSE,
    package = c("dotenv", "falsy", "magrittr"),
    installed = c("1.0", "1.0", NA),
    available = c("1.0", "1.1", "1.0"),
    diff = c(0L, 1L, -2L),
    remote = c("dotenv", "falsy", "magrittr") # these are not actual remotes
  )
  class(object) <- c("package_deps", "data.frame")

  with_mock(
    `devtools::install_remotes` = function(packages, ...) packages,
    expect_equal(
      update(object, upgrade = FALSE),
      "magrittr"
    )
  )

})
