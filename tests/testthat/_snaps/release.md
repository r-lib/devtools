# release() is deprecated

    Code
      . <- release()
    Condition
      Warning:
      `release()` was deprecated in devtools 2.5.0.
      i Please use `usethis::use_release_issue()` instead.
      Error in `release()`:
      ! Interactive session required.

# req_perform_cran() reports an unavailable submission form

    Code
      req_perform_cran(httr2::request(cran_submission_url))
    Condition
      Error:
      ! Can't submit to CRAN right now.
      i Request to <https://xmpalantir.wu.ac.at/cransubmit/index2.php> failed.
      i Check <https://cran.r-project.org> to see if there is a planned closure or known outage.
      Caused by error in `httr2::req_perform()`:
      ! HTTP 503 Service Unavailable.

