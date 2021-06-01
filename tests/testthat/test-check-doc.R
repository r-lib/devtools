test_that("check_man works", {
  pkg <- create_local_package()
  dir.create("man")
  writeLines(c("
\\name{foo}
\\title{Foo bar}
\\usage{
foo(x)
}
\\arguments{\\item{foo}{}}
"), file.path(pkg, "man", "foo.Rd"))

expect_output(
  check_man(pkg),
  "Undocumented arguments"
)
})
