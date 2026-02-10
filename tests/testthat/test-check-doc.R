test_that("check_doc_fields output - missing fields", {
  pkg <- local_package_create()
  dir.create(file.path(pkg, "man"))

  writeLines(
    "\\name{foo}\\title{Foo}\\description{A function.}\\examples{foo()}",
    file.path(pkg, "man", "foo.Rd")
  )
  writeLines(
    "\\name{bar}\\title{Bar}\\description{A function.}\\value{Something.}",
    file.path(pkg, "man", "bar.Rd")
  )

  expect_snapshot(check_doc_fields(pkg))
})

test_that("check_doc_fields output - all present", {
  pkg <- local_package_create()
  dir.create(file.path(pkg, "man"))

  writeLines(
    "\\name{foo}\\title{Foo}\\description{A function.}\\value{A value.}\\examples{foo()}",
    file.path(pkg, "man", "foo.Rd")
  )

  expect_snapshot(check_doc_fields(pkg))
})

test_that("check_man works", {
  # tools:::.check_Rd_xrefs which is called by `check_man()` assumes the base
  # and recommended packages will all be in the library path, which is not the
  # case during R CMD check, so we only run these tests interactively

  skip_if_not(interactive())

  pkg <- local_package_create()
  dir.create(file.path(pkg, "man"))
  writeLines(
    c(
      "
\\name{foo}
\\title{Foo bar}
\\usage{
foo(x)
}
\\arguments{\\item{foo}{}}
"
    ),
    file.path(pkg, "man", "foo.Rd")
  )

  expect_snapshot(
    check_man(pkg),
    transform = \(x) gsub(basename(pkg), "{package}", x, fixed = TRUE)
  )
})
