hello <- function(x) {
  if (!is.character(x)) {
    cli::cli_abort("{.arg x} must be a character string.")
  }
  paste0("Hello, ", x, "!")
}
