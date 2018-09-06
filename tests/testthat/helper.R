skip_if_offline <- function(host = "httpbin.org", port = 80) {
  res <- tryCatch(
    pingr::ping_port(host, count = 1L, port = port),
    error = function(e) NA
  )

  if (is.na(res)) skip("No internet connection")
}
