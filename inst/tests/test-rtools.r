if (.Platform$OS.type == "windows") {

context("Rtools tests")

with_rtools_path <- function(path, code) {
  bin <- c(file.path(path, "bin"), file.path(path, "gcc-4.6.3", "bin"))
  old <- set_path(bin)
  on.exit(set_path(old))
  force(code)
}

test_that("rtools found on path if present", {
  with_rtools_path("rtools-2.15", {
    rt <- scan_path_for_rtools()
    expect_equal(rt$version, "2.15")
  })
})

test_that("out of date rtools is not compatible", {
  with_rtools_path("rtools-2.15", {
    rt <- scan_path_for_rtools()
    expect_false(is_compatible(rt))
  })
})

test_that("rtools must be complete to be located", {
  with_rtools_path("rtools-no-gcc", {
    rt <- scan_path_for_rtools()
    expect_equal(rt, NULL)
  })
})

test_that("correct path doesn't need fixing", {
  with_rtools_path("rtools-manual", {
    rt <- scan_path_for_rtools()
    expect_equal(rt$version, NULL)
  })
})

}

