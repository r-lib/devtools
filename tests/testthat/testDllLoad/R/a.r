a <- 1

nulltest <- function() {
  .Call("null_test", PACKAGE = "testDllLoad")
}

nulltest2 <- function() {
  .Call(null_test2)
}
