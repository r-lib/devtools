upload_ftp <- function(file, url, verbose = FALSE){
  check_suggested("curl")

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
