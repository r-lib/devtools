a <- 1

nulltest <- function() {
  .Call("null_test", PACKAGE = "unloaddll")
}
