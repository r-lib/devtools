library(testthat)
library(devtools)

if (requireNamespace("xml2")) {
  test_check("devtools", reporter = MultiReporter$new(reporters = list(JunitReporter$new(file = "test-results.xml"), CheckReporter$new())))
} else {
  test_check("devtools")
}
