# box

<details>

* Version: 1.0.1
* Source code: https://github.com/cran/box
* URL: https://klmr.me/box/, https://github.com/klmr/box
* BugReports: https://github.com/klmr/box/issues
* Date/Publication: 2021-03-20 21:10:04 UTC
* Number of recursive dependencies: 93

Run `cloud_details(, "box")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      The following object is masked from 'package:base':
      
          file
      
      ══ Skipped tests ═══════════════════════════════════════════════════════════════
      ● Only run on Windows (1)
      ● Outside source code repository (3)
      
      ══ Failed tests ════════════════════════════════════════════════════════════════
      ── Failure (test-pkg.r:143:5): only exported things can be attached ────────────
      "indent" is not in ls(getNamespace("devtools")).
      
      [ FAIL 1 | WARN 0 | SKIP 4 | PASS 455 ]
      Error: Test failures
      Execution halted
    ```

# IalsaSynthesis

<details>

* Version: 0.1.6
* Source code: https://github.com/cran/IalsaSynthesis
* URL: https://github.com/IALSA/IalsaSynthesis, http://www.ialsa.org/
* BugReports: https://github.com/IALSA/IalsaSynthesis/issues
* Date/Publication: 2015-09-02 16:34:33
* Number of recursive dependencies: 88

Run `cloud_details(, "IalsaSynthesis")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
          █
       1. ├─base::file.path(devtools::inst(name = "IalsaSynthesis"), "test_data/2015-portland") test-validate.R:19:2
       2. └─devtools::inst
       3.   └─base::getExportedValue(pkg, name)
      ── Error (test-validate.R:28:3): validate_filename_output -bad extension ───────
      Error: 'inst' is not an exported object from 'namespace:devtools'
      Backtrace:
          █
       1. ├─base::file.path(devtools::inst(name = "IalsaSynthesis"), "test_data/2015-portland") test-validate.R:28:2
       2. └─devtools::inst
       3.   └─base::getExportedValue(pkg, name)
      
      [ FAIL 4 | WARN 0 | SKIP 0 | PASS 1 ]
      Error: Test failures
      Execution halted
    ```

# NlsyLinks

<details>

* Version: 2.0.6
* Source code: https://github.com/cran/NlsyLinks
* URL: http://liveoak.github.io/NlsyLinks, https://github.com/LiveOak/NlsyLinks, https://r-forge.r-project.org/projects/nlsylinks
* BugReports: https://github.com/LiveOak/NlsyLinks/issues
* Date/Publication: 2016-04-19 13:50:00
* Number of recursive dependencies: 107

Run `cloud_details(, "NlsyLinks")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘test-all.R’
    Running the tests in ‘tests/test-all.R’ failed.
    Last 13 lines of output:
          █
       1. ├─base::file.path(devtools::inst("NlsyLinks"), "extdata", "gen2-birth.csv") test-read-csv.R:45:2
       2. └─devtools::inst
       3.   └─base::getExportedValue(pkg, name)
      ── Error (test-read-csv.R:58:3): Nlsy79Gen2DataFrame ───────────────────────────
      Error: 'inst' is not an exported object from 'namespace:devtools'
      Backtrace:
          █
       1. ├─base::file.path(devtools::inst("NlsyLinks"), "extdata", "gen2-birth.csv") test-read-csv.R:58:2
       2. └─devtools::inst
       3.   └─base::getExportedValue(pkg, name)
      
      [ FAIL 6 | WARN 0 | SKIP 0 | PASS 198 ]
      Error: Test failures
      Execution halted
    ```

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  8.6Mb
      sub-directories of 1Mb or more:
        data      4.3Mb
        reports   2.3Mb
    ```

