# abjutils

Version: 0.0.1

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
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

*   R CMD check timed out
    

*   checking R code for possible problems ... NOTE
    ```
    plot_coannotations: no visible binding for global variable ‘.’
      (.../revdep/checks/annotatr/new/annotatr.Rcheck/00_pkg_src/annotatr/R/visualize.R:176-178)
    plot_numerical_coannotations: no visible binding for global variable
      ‘.’
      (.../revdep/checks/annotatr/new/annotatr.Rcheck/00_pkg_src/annotatr/R/visualize.R:412-429)
    plot_numerical_coannotations: no visible binding for global variable
      ‘.’
      (.../revdep/checks/annotatr/new/annotatr.Rcheck/00_pkg_src/annotatr/R/visualize.R:415-420)
    plot_numerical_coannotations: no visible binding for global variable
      ‘.’
      (.../revdep/checks/annotatr/new/annotatr.Rcheck/00_pkg_src/annotatr/R/visualize.R:422-427)
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

# assertive.matrices

Version: 0.0-1

## In both

*   checking dependencies in R code ... NOTE
    ```
    ':::' call which should be '::': ‘assertive.base:::print_and_capture’
      See the note in ?`:::` about the use of this operator.
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
      (.../revdep/checks/BiocCheck/new/BiocCheck.Rcheck/00_pkg_src/BiocCheck/R/checks.R:33-35)
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

Version: 0.2.2

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

*   R CMD check timed out
    

# chipenrich.data

Version: 2.0.0

## Newly broken

*   R CMD check timed out
    

## In both

*   checking installed package size ... NOTE
    ```
      installed size is 147.8Mb
      sub-directories of 1Mb or more:
        data  147.0Mb
    ```

# cogena

Version: 1.10.0

## In both

*   R CMD check timed out
    

*   checking whether package ‘cogena’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: replacing previous import ‘class::somgrid’ by ‘kohonen::somgrid’ when loading ‘cogena’
    See ‘.../revdep/checks/cogena/new/cogena.Rcheck/00install.out’ for details.
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  6.4Mb
      sub-directories of 1Mb or more:
        doc       1.9Mb
        extdata   3.1Mb
    ```

*   checking R code for possible problems ... NOTE
    ```
    ...
      ‘legend’
      (.../revdep/checks/cogena/new/cogena.Rcheck/00_pkg_src/cogena/R/heatmapCluster.R:151-153)
    heatmapCluster,cogena: no visible global function definition for
      ‘legend’
      (.../revdep/checks/cogena/new/cogena.Rcheck/00_pkg_src/cogena/R/heatmapCluster.R:155-157)
    heatmapCluster,cogena: no visible global function definition for
      ‘legend’
      (.../revdep/checks/cogena/new/cogena.Rcheck/00_pkg_src/cogena/R/heatmapCluster.R:159-160)
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
    See ‘.../revdep/checks/COMPASS/new/COMPASS.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘COMPASS’ ...
** libs
clang -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c COMPASS_init.c -o COMPASS_init.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c CellCounts.cpp -o CellCounts.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c CellCounts_character.cpp -o CellCounts_character.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c digamma.c -o digamma.o
clang -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c mat2vec.c -o mat2vec.o
clang -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c melt_dataframe.c -o melt_dataframe.o
clang -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c melt_matrix.c -o melt_matrix.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c samplePuPs.cpp -o samplePuPs.o
clang -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c transpose_list.c -o transpose_list.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c updatealphas_Exp.cpp -o updatealphas_Exp.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c updatealphau.cpp -o updatealphau.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c updatealphau_noPu_Exp.cpp -o updatealphau_noPu_Exp.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c updatebeta_RW.cpp -o updatebeta_RW.o
CellCounts.cpp:40:35: error: no matching function for call to 'sapply'
      IntegerVector c_combo_abs = sapply(c_combo, ::abs);
                                  ^~~~~~
.../revdep/library/COMPASS/Rcpp/include/Rcpp/sugar/functions/sapply.h:126:1: note: candidate template ignored: couldn't infer template argument 'Function'
sapply( const Rcpp::VectorBase<RTYPE,NA,T>& t, Function fun ){
^
.../revdep/library/COMPASS/Rcpp/include/Rcpp/vector/ListOf.h:134:3: note: candidate template ignored: could not match 'ListOf' against 'Vector'
T sapply(const ListOf<T>& t, Function fun) {
  ^
1 error generated.
make: *** [CellCounts.o] Error 1
make: *** Waiting for unfinished jobs....
ERROR: compilation failed for package ‘COMPASS’
* removing ‘.../revdep/checks/COMPASS/new/COMPASS.Rcheck/COMPASS’

```
### CRAN

```
* installing *source* package ‘COMPASS’ ...
** libs
clang -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c COMPASS_init.c -o COMPASS_init.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c CellCounts.cpp -o CellCounts.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c CellCounts_character.cpp -o CellCounts_character.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c digamma.c -o digamma.o
clang -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c mat2vec.c -o mat2vec.o
clang -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c melt_dataframe.c -o melt_dataframe.o
clang -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c melt_matrix.c -o melt_matrix.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c samplePuPs.cpp -o samplePuPs.o
clang -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c transpose_list.c -o transpose_list.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c updatealphas_Exp.cpp -o updatealphas_Exp.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c updatealphau.cpp -o updatealphau.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c updatealphau_noPu_Exp.cpp -o updatealphau_noPu_Exp.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c updatebeta_RW.cpp -o updatebeta_RW.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c updategammak_noPu.cpp -o updategammak_noPu.o
clang -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/COMPASS/Rcpp/include" -I/usr/local/include   -fPIC  -Wall -g -O2  -c utils.c -o utils.o
CellCounts.cpp:40:35: error: no matching function for call to 'sapply'
      IntegerVector c_combo_abs = sapply(c_combo, ::abs);
                                  ^~~~~~
.../revdep/library/COMPASS/Rcpp/include/Rcpp/sugar/functions/sapply.h:126:1: note: candidate template ignored: couldn't infer template argument 'Function'
sapply( const Rcpp::VectorBase<RTYPE,NA,T>& t, Function fun ){
^
.../revdep/library/COMPASS/Rcpp/include/Rcpp/vector/ListOf.h:134:3: note: candidate template ignored: could not match 'ListOf' against 'Vector'
T sapply(const ListOf<T>& t, Function fun) {
  ^
1 error generated.
make: *** [CellCounts.o] Error 1
make: *** Waiting for unfinished jobs....
ERROR: compilation failed for package ‘COMPASS’
* removing ‘.../revdep/checks/COMPASS/old/COMPASS.Rcheck/COMPASS’

```
# congressbr

Version: 0.1.1

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
    See ‘.../revdep/checks/CountClust/new/CountClust.Rcheck/00install.out’ for details.
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
* removing ‘.../revdep/checks/CountClust/new/CountClust.Rcheck/CountClust’

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
* removing ‘.../revdep/checks/CountClust/old/CountClust.Rcheck/CountClust’

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
      (.../revdep/checks/curatedMetagenomicData/new/curatedMetagenomicData.Rcheck/00_pkg_src/curatedMetagenomicData/R/ExpressionSet2MRexperiment.R:45)
    ExpressionSet2MRexperiment: no visible global function definition for
      ‘phenoData’
      (.../revdep/checks/curatedMetagenomicData/new/curatedMetagenomicData.Rcheck/00_pkg_src/curatedMetagenomicData/R/ExpressionSet2MRexperiment.R:46-47)
    curatedMetagenomicData : <anonymous>: no visible global function
      definition for ‘exprs<-’
      (.../revdep/checks/curatedMetagenomicData/new/curatedMetagenomicData.Rcheck/00_pkg_src/curatedMetagenomicData/R/curatedMetagenomicData.R:57-58)
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

*   R CMD check timed out
    

## Newly fixed

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Error: processing vignette 'DEBrowser.Rmd' failed with diagnostics:
    there is no package called ‘BiocStyle’
    Execution halted
    ```

## In both

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
      (.../revdep/checks/debrowser/new/debrowser.Rcheck/00_pkg_src/debrowser/R/volcano.R:19-30)
    volcanoPlot: no visible binding for global variable ‘fill.brush’
      (.../revdep/checks/debrowser/new/debrowser.Rcheck/00_pkg_src/debrowser/R/volcano.R:19-30)
    volcanoPlot: no visible binding for global variable ‘opacity’
      (.../revdep/checks/debrowser/new/debrowser.Rcheck/00_pkg_src/debrowser/R/volcano.R:19-30)
    volcanoPlot: no visible binding for global variable ‘key’
      (.../revdep/checks/debrowser/new/debrowser.Rcheck/00_pkg_src/debrowser/R/volcano.R:19-30)
    volcanoZoom: no visible global function definition for ‘:=’
      (.../revdep/checks/debrowser/new/debrowser.Rcheck/00_pkg_src/debrowser/R/volcano.R:51-61)
    volcanoZoom: no visible binding for global variable ‘size’
      (.../revdep/checks/debrowser/new/debrowser.Rcheck/00_pkg_src/debrowser/R/volcano.R:51-61)
    volcanoZoom: no visible binding for global variable ‘size.hover’
      (.../revdep/checks/debrowser/new/debrowser.Rcheck/00_pkg_src/debrowser/R/volcano.R:51-61)
    volcanoZoom: no visible binding for global variable ‘key’
      (.../revdep/checks/debrowser/new/debrowser.Rcheck/00_pkg_src/debrowser/R/volcano.R:51-61)
    Undefined global functions or variables:
      .startdebrowser.called := NUL align baseline biocLite conds debrowser
      demodata fill fill.brush fillOpacity fillOpacity.hover fit fontSize
      get_user_info googleAuth googleAuthUI initStore key opacity samples
      searched size size.hover stroke updateStore with_shiny
    ```

# demi

Version: 1.1.2

## In both

*   checking R code for possible problems ... NOTE
    ```
    ...
    diffexp,DEMIDiff: no visible global function definition for ‘p.adjust’
      (.../revdep/checks/demi/new/demi.Rcheck/00_pkg_src/demi/R/DEMIDiff-methods.R:352)
    loadAnnotation,DEMIExperiment-environment: no visible global function
      definition for ‘data’
      (.../revdep/checks/demi/new/demi.Rcheck/00_pkg_src/demi/R/DEMIExperiment-methods.R:549)
    loadBlat,DEMIExperiment-environment: no visible global function
      definition for ‘data’
      (.../revdep/checks/demi/new/demi.Rcheck/00_pkg_src/demi/R/DEMIExperiment-methods.R:598)
    loadCytoband,DEMIExperiment-environment: no visible global function
      definition for ‘data’
      (.../revdep/checks/demi/new/demi.Rcheck/00_pkg_src/demi/R/DEMIExperiment-methods.R:700)
    loadPathway,DEMIExperiment-environment: no visible global function
      definition for ‘data’
      (.../revdep/checks/demi/new/demi.Rcheck/00_pkg_src/demi/R/DEMIExperiment-methods.R:735)
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
      .../revdep/checks/document/new/document.Rcheck
      .../revdep/library/devtools/new
      .../revdep/library/document
      /Library/Frameworks/R.framework/Versions/3.4/Resources/library
      Sys.info:
      Jamess-MacBook-Pro-2.local
      Darwin Kernel Version 16.7.0: Thu Jun 15 17:36:27 PDT 2017; root:xnu-3789.70.16~2/RELEASE_X86_64
      Path: /var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T//RtmpgTYkas/document_922d1ae4d77e/mini.mal
      ###
      Error in check_package(package_directory = package_directory, working_directory = working_directory,  : 
        R CMD check failed, read the above log and fix.
      Calls: test_check ... source_file -> eval -> eval -> document -> check_package -> throw
      testthat results ================================================================
      OK: 0 SKIPPED: 0 FAILED: 0
      Execution halted
    ```

# dodgr

Version: 0.0.3

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Loading dodgr
    Quitting from lines 117-144 (benchmark.Rmd) 
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

Version: 1.3.3

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
        Results   2.3Mb
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
      (.../revdep/checks/epiNEM/new/epiNEM.Rcheck/00_pkg_src/epiNEM/R/plot_results.R:375-377)
    plot.epiSim: no visible global function definition for ‘boxplot’
      (.../revdep/checks/epiNEM/new/epiNEM.Rcheck/00_pkg_src/epiNEM/R/plot_results.R:403-405)
    plot.epiSim: no visible global function definition for ‘abline’
      (.../revdep/checks/epiNEM/new/epiNEM.Rcheck/00_pkg_src/epiNEM/R/plot_results.R:407)
    plot.epiSim: no visible global function definition for ‘axis’
      (.../revdep/checks/epiNEM/new/epiNEM.Rcheck/00_pkg_src/epiNEM/R/plot_results.R:409-411)
    plot.epiSim: no visible global function definition for ‘boxplot’
      (.../revdep/checks/epiNEM/new/epiNEM.Rcheck/00_pkg_src/epiNEM/R/plot_results.R:413-415)
    plot.epiSim: no visible global function definition for ‘abline’
      (.../revdep/checks/epiNEM/new/epiNEM.Rcheck/00_pkg_src/epiNEM/R/plot_results.R:417)
    plot.epiSim: no visible global function definition for ‘axis’
      (.../revdep/checks/epiNEM/new/epiNEM.Rcheck/00_pkg_src/epiNEM/R/plot_results.R:419-421)
    Undefined global functions or variables:
      abline absorption adj axis bnem boxplot computeFc dnf2adj
      dummyCNOlist epiNEM2Bg layout popSize preprocessing readSIF sim
      simulateStatesRecursive
    Consider adding
      importFrom("graphics", "abline", "axis", "boxplot", "layout")
    to your NAMESPACE file.
    ```

# ggExtra

Version: 0.7

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘grDevices’
      All declared Imports should be used.
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
             message = handle_message))
      4: withCallingHandlers(withVisible(code), warning = handle_warning, message = handle_message)
      5: withVisible(code)
      6: rmarkdown::render("table-tester-2.Rmd", quiet = TRUE, output_format = "pdf_document")
      7: convert(output_file, run_citeproc)
      8: pandoc_convert(utf8_input, pandoc_to, output_format$pandoc$from, output, citeproc, 
             output_format$pandoc$args, !quiet)
      9: stop("pandoc document conversion failed with error ", result, call. = FALSE)
      
      testthat results ================================================================
      OK: 290 SKIPPED: 48 FAILED: 1
      1. Error: table-tester-2.Rmd renders without errors in LaTeX (@test-with-pandoc.R#27) 
      
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

# icd9

Version: 1.3.1

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
      (.../revdep/checks/IHW/new/IHW.Rcheck/00_pkg_src/IHW/R/plots.R:101)
    plot_decisionboundary: no visible binding for global variable
      ‘covariate’
      (.../revdep/checks/IHW/new/IHW.Rcheck/00_pkg_src/IHW/R/plots.R:110-112)
    plot_decisionboundary: no visible binding for global variable ‘pvalue’
      (.../revdep/checks/IHW/new/IHW.Rcheck/00_pkg_src/IHW/R/plots.R:110-112)
    plot_decisionboundary: no visible binding for global variable ‘fold’
      (.../revdep/checks/IHW/new/IHW.Rcheck/00_pkg_src/IHW/R/plots.R:110-112)
    thresholds_ihwResult: no visible global function definition for
      ‘na.exclude’
      (.../revdep/checks/IHW/new/IHW.Rcheck/00_pkg_src/IHW/R/ihw_class.R:96-97)
    thresholds,ihwResult: no visible global function definition for
      ‘na.exclude’
      (.../revdep/checks/IHW/new/IHW.Rcheck/00_pkg_src/IHW/R/ihw_class.R:96-97)
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
      	 >> 2 records have been read successfully!
      
      testthat results ================================================================
      OK: 488 SKIPPED: 0 FAILED: 1
      1. Failure: Full check of analyse_baSAR function (@test_analyse_baSAR.R#48) 
      
      Error: testthat unit tests failed
      In addition: Warning messages:
      1: closing unused connection 8 (/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T//RtmprDjKyh/read_BIN2R_FILEa9bd5d84fabe) 
      2: closing unused connection 7 (/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T//RtmprDjKyh/read_BIN2R_FILEa9bd1dce7583) 
      3: closing unused connection 6 (/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T//RtmprDjKyh/read_BIN2R_FILEa9bd6824283f) 
      4: closing unused connection 5 (/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T//RtmprDjKyh/read_BIN2R_FILEa9bd6634200c) 
      5: closing unused connection 4 (/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T//RtmprDjKyh/read_BIN2R_FILEa9bd6c0f57a) 
      6: closing unused connection 3 (/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T//RtmprDjKyh/read_BIN2R_FILEa9bd6718b3bf) 
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
      (.../revdep/checks/metafolio/new/metafolio.Rcheck/00_pkg_src/metafolio/R/plot_sp_A_ts.R:90-91)
    run_cons_plans: no visible binding for global variable ‘var’
    thermal_area: no visible global function definition for ‘uniroot’
      (.../revdep/checks/metafolio/new/metafolio.Rcheck/00_pkg_src/metafolio/R/thermal_integration.R:19-21)
    thermal_area: no visible global function definition for ‘uniroot’
      (.../revdep/checks/metafolio/new/metafolio.Rcheck/00_pkg_src/metafolio/R/thermal_integration.R:22-24)
    thermal_area: no visible global function definition for ‘integrate’
      (.../revdep/checks/metafolio/new/metafolio.Rcheck/00_pkg_src/metafolio/R/thermal_integration.R:26-28)
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
                                               ~^~
      tests/testthat/testS4import/R/all.r:1:29: style: Put spaces around all infix operators.
      setClass('derived', contains='class_to_export')
                                 ~^~
      tests/testthat/testVignettesBuilt/R/code.r:1:1: style: Variable and function names should not be longer than 20 characters.
      function_with_unusual_name <- function() {
      ^~~~~~~~~~~~~~~~~~~~~~~~~~
      
      
      testthat results ================================================================
      OK: 72 SKIPPED: 0 FAILED: 1
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

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      1: In .Internal(gc(verbose, reset)) :
        Connection is garbage-collected, use dbDisconnect() to avoid this.
      2: In .Internal(gc(verbose, reset)) :
        Connection is garbage-collected, use dbDisconnect() to avoid this.
      3: In .Internal(gc(verbose, reset)) :
        Connection is garbage-collected, use dbDisconnect() to avoid this.
      4: In .Internal(gc(verbose, reset)) :
        Connection is garbage-collected, use dbDisconnect() to avoid this.
      5: In .Internal(gc(verbose, reset)) :
        Connection is garbage-collected, use dbDisconnect() to avoid this.
      6: Connection is garbage-collected, use dbDisconnect() to avoid this. 
      7: Connection is garbage-collected, use dbDisconnect() to avoid this. 
      8: In .Internal(gc(verbose, reset)) :
        Connection is garbage-collected, use dbDisconnect() to avoid this.
      Execution halted
    ```

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
    Updating the PO-Revision-Date to ‘2017-11-08 12:38:02-0500’.
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
    Updating the PO-Revision-Date to ‘2017-11-08 12:38:03-0500’.
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

# NetworkToolbox

Version: 0.0.1.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘devtools’ ‘qdap’
      All declared Imports should be used.
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

*   R CMD check timed out
    

*   checking Rd cross-references ... WARNING
    ```
    Unknown package ‘RcppOctave’ in Rd xrefs
    ```

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
      (.../revdep/checks/NMF/new/NMF.Rcheck/00_pkg_src/NMF/R/nmf.R:1584)
    nmf,matrix-numeric-NMFStrategy : run.all: no visible binding for global
      variable ‘n’
      (.../revdep/checks/NMF/new/NMF.Rcheck/00_pkg_src/NMF/R/nmf.R:1590-1592)
    nmf,matrix-numeric-NMFStrategy : run.all: no visible binding for global
      variable ‘n’
      (.../revdep/checks/NMF/new/NMF.Rcheck/00_pkg_src/NMF/R/nmf.R:1597-1599)
    nmf,matrix-numeric-NMFStrategy : run.all: no visible binding for global
      variable ‘n’
      (.../revdep/checks/NMF/new/NMF.Rcheck/00_pkg_src/NMF/R/nmf.R:1618-1621)
    nmf,matrix-numeric-NMFStrategy : run.all: no visible binding for global
      variable ‘n’
      (.../revdep/checks/NMF/new/NMF.Rcheck/00_pkg_src/NMF/R/nmf.R:1653)
    nmf,matrix-numeric-NMFStrategy : run.all: no visible binding for global
      variable ‘n’
      (.../revdep/checks/NMF/new/NMF.Rcheck/00_pkg_src/NMF/R/nmf.R:1666-1676)
    rss,matrix: no visible binding for global variable ‘Biobase’
      (.../revdep/checks/NMF/new/NMF.Rcheck/00_pkg_src/NMF/R/NMF-class.R:2263-2264)
    Undefined global functions or variables:
      Biobase RNGobj fstop n
    ```

# npsm

Version: 0.5

## In both

*   checking R code for possible problems ... NOTE
    ```
    ...
    onecovahomog: no visible global function definition for ‘pf’
      (.../revdep/checks/npsm/new/npsm.Rcheck/00_pkg_src/npsm/R/racov.r:53)
    rank.test: no visible global function definition for ‘pnorm’
      (.../revdep/checks/npsm/new/npsm.Rcheck/00_pkg_src/npsm/R/rank.test.r:12-16)
    rank.test: no visible global function definition for ‘coef’
      (.../revdep/checks/npsm/new/npsm.Rcheck/00_pkg_src/npsm/R/rank.test.r:21)
    rank.test: no visible global function definition for ‘qt’
      (.../revdep/checks/npsm/new/npsm.Rcheck/00_pkg_src/npsm/R/rank.test.r:24-28)
    rcn: no visible global function definition for ‘rnorm’
    vanElteren.test: no visible global function definition for ‘pnorm’
      (.../revdep/checks/npsm/new/npsm.Rcheck/00_pkg_src/npsm/R/vanElteren.test.r:23)
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

Version: 2.8.3

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘Rmpi’
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 17.0Mb
      sub-directories of 1Mb or more:
        R        6.1Mb
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
      OK: 47 SKIPPED: 1 FAILED: 11
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
      (.../revdep/checks/pkgmaker/new/pkgmaker.Rcheck/00_pkg_src/pkgmaker/R/unitTests.R:792)
    utest,character: no visible global function definition for ‘test_file’
      (.../revdep/checks/pkgmaker/new/pkgmaker.Rcheck/00_pkg_src/pkgmaker/R/unitTests.R:797)
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
    See ‘.../revdep/checks/pulver/new/pulver.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘pulver’ ...
** package ‘pulver’ successfully unpacked and MD5 sums checked
** libs
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/pulver/Rcpp/include" -I/usr/local/include  -fopenmp -fPIC  -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/pulver/Rcpp/include" -I/usr/local/include  -fopenmp -fPIC  -Wall -g -O2  -c partial_result.cpp -o partial_result.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/pulver/Rcpp/include" -I/usr/local/include  -fopenmp -fPIC  -Wall -g -O2  -c pulver.cpp -o pulver.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/pulver/Rcpp/include" -I/usr/local/include  -fopenmp -fPIC  -Wall -g -O2  -c result.cpp -o result.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/pulver/Rcpp/include" -I/usr/local/include  -fopenmp -fPIC  -Wall -g -O2  -c storage.cpp -o storage.o
clang: error: unsupported option '-fopenmp'
clang: error: unsupported option '-fopenmp'
clang: error: unsupported option '-fopenmp'
clang: error: unsupported option '-fopenmp'
make: *** [RcppExports.o] Error 1
make: *** Waiting for unfinished jobs....
make: *** [pulver.o] Error 1
make: *** [partial_result.o] Error 1
make: *** [result.o] Error 1
clang: error: unsupported option '-fopenmp'
make: *** [storage.o] Error 1
ERROR: compilation failed for package ‘pulver’
* removing ‘.../revdep/checks/pulver/new/pulver.Rcheck/pulver’

```
### CRAN

```
* installing *source* package ‘pulver’ ...
** package ‘pulver’ successfully unpacked and MD5 sums checked
** libs
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/pulver/Rcpp/include" -I/usr/local/include  -fopenmp -fPIC  -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/pulver/Rcpp/include" -I/usr/local/include  -fopenmp -fPIC  -Wall -g -O2  -c partial_result.cpp -o partial_result.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/pulver/Rcpp/include" -I/usr/local/include  -fopenmp -fPIC  -Wall -g -O2  -c pulver.cpp -o pulver.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/pulver/Rcpp/include" -I/usr/local/include  -fopenmp -fPIC  -Wall -g -O2  -c result.cpp -o result.o
clang++  -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I".../revdep/library/pulver/Rcpp/include" -I/usr/local/include  -fopenmp -fPIC  -Wall -g -O2  -c storage.cpp -o storage.o
clang: clangclang: : errorerror: : clangerrorclangunsupported option '-fopenmp'
: : : unsupported option '-fopenmp'unsupported option '-fopenmp'
error: error: 
unsupported option '-fopenmp'
unsupported option '-fopenmp'
make: *** [storage.o] Error 1
make: *** Waiting for unfinished jobs....
make: *** [result.o] Error 1
make: *** [pulver.o] Error 1
make: *** [partial_result.o] Error 1
make: *** [RcppExports.o] Error 1
ERROR: compilation failed for package ‘pulver’
* removing ‘.../revdep/checks/pulver/old/pulver.Rcheck/pulver’

```
# rbundler

Version: 0.3.7

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
      (.../revdep/checks/rbundler/new/rbundler.Rcheck/00_pkg_src/rbundler/R/install_version.r:25)
    install_version: no visible global function definition for
      ‘available.packages’
      (.../revdep/checks/rbundler/new/rbundler.Rcheck/00_pkg_src/rbundler/R/install_version.r:26)
    install_version: no visible global function definition for
      ‘install_url’
      (.../revdep/checks/rbundler/new/rbundler.Rcheck/00_pkg_src/rbundler/R/install_version.r:37)
    load_available_packages: no visible global function definition for
      ‘contrib.url’
      (.../revdep/checks/rbundler/new/rbundler.Rcheck/00_pkg_src/rbundler/R/load_available_packages.r:5)
    validate_installed_package: no visible global function definition for
      ‘installed.packages’
      (.../revdep/checks/rbundler/new/rbundler.Rcheck/00_pkg_src/rbundler/R/install_version.r:55)
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
      (.../revdep/checks/recount/new/recount.Rcheck/00_pkg_src/recount/R/add_predictions.R:80)
    add_predictions: no visible binding for global variable
      ‘PredictedPhenotypes’
      (.../revdep/checks/recount/new/recount.Rcheck/00_pkg_src/recount/R/add_predictions.R:82)
    add_predictions: no visible binding for global variable
      ‘PredictedPhenotypes’
      (.../revdep/checks/recount/new/recount.Rcheck/00_pkg_src/recount/R/add_predictions.R:84-85)
    Undefined global functions or variables:
      PredictedPhenotypes
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 347 marked UTF-8 strings
    ```

# REDCapR

Version: 0.9.8

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/test-all.R’ failed.
    Last 13 lines of output:
      
      3. Error: Write Batch -Update Two Fields (@test-write-batch.R#138) -------------
      wrong sign in 'by' argument
      1: REDCapR::redcap_write(ds = returned_object1$data, redcap_uri = project$redcap_uri, 
             token = project$token) at testthat/test-write-batch.R:138
      2: REDCapR::create_batch_glossary(row_count = base::nrow(ds_to_write), batch_size = batch_size) at .../revdep/checks/REDCapR/new/REDCapR.Rcheck/00_pkg_src/REDCapR/R/redcap-write.R:95
      
      testthat results ================================================================
      OK: 574 SKIPPED: 0 FAILED: 3
      1. Failure: Write Batch -Update One Field (@test-write-batch.R#112) 
      2. Failure: Write Batch -Update Two Fields (@test-write-batch.R#127) 
      3. Error: Write Batch -Update Two Fields (@test-write-batch.R#138) 
      
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

*   R CMD check timed out
    

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
      (.../revdep/checks/RTCGA/new/RTCGA.Rcheck/00_pkg_src/RTCGA/R/ggbiplot.R:157-161)
    ggbiplot: no visible binding for global variable ‘xvar’
      (.../revdep/checks/RTCGA/new/RTCGA.Rcheck/00_pkg_src/RTCGA/R/ggbiplot.R:157-161)
    ggbiplot: no visible binding for global variable ‘yvar’
      (.../revdep/checks/RTCGA/new/RTCGA.Rcheck/00_pkg_src/RTCGA/R/ggbiplot.R:157-161)
    ggbiplot: no visible binding for global variable ‘angle’
      (.../revdep/checks/RTCGA/new/RTCGA.Rcheck/00_pkg_src/RTCGA/R/ggbiplot.R:157-161)
    ggbiplot: no visible binding for global variable ‘hjust’
      (.../revdep/checks/RTCGA/new/RTCGA.Rcheck/00_pkg_src/RTCGA/R/ggbiplot.R:157-161)
    read.mutations: no visible binding for global variable ‘.’
      (.../revdep/checks/RTCGA/new/RTCGA.Rcheck/00_pkg_src/RTCGA/R/readTCGA.R:383)
    read.mutations: no visible binding for global variable ‘.’
      (.../revdep/checks/RTCGA/new/RTCGA.Rcheck/00_pkg_src/RTCGA/R/readTCGA.R:386)
    read.rnaseq: no visible binding for global variable ‘.’
      (.../revdep/checks/RTCGA/new/RTCGA.Rcheck/00_pkg_src/RTCGA/R/readTCGA.R:372-375)
    survivalTCGA: no visible binding for global variable ‘times’
      (.../revdep/checks/RTCGA/new/RTCGA.Rcheck/00_pkg_src/RTCGA/R/survivalTCGA.R:101-137)
    whichDateToUse: no visible binding for global variable ‘.’
      (.../revdep/checks/RTCGA/new/RTCGA.Rcheck/00_pkg_src/RTCGA/R/downloadTCGA.R:167-168)
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

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Quitting from lines 380-382 (RxODE-intro.Rmd) 
    Error: processing vignette 'RxODE-intro.Rmd' failed with diagnostics:
    Tried both LSODA and DOP853, but could not solve the system.
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

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘devtools’
      All declared Imports should be used.
    ```

# spew

Version: 1.3.0

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Loading required package: sp
    Warning in grid.Call(C_textBounds, as.graphicsAnnot(x$label), x$x, x$y,  :
      no font could be found for family "10"
    Warning in grid.Call(C_textBounds, as.graphicsAnnot(x$label), x$x, x$y,  :
      no font could be found for family "10"
    Quitting from lines 45-64 (spew-quickstart.Rmd) 
    Error: processing vignette 'spew-quickstart.Rmd' failed with diagnostics:
    polygon edge not found
    Execution halted
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘Rmpi’
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘maptools’
      All declared Imports should be used.
    ```

# SpidermiR

Version: 1.7.4

## In both

*   checking R code for possible problems ... NOTE
    ```
    .SpidermiRvisualize_gene: possible error in simpleNetwork(NetworkData,
      linkColour = "gray", textColour = "black", zoom = TRUE): unused
      argument (textColour = "black")
      (.../revdep/checks/SpidermiR/new/SpidermiR.Rcheck/00_pkg_src/SpidermiR/R/SpidermiRInternal.R:31)
    SpidermiRvisualize_plot_target: no visible binding for global variable
      ‘miRNAs’
      (.../revdep/checks/SpidermiR/new/SpidermiR.Rcheck/00_pkg_src/SpidermiR/R/SpidermiRvisualize.R:143-145)
    SpidermiRvisualize_plot_target: no visible binding for global variable
      ‘mRNA_target’
      (.../revdep/checks/SpidermiR/new/SpidermiR.Rcheck/00_pkg_src/SpidermiR/R/SpidermiRvisualize.R:143-145)
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
      (.../revdep/checks/StarBioTrek/new/StarBioTrek.Rcheck/00_pkg_src/StarBioTrek/R/getdata.R:108)
    getKEGGdata: no visible binding for global variable ‘Nervous_system’
      (.../revdep/checks/StarBioTrek/new/StarBioTrek.Rcheck/00_pkg_src/StarBioTrek/R/getdata.R:113)
    getKEGGdata: no visible binding for global variable ‘Sensory_system’
      (.../revdep/checks/StarBioTrek/new/StarBioTrek.Rcheck/00_pkg_src/StarBioTrek/R/getdata.R:118)
    matrix_plot: no visible binding for global variable ‘path’
      (.../revdep/checks/StarBioTrek/new/StarBioTrek.Rcheck/00_pkg_src/StarBioTrek/R/path_star.R:132)
    plotting_cross_talk: no visible binding for global variable ‘path’
      (.../revdep/checks/StarBioTrek/new/StarBioTrek.Rcheck/00_pkg_src/StarBioTrek/R/path_star.R:179)
    svm_classification: no visible binding for global variable ‘Target’
      (.../revdep/checks/StarBioTrek/new/StarBioTrek.Rcheck/00_pkg_src/StarBioTrek/R/path_star.R:441)
    svm_classification: no visible binding for global variable ‘Target’
      (.../revdep/checks/StarBioTrek/new/StarBioTrek.Rcheck/00_pkg_src/StarBioTrek/R/path_star.R:444)
    Undefined global functions or variables:
      Aminoacid Carbohydrate Cell_growth_and_death Cellular_community
      Circulatory_system Cofa_vita_met Digestive_system Endocrine_system
      Energy Excretory_system Folding_sorting_and_degradation Glybio_met
      Immune_system Lipid Nervous_system Replication_and_repair
      Sensory_system Signal_transduction
      Signaling_molecules_and_interaction Target Transcription Translation
      Transport_and_catabolism path
    ```

# SuperLearner

Version: 2.0-22

## In both

*   R CMD check timed out
    

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

## Newly fixed

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    This is taxlist 0.1.2
    
    Attaching package: 'taxlist'
    
    The following object is masked from 'package:base':
    
        levels
    
    Calling http://taxosaurus.org/retrieve/9e960e5dacf3c865aa9bcdf341441d44
    Quitting from lines 105-108 (taxlist-intro.Rmd) 
    Error: processing vignette 'taxlist-intro.Rmd' failed with diagnostics:
    HTTP status 502 - Bad Gateway
    Execution halted
    ```

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
      (.../revdep/checks/TCGAbiolinks/new/TCGAbiolinks.Rcheck/00_pkg_src/TCGAbiolinks/R/analyze.R:1131)
    TCGAvisualize_SurvivalCoxNET: no visible global function definition for
      ‘dNetInduce’
      (.../revdep/checks/TCGAbiolinks/new/TCGAbiolinks.Rcheck/00_pkg_src/TCGAbiolinks/R/visualize.R:156-157)
    TCGAvisualize_SurvivalCoxNET: no visible global function definition for
      ‘dNetPipeline’
      (.../revdep/checks/TCGAbiolinks/new/TCGAbiolinks.Rcheck/00_pkg_src/TCGAbiolinks/R/visualize.R:161-162)
    TCGAvisualize_SurvivalCoxNET: no visible global function definition for
      ‘dCommSignif’
      (.../revdep/checks/TCGAbiolinks/new/TCGAbiolinks.Rcheck/00_pkg_src/TCGAbiolinks/R/visualize.R:174)
    TCGAvisualize_SurvivalCoxNET: no visible global function definition for
      ‘visNet’
      (.../revdep/checks/TCGAbiolinks/new/TCGAbiolinks.Rcheck/00_pkg_src/TCGAbiolinks/R/visualize.R:184-189)
    TCGAvisualize_oncoprint: no visible binding for global variable ‘value’
      (.../revdep/checks/TCGAbiolinks/new/TCGAbiolinks.Rcheck/00_pkg_src/TCGAbiolinks/R/visualize.R:933)
    getTSS: no visible global function definition for ‘promoters’
      (.../revdep/checks/TCGAbiolinks/new/TCGAbiolinks.Rcheck/00_pkg_src/TCGAbiolinks/R/methylation.R:1745-1746)
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

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘data.table’ ‘datasets’ ‘stats’
      All declared Imports should be used.
    ```

# testthis

Version: 1.0.2

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘rprojroot’
      All declared Imports should be used.
    ```

# TeXCheckR

Version: 0.4.4

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
      OK: 207 SKIPPED: 0 FAILED: 2
      1. Error: No misspelled words (@test-zzz-check-pkgs-spelling.R#36) 
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

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      
      
      testthat results ================================================================
      OK: 179 SKIPPED: 0 FAILED: 3
      1. Failure: Test returns tibble with correct rows and columns. (@test_tq_get_key_stats.R#15) 
      2. Failure: Test returns tibble with correct rows and columns. (@test_tq_get_key_stats.R#17) 
      3. Failure: Test returns tibble with correct rows and columns. (@test_tq_get_key_stats.R#19) 
      
      Error: testthat unit tests failed
      In addition: Warning messages:
      1: In download.file(url, destfile = tmp, quiet = TRUE) :
        cannot open URL 'http://download.finance.yahoo.com/d/quotes.csv?s=AAPL&f=aa2a5bb4b6c1c4dd1ee7e8e9f6ghjj1j2j4j5j6kk3k4k5ll1mm3m4m5m6m7m8nopp2p5p6qrr1r5r6r7s6s7t8vwxy&e=.csv': HTTP status was '403 Forbidden'
      2: x = 'AAPL', get = 'key.stats': Error in download.file(url, destfile = tmp, quiet = TRUE): cannot open URL 'http://download.finance.yahoo.com/d/quotes.csv?s=AAPL&f=aa2a5bb4b6c1c4dd1ee7e8e9f6ghjj1j2j4j5j6kk3k4k5ll1mm3m4m5m6m7m8nopp2p5p6qrr1r5r6r7s6s7t8vwxy&e=.csv'
       
      Execution halted
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    ...
    Warning in download.file(url, destfile = tmp, quiet = TRUE) :
      cannot open URL 'http://download.finance.yahoo.com/d/quotes.csv?s=AAPL&f=aa2a5bb4b6c1c4dd1ee7e8e9f6ghjj1j2j4j5j6kk3k4k5ll1mm3m4m5m6m7m8nopp2p5p6qrr1r5r6r7s6s7t8vwxy&e=.csv': HTTP status was '403 Forbidden'
    Warning: x = 'AAPL', get = 'key.stats': Error in download.file(url, destfile = tmp, quiet = TRUE): cannot open URL 'http://download.finance.yahoo.com/d/quotes.csv?s=AAPL&f=aa2a5bb4b6c1c4dd1ee7e8e9f6ghjj1j2j4j5j6kk3k4k5ll1mm3m4m5m6m7m8nopp2p5p6qrr1r5r6r7s6s7t8vwxy&e=.csv'
    
    Warning in download.file(url, destfile = tmp, quiet = TRUE) :
      cannot open URL 'http://download.finance.yahoo.com/d/quotes.csv?s=AAPL&f=aa2a5bb4b6c1c4dd1ee7e8e9f6ghjj1j2j4j5j6kk3k4k5ll1mm3m4m5m6m7m8nopp2p5p6qrr1r5r6r7s6s7t8vwxy&e=.csv': HTTP status was '403 Forbidden'
    Warning: x = 'AAPL', get = 'key.stats': Error in download.file(url, destfile = tmp, quiet = TRUE): cannot open URL 'http://download.finance.yahoo.com/d/quotes.csv?s=AAPL&f=aa2a5bb4b6c1c4dd1ee7e8e9f6ghjj1j2j4j5j6kk3k4k5ll1mm3m4m5m6m7m8nopp2p5p6qrr1r5r6r7s6s7t8vwxy&e=.csv'
     Removing AAPL.
    Warning in download.file(url, destfile = tmp, quiet = TRUE) :
      cannot open URL 'http://download.finance.yahoo.com/d/quotes.csv?s=FB&f=aa2a5bb4b6c1c4dd1ee7e8e9f6ghjj1j2j4j5j6kk3k4k5ll1mm3m4m5m6m7m8nopp2p5p6qrr1r5r6r7s6s7t8vwxy&e=.csv': HTTP status was '403 Forbidden'
    Warning: x = 'FB', get = 'key.stats': Error in download.file(url, destfile = tmp, quiet = TRUE): cannot open URL 'http://download.finance.yahoo.com/d/quotes.csv?s=FB&f=aa2a5bb4b6c1c4dd1ee7e8e9f6ghjj1j2j4j5j6kk3k4k5ll1mm3m4m5m6m7m8nopp2p5p6qrr1r5r6r7s6s7t8vwxy&e=.csv'
     Removing FB.
    Warning in download.file(url, destfile = tmp, quiet = TRUE) :
      cannot open URL 'http://download.finance.yahoo.com/d/quotes.csv?s=GOOG&f=aa2a5bb4b6c1c4dd1ee7e8e9f6ghjj1j2j4j5j6kk3k4k5ll1mm3m4m5m6m7m8nopp2p5p6qrr1r5r6r7s6s7t8vwxy&e=.csv': HTTP status was '403 Forbidden'
    Warning: x = 'GOOG', get = 'key.stats': Error in download.file(url, destfile = tmp, quiet = TRUE): cannot open URL 'http://download.finance.yahoo.com/d/quotes.csv?s=GOOG&f=aa2a5bb4b6c1c4dd1ee7e8e9f6ghjj1j2j4j5j6kk3k4k5ll1mm3m4m5m6m7m8nopp2p5p6qrr1r5r6r7s6s7t8vwxy&e=.csv'
     Removing GOOG.
    Warning in value[[3L]](cond) : Returning as nested data frame.
    Quitting from lines 211-214 (TQ01-core-functions-in-tidyquant.Rmd) 
    Error: processing vignette 'TQ01-core-functions-in-tidyquant.Rmd' failed with diagnostics:
    object 'Ask' not found
    Execution halted
    ```

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

Version: 1.9.1

## In both

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘sem’
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

