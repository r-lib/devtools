library(mockery)

local({

pkg <- fs::path_real(local_package_create())

path2char <- function(x) {
  if (inherits(x, "fs_path")) {
    as.character(x)
  } else {
    x
  }
}

expect_passes_args <- function(fn, stub, input_args = list(), expected_args) {
  mck <- mockery::mock(NULL)
  mockery::stub(fn, stub, mck)

  capture.output(suppressMessages(do.call(fn, input_args)))

  mockery::expect_called(mck, 1)
  mock_args <- mockery::mock_args(mck)[[1]]
  mock_args <- lapply(mock_args, path2char)
  expect_equal(mock_args, expected_args)
}

custom_args <- list(
  dependencies = "dep",
  repos = "repo",
  type = "type",
  upgrade = "upgrade",
  quiet = "quiet",
  build = "build",
  build_opts = "build_opts"
)

dep_defaults <- list(
  dependencies = NA,
  repos = getOption("repos"),
  type = getOption("pkgType"),
  upgrade = c("default", "ask", "always", "never"),
  quiet = FALSE,
  build = TRUE,
  build_opts = c("--no-resave-data", "--no-manual", " --no-build-vignettes")
)

dev_dep_defaults <- list(
  dependencies = TRUE,
  repos = getOption("repos"),
  type = getOption("pkgType"),
  upgrade = c("default", "ask", "always", "never"),
  quiet = FALSE,
  build = TRUE,
  build_opts = c("--no-resave-data", "--no-manual", " --no-build-vignettes")
)

extra <- list(foo = "foo", bar = "bar")

test_that("install_deps passes default args to remotes::install_deps", {
  expect_passes_args(
    install_deps,
    "remotes::install_deps",
    list(pkg),
    c(pkg, dep_defaults)
  )
})

test_that("install_deps passes custom args to remotes::install_deps", {
  expect_passes_args(
    install_deps,
    "remotes::install_deps",
    c(pkg, custom_args),
    c(pkg, custom_args)
  )
})

test_that("install_deps passes ellipsis args to remotes::install_deps", {
  expect_passes_args(
    install_deps,
    "remotes::install_deps",
    c(pkg, extra),
    c(pkg, dep_defaults, extra)
  )
})

test_that("install_dev_deps passes default args to remotes::install_deps", {
  expect_passes_args(
    install_dev_deps,
    "remotes::install_deps",
    list(pkg),
    c(pkg, dev_dep_defaults)
  )
})

test_that("install_dev_deps passes custom args to remotes::install_deps", {
  expect_passes_args(
    install_dev_deps,
    "remotes::install_deps",
    c(pkg, custom_args),
    c(pkg, custom_args)
  )
})

test_that("install_dev_deps passes ellipsis args to remotes::install_deps", {
  expect_passes_args(
    install_dev_deps,
    "remotes::install_deps",
    c(pkg, extra),
    c(pkg, dev_dep_defaults, extra)
  )
})

})
