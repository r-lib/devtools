# Adapted from:
# https://github.com/rstudio/rstudio/blob/master/src/cpp/session/modules/SessionPackages.R
#
# Copyright (C) 2009-12 by RStudio, Inc.

download_method <- function(x) {
  if (identical(x, "auto")) {
    auto_download_method()
  } else {
    x
  }
}

auto_download_method <- function() {
  if (isTRUE(capabilities("libcurl"))) {
    "libcurl"
  } else if (isTRUE(capabilities("http/ftp"))) {
    "internal"
  } else if (nzchar(Sys.which("wget"))) {
    "wget"
  } else if (nzchar(Sys.which("curl"))) {
    "curl"
  } else {
    ""
  }
}

download_method_secure <- function(method = getOption("download.file.method", "auto")) {
  method <- download_method(method)

  if (method %in% c("wininet", "libcurl", "wget", "curl")) {
    # known good methods
    TRUE
  } else if (identical(method, "internal")) {
    # if internal then see if were using windows internal with inet2
    identical(Sys.info()[["sysname"]], "Windows") && utils::setInternet2(NA)
  } else {
    # method with unknown properties (e.g. "lynx") or unresolved auto
    FALSE
  }
}


cran_mirror <- function() {
  if (download_method_secure()) {
    "https://cran.rstudio.com"
  } else {
    "http://cran.rstudio.com"
  }
}
