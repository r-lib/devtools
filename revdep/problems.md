# abjutils

Version: 0.0.1

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      4. Failure: rm_accent is the converted version of a string with all non-ASCII characters removed. (@test-rm_accent.R#34) 
      rm_accent(umlaut) not equal to `nudeUmlaut`.
      1/1 mismatches
      x[1]: "\"a\"e\"i\"o\"u\"A\"E\"I\"O\"U\"y"
      y[1]: "aeiouAEIOUy"
      
      testthat results ================================================================
      OK: 10 SKIPPED: 0 FAILED: 4
      1. Failure: rm_accent is the converted version of a string with all non-ASCII characters removed. (@test-rm_accent.R#30) 
      2. Failure: rm_accent is the converted version of a string with all non-ASCII characters removed. (@test-rm_accent.R#32) 
      3. Failure: rm_accent is the converted version of a string with all non-ASCII characters removed. (@test-rm_accent.R#33) 
      4. Failure: rm_accent is the converted version of a string with all non-ASCII characters removed. (@test-rm_accent.R#34) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘devtools’ ‘httr’
      All declared Imports should be used.
    ```

# adapr

Version: 1.0.2

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘plotly’ ‘shinydashboard’
      All declared Imports should be used.
    Missing or unexported object: ‘devtools::clean_source’
    ```

# alphavantager

Version: 0.1.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘devtools’
      All declared Imports should be used.
    ```

# annotatr

Version: 1.2.1

## In both

*   checking R code for possible problems ... NOTE
    ```
    plot_coannotations: no visible binding for global variable ‘.’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/annotatr/new/annotatr.Rcheck/00_pkg_src/annotatr/R/visualize.R:176-178)
    plot_numerical_coannotations: no visible binding for global variable
      ‘.’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/annotatr/new/annotatr.Rcheck/00_pkg_src/annotatr/R/visualize.R:412-429)
    plot_numerical_coannotations: no visible binding for global variable
      ‘.’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/annotatr/new/annotatr.Rcheck/00_pkg_src/annotatr/R/visualize.R:415-420)
    plot_numerical_coannotations: no visible binding for global variable
      ‘.’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/annotatr/new/annotatr.Rcheck/00_pkg_src/annotatr/R/visualize.R:422-427)
    Undefined global functions or variables:
      .
    ```

# archivist

Version: 2.1.2

## In both

*   checking package dependencies ... NOTE
    ```
    Package which this enhances but not available for checking: ‘archivist.github’
    ```

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘archivist.github’
    ```

# assertive.code

Version: 0.0-1

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      Attaching package: 'assertive.base'
      
      The following objects are masked from 'package:testthat':
      
          is_false, is_true
      
      > library(assertive.code)
      > 
      > with_envvar(
      +   c(LANG = "en_US"),
      +   test_check("assertive.code")
      + )
      Error in with_envvar(c(LANG = "en_US"), test_check("assertive.code")) : 
        could not find function "with_envvar"
      Execution halted
    ```

# assertive.data

Version: 0.0-1

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
          use_travis, use_vignette
      
      The following object is masked from 'package:testthat':
      
          setup
      
      > library(assertive.data)
      > 
      > with_envvar(
      +   c(LANG = "en_US"),
      +   test_check("assertive.data")
      + )
      Error in with_envvar(c(LANG = "en_US"), test_check("assertive.data")) : 
        could not find function "with_envvar"
      Execution halted
    ```

# assertive.data.uk

Version: 0.0-1

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
          use_travis, use_vignette
      
      The following object is masked from 'package:testthat':
      
          setup
      
      > library(assertive.data.uk)
      > 
      > with_envvar(
      +   c(LANG = "en_US"),
      +   test_check("assertive.data.uk")
      + )
      Error in with_envvar(c(LANG = "en_US"), test_check("assertive.data.uk")) : 
        could not find function "with_envvar"
      Execution halted
    ```

# assertive.data.us

Version: 0.0-1

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
          use_travis, use_vignette
      
      The following object is masked from 'package:testthat':
      
          setup
      
      > library(assertive.data.us)
      > 
      > with_envvar(
      +   c(LANG = "en_US"),
      +   test_check("assertive.data.us")
      + )
      Error in with_envvar(c(LANG = "en_US"), test_check("assertive.data.us")) : 
        could not find function "with_envvar"
      Execution halted
    ```

# assertive.matrices

Version: 0.0-1

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
          use_travis, use_vignette
      
      The following object is masked from 'package:testthat':
      
          setup
      
      > library(assertive.matrices)
      > 
      > with_envvar(
      +   c(LANG = "en_US"),
      +   test_check("assertive.matrices")
      + )
      Error in with_envvar(c(LANG = "en_US"), test_check("assertive.matrices")) : 
        could not find function "with_envvar"
      Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    ':::' call which should be '::': ‘assertive.base:::print_and_capture’
      See the note in ?`:::` about the use of this operator.
    ```

# assertive.models

Version: 0.0-1

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
          use_travis, use_vignette
      
      The following object is masked from 'package:testthat':
      
          setup
      
      > library(assertive.models)
      > 
      > with_envvar(
      +   c(LANG = "en_US"),
      +   test_check("assertive.models")
      + )
      Error in with_envvar(c(LANG = "en_US"), test_check("assertive.models")) : 
        could not find function "with_envvar"
      Execution halted
    ```

# BEACH

Version: 1.1.2

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘readxl’
      All declared Imports should be used.
    ```

# BiocCheck

Version: 1.12.0

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/runTests.R’ failed.
    Last 13 lines of output:
      Use 'usethis::create_package()' instead.
      See help("Deprecated") and help("devtools-deprecated"). 
      6: 'create_description' is deprecated.
      Use 'usethis::use_description()' instead.
      See help("Deprecated") and help("devtools-deprecated"). 
      7: 'devtools::create' is deprecated.
      Use 'usethis::create_package()' instead.
      See help("Deprecated") and help("devtools-deprecated"). 
      8: 'setup' is deprecated.
      Use 'usethis::create_package()' instead.
      See help("Deprecated") and help("devtools-deprecated"). 
      9: 'create_description' is deprecated.
      Use 'usethis::use_description()' instead.
      See help("Deprecated") and help("devtools-deprecated"). 
      Execution halted
    ```

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Error: processing vignette 'BiocCheck.Rmd' failed with diagnostics:
    there is no package called ‘BiocStyle’
    Execution halted
    ```

*   checking package dependencies ... NOTE
    ```
    Package which this enhances but not available for checking: ‘codetoolsBioC’
    ```

*   checking dependencies in R code ... NOTE
    ```
    Unexported objects imported by ':::' calls:
      ‘knitr:::detect_pattern’ ‘tools:::RdTags’
      See the note in ?`:::` about the use of this operator.
    ```

*   checking R code for possible problems ... NOTE
    ```
    checkValidDevelopmentURL: no visible global function definition for
      ‘url.exists’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/BiocCheck/new/BiocCheck.Rcheck/00_pkg_src/BiocCheck/R/checks.R:33-35)
    Undefined global functions or variables:
      url.exists
    ```

# BiocInstaller

Version: 1.26.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    'library' or 'require' call to ‘utils’ in package code.
      Please use :: or requireNamespace() instead.
      See section 'Suggested packages' in the 'Writing R Extensions' manual.
    Unexported object imported by a ':::' call: ‘utils:::.clean_up_dependencies’
      See the note in ?`:::` about the use of this operator.
    There are ::: calls to the package's namespace in its code. A package
      almost never needs to use ::: for its own objects:
      ‘.updateBiocInstallerFinish’ ‘.updateFinish’
    ```

# BioInstaller

Version: 0.2.1

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
             }
             typeName = gsub("^CURLE_", "", typeName)
             fun = (if (asError) 
                 stop
             else warning)
             fun(structure(list(message = msg, call = sys.call()), class = c(typeName, "GenericCurlError", 
                 "error", "condition")))
         }(28L, "<not set>", TRUE)
      
      testthat results ================================================================
      OK: 60 SKIPPED: 0 FAILED: 1
      1. Error: download.file.custom is.dir (@test_utils.R#138) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# biomartr

Version: 0.5.2

## In both

*   R CMD check timed out
    

# BrailleR

Version: 0.26.0

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘installr’
    ```

# chimeraviz

Version: 1.0.4

## In both

*   R CMD check timed out
    

*   checking package dependencies ... NOTE
    ```
    Depends: includes the non-default packages:
      ‘Biostrings’ ‘GenomicRanges’ ‘IRanges’ ‘Gviz’ ‘S4Vectors’ ‘ensembldb’
      ‘AnnotationFilter’
    Adding so many packages to the search path is excessive and importing
    selectively is preferable.
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  5.5Mb
      sub-directories of 1Mb or more:
        doc       2.7Mb
        extdata   2.0Mb
    ```

# chipenrich

Version: 2.0.1

## In both

*   checking whether package ‘chipenrich’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/jhester/Dropbox/projects/devtools/revdep/checks/chipenrich/new/chipenrich.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘chipenrich’ ...
** R
** inst
** preparing package for lazy loading
Error in loadNamespace(j <- i[[1L]], c(lib.loc, .libPaths()), versionCheck = vI[[j]]) : 
  there is no package called ‘data.table’
ERROR: lazy loading failed for package ‘chipenrich’
* removing ‘/Users/jhester/Dropbox/projects/devtools/revdep/checks/chipenrich/new/chipenrich.Rcheck/chipenrich’

```
### CRAN

```
* installing *source* package ‘chipenrich’ ...
** R
** inst
** preparing package for lazy loading
Error in loadNamespace(j <- i[[1L]], c(lib.loc, .libPaths()), versionCheck = vI[[j]]) : 
  there is no package called ‘data.table’
ERROR: lazy loading failed for package ‘chipenrich’
* removing ‘/Users/jhester/Dropbox/projects/devtools/revdep/checks/chipenrich/old/chipenrich.Rcheck/chipenrich’

```
# chipenrich.data

Version: 2.0.0

## In both

*   checking installed package size ... NOTE
    ```
      installed size is 147.8Mb
      sub-directories of 1Mb or more:
        data  147.0Mb
    ```

# civis

Version: 1.0.2

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      testthat results ================================================================
      OK: 742 SKIPPED: 4 FAILED: 17
      1. Error: calls scripts_post_custom (@test_civis_ml.R#24) 
      2. Error: calls civis_ml.data.frame for local df (@test_civis_ml.R#103) 
      3. Error: calls scripts_post_custom (@test_civis_ml.R#326) 
      4. Error: uploads local df and passes a file_id (@test_civis_ml.R#400) 
      5. Error: uses the correct template_id (@test_civis_ml.R#547) 
      6. Error: converts parameters arg to JSON string (@test_civis_ml.R#564) 
      7. Error: converts cross_validation_parameters to JSON string (@test_civis_ml.R#581) 
      8. Error: converts fit_params to JSON string (@test_civis_ml.R#600) 
      9. Error: space separates excluded_columns (@test_civis_ml.R#618) 
      1. ...
      
      Error: testthat unit tests failed
      Execution halted
    ```

# cogena

Version: 1.10.0

## In both

*   R CMD check timed out
    

*   checking whether package ‘cogena’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: replacing previous import ‘class::somgrid’ by ‘kohonen::somgrid’ when loading ‘cogena’
    See ‘/Users/jhester/Dropbox/projects/devtools/revdep/checks/cogena/new/cogena.Rcheck/00install.out’ for details.
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  6.3Mb
      sub-directories of 1Mb or more:
        doc       1.9Mb
        extdata   3.1Mb
    ```

*   checking R code for possible problems ... NOTE
    ```
    ...
      ‘legend’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/cogena/new/cogena.Rcheck/00_pkg_src/cogena/R/heatmapCluster.R:151-153)
    heatmapCluster,cogena: no visible global function definition for
      ‘legend’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/cogena/new/cogena.Rcheck/00_pkg_src/cogena/R/heatmapCluster.R:155-157)
    heatmapCluster,cogena: no visible global function definition for
      ‘legend’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/cogena/new/cogena.Rcheck/00_pkg_src/cogena/R/heatmapCluster.R:159-160)
    Undefined global functions or variables:
      abline as.dist axis cor data density dist hist image layout legend
      lines median mtext order.dendrogram p.adjust par phyper plot.new
      rainbow rect reorder sd text title topo.colors
    Consider adding
      importFrom("grDevices", "rainbow", "topo.colors")
      importFrom("graphics", "abline", "axis", "hist", "image", "layout",
                 "legend", "lines", "mtext", "par", "plot.new", "rect",
                 "text", "title")
      importFrom("stats", "as.dist", "cor", "density", "dist", "median",
                 "order.dendrogram", "p.adjust", "phyper", "reorder", "sd")
      importFrom("utils", "data")
    to your NAMESPACE file.
    ```

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘clValid’
    ```

# COMPASS

Version: 1.14.0

## In both

*   checking whether package ‘COMPASS’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/jhester/Dropbox/projects/devtools/revdep/checks/COMPASS/new/COMPASS.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘COMPASS’ ...
** libs
clang -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/devtools/new/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c COMPASS_init.c -o COMPASS_init.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/devtools/new/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c CellCounts.cpp -o CellCounts.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/devtools/new/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c CellCounts_character.cpp -o CellCounts_character.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/devtools/new/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/devtools/new/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c digamma.c -o digamma.o
clang -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/devtools/new/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c mat2vec.c -o mat2vec.o
clang -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/devtools/new/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c melt_dataframe.c -o melt_dataframe.o
clang -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/devtools/new/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c melt_matrix.c -o melt_matrix.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/devtools/new/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c samplePuPs.cpp -o samplePuPs.o
clang -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/devtools/new/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c transpose_list.c -o transpose_list.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/devtools/new/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c updatealphas_Exp.cpp -o updatealphas_Exp.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/devtools/new/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c updatealphau.cpp -o updatealphau.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/devtools/new/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c updatealphau_noPu_Exp.cpp -o updatealphau_noPu_Exp.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/devtools/new/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c updatebeta_RW.cpp -o updatebeta_RW.o
CellCounts.cpp:40:35: error: no matching function for call to 'sapply'
      IntegerVector c_combo_abs = sapply(c_combo, ::abs);
                                  ^~~~~~
/Users/jhester/Dropbox/projects/devtools/revdep/library/devtools/new/Rcpp/include/Rcpp/sugar/functions/sapply.h:126:1: note: candidate template ignored: couldn't infer template argument 'Function'
sapply( const Rcpp::VectorBase<RTYPE,NA,T>& t, Function fun ){
^
/Users/jhester/Dropbox/projects/devtools/revdep/library/devtools/new/Rcpp/include/Rcpp/vector/ListOf.h:134:3: note: candidate template ignored: could not match 'ListOf' against 'Vector'
T sapply(const ListOf<T>& t, Function fun) {
  ^
1 error generated.
make: *** [CellCounts.o] Error 1
make: *** Waiting for unfinished jobs....
ERROR: compilation failed for package ‘COMPASS’
* removing ‘/Users/jhester/Dropbox/projects/devtools/revdep/checks/COMPASS/new/COMPASS.Rcheck/COMPASS’

```
### CRAN

```
* installing *source* package ‘COMPASS’ ...
** libs
clang -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c COMPASS_init.c -o COMPASS_init.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c CellCounts.cpp -o CellCounts.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c CellCounts_character.cpp -o CellCounts_character.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c digamma.c -o digamma.o
clang -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c mat2vec.c -o mat2vec.o
clang -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c melt_dataframe.c -o melt_dataframe.o
clang -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c melt_matrix.c -o melt_matrix.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c samplePuPs.cpp -o samplePuPs.o
clang -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c transpose_list.c -o transpose_list.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c updatealphas_Exp.cpp -o updatealphas_Exp.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c updatealphau.cpp -o updatealphau.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c updatealphau_noPu_Exp.cpp -o updatealphau_noPu_Exp.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c updatebeta_RW.cpp -o updatebeta_RW.o
CellCounts.cpp:40:35: error: no matching function for call to 'sapply'
      IntegerVector c_combo_abs = sapply(c_combo, ::abs);
                                  ^~~~~~
/Users/jhester/Dropbox/projects/devtools/revdep/library/COMPASS/Rcpp/include/Rcpp/sugar/functions/sapply.h:126:1: note: candidate template ignored: couldn't infer template argument 'Function'
sapply( const Rcpp::VectorBase<RTYPE,NA,T>& t, Function fun ){
^
/Users/jhester/Dropbox/projects/devtools/revdep/library/COMPASS/Rcpp/include/Rcpp/vector/ListOf.h:134:3: note: candidate template ignored: could not match 'ListOf' against 'Vector'
T sapply(const ListOf<T>& t, Function fun) {
  ^
1 error generated.
make: *** [CellCounts.o] Error 1
make: *** Waiting for unfinished jobs....
ERROR: compilation failed for package ‘COMPASS’
* removing ‘/Users/jhester/Dropbox/projects/devtools/revdep/checks/COMPASS/old/COMPASS.Rcheck/COMPASS’

```
# congressbr

Version: 0.1.1

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘congressbr-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: cham_bill_info
    > ### Title: Downloads details of a specific bill by providing type, number
    > ###   and year
    > ### Aliases: cham_bill_info
    > 
    > ### ** Examples
    > 
    > cham_bill_info(type = "PL", number = "3962", year = "2008")
    Error in mutate_impl(.data, dots) : 
      Evaluation error: object 'x' not found.
    Calls: cham_bill_info ... <Anonymous> -> mutate -> mutate.tbl_df -> mutate_impl -> .Call
    Execution halted
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Quitting from lines 31-32 (chamber.Rmd) 
    Error: processing vignette 'chamber.Rmd' failed with diagnostics:
    Evaluation error: object 'x' not found.
    Execution halted
    ```

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 1 marked UTF-8 string
    ```

# CountClust

Version: 1.3.0

## In both

*   checking whether package ‘CountClust’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/jhester/Dropbox/projects/devtools/revdep/checks/CountClust/new/CountClust.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘CountClust’ ...
** R
** data
*** moving datasets to lazyload DB
** inst
** preparing package for lazy loading
Error : object ‘switch_axis_position’ is not exported by 'namespace:cowplot'
ERROR: lazy loading failed for package ‘CountClust’
* removing ‘/Users/jhester/Dropbox/projects/devtools/revdep/checks/CountClust/new/CountClust.Rcheck/CountClust’

```
### CRAN

```
* installing *source* package ‘CountClust’ ...
** R
** data
*** moving datasets to lazyload DB
** inst
** preparing package for lazy loading
Error : object ‘switch_axis_position’ is not exported by 'namespace:cowplot'
ERROR: lazy loading failed for package ‘CountClust’
* removing ‘/Users/jhester/Dropbox/projects/devtools/revdep/checks/CountClust/old/CountClust.Rcheck/CountClust’

```
# covr

Version: 3.0.0

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      x[115]: isplay\\\">\\n  <thead>\\n    <tr>\\n      <th>Coverage<\\/th>\\n      ...
      y[115]: "          <script type=\"application/json\" data-for=\"htmlwidget-eaef49d
      y[115]: 4a484bc22a8b4\">{\"x\":{\"filter\":\"none\",\"data\":[[\"<div class=\\\"co
      y[115]: verage-box coverage-high\\\">100.00\\u003c/div>\"],[\"<a href=\\\"#\\\">R/
      y[115]: TestS4.R\\u003c/a>\"],[38],[6],[6],[0],[\"2\"]],\"container\":\"<table cla
      y[115]: ss=\\\"display\\\">\\n  <thead>\\n    <tr>\\n      <th>Coverage\\u003c/...
      
      testthat results ================================================================
      OK: 232 SKIPPED: 0 FAILED: 3
      1. Error: parse_gcov parses files properly (@test-gcov.R#3) 
      2. Error: clean_gcov correctly clears files (@test-gcov.R#63) 
      3. Failure: it works with coverage objects (@test-report.R#28) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# crunch

Version: 1.18.4

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      testthat results ================================================================
      OK: 1442 SKIPPED: 10 FAILED: 151
      1. Error: Adding a variable with all the same values gets sent more concisely (@test-add-variable.R#103) 
      2. Error: crunch.debug does not print if disabled (@test-api.R#12) 
      3. Error: crunch.debug logging if enabled (@test-api.R#19) 
      4. Error: If no filtering, 'where' and 'filter' are omitted (@test-append-subset.R#7) 
      5. Error: Append with filter (@test-append-subset.R#13) 
      6. Error: Append with variable selection (@test-append-subset.R#20) 
      7. Error: Append with variable selection and filter (@test-append-subset.R#27) 
      8. Error: append DELETEs the pk (@test-appending.R#22) 
      9. Error: appendDataset shows deprecation warnings (@test-appending.R#27) 
      1. ...
      
      Error: testthat unit tests failed
      Execution halted
    ```

# curatedMetagenomicData

Version: 1.2.2

## In both

*   R CMD check timed out
    

*   checking package dependencies ... NOTE
    ```
    Depends: includes the non-default packages:
      ‘dplyr’ ‘phyloseq’ ‘Biobase’ ‘ExperimentHub’ ‘AnnotationHub’
      ‘magrittr’
    Adding so many packages to the search path is excessive and importing
    selectively is preferable.
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  8.6Mb
      sub-directories of 1Mb or more:
        help   7.9Mb
    ```

*   checking DESCRIPTION meta-information ... NOTE
    ```
    Package listed in more than one of Depends, Imports, Suggests, Enhances:
      ‘BiocInstaller’
    A package should be listed in only one of these fields.
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘BiocInstaller’
      All declared Imports should be used.
    ```

*   checking R code for possible problems ... NOTE
    ```
    ExpressionSet2MRexperiment: no visible global function definition for
      ‘AnnotatedDataFrame’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/curatedMetagenomicData/new/curatedMetagenomicData.Rcheck/00_pkg_src/curatedMetagenomicData/R/ExpressionSet2MRexperiment.R:45)
    ExpressionSet2MRexperiment: no visible global function definition for
      ‘phenoData’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/curatedMetagenomicData/new/curatedMetagenomicData.Rcheck/00_pkg_src/curatedMetagenomicData/R/ExpressionSet2MRexperiment.R:46-47)
    curatedMetagenomicData : <anonymous>: no visible global function
      definition for ‘exprs<-’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/curatedMetagenomicData/new/curatedMetagenomicData.Rcheck/00_pkg_src/curatedMetagenomicData/R/curatedMetagenomicData.R:57-58)
    Undefined global functions or variables:
      AnnotatedDataFrame exprs<- phenoData
    ```

*   checking Rd files ... NOTE
    ```
    prepare_Rd: HMP_2012.Rd:540-542: Dropping empty section \seealso
    prepare_Rd: KarlssonFH_2013.Rd:90-92: Dropping empty section \seealso
    prepare_Rd: LeChatelierE_2013.Rd:86-88: Dropping empty section \seealso
    prepare_Rd: LomanNJ_2013_Hi.Rd:82-84: Dropping empty section \seealso
    prepare_Rd: LomanNJ_2013_Mi.Rd:82-84: Dropping empty section \seealso
    prepare_Rd: NielsenHB_2014.Rd:94-96: Dropping empty section \seealso
    prepare_Rd: Obregon_TitoAJ_2015.Rd:94-96: Dropping empty section \seealso
    prepare_Rd: OhJ_2014.Rd:86-88: Dropping empty section \seealso
    prepare_Rd: QinJ_2012.Rd:106-108: Dropping empty section \seealso
    prepare_Rd: QinN_2014.Rd:94-96: Dropping empty section \seealso
    prepare_Rd: RampelliS_2015.Rd:90-92: Dropping empty section \seealso
    prepare_Rd: TettAJ_2016.Rd:184-186: Dropping empty section \seealso
    prepare_Rd: ZellerG_2014.Rd:94-96: Dropping empty section \seealso
    ```

# debrowser

Version: 1.4.5

## Newly broken

*   checking whether package ‘debrowser’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/jhester/Dropbox/projects/devtools/revdep/checks/debrowser/new/debrowser.Rcheck/00install.out’ for details.
    ```

## Newly fixed

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Error: processing vignette 'DEBrowser.Rmd' failed with diagnostics:
    there is no package called ‘BiocStyle’
    Execution halted
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  9.3Mb
      sub-directories of 1Mb or more:
        doc       6.3Mb
        extdata   2.1Mb
    ```

*   checking R code for possible problems ... NOTE
    ```
    ...
    volcanoPlot: no visible binding for global variable ‘fillOpacity.hover’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/debrowser/old/debrowser.Rcheck/00_pkg_src/debrowser/R/volcano.R:19-30)
    volcanoPlot: no visible binding for global variable ‘fill.brush’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/debrowser/old/debrowser.Rcheck/00_pkg_src/debrowser/R/volcano.R:19-30)
    volcanoPlot: no visible binding for global variable ‘opacity’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/debrowser/old/debrowser.Rcheck/00_pkg_src/debrowser/R/volcano.R:19-30)
    volcanoPlot: no visible binding for global variable ‘key’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/debrowser/old/debrowser.Rcheck/00_pkg_src/debrowser/R/volcano.R:19-30)
    volcanoZoom: no visible global function definition for ‘:=’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/debrowser/old/debrowser.Rcheck/00_pkg_src/debrowser/R/volcano.R:51-61)
    volcanoZoom: no visible binding for global variable ‘size’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/debrowser/old/debrowser.Rcheck/00_pkg_src/debrowser/R/volcano.R:51-61)
    volcanoZoom: no visible binding for global variable ‘size.hover’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/debrowser/old/debrowser.Rcheck/00_pkg_src/debrowser/R/volcano.R:51-61)
    volcanoZoom: no visible binding for global variable ‘key’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/debrowser/old/debrowser.Rcheck/00_pkg_src/debrowser/R/volcano.R:51-61)
    Undefined global functions or variables:
      .startdebrowser.called := NUL align baseline biocLite conds debrowser
      demodata fill fill.brush fillOpacity fillOpacity.hover fit fontSize
      get_user_info googleAuth googleAuthUI initStore key opacity samples
      searched size size.hover stroke updateStore with_shiny
    ```

## Installation

### Devel

```
* installing *source* package ‘debrowser’ ...
** R
** inst
** preparing package for lazy loading
Error : object ‘load_data’ is not exported by 'namespace:devtools'
ERROR: lazy loading failed for package ‘debrowser’
* removing ‘/Users/jhester/Dropbox/projects/devtools/revdep/checks/debrowser/new/debrowser.Rcheck/debrowser’

```
### CRAN

```
* installing *source* package ‘debrowser’ ...
** R
** inst
** preparing package for lazy loading
No methods found in "S4Vectors" for requests: rowMeans
No methods found in "S4Vectors" for requests: rowSums
** help
*** installing help indices
** building package indices
** installing vignettes
** testing if installed package can be loaded
No methods found in "S4Vectors" for requests: rowMeans
No methods found in "S4Vectors" for requests: rowSums
* DONE (debrowser)

```
# demi

Version: 1.1.2

## In both

*   checking R code for possible problems ... NOTE
    ```
    ...
    diffexp,DEMIDiff: no visible global function definition for ‘p.adjust’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/demi/new/demi.Rcheck/00_pkg_src/demi/R/DEMIDiff-methods.R:352)
    loadAnnotation,DEMIExperiment-environment: no visible global function
      definition for ‘data’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/demi/new/demi.Rcheck/00_pkg_src/demi/R/DEMIExperiment-methods.R:549)
    loadBlat,DEMIExperiment-environment: no visible global function
      definition for ‘data’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/demi/new/demi.Rcheck/00_pkg_src/demi/R/DEMIExperiment-methods.R:598)
    loadCytoband,DEMIExperiment-environment: no visible global function
      definition for ‘data’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/demi/new/demi.Rcheck/00_pkg_src/demi/R/DEMIExperiment-methods.R:700)
    loadPathway,DEMIExperiment-environment: no visible global function
      definition for ‘data’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/demi/new/demi.Rcheck/00_pkg_src/demi/R/DEMIExperiment-methods.R:735)
    Undefined global functions or variables:
      combn data dhyper median p.adjust t.test wilcox.test write.table
    Consider adding
      importFrom("stats", "dhyper", "median", "p.adjust", "t.test",
                 "wilcox.test")
      importFrom("utils", "combn", "data", "write.table")
    to your NAMESPACE file.
    ```

# derfinder

Version: 1.10.6

## In both

*   R CMD check timed out
    

*   checking dependencies in R code ... NOTE
    ```
    Unexported objects imported by ':::' calls:
      ‘GenomeInfoDb:::.guessSpeciesStyle’
      ‘GenomeInfoDb:::.supportedSeqnameMappings’
      See the note in ?`:::` about the use of this operator.
    There are ::: calls to the package's namespace in its code. A package
      almost never needs to use ::: for its own objects:
      ‘.smootherFstats’
    ```

# derfinderData

Version: 0.110.0

## In both

*   checking installed package size ... NOTE
    ```
      installed size is 33.9Mb
      sub-directories of 1Mb or more:
        extdata  33.7Mb
    ```

# derfinderHelper

Version: 1.10.0

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Warning in citation("BiocStyle") :
      no date field in DESCRIPTION file of package 'BiocStyle'
    Quitting from lines 51-82 (derfinderHelper.Rmd) 
    Error: processing vignette 'derfinderHelper.Rmd' failed with diagnostics:
    package 'BiocParallel' not found
    Execution halted
    ```

# derfinderPlot

Version: 1.10.0

## In both

*   R CMD check timed out
    

# document

Version: 2.1.0

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      > library("document")
      > test_check("document")
      1. Error: (unknown) (@test_basic.R#13) -----------------------------------------
      R CMD check failed, read the above log and fix.
      1: document(file_name, check_package = TRUE, runit = TRUE) at testthat/test_basic.R:13
      2: check_package(package_directory = package_directory, working_directory = working_directory, 
             check_as_cran = check_as_cran, debug = debug, stop_on_check_not_passing = stop_on_check_not_passing) at /Users/jhester/Dropbox/projects/devtools/revdep/checks/document/new/document.Rcheck/00_pkg_src/document/R/document.R:80
      3: throw("R CMD check failed, read the above log and fix.") at /Users/jhester/Dropbox/projects/devtools/revdep/checks/document/new/document.Rcheck/00_pkg_src/document/R/package_functions.R:119
      
      testthat results ================================================================
      OK: 0 SKIPPED: 0 FAILED: 1
      1. Error: (unknown) (@test_basic.R#13) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# dodgr

Version: 0.0.1

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Loading dodgr
    Quitting from lines 119-131 (benchmark.Rmd) 
    Error: processing vignette 'benchmark.Rmd' failed with diagnostics:
    polygon edge not found
    Execution halted
    ```

# doRNG

Version: 1.6.6

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘doMPI’
    ```

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘doMPI’
    ```

# dr4pl

Version: 1.0.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘devtools’ ‘drc’ ‘testthat’
      All declared Imports should be used.
    ```

# elementR

Version: 1.3.2

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘elementR-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: elementR_project
    > ### Title: Object elementR_project
    > ### Aliases: elementR_project
    > 
    > ### ** Examples
    > 
    > ## create a new elementR_repStandard object based on the "filePath" 
    > ## from a folder containing sample replicate
    > 
    > filePath <- system.file("Example_Session", package="elementR")
    > 
    > exampleProject <- elementR_project$new(filePath)
    Error in structure(.External(.C_dotTclObjv, objv), class = "tclObj") : 
      [tcl] invalid command name "toplevel".
    Calls: <Anonymous> ... tktoplevel -> tkwidget -> tcl -> .Tcl.objv -> structure
    Execution halted
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  5.6Mb
      sub-directories of 1Mb or more:
        R         1.8Mb
        Results   2.4Mb
    ```

# epiNEM

Version: 1.0.1

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Error: processing vignette 'epiNEM.Rmd' failed with diagnostics:
    there is no package called ‘BiocStyle’
    Execution halted
    ```

*   checking foreign function calls ... NOTE
    ```
    Foreign function call to a different package:
      .Call("getTruthTable_R", ..., PACKAGE = "BoolNet")
    See chapter ‘System and foreign language interfaces’ in the ‘Writing R
    Extensions’ manual.
    ```

*   checking R code for possible problems ... NOTE
    ```
    ...
    plot.epiSim: no visible global function definition for ‘axis’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/epiNEM/new/epiNEM.Rcheck/00_pkg_src/epiNEM/R/plot_results.R:375-377)
    plot.epiSim: no visible global function definition for ‘boxplot’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/epiNEM/new/epiNEM.Rcheck/00_pkg_src/epiNEM/R/plot_results.R:403-405)
    plot.epiSim: no visible global function definition for ‘abline’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/epiNEM/new/epiNEM.Rcheck/00_pkg_src/epiNEM/R/plot_results.R:407)
    plot.epiSim: no visible global function definition for ‘axis’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/epiNEM/new/epiNEM.Rcheck/00_pkg_src/epiNEM/R/plot_results.R:409-411)
    plot.epiSim: no visible global function definition for ‘boxplot’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/epiNEM/new/epiNEM.Rcheck/00_pkg_src/epiNEM/R/plot_results.R:413-415)
    plot.epiSim: no visible global function definition for ‘abline’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/epiNEM/new/epiNEM.Rcheck/00_pkg_src/epiNEM/R/plot_results.R:417)
    plot.epiSim: no visible global function definition for ‘axis’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/epiNEM/new/epiNEM.Rcheck/00_pkg_src/epiNEM/R/plot_results.R:419-421)
    Undefined global functions or variables:
      abline absorption adj axis bnem boxplot computeFc dnf2adj
      dummyCNOlist epiNEM2Bg layout popSize preprocessing readSIF sim
      simulateStatesRecursive
    Consider adding
      importFrom("graphics", "abline", "axis", "boxplot", "layout")
    to your NAMESPACE file.
    ```

# exampletestr

Version: 1.0.1

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    See help("Deprecated") and help("devtools-deprecated").
    No DESCRIPTION found. Creating with values:
    
    
    Package: tempkg
    Title: What the Package Does (one line, title case)
    Version: 0.0.0.9000
    Authors@R: person("First", "Last", email = "first.last@example.com", role = c("aut", "cre"))
    Description: What the package does (one paragraph).
    Depends: R (>= 3.4.2)
    License: What license is it under?
    Encoding: UTF-8
    LazyData: true
    Warning: 'use_rstudio' is deprecated.
    Use 'usethis::use_rstudio()' instead.
    See help("Deprecated") and help("devtools-deprecated").
    Warning in warn_unless_current_dir(pkg) :
      `pkg` is not `.`, which is now unsupported.
      Please use `usethis::proj_set()` to set the project directory.
    Error: Current working directory, '/private/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T/RtmpqHEKVb',  does not appear to be inside a project or package.
    Execution halted
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      1: expect_true(devtools::create("tempkg")) at testthat/test_exemplar.R:140
      2: quasi_label(enquo(object), label) at /private/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T/Rtmpd4pGKb/remotes96f838157a80/r-lib-testthat-1faa32f/R/expect-logical.R:32
      3: eval_bare(get_expr(quo), get_env(quo)) at /private/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T/Rtmpd4pGKb/remotes96f838157a80/r-lib-testthat-1faa32f/R/expectation.R:90
      4: devtools::create("tempkg") at /private/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T/Rtmpd4pGKb/remotes96f8300192cd/tidyverse-rlang-cbdc3f3/R/eval.R:66
      5: stop("Directory exists and is not empty", call. = FALSE) at /private/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T/Rtmpd4pGKb/file96f832690f52/devtools/R/create.r:28
      
      testthat results ================================================================
      OK: 15 SKIPPED: 0 FAILED: 4
      1. Error: extract_examples works (@test_exemplar.R#5) 
      2. Failure: make_test_shell works (@test_exemplar.R#93) 
      3. Error: make_test_shell works (@test_exemplar.R#94) 
      4. Error: make_tests_shells_file works (@test_exemplar.R#140) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Quitting from lines 23-30 (exampletestr.Rmd) 
    Error: processing vignette 'exampletestr.Rmd' failed with diagnostics:
    Current working directory, '/private/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T/RtmpPHiRQV',  does not appear to be inside a project or package.
    Execution halted
    ```

# ggExtra

Version: 0.7

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘grDevices’
      All declared Imports should be used.
    ```

# githubinstall

Version: 0.2.1

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      testthat results ================================================================
      OK: 34 SKIPPED: 0 FAILED: 12
      1. Error: Install: ask no (@test-gh_install_packages.R#27) 
      2. Error: Install: ask yes (@test-gh_install_packages.R#37) 
      3. Error: recommend_dependencies: ask = TRUE (@test-utils_for_install.R#49) 
      4. Error: select_repository: multi candidates (@test-utils_for_install.R#130) 
      5. Error: select_repository: cancel (@test-utils_for_install.R#142) 
      6. Error: remove_conflict_repos: no installed (@test-utils_for_install.R#169) 
      7. Error: remove_conflict_repos: not conflict (@test-utils_for_install.R#183) 
      8. Error: remove_conflict_repos: conflict GitHub, ask yes (@test-utils_for_install.R#198) 
      9. Error: remove_conflict_repos: conflict GitHub, ask no (@test-utils_for_install.R#213) 
      1. ...
      
      Error: testthat unit tests failed
      Execution halted
    ```

# googleAuthR

Version: 0.6.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘R6’
      All declared Imports should be used.
    ```

# googleComputeEngineR

Version: 0.2.0

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      testthat results ================================================================
      OK: 5 SKIPPED: 0 FAILED: 46
      1. Error: We can see a project resource (@test_aa_auth.R#16) 
      2. Error: We can set auto project (@test_aa_auth.R#26) 
      3. Error: We can get auto project (@test_aa_auth.R#37) 
      4. Error: We can list networks (@test_aa_auth.R#70) 
      5. Error: We can get a network (@test_aa_auth.R#79) 
      6. Error: We can make a container VM (@test_bb_create_vm.R#7) 
      7. Error: We can make a VM with metadata (@test_bb_create_vm.R#24) 
      8. Error: We can make a template VM (@test_bb_create_vm.R#41) 
      9. Error: We can make a VM with custom disk size (@test_bb_create_vm.R#57) 
      1. ...
      
      Error: testthat unit tests failed
      Execution halted
    ```

# gsrc

Version: 1.1

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘brassicaData’
    ```

# huxtable

Version: 1.1.0

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      testthat results ================================================================
      OK: 290 SKIPPED: 2 FAILED: 47
      1. Error: Cell property attr align examples unchanged (@test-attributes.R#14) 
      2. Error: Cell property attr valign examples unchanged (@test-attributes.R#14) 
      3. Error: Cell property attr rowspan examples unchanged (@test-attributes.R#14) 
      4. Error: Cell property attr colspan examples unchanged (@test-attributes.R#14) 
      5. Error: Cell property attr background_color examples unchanged (@test-attributes.R#14) 
      6. Error: Cell property attr text_color examples unchanged (@test-attributes.R#14) 
      7. Error: Cell property attr top_border examples unchanged (@test-attributes.R#14) 
      8. Error: Cell property attr left_border examples unchanged (@test-attributes.R#14) 
      9. Error: Cell property attr right_border examples unchanged (@test-attributes.R#14) 
      1. ...
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘xtable’
    ```

# hyperSpec

Version: 0.99-20171005

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  6.0Mb
      sub-directories of 1Mb or more:
        R     1.6Mb
        doc   3.9Mb
    ```

*   checking R code for possible problems ... NOTE
    ```
    Warning: local assignments to syntactic functions: ~
    ```

# IalsaSynthesis

Version: 0.1.6

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      1: base::file.path(devtools::inst(name = "IalsaSynthesis"), "test_data/2015-portland") at testthat/test-validate.R:28
      2: devtools::inst
      3: getExportedValue(pkg, name)
      4: stop(gettextf("'%s' is not an exported object from 'namespace:%s'", name, getNamespaceName(ns)), 
             call. = FALSE, domain = NA)
      
      testthat results ================================================================
      OK: 1 SKIPPED: 0 FAILED: 4
      1. Error: (unknown) (@test-extract.R#5) 
      2. Error: validate_filename_output -good (@test-validate.R#7) 
      3. Error: validate_filename_output -missing (@test-validate.R#19) 
      4. Error: validate_filename_output -bad extension (@test-validate.R#28) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# icd9

Version: 1.3.1

## Newly broken

*   checking dependencies in R code ... NOTE
    ```
    Missing or unexported object: ‘devtools::load_data’
    ```

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 14 marked Latin-1 strings
      Note: found 39 marked UTF-8 strings
    ```

# IHW

Version: 1.4.0

## In both

*   checking R code for possible problems ... NOTE
    ```
    ...
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/IHW/new/IHW.Rcheck/00_pkg_src/IHW/R/plots.R:101)
    plot_decisionboundary: no visible binding for global variable
      ‘covariate’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/IHW/new/IHW.Rcheck/00_pkg_src/IHW/R/plots.R:110-112)
    plot_decisionboundary: no visible binding for global variable ‘pvalue’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/IHW/new/IHW.Rcheck/00_pkg_src/IHW/R/plots.R:110-112)
    plot_decisionboundary: no visible binding for global variable ‘fold’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/IHW/new/IHW.Rcheck/00_pkg_src/IHW/R/plots.R:110-112)
    thresholds_ihwResult: no visible global function definition for
      ‘na.exclude’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/IHW/new/IHW.Rcheck/00_pkg_src/IHW/R/ihw_class.R:96-97)
    thresholds,ihwResult: no visible global function definition for
      ‘na.exclude’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/IHW/new/IHW.Rcheck/00_pkg_src/IHW/R/ihw_class.R:96-97)
    Undefined global functions or variables:
      covariate fold gurobi mcols mcols<- metadata metadata<- na.exclude
      p.adjust pvalue runif str stratum
    Consider adding
      importFrom("stats", "na.exclude", "p.adjust", "runif")
      importFrom("utils", "str")
    to your NAMESPACE file.
    ```

# jpmesh

Version: 0.4.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘readr’
      All declared Imports should be used.
    ```

# jpndistrict

Version: 0.2.0

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 188 marked UTF-8 strings
    ```

# KoNLP

Version: 0.80.1

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  6.5Mb
      sub-directories of 1Mb or more:
        java   6.0Mb
    ```

# likert

Version: 1.3.5

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 7 marked UTF-8 strings
    ```

# Logolas

Version: 1.0.0

## In both

*   checking files in ‘vignettes’ ... NOTE
    ```
    The following directory looks like a leftover from 'knitr':
      ‘figure’
    Please remove from your package.
    ```

# Luminescence

Version: 0.7.5

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      Error: testthat unit tests failed
      In addition: Warning messages:
      1: In .Internal(gc(verbose, reset)) :
        closing unused connection 8 (/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T//RtmpnjWeBc/read_BIN2R_FILEfc9339e39)
      2: In .Internal(gc(verbose, reset)) :
        closing unused connection 7 (/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T//RtmpnjWeBc/read_BIN2R_FILEfc935deb412b)
      3: In .Internal(gc(verbose, reset)) :
        closing unused connection 6 (/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T//RtmpnjWeBc/read_BIN2R_FILEfc93298cd8c4)
      4: In .Internal(gc(verbose, reset)) :
        closing unused connection 5 (/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T//RtmpnjWeBc/read_BIN2R_FILEfc93283cb4f7)
      5: In .Internal(gc(verbose, reset)) :
        closing unused connection 4 (/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T//RtmpnjWeBc/read_BIN2R_FILEfc9353ea024b)
      6: In .Internal(gc(verbose, reset)) :
        closing unused connection 3 (/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T//RtmpnjWeBc/read_BIN2R_FILEfc93688483d0)
      Execution halted
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  6.6Mb
      sub-directories of 1Mb or more:
        R   4.5Mb
    ```

# MCbiclust

Version: 1.0.1

## In both

*   R CMD check timed out
    

*   checking installed package size ... NOTE
    ```
      installed size is  9.0Mb
      sub-directories of 1Mb or more:
        data   3.1Mb
        doc    4.9Mb
    ```

# metafolio

Version: 0.1.0

## In both

*   checking R code for possible problems ... NOTE
    ```
    ...
    plot_sp_A_ts: no visible global function definition for ‘axis’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/metafolio/new/metafolio.Rcheck/00_pkg_src/metafolio/R/plot_sp_A_ts.R:90-91)
    run_cons_plans: no visible binding for global variable ‘var’
    thermal_area: no visible global function definition for ‘uniroot’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/metafolio/new/metafolio.Rcheck/00_pkg_src/metafolio/R/thermal_integration.R:19-21)
    thermal_area: no visible global function definition for ‘uniroot’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/metafolio/new/metafolio.Rcheck/00_pkg_src/metafolio/R/thermal_integration.R:22-24)
    thermal_area: no visible global function definition for ‘integrate’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/metafolio/new/metafolio.Rcheck/00_pkg_src/metafolio/R/thermal_integration.R:26-28)
    Undefined global functions or variables:
      abline axTicks axis barplot box chull contourLines hcl integrate
      legend lines lm matplot mtext na.omit optimize par plot plot.default
      points polygon quantile rect rnorm runif text uniroot var
    Consider adding
      importFrom("grDevices", "chull", "contourLines", "hcl")
      importFrom("graphics", "abline", "axTicks", "axis", "barplot", "box",
                 "legend", "lines", "matplot", "mtext", "par", "plot",
                 "plot.default", "points", "polygon", "rect", "text")
      importFrom("stats", "integrate", "lm", "na.omit", "optimize",
                 "quantile", "rnorm", "runif", "uniroot", "var")
    to your NAMESPACE file.
    ```

# miniCRAN

Version: 0.2.10

## In both

*   R CMD check timed out
    

# MODIS

Version: 1.1.0

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.4Mb
      sub-directories of 1Mb or more:
        R          1.2Mb
        external   3.9Mb
    ```

# modules

Version: 0.6.0

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
        expect_warning(source_gist("605a984e764f9ed358556b4ce48cbd08", local = environment()), "using first")
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      tests/testthat/test-uninstall.r:7:15: style: Use <-, not =, for assignment.
        tmp_libpath = file.path(tempdir(), "devtools_test")
                    ^
      tests/testthat/testVignettesBuilt/R/code.r:1:1: style: Variable and function names should not be longer than 20 characters.
      function_with_unusual_name <- function() {
      ^~~~~~~~~~~~~~~~~~~~~~~~~~
      
      testthat results ================================================================
      OK: 64 SKIPPED: 0 FAILED: 1
      1. Failure: Package Style (@test-lintr.R#3) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# Momocs

Version: 1.2.2

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  6.6Mb
      sub-directories of 1Mb or more:
        R      1.9Mb
        data   1.5Mb
        doc    2.3Mb
    ```

# MonetDBLite

Version: 0.4.1

## In both

*   R CMD check timed out
    

*   checking installed package size ... NOTE
    ```
      installed size is  5.7Mb
      sub-directories of 1Mb or more:
        libs   5.1Mb
    ```

# MoonlightR

Version: 1.2.0

## In both

*   R CMD check timed out
    

*   checking installed package size ... NOTE
    ```
      installed size is  5.9Mb
      sub-directories of 1Mb or more:
        data   3.1Mb
        doc    2.6Mb
    ```

# msgtools

Version: 0.2.7

## In both

*   checking examples ... ERROR
    ```
    ...
    >   # make a translation
    >   tran <- make_translation("es", translator = "Some Person <example@examle.com>", pkg = pkg)
    Updating the PO-Revision-Date to ‘2017-10-26 15:23:53-0400’.
    Updating the Language-Team to ‘’.
    >   write_translation(tran, pkg = pkg)
    > 
    >   # install translation(s)
    >   check_translations(pkg = pkg) # check for errors before install
    $`R-es`
    No errors
    
    >   install_translations(pkg = pkg)
    sh: msgfmt: command not found
    Warning in install_translations(pkg = pkg) :
      running msgfmt on R-es.po failed
    Updating the PO-Revision-Date to ‘2017-10-26 15:23:54-0400’.
    Updating the Language-Team to ‘’.
    sh: msgconv: command not found
    Error in install_translations(pkg = pkg) : 
      running msgconv on 'R-en@quot' UTF-8 localization failed
    Execution halted
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    sh: xgettext: command not found
    sh: msgmerge: command not found
    sh: msgmerge: command not found
    sh: msgfmt: command not found
    sh: msgconv: command not found
    Quitting from lines 136-138 (Tutorial.Rmd) 
    Error: processing vignette 'Tutorial.Rmd' failed with diagnostics:
    running msgconv on 'R-en@quot' UTF-8 localization failed
    Execution halted
    ```

# myTAI

Version: 0.6.0

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.6Mb
      sub-directories of 1Mb or more:
        data   2.0Mb
        doc    2.7Mb
    ```

# networktools

Version: 1.1.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘devtools’
      All declared Imports should be used.
    ```

# nima

Version: 0.4.5

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘survival’
      All declared Imports should be used.
    ```

# NlsyLinks

Version: 2.0.6

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/test-all.R’ failed.
    Last 13 lines of output:
      3: getExportedValue(pkg, name)
      4: stop(gettextf("'%s' is not an exported object from 'namespace:%s'", name, getNamespaceName(ns)), 
             call. = FALSE, domain = NA)
      
      testthat results ================================================================
      OK: 198 SKIPPED: 0 FAILED: 6
      1. Error: Nlsy79Gen2 (@test-column-utilities.R#89) 
      2. Error: RenameNlsyColumn (@test-column-utilities.R#103) 
      3. Error: Nlsy79Gen1Path (@test-read-csv.R#21) 
      4. Error: Nlsy79Gen1DataFrame (@test-read-csv.R#32) 
      5. Error: Nlsy79Gen2Path (@test-read-csv.R#45) 
      6. Error: Nlsy79Gen2DataFrame (@test-read-csv.R#58) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  8.7Mb
      sub-directories of 1Mb or more:
        data      4.3Mb
        reports   2.2Mb
    ```

# NMF

Version: 0.20.6

## In both

*   checking package dependencies ... NOTE
    ```
    Packages suggested but not available for checking: ‘RcppOctave’ ‘doMPI’
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  5.1Mb
      sub-directories of 1Mb or more:
        R     2.6Mb
        doc   1.1Mb
    ```

*   checking R code for possible problems ... NOTE
    ```
    ...
      variable ‘n’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/NMF/new/NMF.Rcheck/00_pkg_src/NMF/R/nmf.R:1584)
    nmf,matrix-numeric-NMFStrategy : run.all: no visible binding for global
      variable ‘n’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/NMF/new/NMF.Rcheck/00_pkg_src/NMF/R/nmf.R:1590-1592)
    nmf,matrix-numeric-NMFStrategy : run.all: no visible binding for global
      variable ‘n’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/NMF/new/NMF.Rcheck/00_pkg_src/NMF/R/nmf.R:1597-1599)
    nmf,matrix-numeric-NMFStrategy : run.all: no visible binding for global
      variable ‘n’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/NMF/new/NMF.Rcheck/00_pkg_src/NMF/R/nmf.R:1618-1621)
    nmf,matrix-numeric-NMFStrategy : run.all: no visible binding for global
      variable ‘n’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/NMF/new/NMF.Rcheck/00_pkg_src/NMF/R/nmf.R:1653)
    nmf,matrix-numeric-NMFStrategy : run.all: no visible binding for global
      variable ‘n’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/NMF/new/NMF.Rcheck/00_pkg_src/NMF/R/nmf.R:1666-1676)
    rss,matrix: no visible binding for global variable ‘Biobase’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/NMF/new/NMF.Rcheck/00_pkg_src/NMF/R/NMF-class.R:2263-2264)
    Undefined global functions or variables:
      Biobase RNGobj fstop n
    ```

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘RcppOctave’
    ```

# npsm

Version: 0.5

## In both

*   checking R code for possible problems ... NOTE
    ```
    ...
    onecovahomog: no visible global function definition for ‘pf’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/npsm/new/npsm.Rcheck/00_pkg_src/npsm/R/racov.r:53)
    rank.test: no visible global function definition for ‘pnorm’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/npsm/new/npsm.Rcheck/00_pkg_src/npsm/R/rank.test.r:12-16)
    rank.test: no visible global function definition for ‘coef’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/npsm/new/npsm.Rcheck/00_pkg_src/npsm/R/rank.test.r:21)
    rank.test: no visible global function definition for ‘qt’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/npsm/new/npsm.Rcheck/00_pkg_src/npsm/R/rank.test.r:24-28)
    rcn: no visible global function definition for ‘rnorm’
    vanElteren.test: no visible global function definition for ‘pnorm’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/npsm/new/npsm.Rcheck/00_pkg_src/npsm/R/vanElteren.test.r:23)
    Undefined global functions or variables:
      coef cor dnorm median model.matrix new pchisq pf pnorm qnorm qt
      quantile resid rnorm var
    Consider adding
      importFrom("methods", "new")
      importFrom("stats", "coef", "cor", "dnorm", "median", "model.matrix",
                 "pchisq", "pf", "pnorm", "qnorm", "qt", "quantile", "resid",
                 "rnorm", "var")
    to your NAMESPACE file (and ensure that your DESCRIPTION Imports field
    contains 'methods').
    ```

# opencpu

Version: 2.0.5

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 4 marked UTF-8 strings
    ```

# OpenMx

Version: 2.7.18

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘Rmpi’
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 15.2Mb
      sub-directories of 1Mb or more:
        R        4.3Mb
        libs     3.5Mb
        models   4.6Mb
    ```

*   checking Rd cross-references ... NOTE
    ```
    Packages unavailable to check Rd xrefs: ‘ifaTools’, ‘umx’
    ```

# osmplotr

Version: 0.3.0

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  6.8Mb
      sub-directories of 1Mb or more:
        doc   5.9Mb
    ```

# packrat

Version: 0.4.8-1

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/test-all.R’ failed.
    Last 13 lines of output:
      testthat results ================================================================
      OK: 47 SKIPPED: 2 FAILED: 11
      1. Error: Bundle works when using R's internal tar (@test-bundle.R#14) 
      2. Error: Bundle works when omitting CRAN packages (@test-bundle.R#36) 
      3. Error: init creates project structure and installs dependencies (@test-packrat.R#19) 
      4. Error: restore ignores dirty packages (@test-packrat.R#35) 
      5. Error: restore installs missing packages (@test-packrat.R#48) 
      6. Error: snapshot captures new dependencies (@test-packrat.R#62) 
      7. Error: dependencies in library directories are ignored (@test-packrat.R#89) 
      8. Error: clean removes libraries and sources (@test-packrat.R#103) 
      9. Error: init works with multiple repos (@test-packrat.R#133) 
      1. ...
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   checking package dependencies ... NOTE
    ```
    Package which this enhances but not available for checking: ‘BiocInstaller’
    ```

# parlitools

Version: 0.2.1

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 13 marked UTF-8 strings
    ```

# perccalc

Version: 1.0.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘MASS’ ‘devtools’ ‘ggplot2’ ‘haven’ ‘tidyverse’
      All declared Imports should be used.
    ```

# pkgmaker

Version: 0.22

## In both

*   checking dependencies in R code ... NOTE
    ```
    'library' or 'require' calls in package code:
      ‘argparse’ ‘devtools’ ‘knitr’
      Please use :: or requireNamespace() instead.
      See section 'Suggested packages' in the 'Writing R Extensions' manual.
    ```

*   checking R code for possible problems ... NOTE
    ```
    ...
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/pkgmaker/new/pkgmaker.Rcheck/00_pkg_src/pkgmaker/R/unitTests.R:792)
    utest,character: no visible global function definition for ‘test_file’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/pkgmaker/new/pkgmaker.Rcheck/00_pkg_src/pkgmaker/R/unitTests.R:797)
    Undefined global functions or variables:
      .testLogger ArgumentParser HTMLReport RweaveLatex Sweave
      available.packages browseURL capture.output citation compareVersion
      contrib.url data defineTestSuite dev.off devtools file_test finish
      getErrors head hwrite installed.packages is.package knit knit2html
      knit2pdf knit_hooks load_all opts_chunk packageDescription par png
      printHTMLProtocol printTextProtocol proto publish read.bib
      runTestFile runTestSuite sessionInfo str tail test_dir test_file
      toBibtex toLatex untar
    Consider adding
      importFrom("grDevices", "dev.off", "png")
      importFrom("graphics", "par")
      importFrom("utils", "RweaveLatex", "Sweave", "available.packages",
                 "browseURL", "capture.output", "citation", "compareVersion",
                 "contrib.url", "data", "file_test", "head",
                 "installed.packages", "packageDescription", "sessionInfo",
                 "str", "tail", "toBibtex", "toLatex", "untar")
    to your NAMESPACE file.
    ```

# PKPDmisc

Version: 2.0.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘purrr’
      All declared Imports should be used.
    ```

# poio

Version: 0.0-3

## In both

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘ISOcodes’
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 8 marked UTF-8 strings
    ```

# prodigenr

Version: 0.3.0

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      13: suppressMessages(devtools::create(proj_path))
      14: withCallingHandlers(expr, message = function(c) invokeRestart("muffleMessage"))
      15: devtools::create(proj_path)
      16: stop("Directory exists and is not empty", call. = FALSE) at /private/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T/Rtmpd4pGKb/file96f832690f52/devtools/R/create.r:28
      
      testthat results ================================================================
      OK: 18 SKIPPED: 0 FAILED: 5
      1. Error: (current version) project directory and files created (default) (@test-projects.R#129) 
      2. Error: (current version) project directory and files created (using name) (@test-projects.R#137) 
      3. Error: (current version) project directory and files created (using strobe) (@test-projects.R#145) 
      4. Error: (current version) project directory and files created (using license) (@test-projects.R#153) 
      5. Error: (current version) project directory and files created (using figshare) (@test-projects.R#161) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘stats’
      All declared Imports should be used.
    ```

# PSAboot

Version: 1.1.4

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 4 marked UTF-8 strings
    ```

# psichomics

Version: 1.2.1

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.4Mb
      sub-directories of 1Mb or more:
        R     1.4Mb
        doc   3.3Mb
    ```

# pulver

Version: 0.1.0

## In both

*   checking whether package ‘pulver’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/jhester/Dropbox/projects/devtools/revdep/checks/pulver/new/pulver.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘pulver’ ...
** package ‘pulver’ successfully unpacked and MD5 sums checked
** libs
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/devtools/new/Rcpp/include" -I/usr/local/include  -fopenmp -fPIC  -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/devtools/new/Rcpp/include" -I/usr/local/include  -fopenmp -fPIC  -Wall -g -O2  -c partial_result.cpp -o partial_result.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/devtools/new/Rcpp/include" -I/usr/local/include  -fopenmp -fPIC  -Wall -g -O2  -c pulver.cpp -o pulver.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/devtools/new/Rcpp/include" -I/usr/local/include  -fopenmp -fPIC  -Wall -g -O2  -c result.cpp -o result.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/devtools/new/Rcpp/include" -I/usr/local/include  -fopenmp -fPIC  -Wall -g -O2  -c storage.cpp -o storage.o
clang: error: unsupported option '-fopenmp'
clang: error: unsupported option '-fopenmp'
clang: error: unsupported option '-fopenmp'
make: *** [partial_result.o] Error 1
make: *** Waiting for unfinished jobs....
make: *** [pulver.o] Error 1
clang: error: unsupported option '-fopenmp'
make: *** [RcppExports.o] Error 1
make: *** [result.o] Error 1
clang: error: unsupported option '-fopenmp'
make: *** [storage.o] Error 1
ERROR: compilation failed for package ‘pulver’
* removing ‘/Users/jhester/Dropbox/projects/devtools/revdep/checks/pulver/new/pulver.Rcheck/pulver’

```
### CRAN

```
* installing *source* package ‘pulver’ ...
** package ‘pulver’ successfully unpacked and MD5 sums checked
** libs
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/pulver/Rcpp/include" -I/usr/local/include  -fopenmp -fPIC  -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/pulver/Rcpp/include" -I/usr/local/include  -fopenmp -fPIC  -Wall -g -O2  -c partial_result.cpp -o partial_result.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/pulver/Rcpp/include" -I/usr/local/include  -fopenmp -fPIC  -Wall -g -O2  -c pulver.cpp -o pulver.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/pulver/Rcpp/include" -I/usr/local/include  -fopenmp -fPIC  -Wall -g -O2  -c result.cpp -o result.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/pulver/Rcpp/include" -I/usr/local/include  -fopenmp -fPIC  -Wall -g -O2  -c storage.cpp -o storage.o
clang: errorclang: error: unsupported option '-fopenmp'
: unsupported option '-fopenmp'
clang: error: clang: error: unsupported option '-fopenmp'unsupported option '-fopenmp'

make: *** [result.o] Error 1
make: *** Waiting for unfinished jobs....
make: *** [storage.o] Error 1
make: *** [pulver.o] Error 1
make: *** [partial_result.o] Error 1
clang: error: unsupported option '-fopenmp'
make: *** [RcppExports.o] Error 1
ERROR: compilation failed for package ‘pulver’
* removing ‘/Users/jhester/Dropbox/projects/devtools/revdep/checks/pulver/old/pulver.Rcheck/pulver’

```
# rbundler

Version: 0.3.7

## Newly broken

*   checking Rd cross-references ... WARNING
    ```
    Missing link or links in documentation object 'install_version.Rd':
      ‘has_devel’
    
    See section 'Cross-references' in the 'Writing R Extensions' manual.
    ```

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
    Malformed Title field: should not end in a period.
    ```

*   checking R code for possible problems ... NOTE
    ```
    ...
    install_version: no visible global function definition for
      ‘contrib.url’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/rbundler/new/rbundler.Rcheck/00_pkg_src/rbundler/R/install_version.r:25)
    install_version: no visible global function definition for
      ‘available.packages’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/rbundler/new/rbundler.Rcheck/00_pkg_src/rbundler/R/install_version.r:26)
    install_version: no visible global function definition for
      ‘install_url’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/rbundler/new/rbundler.Rcheck/00_pkg_src/rbundler/R/install_version.r:37)
    load_available_packages: no visible global function definition for
      ‘contrib.url’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/rbundler/new/rbundler.Rcheck/00_pkg_src/rbundler/R/load_available_packages.r:5)
    validate_installed_package: no visible global function definition for
      ‘installed.packages’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/rbundler/new/rbundler.Rcheck/00_pkg_src/rbundler/R/install_version.r:55)
    Undefined global functions or variables:
      available.packages contrib.url install_url installed.packages
    Consider adding
      importFrom("utils", "available.packages", "contrib.url",
                 "installed.packages")
    to your NAMESPACE file.
    ```

# recount

Version: 1.2.3

## In both

*   R CMD check timed out
    

*   checking installed package size ... NOTE
    ```
      installed size is 13.5Mb
      sub-directories of 1Mb or more:
        data  10.7Mb
        doc    2.6Mb
    ```

*   checking R code for possible problems ... NOTE
    ```
    add_predictions: no visible binding for global variable
      ‘PredictedPhenotypes’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/recount/new/recount.Rcheck/00_pkg_src/recount/R/add_predictions.R:80)
    add_predictions: no visible binding for global variable
      ‘PredictedPhenotypes’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/recount/new/recount.Rcheck/00_pkg_src/recount/R/add_predictions.R:82)
    add_predictions: no visible binding for global variable
      ‘PredictedPhenotypes’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/recount/new/recount.Rcheck/00_pkg_src/recount/R/add_predictions.R:84-85)
    Undefined global functions or variables:
      PredictedPhenotypes
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 347 marked UTF-8 strings
    ```

# REDCapR

Version: 0.9.8

## Newly broken

*   checking dependencies in R code ... NOTE
    ```
    Missing or unexported object: ‘devtools::inst’
    ```

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/test-all.R’ failed.
    Last 13 lines of output:
      testthat results ================================================================
      OK: 120 SKIPPED: 0 FAILED: 25
      1. Error: NameComesFromREDCap (@test-file-oneshot.R#11) 
      2. Error: FullPathSpecified (@test-file-oneshot.R#63) 
      3. Error: RelativePath (@test-file-oneshot.R#114) 
      4. Error: Full Directory Specific (@test-file-oneshot.R#165) 
      5. Error: (unknown) (@test-metadata-read.R#4) 
      6. Error: Smoke Test (@test-project.R#6) 
      7. Error: Read, Insert, and Update (@test-project.R#12) 
      8. Error: (unknown) (@test-read-batch-longitudinal.R#4) 
      9. Error: (unknown) (@test-read-batch-simple.R#4) 
      1. ...
      
      Error: testthat unit tests failed
      Execution halted
    ```

# redlistr

Version: 1.0.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘rgdal’
      All declared Imports should be used.
    ```

# regionReport

Version: 1.10.2

## In both

*   R CMD check timed out
    

*   checking dependencies in R code ... NOTE
    ```
    Unexported object imported by a ':::' call: ‘DESeq2:::pvalueAdjustment’
      See the note in ?`:::` about the use of this operator.
    ```

# rfishbase

Version: 2.1.2

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 44 marked UTF-8 strings
    ```

# RIVER

Version: 1.0.0

## In both

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘data.table’
    ```

# rnaturalearth

Version: 0.1.0

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘rnaturalearthhires’
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 7 marked Latin-1 strings
    ```

# ropenaq

Version: 0.2.2

## In both

*   R CMD check timed out
    

# rpivotTable

Version: 0.2.0

## In both

*   checking package dependencies ... NOTE
    ```
    Package which this enhances but not available for checking: ‘shiny’
    ```

# rsoi

Version: 0.3.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘utils’
      All declared Imports should be used.
    ```

# RTCGA

Version: 1.6.0

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘RTCGA-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: boxplotTCGA
    > ### Title: Create Boxplots for TCGA Datasets
    > ### Aliases: boxplotTCGA
    > 
    > ### ** Examples
    > 
    > library(RTCGA.rnaseq)
    Error in library(RTCGA.rnaseq) : 
      there is no package called ‘RTCGA.rnaseq’
    Execution halted
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Complete output:
      > library(testthat)
      > library(RTCGA)
      Welcome to the RTCGA (version: 1.6.0).
      > library(RTCGA.rnaseq)
      Error in library(RTCGA.rnaseq) : 
        there is no package called 'RTCGA.rnaseq'
      Execution halted
    ```

*   checking package dependencies ... NOTE
    ```
    Packages suggested but not available for checking:
      ‘RTCGA.rnaseq’ ‘RTCGA.clinical’ ‘RTCGA.mutations’ ‘RTCGA.RPPA’
      ‘RTCGA.mRNA’ ‘RTCGA.miRNASeq’ ‘RTCGA.methylation’ ‘RTCGA.CNV’
      ‘RTCGA.PANCAN12’
    ```

*   checking R code for possible problems ... NOTE
    ```
    ...
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/RTCGA/new/RTCGA.Rcheck/00_pkg_src/RTCGA/R/ggbiplot.R:157-161)
    ggbiplot: no visible binding for global variable ‘xvar’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/RTCGA/new/RTCGA.Rcheck/00_pkg_src/RTCGA/R/ggbiplot.R:157-161)
    ggbiplot: no visible binding for global variable ‘yvar’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/RTCGA/new/RTCGA.Rcheck/00_pkg_src/RTCGA/R/ggbiplot.R:157-161)
    ggbiplot: no visible binding for global variable ‘angle’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/RTCGA/new/RTCGA.Rcheck/00_pkg_src/RTCGA/R/ggbiplot.R:157-161)
    ggbiplot: no visible binding for global variable ‘hjust’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/RTCGA/new/RTCGA.Rcheck/00_pkg_src/RTCGA/R/ggbiplot.R:157-161)
    read.mutations: no visible binding for global variable ‘.’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/RTCGA/new/RTCGA.Rcheck/00_pkg_src/RTCGA/R/readTCGA.R:383)
    read.mutations: no visible binding for global variable ‘.’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/RTCGA/new/RTCGA.Rcheck/00_pkg_src/RTCGA/R/readTCGA.R:386)
    read.rnaseq: no visible binding for global variable ‘.’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/RTCGA/new/RTCGA.Rcheck/00_pkg_src/RTCGA/R/readTCGA.R:372-375)
    survivalTCGA: no visible binding for global variable ‘times’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/RTCGA/new/RTCGA.Rcheck/00_pkg_src/RTCGA/R/survivalTCGA.R:101-137)
    whichDateToUse: no visible binding for global variable ‘.’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/RTCGA/new/RTCGA.Rcheck/00_pkg_src/RTCGA/R/downloadTCGA.R:167-168)
    Undefined global functions or variables:
      . angle hjust muted times varname xvar yvar
    ```

*   checking Rd cross-references ... NOTE
    ```
    Packages unavailable to check Rd xrefs: ‘RTCGA.rnaseq’, ‘RTCGA.clinical’, ‘RTCGA.mutations’, ‘RTCGA.CNV’, ‘RTCGA.RPPA’, ‘RTCGA.mRNA’, ‘RTCGA.miRNASeq’, ‘RTCGA.methylation’
    ```

# RxODE

Version: 0.6-1

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      7: eval(substitute(expr), envir = parent.frame(1))
      8: devtools::create("tmp") at testthat/test-issue-4.R:49
      9: setup(path = path, description = description, rstudio = rstudio, check = check, quiet = quiet) at /private/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T/Rtmpd4pGKb/file96f832690f52/devtools/R/create.r:33
      10: use_rstudio(path) at /private/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T/Rtmpd4pGKb/file96f832690f52/devtools/R/create.r:55
      11: usethis::use_rstudio() at /private/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T/Rtmpd4pGKb/file96f832690f52/devtools/R/infrastructure.R:25
      12: use_template("template.Rproj", paste0(project_name(), ".Rproj")) at /private/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T/Rtmpd4pGKb/remotes96f8688f4b75/r-lib-usethis-b093d9c/R/rstudio.R:9
      13: write_over(proj_get(), save_as, template_contents) at /private/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T/Rtmpd4pGKb/remotes96f8688f4b75/r-lib-usethis-b093d9c/R/helpers.R:17
      14: stop(value(path), " already exists.", call. = FALSE) at /private/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T/Rtmpd4pGKb/remotes96f8688f4b75/r-lib-usethis-b093d9c/R/write.R:33
      
      testthat results ================================================================
      OK: 406 SKIPPED: 1 FAILED: 1
      1. Error: (unknown) (@test-issue-4.R#26) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# SciencesPo

Version: 1.4.1

## In both

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘gmodels’
    ```

# soilcarbon

Version: 1.2.0

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 145 marked UTF-8 strings
    ```

# SpaDES.addins

Version: 0.1.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘devtools’ ‘rstudioapi’
      All declared Imports should be used.
    ```

# spectrolab

Version: 0.0.2

## Newly broken

*   checking whether package ‘spectrolab’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: 'devtools::use_package' is deprecated.
    See ‘/Users/jhester/Dropbox/projects/devtools/revdep/checks/spectrolab/new/spectrolab.Rcheck/00install.out’ for details.
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘devtools’
      All declared Imports should be used.
    ```

# SpidermiR

Version: 1.7.4

## Newly fixed

*   R CMD check timed out
    

## In both

*   checking R code for possible problems ... NOTE
    ```
    .SpidermiRvisualize_gene: possible error in simpleNetwork(NetworkData,
      linkColour = "gray", textColour = "black", zoom = TRUE): unused
      argument (textColour = "black")
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/SpidermiR/new/SpidermiR.Rcheck/00_pkg_src/SpidermiR/R/SpidermiRInternal.R:31)
    SpidermiRvisualize_plot_target: no visible binding for global variable
      ‘miRNAs’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/SpidermiR/new/SpidermiR.Rcheck/00_pkg_src/SpidermiR/R/SpidermiRvisualize.R:143-145)
    SpidermiRvisualize_plot_target: no visible binding for global variable
      ‘mRNA_target’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/SpidermiR/new/SpidermiR.Rcheck/00_pkg_src/SpidermiR/R/SpidermiRvisualize.R:143-145)
    Undefined global functions or variables:
      mRNA_target miRNAs
    ```

# StarBioTrek

Version: 1.2.1

## In both

*   checking installed package size ... NOTE
    ```
      installed size is 11.1Mb
      sub-directories of 1Mb or more:
        data   8.8Mb
        doc    2.0Mb
    ```

*   checking R code for possible problems ... NOTE
    ```
    ...
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/StarBioTrek/new/StarBioTrek.Rcheck/00_pkg_src/StarBioTrek/R/getdata.R:108)
    getKEGGdata: no visible binding for global variable ‘Nervous_system’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/StarBioTrek/new/StarBioTrek.Rcheck/00_pkg_src/StarBioTrek/R/getdata.R:113)
    getKEGGdata: no visible binding for global variable ‘Sensory_system’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/StarBioTrek/new/StarBioTrek.Rcheck/00_pkg_src/StarBioTrek/R/getdata.R:118)
    matrix_plot: no visible binding for global variable ‘path’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/StarBioTrek/new/StarBioTrek.Rcheck/00_pkg_src/StarBioTrek/R/path_star.R:132)
    plotting_cross_talk: no visible binding for global variable ‘path’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/StarBioTrek/new/StarBioTrek.Rcheck/00_pkg_src/StarBioTrek/R/path_star.R:179)
    svm_classification: no visible binding for global variable ‘Target’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/StarBioTrek/new/StarBioTrek.Rcheck/00_pkg_src/StarBioTrek/R/path_star.R:441)
    svm_classification: no visible binding for global variable ‘Target’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/StarBioTrek/new/StarBioTrek.Rcheck/00_pkg_src/StarBioTrek/R/path_star.R:444)
    Undefined global functions or variables:
      Aminoacid Carbohydrate Cell_growth_and_death Cellular_community
      Circulatory_system Cofa_vita_met Digestive_system Endocrine_system
      Energy Excretory_system Folding_sorting_and_degradation Glybio_met
      Immune_system Lipid Nervous_system Replication_and_repair
      Sensory_system Signal_transduction
      Signaling_molecules_and_interaction Target Transcription Translation
      Transport_and_catabolism path
    ```

# sweep

Version: 0.2.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘devtools’ ‘lazyeval’ ‘lubridate’ ‘tidyr’
      All declared Imports should be used.
    ```

# taxlist

Version: 0.1.2

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 126 marked UTF-8 strings
    ```

# TCGAbiolinks

Version: 2.5.9

## In both

*   checking examples ... ERROR
    ```
    ...
    |NA                          |NA                                  |NA                   |NA                           |
    |NA                          |NA                                  |NA                   |NA                           |
    |NA                          |NA                                  |NA                   |NA                           |
    |NA                          |NA                                  |NA                   |NA                           |
    |NA                          |NA                                  |NA                   |NA                           |
    |NA                          |NA                                  |NA                   |NA                           |
    |NA                          |NA                                  |NA                   |NA                           |
    |NA                          |NA                                  |NA                   |NA                           |
    |NA                          |NA                                  |NA                   |NA                           |
    |NA                          |NA                                  |NA                   |NA                           |
    |NA                          |NA                                  |NA                   |NA                           |
    |NA                          |NA                                  |NA                   |NA                           |
    |NA                          |NA                                  |NA                   |NA                           |
    |NA                          |NA                                  |NA                   |NA                           |
    |NA                          |NA                                  |NA                   |NA                           |
    |NA                          |NA                                  |NA                   |NA                           |
    |NA                          |NA                                  |NA                   |NA                           |
    Error in checkProjectInput(project) : 
      Please set a valid project argument from the column id above. Project TCGA-ACC was not found.
    Calls: GDCquery -> checkProjectInput
    Execution halted
    ```

*   R CMD check timed out
    

*   checking installed package size ... NOTE
    ```
      installed size is 61.8Mb
      sub-directories of 1Mb or more:
        R      1.9Mb
        data   2.3Mb
        doc   57.4Mb
    ```

*   checking R code for possible problems ... NOTE
    ```
    ...
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/TCGAbiolinks/new/TCGAbiolinks.Rcheck/00_pkg_src/TCGAbiolinks/R/analyze.R:1131)
    TCGAvisualize_SurvivalCoxNET: no visible global function definition for
      ‘dNetInduce’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/TCGAbiolinks/new/TCGAbiolinks.Rcheck/00_pkg_src/TCGAbiolinks/R/visualize.R:156-157)
    TCGAvisualize_SurvivalCoxNET: no visible global function definition for
      ‘dNetPipeline’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/TCGAbiolinks/new/TCGAbiolinks.Rcheck/00_pkg_src/TCGAbiolinks/R/visualize.R:161-162)
    TCGAvisualize_SurvivalCoxNET: no visible global function definition for
      ‘dCommSignif’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/TCGAbiolinks/new/TCGAbiolinks.Rcheck/00_pkg_src/TCGAbiolinks/R/visualize.R:174)
    TCGAvisualize_SurvivalCoxNET: no visible global function definition for
      ‘visNet’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/TCGAbiolinks/new/TCGAbiolinks.Rcheck/00_pkg_src/TCGAbiolinks/R/visualize.R:184-189)
    TCGAvisualize_oncoprint: no visible binding for global variable ‘value’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/TCGAbiolinks/new/TCGAbiolinks.Rcheck/00_pkg_src/TCGAbiolinks/R/visualize.R:933)
    getTSS: no visible global function definition for ‘promoters’
      (/Users/jhester/Dropbox/projects/devtools/revdep/checks/TCGAbiolinks/new/TCGAbiolinks.Rcheck/00_pkg_src/TCGAbiolinks/R/methylation.R:1745-1746)
    Undefined global functions or variables:
      c3net dCommSignif dNetInduce dNetPipeline knnmi.cross
      limmacontrasts.fit limmamakeContrasts minet portions promoters value
      visNet
    ```

# TCGAbiolinksGUI

Version: 1.2.1

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    ...
    
    The following objects are masked from 'package:S4Vectors':
    
        first, intersect, rename, setdiff, setequal, union
    
    The following objects are masked from 'package:BiocGenerics':
    
        combine, intersect, setdiff, union
    
    The following objects are masked from 'package:stats':
    
        filter, lag
    
    The following objects are masked from 'package:base':
    
        intersect, setdiff, setequal, union
    
    Quitting from lines 11-15 (data.Rmd) 
    Error: processing vignette 'data.Rmd' failed with diagnostics:
    there is no package called 'DT'
    Execution halted
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 30.3Mb
      sub-directories of 1Mb or more:
        app   1.0Mb
        doc  28.9Mb
    ```

*   checking DESCRIPTION meta-information ... NOTE
    ```
    Malformed Description field: should contain one or more complete sentences.
    ```

*   checking for unstated dependencies in vignettes ... NOTE
    ```
    'library' or 'require' calls not declared from:
      ‘DT’ ‘dplyr’
    ```

# teachingApps

Version: 1.0.2

## Newly broken

*   checking whether package ‘teachingApps’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/jhester/Dropbox/projects/devtools/revdep/checks/teachingApps/new/teachingApps.Rcheck/00install.out’ for details.
    ```

## Newly fixed

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘data.table’ ‘datasets’ ‘stats’
      All declared Imports should be used.
    ```

## Installation

### Devel

```
* installing *source* package ‘teachingApps’ ...
** package ‘teachingApps’ successfully unpacked and MD5 sums checked
** libs
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/devtools/new/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/devtools/new/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c bisa.cpp -o bisa.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/devtools/new/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c lev.cpp -o lev.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/devtools/new/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c likely.cpp -o likely.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/devtools/new/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c rcpp_hello_world.cpp -o rcpp_hello_world.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/devtools/new/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c sev.cpp -o sev.o
clang++ -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/usr/local/lib -o teachingApps.so RcppExports.o bisa.o lev.o likely.o rcpp_hello_world.o sev.o -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
installing to /Users/jhester/Dropbox/projects/devtools/revdep/checks/teachingApps/new/teachingApps.Rcheck/teachingApps/libs
** R
** inst
** preparing package for lazy loading
Error : object ‘inst’ is not exported by 'namespace:devtools'
ERROR: lazy loading failed for package ‘teachingApps’
* removing ‘/Users/jhester/Dropbox/projects/devtools/revdep/checks/teachingApps/new/teachingApps.Rcheck/teachingApps’

```
### CRAN

```
* installing *source* package ‘teachingApps’ ...
** package ‘teachingApps’ successfully unpacked and MD5 sums checked
** libs
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/teachingApps/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/teachingApps/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c bisa.cpp -o bisa.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/teachingApps/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c lev.cpp -o lev.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/teachingApps/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c likely.cpp -o likely.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/teachingApps/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c rcpp_hello_world.cpp -o rcpp_hello_world.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/jhester/Dropbox/projects/devtools/revdep/library/teachingApps/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c sev.cpp -o sev.o
clang++ -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/usr/local/lib -o teachingApps.so RcppExports.o bisa.o lev.o likely.o rcpp_hello_world.o sev.o -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
installing to /Users/jhester/Dropbox/projects/devtools/revdep/checks/teachingApps/old/teachingApps.Rcheck/teachingApps/libs
** R
** inst
** preparing package for lazy loading
** help
*** installing help indices
** building package indices
** testing if installed package can be loaded
* DONE (teachingApps)

```
# TeXCheckR

Version: 0.4.1

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      	or is a single closing brace, or a blank line. If you can, run
      	lint_bib('./validate-bib/field-broken-over2lines.bib')
                                  bib_file line_no       key    value  authors
      1: validate-bib/near-dup-authors.bib       8 VicRoadsr VicRoads VicRoads
      
      Same author used with inconsistent upper/lowercase.
      ✖ 28: 
      Ensure the entries above are used with consistent case so ibid/idem's are respected.
      testthat results ================================================================
      OK: 203 SKIPPED: 1 FAILED: 2
      1. Error: No misspelled words (@test-zzz-check-pkgs-spelling.R#19) 
      2. Failure: Couldn't find an entry for (@test_check_biber.R#10) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# texmex

Version: 2.3

## In both

*   R CMD check timed out
    

# tidyquant

Version: 0.5.3

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
             while (!is_null(x)) {
                 quo_splice(node_car(x), x, warn = warn)
                 x <- node_cdr(x)
             }
         }) at /private/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T/Rtmpd4pGKb/remotes96f8300192cd/tidyverse-rlang-cbdc3f3/R/quo.R:464
      9: expr_type_of(.x) at /private/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T/Rtmpd4pGKb/remotes96f8300192cd/tidyverse-rlang-cbdc3f3/R/expr.R:355
      10: duplicate(quo) at /private/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T/Rtmpd4pGKb/remotes96f8300192cd/tidyverse-rlang-cbdc3f3/R/quo.R:445
      
      testthat results ================================================================
      OK: 174 SKIPPED: 0 FAILED: 2
      1. Error: Test error on invalid data inputs. (@test_tq_mutate.R#142) 
      2. Error: Test error on invalid data inputs. (@test_tq_transmute.R#121) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘broom’ ‘curl’ ‘devtools’ ‘rvest’ ‘timeSeries’ ‘tseries’ ‘zoo’
      All declared Imports should be used.
    ```

# timetk

Version: 0.1.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘devtools’ ‘forecast’
      All declared Imports should be used.
    ```

# toxplot

Version: 0.1.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘tidyr’
      All declared Imports should be used.
    ```

# uavRmp

Version: 0.5.1

## In both

*   checking examples ... ERROR
    ```
    ...
    > 
    > ## (2) make position flight plan
    > makeTP  <-  makeTP(missionTrackList= tutorial_flightArea,
    +                    demFn = dsmFn,
    +                    uavType = "solo",
    +                    followSurfaceRes=5,
    +                    launchPos = c(8.679,50.856))
    preprocessing DSM data...
    Warning in gdal_setInstallation(ignore.full_scan = ignore.full_scan, verbose = verbose) :
      No GDAL installation found. Please install 'gdal' before continuing:
    	- www.gdal.org (no HDF4 support!)
    	- www.trac.osgeo.org/osgeo4w/ (with HDF4 support RECOMMENDED)
    	- www.fwtools.maptools.org (with HDF4 support)
    
    Warning in gdal_setInstallation(ignore.full_scan = ignore.full_scan, verbose = verbose) :
      If you think GDAL is installed, please run:
    gdal_setInstallation(ignore.full_scan=FALSE)
    Error in (function (classes, fdef, mtable)  : 
      unable to find an inherited method for function ‘crop’ for signature ‘"NULL"’
    Calls: makeTP -> makeFlightPathT3 -> <Anonymous> -> <Anonymous>
    Execution halted
    ```

# umx

Version: 1.7.5

## Newly broken

*   checking dependencies in R code ... NOTE
    ```
    Missing or unexported object: ‘devtools::build_win’
    ```

## In both

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘sem’
    ```

# unitizer

Version: 1.4.4

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/runtt.R’ failed.
    Last 13 lines of output:
      1. Error: (unknown) (@testthat.browse.R#5) 
      2. Error: (unknown) (@testthat.demo.R#4) 
      3. Failure: Show Test Error (@testthat.error.R#28) 
      4. Error: (unknown) (@testthat.exec.R#11) 
      5. Error: (unknown) (@testthat.inpkg.R#11) 
      6. Error: (unknown) (@testthat.item.R#4) 
      7. Error: (unknown) (@testthat.parse.R#5) 
      8. Failure: simple tests (@testthat.section.R#13) 
      9. Error: (unknown) (@testthat.section.R#5) 
      1. ...
      
      Error: testthat unit tests failed
      Removing packages from '/Users/jhester/Dropbox/projects/devtools/revdep/checks/unitizer/new/unitizer.Rcheck'
      (as 'lib' is unspecified)
      Execution halted
    ```

# unvotes

Version: 0.2.0

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 4494 marked UTF-8 strings
    ```

# vaersvax

Version: 1.0.4

## In both

*   checking package dependencies ... NOTE
    ```
    Packages suggested but not available for checking: ‘vaers’ ‘vaersND’
    ```

# veccompare

Version: 0.1.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘pander’
      All declared Imports should be used.
    ```

# vegtable

Version: 0.1.0

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 124 marked UTF-8 strings
    ```

# wallace

Version: 0.6.4

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘DT’ ‘ENMeval’ ‘RColorBrewer’ ‘devtools’ ‘dismo’ ‘dplyr’ ‘maptools’
      ‘raster’ ‘rgdal’ ‘rgeos’ ‘rmarkdown’ ‘shinyBS’ ‘shinyjs’
      ‘shinythemes’ ‘spThin’ ‘spocc’
      All declared Imports should be used.
    ```

# Wats

Version: 0.10.3

## In both

*   checking installed package size ... NOTE
    ```
      installed size is 12.3Mb
      sub-directories of 1Mb or more:
        doc  12.1Mb
    ```

# wru

Version: 0.1-7

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.8Mb
      sub-directories of 1Mb or more:
        data   5.6Mb
    ```

