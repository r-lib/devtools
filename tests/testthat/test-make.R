context ("make")

makefile <- file.path ("testMakefiles/Makefile-test")

test_that("make_gettargets", {

	targets <- make_gettargets (makefile)
	expect_true (setequal (targets,
												 c ("all", ".PHONY", "echo", "www/README-$(NAME).md", "%.md", "../%.R")))
})

test_that("make_geteasytargets", {

	targets <- make_geteasytargets (makefile)
	expect_true (setequal (targets, c ("all", "echo")))

})

test_that ("make leaves in start directory", {
	## make sure directory is same after leaving, even with error
	dir <- getwd ()
	expect_error(make (path = ".."))
	expect_equal (getwd (), dir)
})

test_that ("all is default target", {
	expect_match (tail (make (makefile = makefile, stdout = TRUE), 1), "all")
})

test_that ("echo target", {
	expect_match (make ("echo", makefile = makefile, stdout = TRUE), "echo")
})
