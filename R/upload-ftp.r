upload_ftp <- function(file, url, verbose = FALSE){
  if (packageVersion("curl") < "0.9") {
    stop("package 'curl' must be >= 0.9")
  }

  stopifnot(file.exists(file))
  stopifnot(is.character(url))
  con <- file(file, open = "rb")
  on.exit(close(con))
  h <- curl::new_handle(upload = TRUE, filetime = FALSE)
  curl::handle_setopt(h, readfunction = function(n){
    readBin(con, raw(), n = n)
  }, verbose = verbose)
  curl::curl_fetch_memory(url, handle = h)
}
