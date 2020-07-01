context("Version change")

test_that("Version changes properly", {
	version_txt <- readLines("DESCRIPTION")[3]
	mmp_version <- substr(version_txt, 10, 14)
	current_version <- as.numeric(substr(version_txt, 16, 20))
	next_version <- current_version + 1
	output_txt <- paste0(
		"devtools updated from Version: ", mmp_version, ".", current_version,
		"to Version: ", mmp_version, next_version, "\n",
		"Change not saved because test == TRUE"
	)
	expect_message(
		object = increase_version(test=TRUE),
		expected = output_txt
	)
})