# rfishbase

<details>

* Version: 3.0.4
* Source code: https://github.com/cran/rfishbase
* URL: https://github.com/ropensci/rfishbase
* BugReports: https://github.com/ropensci/rfishbase/issues
* Date/Publication: 2019-06-27 21:50:03 UTC
* Number of recursive dependencies: 83

Run `cloud_details(, "rfishbase")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      Backtrace:
       1. rfishbase::species_list(Genus = "Labroides")
       2. rfishbase::load_taxa(server)
       4. rfishbase:::`_f`(server = server, ... = ...)
       5. rfishbase:::fb_taxa_table(server)
       6. rfishbase:::fb_tbl("genera", server)
       8. rfishbase:::`_f`(tbl = tbl, server = server, ... = ...)
       9. utils::download.file(addr, tmp, quiet = TRUE)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 7 | SKIPPED: 20 | WARNINGS: 1 | FAILED: 1 ]
      1. Error: We can pass a species_list based on taxanomic group (@test_species_list.R#5) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 44 marked UTF-8 strings
    ```

