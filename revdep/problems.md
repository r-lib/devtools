# available

<details>

* Version: 1.0.2
* Source code: https://github.com/cran/available
* URL: https://github.com/ropenscilabs/available
* BugReports: https://github.com/ropenscilabs/available/issues
* Date/Publication: 2018-11-08 15:40:18 UTC
* Number of recursive dependencies: 73

Run `revdep_details(,"available")` for more info

</details>

## Newly broken

*   checking dependencies in R code ... NOTE
    ```
    Missing or unexported object: ‘devtools::create’
    ```

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘BiocInstaller’
    ```

# BiocWorkflowTools

<details>

* Version: 1.10.0
* Source code: https://github.com/cran/BiocWorkflowTools
* Date/Publication: 2019-05-02
* Number of recursive dependencies: 57

Run `revdep_details(,"BiocWorkflowTools")` for more info

</details>

## Newly broken

*   checking Rd cross-references ... WARNING
    ```
    Missing link or links in documentation object 'createBiocWorkflow.Rd':
      ‘create’
    
    See section 'Cross-references' in the 'Writing R Extensions' manual.
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘devtools’
      All declared Imports should be used.
    Unexported objects imported by ':::' calls:
      ‘BiocStyle:::auth_affil_latex’ ‘BiocStyle:::modifyLines’
      ‘rmarkdown:::partition_yaml_front_matter’
      See the note in ?`:::` about the use of this operator.
    ```

# googleAuthR

<details>

* Version: 0.8.0
* Source code: https://github.com/cran/googleAuthR
* URL: http://code.markedmondson.me/googleAuthR/
* BugReports: https://github.com/MarkEdmondson1234/googleAuthR/issues
* Date/Publication: 2019-06-30 15:00:03 UTC
* Number of recursive dependencies: 88

Run `revdep_details(,"googleAuthR")` for more info

</details>

## Newly broken

*   checking Rd cross-references ... WARNING
    ```
    Missing link or links in documentation object 'gar_create_package.Rd':
      ‘[devtools]{create}’ ‘[devtools]{use_github}’
    
    See section 'Cross-references' in the 'Writing R Extensions' manual.
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘R6’
      All declared Imports should be used.
    Missing or unexported objects:
      ‘devtools::create’ ‘devtools::use_github’
    ```

# packagedocs

<details>

* Version: 0.4.0
* Source code: https://github.com/cran/packagedocs
* URL: http://hafen.github.io/packagedocs, https://github.com/hafen/packagedocs
* BugReports: https://github.com/hafen/packagedocs/issues
* Date/Publication: 2016-11-04 00:41:33
* Number of recursive dependencies: 59

Run `revdep_details(,"packagedocs")` for more info

</details>

## Newly broken

*   checking dependencies in R code ... NOTE
    ```
    Missing or unexported objects:
      ‘devtools::use_build_ignore’ ‘devtools::use_travis’
    ```

# soilcarbon

<details>

* Version: 1.2.0
* Source code: https://github.com/cran/soilcarbon
* URL: https://powellcenter-soilcarbon.github.io/soilcarbon/
* BugReports: https://github.com/powellcenter-soilcarbon/soilcarbon/issues
* Date/Publication: 2017-08-04 03:17:31 UTC
* Number of recursive dependencies: 86

Run `revdep_details(,"soilcarbon")` for more info

</details>

## Newly broken

*   checking R code for possible problems ... NOTE
    ```
    compileDatabase: no visible global function definition for ‘use_data’
      (.../revdep/checks.noindex/soilcarbon/new/soilcarbon.Rcheck/00_pkg_src/soilcarbon/R/compileDatabase.R:30)
    Undefined global functions or variables:
      use_data
    ```

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 145 marked UTF-8 strings
    ```

# SpaDES.core

<details>

* Version: 0.2.5
* Source code: https://github.com/cran/SpaDES.core
* URL: http://spades-core.predictiveecology.org/, https://github.com/PredictiveEcology/SpaDES.core
* BugReports: https://github.com/PredictiveEcology/SpaDES.core/issues
* Date/Publication: 2019-03-19 05:43:37 UTC
* Number of recursive dependencies: 151

Run `revdep_details(,"SpaDES.core")` for more info

</details>

## Newly broken

*   checking installed package size ... NOTE
    ```
      installed size is  5.6Mb
      sub-directories of 1Mb or more:
        R     3.1Mb
        doc   1.6Mb
    ```

## In both

*   checking examples ... ERROR
    ```
    ...
    +      .globals = list(stackName = "landscape", burnStats = "nPixelsBurned")
    +    ),
    +    modules = list("caribouMovement"),
    +    paths = list(modulePath = path)
    + )
    Setting:
      options(
        spades.modulePath = '.../revdep/checks.noindex/SpaDES.core/new/SpaDES.core.Rcheck/SpaDES.core/sampleModules'
      )
    Paths set to:
      options(
        reproducible.cachePath = '/var/folders/xn/m8dzdsgs7sg8q7jgflnqm8w80000gn/T/RtmpvqUB3y/reproducible/cache'
        spades.inputPath = '/private/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T/RtmpUfXsOm/SpaDES/inputs'
        spades.outputPath = '/private/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T/RtmpUfXsOm/SpaDES/outputs'
        spades.modulePath = '.../revdep/checks.noindex/SpaDES.core/new/SpaDES.core.Rcheck/SpaDES.core/sampleModules'
      )
    Warning in gzfile(file, mode) :
      cannot open compressed file '/var/folders/xn/m8dzdsgs7sg8q7jgflnqm8w80000gn/T/RtmpvqUB3y/reproducible/cache/.Require/_Users_jhester_Dropbox_projects_devtools_revdep_checks.noindex_SpaDES.core_new_SpaDES.core.Rcheck.snapshot.RDS', probable reason 'No such file or directory'
    Error in gzfile(file, mode) : cannot open the connection
    Calls: simInit ... Require -> installedVersionsQuick -> saveRDS -> gzfile
    Execution halted
    ```

*   R CMD check timed out
    

# understandBPMN

<details>

* Version: 1.1.0
* Source code: https://github.com/cran/understandBPMN
* Date/Publication: 2018-06-08 15:15:35 UTC
* Number of recursive dependencies: 72

Run `revdep_details(,"understandBPMN")` for more info

</details>

## Newly broken

*   checking dependencies in R code ... NOTE
    ```
    Missing or unexported object: ‘devtools::use_data’
    ```

# zebu

<details>

* Version: 0.1.2
* Source code: https://github.com/cran/zebu
* URL: http://github.com/oliviermfmartin/zebu
* BugReports: https://github.com/oliviermfmartin/zebu/issues
* Date/Publication: 2017-10-24 14:05:08 UTC
* Number of recursive dependencies: 80

Run `revdep_details(,"zebu")` for more info

</details>

## Newly broken

*   checking dependencies in R code ... NOTE
    ```
    Missing or unexported object: ‘devtools::use_data’
    ```

