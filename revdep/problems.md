# abjutils

Version: 0.2.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘httr’ ‘progress’
      All declared Imports should be used.
    ```

# adapr

Version: 2.0.0

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

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      2: stop(content, call. = F) at .../revdep/checks.noindex/alphavantager/new/alphavantager.Rcheck/00_pkg_src/alphavantager/R/av_get.R:103
      
      ── 3. Error: call Technical Indicators (@test_av_get.R#57)  ────────────────────
      Thank you for using Alpha Vantage! Please visit https://www.alphavantage.co/premium/ if you would like to have a higher API call volume.. API parameters used: symbol=MSFT, function=SMA, interval=monthly, time_period=60, series_type=close, apikey=HIDDEN_FOR_YOUR_SAFETY
      1: av_get(symbol, av_fun, interval = interval, time_period = time_period, series_type = series_type) at testthat/test_av_get.R:57
      2: stop(content, call. = F) at .../revdep/checks.noindex/alphavantager/new/alphavantager.Rcheck/00_pkg_src/alphavantager/R/av_get.R:103
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      OK: 7 SKIPPED: 0 FAILED: 3
      1. Error: call TIMES_SERIES_INTRADAY (@test_av_get.R#22) 
      2. Error: call SECTOR (@test_av_get.R#38) 
      3. Error: call Technical Indicators (@test_av_get.R#57) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘devtools’
      All declared Imports should be used.
    ```

# aMNLFA

Version: 0.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘devtools’ ‘gridExtra’
      All declared Imports should be used.
    ```

# amt

Version: 0.0.5.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘Rcpp’ ‘magrittr’
      All declared Imports should be used.
    ```

# annotatr

Version: 1.6.0

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘annotatr-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: build_annotations
    > ### Title: A function to build annotations from TxDb.* and AnnotationHub
    > ###   resources
    > ### Aliases: build_annotations
    > 
    > ### ** Examples
    > 
    > # Example with hg19 gene promoters
    > annots = c('hg19_genes_promoters')
    > annots_gr = build_annotations(genome = 'hg19', annotations = annots)
    Error in build_gene_annots(genome = genome, annotations = gene_annotations) : 
      The package TxDb.Hsapiens.UCSC.hg19.knownGene is not installed, please install it via Bioconductor.
    Calls: build_annotations
    Execution halted
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    snapshotDate(): 2018-04-30
    Building annotation Gm12878 from AnnotationHub resource AH23256 ...
    require("rtracklayer")
    downloading 0 resources
    loading from cache 
        '/Users/jhester//.AnnotationHub/28684'
    Quitting from lines 153-170 (annotatr-vignette.Rmd) 
    Error: processing vignette 'annotatr-vignette.Rmd' failed with diagnostics:
    The package TxDb.Hsapiens.UCSC.hg19.knownGene is not installed, please install it via Bioconductor.
    Execution halted
    ```

*   checking package dependencies ... NOTE
    ```
    Packages suggested but not available for checking:
      ‘org.Dm.eg.db’ ‘org.Gg.eg.db’ ‘org.Hs.eg.db’ ‘org.Mm.eg.db’
      ‘org.Rn.eg.db’ ‘TxDb.Dmelanogaster.UCSC.dm3.ensGene’
      ‘TxDb.Dmelanogaster.UCSC.dm6.ensGene’
      ‘TxDb.Ggallus.UCSC.galGal5.refGene’
      ‘TxDb.Hsapiens.UCSC.hg19.knownGene’
      ‘TxDb.Hsapiens.UCSC.hg38.knownGene’
      ‘TxDb.Mmusculus.UCSC.mm9.knownGene’
      ‘TxDb.Mmusculus.UCSC.mm10.knownGene’
      ‘TxDb.Rnorvegicus.UCSC.rn4.ensGene’
      ‘TxDb.Rnorvegicus.UCSC.rn5.refGene’
      ‘TxDb.Rnorvegicus.UCSC.rn6.refGene’
    ```

*   checking R code for possible problems ... NOTE
    ```
    plot_coannotations: no visible binding for global variable ‘.’
      (.../revdep/checks.noindex/annotatr/new/annotatr.Rcheck/00_pkg_src/annotatr/R/visualize.R:176-178)
    plot_numerical_coannotations: no visible binding for global variable
      ‘.’
      (.../revdep/checks.noindex/annotatr/new/annotatr.Rcheck/00_pkg_src/annotatr/R/visualize.R:463-480)
    plot_numerical_coannotations: no visible binding for global variable
      ‘.’
      (.../revdep/checks.noindex/annotatr/new/annotatr.Rcheck/00_pkg_src/annotatr/R/visualize.R:466-471)
    plot_numerical_coannotations: no visible binding for global variable
      ‘.’
      (.../revdep/checks.noindex/annotatr/new/annotatr.Rcheck/00_pkg_src/annotatr/R/visualize.R:473-478)
    Undefined global functions or variables:
      .
    ```

# anomalize

Version: 0.1.1

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.5Mb
      sub-directories of 1Mb or more:
        help   4.7Mb
    ```

# anyLib

Version: 1.0.4

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘curl’ ‘httr’
      All declared Imports should be used.
    ```

# archivist

Version: 2.3.1

## In both

*   checking package dependencies ... NOTE
    ```
    Package which this enhances but not available for checking: ‘archivist.github’
    ```

*   checking Rd cross-references ... NOTE
    ```
    Packages unavailable to check Rd xrefs: ‘rmarkdown’, ‘archivist.github’
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
    Complete output:
      > library(testthat)
      > library(devtools)
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
    Complete output:
      > library(testthat)
      > library(devtools)
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
    Complete output:
      > library(testthat)
      > library(devtools)
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
    Complete output:
      > library(testthat)
      > library(devtools)
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
    Complete output:
      > library(testthat)
      > library(devtools)
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

# AUCell

Version: 1.2.4

## In both

*   checking package dependencies ... NOTE
    ```
    Packages which this enhances but not available for checking: ‘doMC’ ‘doRNG’
    ```

*   checking dependencies in R code ... NOTE
    ```
    'library' or 'require' call to ‘rbokeh’ in package code.
      Please use :: or requireNamespace() instead.
      See section 'Suggested packages' in the 'Writing R Extensions' manual.
    ```

*   checking R code for possible problems ... NOTE
    ```
    .cellProps_plotTsne: warning in adjustcolor(colorPal(10), alpha = 0.8):
      partial argument match of 'alpha' to 'alpha.f'
      (.../revdep/checks.noindex/AUCell/new/AUCell.Rcheck/00_pkg_src/AUCell/R/priv_plots.R:127)
    AUCell_createViewerApp : <anonymous>: no visible global function
      definition for ‘%>%’
      (.../revdep/checks.noindex/AUCell/new/AUCell.Rcheck/00_pkg_src/AUCell/R/aux_createViewerApp.R:224-228)
    AUCell_createViewerApp : <anonymous>: no visible binding for global
      variable ‘tsne1’
      (.../revdep/checks.noindex/AUCell/new/AUCell.Rcheck/00_pkg_src/AUCell/R/aux_createViewerApp.R:224-228)
    AUCell_createViewerApp : <anonymous>: no visible binding for global
      variable ‘tsne2’
      (.../revdep/checks.noindex/AUCell/new/AUCell.Rcheck/00_pkg_src/AUCell/R/aux_createViewerApp.R:224-228)
    AUCell_createViewerApp : <anonymous>: no visible binding for global
      variable ‘cell’
      (.../revdep/checks.noindex/AUCell/new/AUCell.Rcheck/00_pkg_src/AUCell/R/aux_createViewerApp.R:224-228)
    Undefined global functions or variables:
      %>% cell tsne1 tsne2
    ```

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘SingleCellExperiment’
    ```

*   checking for unstated dependencies in vignettes ... NOTE
    ```
    '::' or ':::' import not declared from: ‘reshape2’
    ```

# baytrends

Version: 1.0.7

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  6.4Mb
      sub-directories of 1Mb or more:
        R         2.7Mb
        data      1.0Mb
        extdata   1.8Mb
    ```

# BEACH

Version: 1.2.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘readxl’
      All declared Imports should be used.
    ```

# beachmat

Version: 1.2.1

## In both

*   checking installed package size ... NOTE
    ```
      installed size is 24.8Mb
      sub-directories of 1Mb or more:
        doc    2.5Mb
        lib   16.6Mb
        libs   5.2Mb
    ```

# BETS

Version: 0.4.4

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘mFilter’
    ```

# bigstep

Version: 1.0.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘methods’
      All declared Imports should be used.
    ```

# BiocCheck

Version: 1.16.0

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

*   checking installed package size ... NOTE
    ```
      installed size is  5.4Mb
      sub-directories of 1Mb or more:
        unitTests   4.1Mb
    ```

*   checking dependencies in R code ... NOTE
    ```
    Unexported objects imported by ':::' calls:
      ‘knitr:::detect_pattern’ ‘tools:::RdTags’
      See the note in ?`:::` about the use of this operator.
    ```

# BiocWorkflowTools

Version: 1.6.2

## Newly broken

*   checking examples ... WARNING
    ```
    Found the following significant warnings:
    
      Warning: 'create' is deprecated.
      Warning: 'setup' is deprecated.
      Warning: 'create_description' is deprecated.
      Warning: 'use_rstudio' is deprecated.
    Deprecated functions may be defunct as soon as of the next release of
    R.
    See ?Deprecated.
    ```

## In both

*   checking for hidden files and directories ... NOTE
    ```
    Found the following hidden files and directories:
      .travis.yml
    These were most likely included in error. See section ‘Package
    structure’ in the ‘Writing R Extensions’ manual.
    ```

*   checking dependencies in R code ... NOTE
    ```
    Unexported objects imported by ':::' calls:
      ‘BiocStyle:::auth_affil_latex’ ‘BiocStyle:::modifyLines’
      ‘rmarkdown:::partition_yaml_front_matter’
      See the note in ?`:::` about the use of this operator.
    ```

# BioInstaller

Version: 0.3.6

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      Please input y/n/Y/N!
      /var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T//RtmphnLDFa/destdir.initial not empty, overwrite?[y]
      More than 3 counts input, default is not to overwrite.
      /var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T//RtmphnLDFa/destdir.initial existed, overwrite?[y]
      Please input y/n/Y/N!
      /var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T//RtmphnLDFa/destdir.initial existed, overwrite?[y]
      Please input y/n/Y/N!
      /var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T//RtmphnLDFa/destdir.initial existed, overwrite?[y]
      More than 3 counts input, default is not to overwrite.
      ══ testthat results  ═══════════════════════════════════════════════════════════
      OK: 62 SKIPPED: 0 FAILED: 1
      1. Error: install.github (@test_install.R#12) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 10.9Mb
      sub-directories of 1Mb or more:
        doc       2.5Mb
        extdata   8.0Mb
    ```

# biwavelet

Version: 0.20.17

## In both

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘RColorBrewer’
    ```

# BloodCancerMultiOmics2017

Version: 1.0.2

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    ...
    
    The following objects are masked from 'package:IRanges':
    
        intersect, setdiff, union
    
    The following objects are masked from 'package:S4Vectors':
    
        intersect, setdiff, union
    
    The following objects are masked from 'package:BiocGenerics':
    
        intersect, setdiff, union
    
    The following objects are masked from 'package:base':
    
        intersect, setdiff, union
    
    Quitting from lines 46-92 (BloodCancerMultiOmics2017.Rmd) 
    Error: processing vignette 'BloodCancerMultiOmics2017.Rmd' failed with diagnostics:
    there is no package called 'org.Hs.eg.db'
    Execution halted
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘org.Hs.eg.db’
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 102.1Mb
      sub-directories of 1Mb or more:
        data     66.4Mb
        doc      26.5Mb
        extdata   8.5Mb
    ```

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘vsn’
    ```

# BrailleR

Version: 0.29.1

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘installr’
    ```

# cartools

Version: 0.1.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘animation’ ‘devtools’ ‘gapminder’ ‘knitr’ ‘rlist’ ‘rmarkdown’
      ‘roxygen2’ ‘sde’ ‘shiny’ ‘tidyverse’ ‘usethis’ ‘utils’
      All declared Imports should be used.
    ```

# CGPfunctions

Version: 0.4

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘devtools’
      All declared Imports should be used.
    ```

*   checking Rd cross-references ... NOTE
    ```
    Packages unavailable to check Rd xrefs: ‘BSDA’, ‘janitor’
    ```

# chimeraviz

Version: 1.6.1

## In both

*   checking package dependencies ... ERROR
    ```
    Packages required but not available: ‘org.Hs.eg.db’ ‘org.Mm.eg.db’
    
    Depends: includes the non-default packages:
      ‘Biostrings’ ‘GenomicRanges’ ‘IRanges’ ‘Gviz’ ‘S4Vectors’ ‘ensembldb’
      ‘AnnotationFilter’
    Adding so many packages to the search path is excessive and importing
    selectively is preferable.
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# chipenrich

Version: 2.4.0

## In both

*   checking package dependencies ... ERROR
    ```
    Packages required but not available:
      ‘org.Dm.eg.db’ ‘org.Dr.eg.db’ ‘org.Hs.eg.db’ ‘org.Mm.eg.db’
      ‘org.Rn.eg.db’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# chipenrich.data

Version: 2.4.0

## In both

*   checking package dependencies ... NOTE
    ```
    Packages suggested but not available for checking:
      ‘GO.db’ ‘org.Dm.eg.db’ ‘org.Dr.eg.db’ ‘org.Hs.eg.db’ ‘org.Mm.eg.db’
      ‘org.Rn.eg.db’ ‘TxDb.Dmelanogaster.UCSC.dm3.ensGene’
      ‘TxDb.Dmelanogaster.UCSC.dm6.ensGene’
      ‘TxDb.Drerio.UCSC.danRer10.refGene’
      ‘TxDb.Hsapiens.UCSC.hg19.knownGene’
      ‘TxDb.Hsapiens.UCSC.hg38.knownGene’
      ‘TxDb.Mmusculus.UCSC.mm9.knownGene’
      ‘TxDb.Mmusculus.UCSC.mm10.knownGene’
      ‘TxDb.Rnorvegicus.UCSC.rn4.ensGene’
      ‘TxDb.Rnorvegicus.UCSC.rn5.refGene’
      ‘TxDb.Rnorvegicus.UCSC.rn6.refGene’
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 153.5Mb
      sub-directories of 1Mb or more:
        data  152.2Mb
    ```

# civis

Version: 1.5.1

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.4Mb
      sub-directories of 1Mb or more:
        R      3.1Mb
        help   1.7Mb
    ```

# ClusterJudge

Version: 1.2.0

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘ClusterJudge-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: clusterJudge
    > ### Title: judges clustering using an entity.attribute table
    > ### Aliases: clusterJudge
    > ### Keywords: attribute_mut_inf consolidate_entity_attribute
    > 
    > ### ** Examples
    > 
    > 
    > library('yeastExpData')
    Error in library("yeastExpData") : 
      there is no package called ‘yeastExpData’
    Execution halted
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Loading ClusterJudge
    Loading required package: infotheo
    Loading required package: lattice
    Loading required package: latticeExtra
    Loading required package: RColorBrewer
    Loading required package: httr
    Loading required package: jsonlite
    Warning in readLines(con, warn = FALSE, n = n, ok = ok, skipNul = skipNul) :
      invalid input found on input connection '.../revdep/checks.noindex/ClusterJudge/new/ClusterJudge.Rcheck/vign_test/ClusterJudge/R/clusterJudge_z_score.R'
    Quitting from lines 61-62 (ClusterJudge-intro.Rmd) 
    Error: processing vignette 'ClusterJudge-intro.Rmd' failed with diagnostics:
    .../revdep/checks.noindex/ClusterJudge/new/ClusterJudge.Rcheck/vign_test/ClusterJudge/R/:24:0: unexpected end of input
    22: ##### z-score definition
    23: #####   z
       ^
    Execution halted
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘yeastExpData’
    ```

# codemetar

Version: 0.1.6

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘memoise’
      All declared Imports should be used.
    ```

# cogena

Version: 1.14.0

## In both

*   checking whether package ‘cogena’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: replacing previous import ‘class::somgrid’ by ‘kohonen::somgrid’ when loading ‘cogena’
    See ‘.../revdep/checks.noindex/cogena/new/cogena.Rcheck/00install.out’ for details.
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  6.5Mb
      sub-directories of 1Mb or more:
        doc       1.9Mb
        extdata   3.1Mb
    ```

*   checking R code for possible problems ... NOTE
    ```
    ...
      ‘legend’
      (.../revdep/checks.noindex/cogena/new/cogena.Rcheck/00_pkg_src/cogena/R/heatmapCluster.R:151-153)
    heatmapCluster,cogena: no visible global function definition for
      ‘legend’
      (.../revdep/checks.noindex/cogena/new/cogena.Rcheck/00_pkg_src/cogena/R/heatmapCluster.R:155-157)
    heatmapCluster,cogena: no visible global function definition for
      ‘legend’
      (.../revdep/checks.noindex/cogena/new/cogena.Rcheck/00_pkg_src/cogena/R/heatmapCluster.R:159-160)
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

Version: 1.18.0

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Quitting from lines 39-41 (SimpleCOMPASS.Rmd) 
    Error: processing vignette 'SimpleCOMPASS.Rmd' failed with diagnostics:
    there is no package called 'readxl'
    Execution halted
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘BiocStyle’ ‘rmarkdown’
      All declared Imports should be used.
    ':::' call which should be '::': ‘flowWorkspace:::.getNodeInd’
      See the note in ?`:::` about the use of this operator.
    ```

*   checking R code for possible problems ... NOTE
    ```
    COMPASSfitToCountsTable: no visible binding for global variable
      ‘population’
      (.../revdep/checks.noindex/COMPASS/new/COMPASS.Rcheck/00_pkg_src/COMPASS/R/utils.R:193)
    COMPASSfitToCountsTable: no visible binding for global variable ‘Count’
      (.../revdep/checks.noindex/COMPASS/new/COMPASS.Rcheck/00_pkg_src/COMPASS/R/utils.R:193)
    COMPASSfitToCountsTable: no visible binding for global variable
      ‘population’
      (.../revdep/checks.noindex/COMPASS/new/COMPASS.Rcheck/00_pkg_src/COMPASS/R/utils.R:194)
    COMPASSfitToCountsTable: no visible binding for global variable ‘Count’
      (.../revdep/checks.noindex/COMPASS/new/COMPASS.Rcheck/00_pkg_src/COMPASS/R/utils.R:194)
    COMPASSfitToCountsTable: no visible binding for global variable ‘id’
      (.../revdep/checks.noindex/COMPASS/new/COMPASS.Rcheck/00_pkg_src/COMPASS/R/utils.R:200)
    COMPASSfitToCountsTable: no visible binding for global variable ‘id’
      (.../revdep/checks.noindex/COMPASS/new/COMPASS.Rcheck/00_pkg_src/COMPASS/R/utils.R:206)
    Undefined global functions or variables:
      Count id population
    ```

*   checking for unstated dependencies in vignettes ... NOTE
    ```
    'library' or 'require' calls not declared from:
      ‘ggplot2’ ‘readxl’
    ```

# CompGLM

Version: 2.0

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      122                                                Variable and function names should be all lowercase.
      123                                                        lines should not be more than 80 characters.
      124                                                               Trailing blank lines are superfluous.
      125                                                Variable and function names should be all lowercase.
      126                                                Variable and function names should be all lowercase.
      127                                                               Trailing blank lines are superfluous.
      ── 1. Failure: check that package has google style (@test_code_style.R#11)  ────
      length(lints) == 0 isn't true.
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      OK: 19 SKIPPED: 0 FAILED: 1
      1. Failure: check that package has google style (@test_code_style.R#11) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# congressbr

Version: 0.1.3

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 187 marked UTF-8 strings
    ```

# CountClust

Version: 1.8.0

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  8.4Mb
      sub-directories of 1Mb or more:
        data   7.3Mb
    ```

# crunch

Version: 1.24.0

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  6.4Mb
      sub-directories of 1Mb or more:
        R     3.5Mb
        doc   1.1Mb
    ```

# curatedMetagenomicData

Version: 1.10.2

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.7Mb
      sub-directories of 1Mb or more:
        doc    1.4Mb
        help   2.7Mb
    ```

# demi

Version: 1.1.2

## In both

*   checking R code for possible problems ... NOTE
    ```
    ...
    diffexp,DEMIDiff: no visible global function definition for ‘p.adjust’
      (.../revdep/checks.noindex/demi/new/demi.Rcheck/00_pkg_src/demi/R/DEMIDiff-methods.R:352)
    loadAnnotation,DEMIExperiment-environment: no visible global function
      definition for ‘data’
      (.../revdep/checks.noindex/demi/new/demi.Rcheck/00_pkg_src/demi/R/DEMIExperiment-methods.R:549)
    loadBlat,DEMIExperiment-environment: no visible global function
      definition for ‘data’
      (.../revdep/checks.noindex/demi/new/demi.Rcheck/00_pkg_src/demi/R/DEMIExperiment-methods.R:598)
    loadCytoband,DEMIExperiment-environment: no visible global function
      definition for ‘data’
      (.../revdep/checks.noindex/demi/new/demi.Rcheck/00_pkg_src/demi/R/DEMIExperiment-methods.R:700)
    loadPathway,DEMIExperiment-environment: no visible global function
      definition for ‘data’
      (.../revdep/checks.noindex/demi/new/demi.Rcheck/00_pkg_src/demi/R/DEMIExperiment-methods.R:735)
    Undefined global functions or variables:
      combn data dhyper median p.adjust t.test wilcox.test write.table
    Consider adding
      importFrom("stats", "dhyper", "median", "p.adjust", "t.test",
                 "wilcox.test")
      importFrom("utils", "combn", "data", "write.table")
    to your NAMESPACE file.
    ```

# derfinder

Version: 1.14.0

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/test-all.R’ failed.
    Last 13 lines of output:
        bplog: FALSE; bpthreshold: INFO; bpstopOnError: TRUE
        bptimeout: 2592000; bpprogressbar: FALSE
        bplogdir: NA
      class: SerialParam
        bpisup: TRUE; bpnworkers: 1; bptasks: 0; bpjobname: BPJOB
        bplog: FALSE; bpthreshold: INFO; bpstopOnError: TRUE
        bptimeout: 2592000; bpprogressbar: FALSE
        bplogdir: NA
      ══ testthat results  ═══════════════════════════════════════════════════════════
      OK: 122 SKIPPED: 0 FAILED: 2
      1. Error: (unknown) (@test_Fstats.R#104) 
      2. Error: (unknown) (@test_annotation.R#4) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Warning in citation("BiocStyle") :
      no date field in DESCRIPTION file of package 'BiocStyle'
    Quitting from lines 63-131 (derfinder-quickstart.Rmd) 
    Error: processing vignette 'derfinder-quickstart.Rmd' failed with diagnostics:
    package 'knitrBootstrap' not found
    Execution halted
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘TxDb.Hsapiens.UCSC.hg19.knownGene’
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  6.8Mb
      sub-directories of 1Mb or more:
        doc   5.0Mb
    ```

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

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘TxDb.Hsapiens.UCSC.hg19.knownGene’
    ```

# derfinderData

Version: 0.114.0

## In both

*   checking installed package size ... NOTE
    ```
      installed size is 33.9Mb
      sub-directories of 1Mb or more:
        extdata  33.7Mb
    ```

# derfinderHelper

Version: 1.14.0

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Warning in citation("BiocStyle") :
      no date field in DESCRIPTION file of package 'BiocStyle'
    Quitting from lines 61-90 (derfinderHelper.Rmd) 
    Error: processing vignette 'derfinderHelper.Rmd' failed with diagnostics:
    package 'BiocParallel' not found
    Execution halted
    ```

*   checking for unstated dependencies in vignettes ... NOTE
    ```
    '::' or ':::' import not declared from: ‘RefManageR’
    ```

# derfinderPlot

Version: 1.14.0

## In both

*   checking examples ... ERROR
    ```
    ...
        rowMeans, rowSums, rownames, sapply, setdiff, sort, table, tapply,
        union, unique, unsplit, which, which.max, which.min
    
    
    Attaching package: 'S4Vectors'
    
    The following object is masked from 'package:base':
    
        expand.grid
    
    Loading required package: IRanges
    Loading required package: GenomeInfoDb
    Loading required package: GenomicRanges
    Loading required package: foreach
    Loading required package: iterators
    Loading required package: locfit
    locfit 1.5-9.1 	 2013-03-22
    > library('TxDb.Hsapiens.UCSC.hg19.knownGene')
    Error in library("TxDb.Hsapiens.UCSC.hg19.knownGene") : 
      there is no package called 'TxDb.Hsapiens.UCSC.hg19.knownGene'
    Execution halted
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/test-all.R’ failed.
    Last 13 lines of output:
      1: library("TxDb.Hsapiens.UCSC.hg19.knownGene") at testthat/test_adv-plotCluster.R:3
      2: stop(txt, domain = NA)
      
      ── 2. Error: (unknown) (@test_plotting.R#14)  ──────────────────────────────────
      there is no package called 'TxDb.Hsapiens.UCSC.hg19.knownGene'
      1: library("TxDb.Hsapiens.UCSC.hg19.knownGene") at testthat/test_plotting.R:14
      2: stop(txt, domain = NA)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      OK: 0 SKIPPED: 0 FAILED: 2
      1. Error: (unknown) (@test_adv-plotCluster.R#3) 
      2. Error: (unknown) (@test_plotting.R#14) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Warning in citation("BiocStyle") :
      no date field in DESCRIPTION file of package 'BiocStyle'
    Warning in citation("devtools") :
      no date field in DESCRIPTION file of package 'devtools'
    Quitting from lines 62-115 (derfinderPlot.Rmd) 
    Error: processing vignette 'derfinderPlot.Rmd' failed with diagnostics:
    package 'TxDb.Hsapiens.UCSC.hg19.knownGene' not found
    Execution halted
    ```

*   checking package dependencies ... NOTE
    ```
    Packages suggested but not available for checking:
      ‘org.Hs.eg.db’ ‘TxDb.Hsapiens.UCSC.hg19.knownGene’
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: 'RefManageR'
      All declared Imports should be used.
    ```

# DLMtool

Version: 5.2.3

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  8.7Mb
      sub-directories of 1Mb or more:
        R      5.2Mb
        data   2.1Mb
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

Version: 1.7.1

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘doMPI’
    ```

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘doMPI’
    ```

# dynutils

Version: 1.0.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘Rcpp’ ‘processx’
      All declared Imports should be used.
    ```

# elementR

Version: 1.3.6

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
      installed size is  6.5Mb
      sub-directories of 1Mb or more:
        R         2.7Mb
        Results   2.3Mb
    ```

# ELMER.data

Version: 2.4.2

## In both

*   checking for hidden files and directories ... NOTE
    ```
    Found the following hidden files and directories:
      .travis.yml
    These were most likely included in error. See section ‘Package
    structure’ in the ‘Writing R Extensions’ manual.
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 288.8Mb
      sub-directories of 1Mb or more:
        data  286.3Mb
        doc     2.4Mb
    ```

*   checking DESCRIPTION meta-information ... NOTE
    ```
    Malformed Description field: should contain one or more complete sentences.
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Error in .requirePackage(package) : 
        unable to find required package 'MultiAssayExperiment'
      Calls: <Anonymous> ... getClass -> getClassDef -> .classEnv -> .requirePackage
      Execution halted
    ```

# epiNEM

Version: 1.4.0

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Error: processing vignette 'epiNEM.Rmd' failed with diagnostics:
    there is no package called ‘BiocStyle’
    Execution halted
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘org.Sc.sgd.db’
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
      (.../revdep/checks.noindex/epiNEM/new/epiNEM.Rcheck/00_pkg_src/epiNEM/R/plot_results.R:375-377)
    plot.epiSim: no visible global function definition for ‘boxplot’
      (.../revdep/checks.noindex/epiNEM/new/epiNEM.Rcheck/00_pkg_src/epiNEM/R/plot_results.R:403-405)
    plot.epiSim: no visible global function definition for ‘abline’
      (.../revdep/checks.noindex/epiNEM/new/epiNEM.Rcheck/00_pkg_src/epiNEM/R/plot_results.R:407)
    plot.epiSim: no visible global function definition for ‘axis’
      (.../revdep/checks.noindex/epiNEM/new/epiNEM.Rcheck/00_pkg_src/epiNEM/R/plot_results.R:409-411)
    plot.epiSim: no visible global function definition for ‘boxplot’
      (.../revdep/checks.noindex/epiNEM/new/epiNEM.Rcheck/00_pkg_src/epiNEM/R/plot_results.R:413-415)
    plot.epiSim: no visible global function definition for ‘abline’
      (.../revdep/checks.noindex/epiNEM/new/epiNEM.Rcheck/00_pkg_src/epiNEM/R/plot_results.R:417)
    plot.epiSim: no visible global function definition for ‘axis’
      (.../revdep/checks.noindex/epiNEM/new/epiNEM.Rcheck/00_pkg_src/epiNEM/R/plot_results.R:419-421)
    Undefined global functions or variables:
      abline absorption adj axis bnem boxplot computeFc dnf2adj
      dummyCNOlist epiNEM2Bg layout popSize preprocessing readSIF sim
      simulateStatesRecursive
    Consider adding
      importFrom("graphics", "abline", "axis", "boxplot", "layout")
    to your NAMESPACE file.
    ```

# EValue

Version: 1.1.5

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘devtools’ ‘msm’
      All declared Imports should be used.
    ```

# excerptr

Version: 1.4.1

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘excerptr-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: excerptr
    > ### Title: Excerpt Structuring Comments and Set a Table of Contents.
    > ### Aliases: excerptr
    > 
    > ### ** Examples
    > 
    > root <- system.file(package = "excerptr")
    > test_files <- file.path(root, "excerpts", "tests", "files")
    > excerptr(file_name = file.path(test_files, "some_file.txt"),
    +          output_path = tempdir(), run_pandoc = FALSE,
    +          compile_latex = FALSE,
    +          pandoc_formats = c("tex", "html"))
    cloning into '.../inst/excerpts'...
    Error in git2r::clone(url = "https://github.com/fvafrCU/excerpts/", branch = branch,  : 
      Error in 'git2r_clone': unsupported URL protocol
    Calls: excerptr -> load_excerpts -> get_excerpts -> <Anonymous>
    Execution halted
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
             "html"), output_path = tempdir(), run_pandoc = TRUE) at testthat/test_basic.R:64
      2: load_excerpts() at .../revdep/checks.noindex/excerptr/new/excerptr.Rcheck/00_pkg_src/excerptr/R/excerptr.R:36
      3: get_excerpts(directory = python_directory) at .../revdep/checks.noindex/excerptr/new/excerptr.Rcheck/00_pkg_src/excerptr/R/utils.R:42
      4: git2r::clone(url = "https://github.com/fvafrCU/excerpts/", branch = branch, local_path = directory) at .../revdep/checks.noindex/excerptr/new/excerptr.Rcheck/00_pkg_src/excerptr/R/get_excerpts.R:21
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      OK: 2 SKIPPED: 0 FAILED: 5
      1. Error: get (@test_basic.R#9) 
      2. Error: load (@test_basic.R#15) 
      3. Error: md (@test_basic.R#38) 
      4. Error: pandoc_formats (@test_basic.R#52) 
      5. Error: pandoc_formats_list (@test_basic.R#64) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# ExPanDaR

Version: 0.2.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘CodeDepends’ ‘DT’ ‘PKI’ ‘shinycssloaders’ ‘tictoc’
      All declared Imports should be used.
    ```

# fakemake

Version: 1.3.0

## Newly broken

*   checking examples ... WARNING
    ```
    Found the following significant warnings:
    
      Warning: 'devtools::create' is deprecated.
      Warning: 'setup' is deprecated.
      Warning: 'create_description' is deprecated.
      Warning: 'use_rstudio' is deprecated.
    Deprecated functions may be defunct as soon as of the next release of
    R.
    See ?Deprecated.
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Creating package 'fakepack' in '/private/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T/RtmpWyVmqy'
    No DESCRIPTION found. Creating with values:
    
    
    Prerequisite DESCRIPTION found.
    Prerequisite R/throw.R found.
    Prerequisite R/throw.R found.
    Prerequisite R/throw.R found.
    Prerequisite R/throw.R found.
    ```

## Newly fixed

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘rcmdcheck’
    ```

# fitODBOD

Version: 1.2.0

## In both

*   checking Rd cross-references ... NOTE
    ```
    Packages unavailable to check Rd xrefs: ‘BinaryEPPM’, ‘extraDistr’, ‘triangle’
    ```

# gbfs

Version: 1.0.0

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Quitting from lines 30-31 (kc_bikeshare.Rmd) 
    Error: processing vignette 'kc_bikeshare.Rmd' failed with diagnostics:
    Column `num_bikes_available_types` must be a 1d atomic vector or a list
    Execution halted
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘devtools’ ‘roxygen2’ ‘testthat’ ‘utils’ ‘withr’
      All declared Imports should be used.
    ```

# ggExtra

Version: 0.8

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘grDevices’
      All declared Imports should be used.
    ```

# githubinstall

Version: 0.2.2

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘mockery’
      All declared Imports should be used.
    ```

# googleAuthR

Version: 0.6.3

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘R6’
      All declared Imports should be used.
    ```

# gsrc

Version: 1.1

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘brassicaData’
    ```

# HMP16SData

Version: 1.0.1

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    ...
    Attaching package: 'dendextend'
    
    The following object is masked from 'package:stats':
    
        cutree
    
    ========================================
    circlize version 0.4.4
    CRAN page: https://cran.r-project.org/package=circlize
    Github page: https://github.com/jokergoo/circlize
    Documentation: http://jokergoo.github.io/circlize_book/book/
    
    If you use it in published research, please cite:
    Gu, Z. circlize implements and enhances circular visualization 
      in R. Bioinformatics 2014.
    ========================================
    
    Quitting from lines 58-71 (HMP16SData.Rmd) 
    Error: processing vignette 'HMP16SData.Rmd' failed with diagnostics:
    there is no package called 'curatedMetagenomicData'
    Execution halted
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘curatedMetagenomicData’
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 19.1Mb
      sub-directories of 1Mb or more:
        doc       1.5Mb
        extdata  17.4Mb
    ```

# hyperSpec

Version: 0.99-20180627

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  6.3Mb
      sub-directories of 1Mb or more:
        R     2.0Mb
        doc   3.8Mb
    ```

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘caTools’
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

Version: 1.8.0

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
    
    Quitting from lines 42-47 (introduction_to_ihw.Rmd) 
    Error: processing vignette 'introduction_to_ihw.Rmd' failed with diagnostics:
    there is no package called 'airway'
    Execution halted
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘airway’
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  6.2Mb
      sub-directories of 1Mb or more:
        doc   5.8Mb
    ```

*   checking R code for possible problems ... NOTE
    ```
    ...
      (.../revdep/checks.noindex/IHW/new/IHW.Rcheck/00_pkg_src/IHW/R/plots.R:101)
    plot_decisionboundary: no visible binding for global variable
      ‘covariate’
      (.../revdep/checks.noindex/IHW/new/IHW.Rcheck/00_pkg_src/IHW/R/plots.R:110-112)
    plot_decisionboundary: no visible binding for global variable ‘pvalue’
      (.../revdep/checks.noindex/IHW/new/IHW.Rcheck/00_pkg_src/IHW/R/plots.R:110-112)
    plot_decisionboundary: no visible binding for global variable ‘fold’
      (.../revdep/checks.noindex/IHW/new/IHW.Rcheck/00_pkg_src/IHW/R/plots.R:110-112)
    thresholds_ihwResult: no visible global function definition for
      ‘na.exclude’
      (.../revdep/checks.noindex/IHW/new/IHW.Rcheck/00_pkg_src/IHW/R/ihw_class.R:96-97)
    thresholds,ihwResult: no visible global function definition for
      ‘na.exclude’
      (.../revdep/checks.noindex/IHW/new/IHW.Rcheck/00_pkg_src/IHW/R/ihw_class.R:96-97)
    Undefined global functions or variables:
      covariate fold gurobi mcols mcols<- metadata metadata<- na.exclude
      p.adjust pvalue runif str stratum
    Consider adding
      importFrom("stats", "na.exclude", "p.adjust", "runif")
      importFrom("utils", "str")
    to your NAMESPACE file.
    ```

# iLaplace

Version: 1.1.0

## In both

*   checking for portable use of $(BLAS_LIBS) and $(LAPACK_LIBS) ... WARNING
    ```
      apparently using $(LAPACK_LIBS) without following $(BLAS_LIBS) in ‘src/Makevars’
    ```

# KoNLP

Version: 0.80.1

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  6.6Mb
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

# lilikoi

Version: 0.1.0

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.2Mb
      sub-directories of 1Mb or more:
        data      3.8Mb
        extdata   1.1Mb
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘Matrix’ ‘devtools’ ‘e1071’ ‘glmnet’ ‘hash’ ‘pamr’ ‘randomForest’
      All declared Imports should be used.
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 3837 marked UTF-8 strings
    ```

# lime

Version: 0.4.0

## In both

*   checking package dependencies ... ERROR
    ```
    Packages required but not available:
      ‘glmnet’ ‘ggplot2’ ‘stringi’ ‘stringdist’ ‘htmlwidgets’ ‘shiny’
      ‘shinythemes’ ‘magick’ ‘gower’ ‘RcppEigen’
    
    Packages suggested but not available for checking:
      ‘xgboost’ ‘testthat’ ‘mlr’ ‘h2o’ ‘text2vec’ ‘knitr’ ‘rmarkdown’
      ‘keras’
    
    VignetteBuilder package required for checking but not installed: ‘knitr’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# loose.rock

Version: 1.0.9

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘futile.options’ ‘ggfortify’ ‘grDevices’ ‘stats’
      All declared Imports should be used.
    ```

# Luminescence

Version: 0.8.5

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  8.7Mb
      sub-directories of 1Mb or more:
        R   6.2Mb
    ```

# MCbiclust

Version: 1.4.0

## In both

*   checking package dependencies ... ERROR
    ```
    Packages required but not available: ‘GO.db’ ‘org.Hs.eg.db’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# metafolio

Version: 0.1.0

## In both

*   checking R code for possible problems ... NOTE
    ```
    ...
    plot_sp_A_ts: no visible global function definition for ‘axis’
      (.../revdep/checks.noindex/metafolio/new/metafolio.Rcheck/00_pkg_src/metafolio/R/plot_sp_A_ts.R:90-91)
    run_cons_plans: no visible binding for global variable ‘var’
    thermal_area: no visible global function definition for ‘uniroot’
      (.../revdep/checks.noindex/metafolio/new/metafolio.Rcheck/00_pkg_src/metafolio/R/thermal_integration.R:19-21)
    thermal_area: no visible global function definition for ‘uniroot’
      (.../revdep/checks.noindex/metafolio/new/metafolio.Rcheck/00_pkg_src/metafolio/R/thermal_integration.R:22-24)
    thermal_area: no visible global function definition for ‘integrate’
      (.../revdep/checks.noindex/metafolio/new/metafolio.Rcheck/00_pkg_src/metafolio/R/thermal_integration.R:26-28)
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

# metagenomeFeatures

Version: 2.0.0

## In both

*   checking whether package ‘metagenomeFeatures’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: subclass "QualityScaledDNAStringSet" of class "DNAStringSet" is not local and cannot be updated for new inheritance information; consider setClassUnion()
      Warning: replacing previous import ‘lazyeval::is_formula’ by ‘purrr::is_formula’ when loading ‘metagenomeFeatures’
      Warning: replacing previous import ‘lazyeval::is_atomic’ by ‘purrr::is_atomic’ when loading ‘metagenomeFeatures’
    See ‘.../revdep/checks.noindex/metagenomeFeatures/new/metagenomeFeatures.Rcheck/00install.out’ for details.
    ```

*   checking for missing documentation entries ... WARNING
    ```
    Undocumented S4 methods:
      generic '[' and siglist 'mgFeatures'
    All user-level objects in a package (including S4 classes and methods)
    should have documentation entries.
    See chapter ‘Writing R documentation files’ in the ‘Writing R
    Extensions’ manual.
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  5.1Mb
      sub-directories of 1Mb or more:
        extdata   3.5Mb
    ```

*   checking R code for possible problems ... NOTE
    ```
    .select: no visible binding for global variable ‘identifier’
      (.../revdep/checks.noindex/metagenomeFeatures/new/metagenomeFeatures.Rcheck/00_pkg_src/metagenomeFeatures/R/mgDb_method_select.R:96-97)
    .select.taxa: no visible binding for global variable ‘Keys’
      (.../revdep/checks.noindex/metagenomeFeatures/new/metagenomeFeatures.Rcheck/00_pkg_src/metagenomeFeatures/R/mgDb_method_select.R:21)
    .select.taxa: no visible binding for global variable ‘.’
      (.../revdep/checks.noindex/metagenomeFeatures/new/metagenomeFeatures.Rcheck/00_pkg_src/metagenomeFeatures/R/mgDb_method_select.R:21)
    get_gg13.8_85MgDb: no visible binding for global variable ‘metadata’
      (.../revdep/checks.noindex/metagenomeFeatures/new/metagenomeFeatures.Rcheck/00_pkg_src/metagenomeFeatures/R/gg13.8_85MgDb.R:23-25)
    Undefined global functions or variables:
      . Keys identifier metadata
    ```

# micompr

Version: 1.1.0

## In both

*   checking examples ... ERROR
    ```
    ...
    Running examples in ‘micompr-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: assumptions.cmpoutput
    > ### Title: Get assumptions for parametric tests performed on output
    > ###   comparisons
    > ### Aliases: assumptions.cmpoutput
    > 
    > ### ** Examples
    > 
    > 
    > # Create a cmpoutput object from the provided datasets
    > cmp <- cmpoutput("All", 0.9, pphpc_ok$data[["All"]], pphpc_ok$obs_lvls)
    > 
    > # Get the assumptions for the parametric tests performed in cmp
    > acmp <- assumptions(cmp)
    sROC 0.1-2 loaded
    MANOVA assumptions require 'MVN' and 'biotools' packages.
    Error in `*tmp*`[[i]] : subscript out of bounds
    Calls: assumptions -> assumptions.cmpoutput
    Execution halted
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      subscript out of bounds
      1: assumptions(mic1a) at testthat/test_micomp.R:281
      2: assumptions.micomp(mic1a) at .../revdep/checks.noindex/micompr/new/micompr.Rcheck/00_pkg_src/micompr/R/assumptions.R:19
      3: lapply(obj, function(x) assumptions(x)) at .../revdep/checks.noindex/micompr/new/micompr.Rcheck/00_pkg_src/micompr/R/micomp.R:498
      4: FUN(X[[i]], ...)
      5: assumptions(x) at .../revdep/checks.noindex/micompr/new/micompr.Rcheck/00_pkg_src/micompr/R/micomp.R:498
      6: assumptions.cmpoutput(x) at .../revdep/checks.noindex/micompr/new/micompr.Rcheck/00_pkg_src/micompr/R/assumptions.R:19
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      OK: 363 SKIPPED: 0 FAILED: 2
      1. Error: assumptions.cmpoutput creates the correct object (@test_cmpoutput.R#214) 
      2. Error: micomp assumptions have the correct properties (@test_micomp.R#281) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Quitting from lines 341-342 (paper.Rnw) 
    Error: processing vignette 'paper.Rnw' failed with diagnostics:
    subscript out of bounds
    Execution halted
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘biotools’
    ```

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘biotools’
    ```

# microsamplingDesign

Version: 1.0.5

## Newly broken

*   checking whether package ‘microsamplingDesign’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘.../revdep/checks.noindex/microsamplingDesign/new/microsamplingDesign.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘microsamplingDesign’ ...
** package ‘microsamplingDesign’ successfully unpacked and MD5 sums checked
** libs
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/devtools/new/Rcpp/include" -I".../revdep/library.noindex/microsamplingDesign/RcppArmadillo/include" -I/usr/local/include   -fPIC  -Wall -g -O2 -c RcppExports.cpp -o RcppExports.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/devtools/new/Rcpp/include" -I".../revdep/library.noindex/microsamplingDesign/RcppArmadillo/include" -I/usr/local/include   -fPIC  -Wall -g -O2 -c interpolation.cpp -o interpolation.o
clang++ -std=gnu++11 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/usr/local/lib -o microsamplingDesign.so RcppExports.o interpolation.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/usr/local/gfortran/lib/gcc/x86_64-apple-darwin15/6.1.0 -L/usr/local/gfortran/lib -lgfortran -lquadmath -lm -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/usr/local/gfortran/lib/gcc/x86_64-apple-darwin15/6.1.0'
ld: warning: directory not found for option '-L/usr/local/gfortran/lib'
installing to .../revdep/checks.noindex/microsamplingDesign/new/microsamplingDesign.Rcheck/microsamplingDesign/libs
** R
** inst
** byte-compile and prepare package for lazy loading
Error : object ‘dev_package_deps’ is not exported by 'namespace:devtools'
ERROR: lazy loading failed for package ‘microsamplingDesign’
* removing ‘.../revdep/checks.noindex/microsamplingDesign/new/microsamplingDesign.Rcheck/microsamplingDesign’

```
### CRAN

```
* installing *source* package ‘microsamplingDesign’ ...
** package ‘microsamplingDesign’ successfully unpacked and MD5 sums checked
** libs
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/microsamplingDesign/Rcpp/include" -I".../revdep/library.noindex/microsamplingDesign/RcppArmadillo/include" -I/usr/local/include   -fPIC  -Wall -g -O2 -c RcppExports.cpp -o RcppExports.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/microsamplingDesign/Rcpp/include" -I".../revdep/library.noindex/microsamplingDesign/RcppArmadillo/include" -I/usr/local/include   -fPIC  -Wall -g -O2 -c interpolation.cpp -o interpolation.o
clang++ -std=gnu++11 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/usr/local/lib -o microsamplingDesign.so RcppExports.o interpolation.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/usr/local/gfortran/lib/gcc/x86_64-apple-darwin15/6.1.0 -L/usr/local/gfortran/lib -lgfortran -lquadmath -lm -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/usr/local/gfortran/lib/gcc/x86_64-apple-darwin15/6.1.0'
ld: warning: directory not found for option '-L/usr/local/gfortran/lib'
installing to .../revdep/checks.noindex/microsamplingDesign/old/microsamplingDesign.Rcheck/microsamplingDesign/libs
** R
** inst
** byte-compile and prepare package for lazy loading
** help
*** installing help indices
** building package indices
** installing vignettes
** testing if installed package can be loaded
* DONE (microsamplingDesign)

```
# MODIS

Version: 1.1.3

## In both

*   checking S3 generic/method consistency ... WARNING
    ```
    sh: gdalinfo: command not found
    See section ‘Generic functions and methods’ in the ‘Writing R
    Extensions’ manual.
    ```

*   checking replacement functions ... WARNING
    ```
    sh: gdalinfo: command not found
    The argument of a replacement function which corresponds to the right
    hand side must be named ‘value’.
    ```

*   checking for missing documentation entries ... WARNING
    ```
    sh: gdalinfo: command not found
    All user-level objects in a package should have documentation entries.
    See chapter ‘Writing R documentation files’ in the ‘Writing R
    Extensions’ manual.
    ```

*   checking for code/documentation mismatches ... WARNING
    ```
    sh: gdalinfo: command not found
    sh: gdalinfo: command not found
    sh: gdalinfo: command not found
    ```

*   checking dependencies in R code ... NOTE
    ```
    sh: gdalinfo: command not found
    ```

*   checking foreign function calls ... NOTE
    ```
    sh: gdalinfo: command not found
    See chapter ‘System and foreign language interfaces’ in the ‘Writing R
    Extensions’ manual.
    ```

*   checking Rd \usage sections ... NOTE
    ```
    sh: gdalinfo: command not found
    The \usage entries for S3 methods should use the \method markup and not
    their full name.
    See chapter ‘Writing R documentation files’ in the ‘Writing R
    Extensions’ manual.
    ```

# MonetDBLite

Version: 0.6.0

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  6.0Mb
      sub-directories of 1Mb or more:
        libs   5.3Mb
    ```

# MoonlightR

Version: 1.6.1

## In both

*   checking installed package size ... NOTE
    ```
      installed size is 11.3Mb
      sub-directories of 1Mb or more:
        data   3.1Mb
        doc    7.9Mb
    ```

# msgtools

Version: 0.2.7

## Newly broken

*   checking examples ... WARNING
    ```
    Found the following significant warnings:
    
      Warning: 'create' is deprecated.
      Warning: 'setup' is deprecated.
      Warning: 'create_description' is deprecated.
      Warning: 'create' is deprecated.
      Warning: 'setup' is deprecated.
      Warning: 'create_description' is deprecated.
      Warning: 'create' is deprecated.
      Warning: 'setup' is deprecated.
      Warning: 'create_description' is deprecated.
      Warning: 'create' is deprecated.
      Warning: 'setup' is deprecated.
      Warning: 'create_description' is deprecated.
    Deprecated functions may be defunct as soon as of the next release of
    R.
    See ?Deprecated.
    ```

# myTAI

Version: 0.8.0

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.5Mb
      sub-directories of 1Mb or more:
        data   2.0Mb
        doc    2.4Mb
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘biomartr’
      All declared Imports should be used.
    ```

# networktools

Version: 1.2.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘devtools’
      All declared Imports should be used.
    ```

# nima

Version: 0.5.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘ProjectTemplate’ ‘devtools’ ‘plyr’ ‘survival’
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

Version: 0.21.0

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘doMPI’
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  5.3Mb
      sub-directories of 1Mb or more:
        R   3.2Mb
    ```

# npsm

Version: 0.5

## In both

*   checking R code for possible problems ... NOTE
    ```
    ...
    onecovahomog: no visible global function definition for ‘pf’
      (.../revdep/checks.noindex/npsm/new/npsm.Rcheck/00_pkg_src/npsm/R/racov.r:53)
    rank.test: no visible global function definition for ‘pnorm’
      (.../revdep/checks.noindex/npsm/new/npsm.Rcheck/00_pkg_src/npsm/R/rank.test.r:12-16)
    rank.test: no visible global function definition for ‘coef’
      (.../revdep/checks.noindex/npsm/new/npsm.Rcheck/00_pkg_src/npsm/R/rank.test.r:21)
    rank.test: no visible global function definition for ‘qt’
      (.../revdep/checks.noindex/npsm/new/npsm.Rcheck/00_pkg_src/npsm/R/rank.test.r:24-28)
    rcn: no visible global function definition for ‘rnorm’
    vanElteren.test: no visible global function definition for ‘pnorm’
      (.../revdep/checks.noindex/npsm/new/npsm.Rcheck/00_pkg_src/npsm/R/vanElteren.test.r:23)
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

Version: 2.0.8

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 4 marked UTF-8 strings
    ```

# OpenMx

Version: 2.11.3

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘Rmpi’
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 18.2Mb
      sub-directories of 1Mb or more:
        R        6.6Mb
        libs     4.1Mb
        models   4.7Mb
    ```

*   checking Rd cross-references ... NOTE
    ```
    Packages unavailable to check Rd xrefs: ‘ifaTools’, ‘umx’
    ```

# openPrimeR

Version: 1.2.0

## In both

*   checking for hidden files and directories ... NOTE
    ```
    Found the following hidden files and directories:
      .travis.yml
    These were most likely included in error. See section ‘Package
    structure’ in the ‘Writing R Extensions’ manual.
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 15.2Mb
      sub-directories of 1Mb or more:
        R         3.9Mb
        extdata  10.2Mb
    ```

# OPWeight

Version: 1.2.0

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    ...
      ...
    Installing package into '.../revdep/checks.noindex/OPWeight/new/OPWeight.Rcheck'
    (as 'lib' is unspecified)
    trying URL 'https://bioconductor.org/packages/3.7/bioc/bin/macosx/el-capitan/contrib/3.5/BiocInstaller_1.30.0.tgz'
    Content type 'application/x-gzip' length 84646 bytes (82 KB)
    ==================================================
    downloaded 82 KB
    
    Bioconductor version 3.7 (BiocInstaller 1.30.0), ?biocLite for help
    BioC_mirror: https://bioconductor.org
    Using Bioconductor 3.7 (BiocInstaller 1.30.0), R 3.5.1 (2018-07-02).
    Installing package(s) 'OPWeight'
    trying URL 'https://bioconductor.org/packages/3.7/bioc/bin/macosx/el-capitan/contrib/3.5/OPWeight_1.2.0.tgz'
    Content type 'application/x-gzip' length 632632 bytes (617 KB)
    ==================================================
    downloaded 617 KB
    
    Quitting from lines 46-59 (OPWeight.Rmd) 
    Error: processing vignette 'OPWeight.Rmd' failed with diagnostics:
    there is no package called 'airway'
    Execution halted
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘airway’
    ```

# osmplotr

Version: 0.3.0

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  6.9Mb
      sub-directories of 1Mb or more:
        doc   5.9Mb
    ```

# packrat

Version: 0.4.9-3

## In both

*   checking package dependencies ... NOTE
    ```
    Package which this enhances but not available for checking: ‘BiocInstaller’
    ```

# pacman

Version: 0.4.6

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      9: vapply(remotes, install_remote, ..., FUN.VALUE = character(1)) at /private/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T/RtmpROUfuj/R.INSTALL1463c63119464/remotes/R/install-remote.R:73
      10: FUN(X[[i]], ...)
      11: remote_package_name(remote) at /private/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T/RtmpROUfuj/R.INSTALL1463c63119464/remotes/R/install-remote.R:24
      12: remote_package_name.github_remote(remote) at /private/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T/RtmpROUfuj/R.INSTALL1463c63119464/remotes/R/install-remote.R:105
      13: github_DESCRIPTION(username = remote$username, repo = remote$repo, subdir = remote$subdir, 
             host = remote$host, ref = remote$ref, pat = remote$auth_token %||% github_pat(), 
             use_curl = use_curl) at /private/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T/RtmpROUfuj/R.INSTALL1463c63119464/remotes/R/install-github.R:222
      14: stop("HTTP error ", res$status_code, ".", "\n", github_error_message(res), call. = FALSE) at /private/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T/RtmpROUfuj/R.INSTALL1463c63119464/remotes/R/github.R:101
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      OK: 54 SKIPPED: 3 FAILED: 1
      1. Error: p_install_gh works (@test-p_install_gh.R#5) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# parlitools

Version: 0.2.1

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 13 marked UTF-8 strings
    ```

# pkgdown

Version: 1.1.0

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      nrow(out) not equal to 1.
      1/1 mismatches
      [1] 0 - 1 == -1
      
      ── 2. Failure: can autodetect published tutorials (@test-tutorials.R#31)  ──────
      out$name not equal to "test-1".
      Lengths differ: 0 is not 1
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      OK: 241 SKIPPED: 9 FAILED: 2
      1. Failure: can autodetect published tutorials (@test-tutorials.R#30) 
      2. Failure: can autodetect published tutorials (@test-tutorials.R#31) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# pkgmaker

Version: 0.27

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘magrittr’ ‘stringi’
      All declared Imports should be used.
    ```

# pkgnet

Version: 0.2.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘DT’ ‘covr’ ‘knitr’
      All declared Imports should be used.
    ```

# PKPDmisc

Version: 2.1.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘purrr’
      All declared Imports should be used.
    ```

# plotly

Version: 4.8.0

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  6.5Mb
      sub-directories of 1Mb or more:
        R             1.7Mb
        htmlwidgets   3.1Mb
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

Version: 0.4.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘clipr’ ‘desc’ ‘devtools’
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

Version: 1.6.1

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  9.6Mb
      sub-directories of 1Mb or more:
        R     2.9Mb
        doc   5.6Mb
    ```

*   checking R code for possible problems ... NOTE
    ```
    ...
      (.../revdep/checks.noindex/psichomics/new/psichomics.Rcheck/00_pkg_src/psichomics/R/data_local.R:284)
    prepareGeneQuantSTAR : <anonymous>: no visible binding for global
      variable ‘index’
      (.../revdep/checks.noindex/psichomics/new/psichomics.Rcheck/00_pkg_src/psichomics/R/data_local.R:284)
    prepareGeneQuantSTAR : <anonymous>: no visible binding for global
      variable ‘index’
      (.../revdep/checks.noindex/psichomics/new/psichomics.Rcheck/00_pkg_src/psichomics/R/data_local.R:285)
    prepareJunctionQuantSTAR: no visible binding for '<<-' assignment to
      ‘index’
      (.../revdep/checks.noindex/psichomics/new/psichomics.Rcheck/00_pkg_src/psichomics/R/data_local.R:198)
    prepareJunctionQuantSTAR : <anonymous>: no visible binding for '<<-'
      assignment to ‘index’
      (.../revdep/checks.noindex/psichomics/new/psichomics.Rcheck/00_pkg_src/psichomics/R/data_local.R:200)
    prepareJunctionQuantSTAR : <anonymous>: no visible binding for global
      variable ‘index’
      (.../revdep/checks.noindex/psichomics/new/psichomics.Rcheck/00_pkg_src/psichomics/R/data_local.R:200)
    prepareJunctionQuantSTAR : <anonymous>: no visible binding for global
      variable ‘index’
      (.../revdep/checks.noindex/psichomics/new/psichomics.Rcheck/00_pkg_src/psichomics/R/data_local.R:201)
    Undefined global functions or variables:
      ..strandedness index
    ```

*   checking compiled code ... NOTE
    ```
    File ‘psichomics/libs/psichomics.so’:
      Found ‘___stdoutp’, possibly from ‘stdout’ (C)
        Object: ‘psiFastCalc.o’
      Found ‘_printf’, possibly from ‘printf’ (C)
        Object: ‘psiFastCalc.o’
      Found ‘_putchar’, possibly from ‘putchar’ (C)
        Object: ‘psiFastCalc.o’
    
    Compiled code should not call entry points which might terminate R nor
    write to stdout/stderr instead of to the console, nor use Fortran I/O
    nor system RNGs.
    
    See ‘Writing portable packages’ in the ‘Writing R Extensions’ manual.
    ```

# PSPManalysis

Version: 0.2.0

## Newly broken

*   checking whether package ‘PSPManalysis’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘.../revdep/checks.noindex/PSPManalysis/new/PSPManalysis.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘PSPManalysis’ ...
** package ‘PSPManalysis’ successfully unpacked and MD5 sums checked
** libs
clang -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG   -I/usr/local/include   -fPIC  -Wall -g -O2  -c PSPManalysis_init.c -o PSPManalysis_init.o
clang -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG   -I/usr/local/include   -fPIC  -Wall -g -O2  -c csb2rlist.c -o csb2rlist.o
clang -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/usr/local/lib -o PSPManalysis.so PSPManalysis_init.o csb2rlist.o -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
installing to .../revdep/checks.noindex/PSPManalysis/new/PSPManalysis.Rcheck/PSPManalysis/libs
** R
** demo
** inst
** byte-compile and prepare package for lazy loading
** help
*** installing help indices
** building package indices
** installing vignettes
** testing if installed package can be loaded
Error: package or namespace load failed for ‘PSPManalysis’:
 .onAttach failed in attachNamespace() for 'PSPManalysis', details:
  call: NULL
  error: 'setup_rtools' is not an exported object from 'namespace:devtools'
Error: loading failed
Execution halted
ERROR: loading failed
* removing ‘.../revdep/checks.noindex/PSPManalysis/new/PSPManalysis.Rcheck/PSPManalysis’

```
### CRAN

```
* installing *source* package ‘PSPManalysis’ ...
** package ‘PSPManalysis’ successfully unpacked and MD5 sums checked
** libs
clang -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG   -I/usr/local/include   -fPIC  -Wall -g -O2  -c PSPManalysis_init.c -o PSPManalysis_init.o
clang -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG   -I/usr/local/include   -fPIC  -Wall -g -O2  -c csb2rlist.c -o csb2rlist.o
clang -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/usr/local/lib -o PSPManalysis.so PSPManalysis_init.o csb2rlist.o -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
installing to .../revdep/checks.noindex/PSPManalysis/old/PSPManalysis.Rcheck/PSPManalysis/libs
** R
** demo
** inst
** byte-compile and prepare package for lazy loading
** help
*** installing help indices
** building package indices
** installing vignettes
** testing if installed package can be loaded
* DONE (PSPManalysis)

```
# pulver

Version: 0.1.0

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘DatABEL’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# qqplotr

Version: 0.0.3

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘knitr’ ‘purrr’ ‘rmarkdown’
      All declared Imports should be used.
    ```

# qsort

Version: 0.2.2

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 6 marked UTF-8 strings
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
      (.../revdep/checks.noindex/rbundler/new/rbundler.Rcheck/00_pkg_src/rbundler/R/install_version.r:25)
    install_version: no visible global function definition for
      ‘available.packages’
      (.../revdep/checks.noindex/rbundler/new/rbundler.Rcheck/00_pkg_src/rbundler/R/install_version.r:26)
    install_version: no visible global function definition for
      ‘install_url’
      (.../revdep/checks.noindex/rbundler/new/rbundler.Rcheck/00_pkg_src/rbundler/R/install_version.r:37)
    load_available_packages: no visible global function definition for
      ‘contrib.url’
      (.../revdep/checks.noindex/rbundler/new/rbundler.Rcheck/00_pkg_src/rbundler/R/load_available_packages.r:5)
    validate_installed_package: no visible global function definition for
      ‘installed.packages’
      (.../revdep/checks.noindex/rbundler/new/rbundler.Rcheck/00_pkg_src/rbundler/R/install_version.r:55)
    Undefined global functions or variables:
      available.packages contrib.url install_url installed.packages
    Consider adding
      importFrom("utils", "available.packages", "contrib.url",
                 "installed.packages")
    to your NAMESPACE file.
    ```

# RcppProgress

Version: 0.4.1

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      
      ── 4. Failure: eta_progress_bar (@test-pkg_examples.R#28)  ─────────────────────
      `eta_progress_bar(nb = 1000)` threw an error.
      Message: System command error
      Class:   system_command_status_error/system_command_error/error/condition
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      OK: 0 SKIPPED: 0 FAILED: 4
      1. Failure: test_sequential (@test-pkg_examples.R#6) 
      2. Failure: test_multithreaded (@test-pkg_examples.R#13) 
      3. Failure: amardillo_multithreaded (@test-pkg_examples.R#20) 
      4. Failure: eta_progress_bar (@test-pkg_examples.R#28) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# recount

Version: 1.6.3

## In both

*   R CMD check timed out
    

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘EnsDb.Hsapiens.v79’
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 15.7Mb
      sub-directories of 1Mb or more:
        data  12.1Mb
        doc    3.3Mb
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 347 marked UTF-8 strings
    ```

# regionReport

Version: 1.14.3

## In both

*   checking examples ... ERROR
    ```
    ...
      ordinary text without R code
    
    label: reproducibility1 (with options) 
    List of 1
     $ echo: logi FALSE
    
      ordinary text without R code
    
    label: reproducibility2 (with options) 
    List of 1
     $ echo: logi FALSE
    
      ordinary text without R code
    
    label: reproducibility3 (with options) 
    List of 1
     $ echo: logi FALSE
    
    Quitting from lines 341-344 (DESeq2Exploration.Rmd) 
    Error: 'sessioninfo' >= * must be installed for this functionality.
    Execution halted
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Quitting from lines 126-135 (bumphunterExample.Rmd) 
    Error: processing vignette 'bumphunterExample.Rmd' failed with diagnostics:
    'sessioninfo' >= * must be installed for this functionality.
    Execution halted
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘TxDb.Hsapiens.UCSC.hg19.knownGene’
    ```

*   checking dependencies in R code ... NOTE
    ```
    Unexported object imported by a ':::' call: ‘DESeq2:::pvalueAdjustment’
      See the note in ?`:::` about the use of this operator.
    ```

# reprex

Version: 0.2.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘tools’
      All declared Imports should be used.
    ```

# reproducible

Version: 0.2.3

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘gdalUtils’
      All declared Imports should be used.
    ```

# rfishbase

Version: 2.1.2

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 44 marked UTF-8 strings
    ```

# Ricetl

Version: 0.2.5

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘gWidgetsRGtk2’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# RIVER

Version: 1.4.0

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

# rpivotTable

Version: 0.3.0

## In both

*   checking package dependencies ... NOTE
    ```
    Package which this enhances but not available for checking: ‘shiny’
    ```

# rsimsum

Version: 0.3.3

## In both

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘ggthemes’
    ```

# rsMove

Version: 0.2.4

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘gdalUtils’ ‘igraph’ ‘lattice’ ‘lubridate’ ‘randomForest’ ‘rgdal’
      ‘spatialEco’
      All declared Imports should be used.
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

Version: 1.10.0

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
      Welcome to the RTCGA (version: 1.10.0).
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
      (.../revdep/checks.noindex/RTCGA/new/RTCGA.Rcheck/00_pkg_src/RTCGA/R/ggbiplot.R:157-161)
    ggbiplot: no visible binding for global variable ‘xvar’
      (.../revdep/checks.noindex/RTCGA/new/RTCGA.Rcheck/00_pkg_src/RTCGA/R/ggbiplot.R:157-161)
    ggbiplot: no visible binding for global variable ‘yvar’
      (.../revdep/checks.noindex/RTCGA/new/RTCGA.Rcheck/00_pkg_src/RTCGA/R/ggbiplot.R:157-161)
    ggbiplot: no visible binding for global variable ‘angle’
      (.../revdep/checks.noindex/RTCGA/new/RTCGA.Rcheck/00_pkg_src/RTCGA/R/ggbiplot.R:157-161)
    ggbiplot: no visible binding for global variable ‘hjust’
      (.../revdep/checks.noindex/RTCGA/new/RTCGA.Rcheck/00_pkg_src/RTCGA/R/ggbiplot.R:157-161)
    read.mutations: no visible binding for global variable ‘.’
      (.../revdep/checks.noindex/RTCGA/new/RTCGA.Rcheck/00_pkg_src/RTCGA/R/readTCGA.R:383)
    read.mutations: no visible binding for global variable ‘.’
      (.../revdep/checks.noindex/RTCGA/new/RTCGA.Rcheck/00_pkg_src/RTCGA/R/readTCGA.R:386)
    read.rnaseq: no visible binding for global variable ‘.’
      (.../revdep/checks.noindex/RTCGA/new/RTCGA.Rcheck/00_pkg_src/RTCGA/R/readTCGA.R:372-375)
    survivalTCGA: no visible binding for global variable ‘times’
      (.../revdep/checks.noindex/RTCGA/new/RTCGA.Rcheck/00_pkg_src/RTCGA/R/survivalTCGA.R:101-137)
    whichDateToUse: no visible binding for global variable ‘.’
      (.../revdep/checks.noindex/RTCGA/new/RTCGA.Rcheck/00_pkg_src/RTCGA/R/downloadTCGA.R:167-168)
    Undefined global functions or variables:
      . angle hjust muted times varname xvar yvar
    ```

*   checking Rd cross-references ... NOTE
    ```
    Packages unavailable to check Rd xrefs: ‘RTCGA.rnaseq’, ‘RTCGA.clinical’, ‘RTCGA.mutations’, ‘RTCGA.CNV’, ‘RTCGA.RPPA’, ‘RTCGA.mRNA’, ‘RTCGA.miRNASeq’, ‘RTCGA.methylation’
    ```

# RtutoR

Version: 1.2

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘DT’ ‘rmarkdown’
      All declared Imports should be used.
    ```

# Ryacas

Version: 0.3-1

## In both

*   checking whether package ‘Ryacas’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      yacas/src/obmalloc.cpp:584:23: warning: comparison of constant 384307168202282325 with expression of type 'unsigned int' is always false [-Wtautological-constant-out-of-range-compare]
    See ‘.../revdep/checks.noindex/Ryacas/new/Ryacas.Rcheck/00install.out’ for details.
    ```

# SciencesPo

Version: 1.4.1

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Warning in engine$weave(file, quiet = quiet, encoding = enc) :
      The vignette engine knitr::rmarkdown is not available, because the rmarkdown package is not installed. Please install it.
    SciencesPo 1.4.1
    Warning: `panel.margin` is deprecated. Please use `panel.spacing` property instead
    Warning: `legend.margin` must be specified using `margin()`. For the old behavior use legend.spacing
    Warning: `panel.margin` is deprecated. Please use `panel.spacing` property instead
    Warning: `legend.margin` must be specified using `margin()`. For the old behavior use legend.spacing
    Quitting from lines 754-756 (Indices.Rmd) 
    Error: processing vignette 'Indices.Rmd' failed with diagnostics:
    'sessioninfo' >= * must be installed for this functionality.
    Execution halted
    ```

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘gmodels’
    ```

# segclust2d

Version: 0.1.0

## In both

*   checking whether package ‘segclust2d’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘.../revdep/checks.noindex/segclust2d/new/segclust2d.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘segclust2d’ ...
** package ‘segclust2d’ successfully unpacked and MD5 sums checked
** libs
clang++  -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/devtools/new/Rcpp/include" -I".../revdep/library.noindex/segclust2d/RcppArmadillo/include" -I/usr/local/include  -fopenmp -fPIC  -Og -g -Wextra -Wno-unused-parameter -Wpedantic -fcolor-diagnostics -c RcppExports.cpp -o RcppExports.o
clang++  -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/devtools/new/Rcpp/include" -I".../revdep/library.noindex/segclust2d/RcppArmadillo/include" -I/usr/local/include  -fopenmp -fPIC  -Og -g -Wextra -Wno-unused-parameter -Wpedantic -fcolor-diagnostics -c SegTraj_DynProg.cpp -o SegTraj_DynProg.o
clang++  -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/devtools/new/Rcpp/include" -I".../revdep/library.noindex/segclust2d/RcppArmadillo/include" -I/usr/local/include  -fopenmp -fPIC  -Og -g -Wextra -Wno-unused-parameter -Wpedantic -fcolor-diagnostics -c SegTraj_EM.cpp -o SegTraj_EM.o
clang++  -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/devtools/new/Rcpp/include" -I".../revdep/library.noindex/segclust2d/RcppArmadillo/include" -I/usr/local/include  -fopenmp -fPIC  -Og -g -Wextra -Wno-unused-parameter -Wpedantic -fcolor-diagnostics -c SegTraj_Gmixt.cpp -o SegTraj_Gmixt.o
clang: clang: [0;1;31merror: [0munsupported option '-fopenmp'[0m[0;1;31merror
: [0munsupported option '-fopenmp'[0m
clang: [0;1;31merror: [0munsupported option '-fopenmp'[0m
clang: [0;1;31merror: [0munsupported option '-fopenmp'[0m
make: *** [SegTraj_EM.o] Error 1
make: *** Waiting for unfinished jobs....
make: *** [SegTraj_DynProg.o] Error 1
make: *** [RcppExports.o] Error 1
make: *** [SegTraj_Gmixt.o] Error 1
ERROR: compilation failed for package ‘segclust2d’
* removing ‘.../revdep/checks.noindex/segclust2d/new/segclust2d.Rcheck/segclust2d’

```
### CRAN

```
* installing *source* package ‘segclust2d’ ...
** package ‘segclust2d’ successfully unpacked and MD5 sums checked
** libs
clang++  -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/segclust2d/Rcpp/include" -I".../revdep/library.noindex/segclust2d/RcppArmadillo/include" -I/usr/local/include  -fopenmp -fPIC  -Og -g -Wextra -Wno-unused-parameter -Wpedantic -fcolor-diagnostics -c RcppExports.cpp -o RcppExports.o
clang++  -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/segclust2d/Rcpp/include" -I".../revdep/library.noindex/segclust2d/RcppArmadillo/include" -I/usr/local/include  -fopenmp -fPIC  -Og -g -Wextra -Wno-unused-parameter -Wpedantic -fcolor-diagnostics -c SegTraj_DynProg.cpp -o SegTraj_DynProg.o
clang++  -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/segclust2d/Rcpp/include" -I".../revdep/library.noindex/segclust2d/RcppArmadillo/include" -I/usr/local/include  -fopenmp -fPIC  -Og -g -Wextra -Wno-unused-parameter -Wpedantic -fcolor-diagnostics -c SegTraj_EM.cpp -o SegTraj_EM.o
clang++  -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/segclust2d/Rcpp/include" -I".../revdep/library.noindex/segclust2d/RcppArmadillo/include" -I/usr/local/include  -fopenmp -fPIC  -Og -g -Wextra -Wno-unused-parameter -Wpedantic -fcolor-diagnostics -c SegTraj_Gmixt.cpp -o SegTraj_Gmixt.o
clang: clang: [0;1;31merrorclang: : [0munsupported option '-fopenmp'[0m[0;1;31merror[0;1;31m: [0munsupported option '-fopenmp'error: 
[0m
[0munsupported option '-fopenmp'[0m
clang: [0;1;31merror: [0munsupported option '-fopenmp'[0m
make: *** [SegTraj_EM.o] Error 1
make: *** Waiting for unfinished jobs....
make: *** [SegTraj_Gmixt.o] Error 1
make: *** [SegTraj_DynProg.o] Error 1
make: *** [RcppExports.o] Error 1
ERROR: compilation failed for package ‘segclust2d’
* removing ‘.../revdep/checks.noindex/segclust2d/old/segclust2d.Rcheck/segclust2d’

```
# soilcarbon

Version: 1.2.0

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 145 marked UTF-8 strings
    ```

# SpaDES

Version: 2.0.2

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘SpaDES.core’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# SpaDES.addins

Version: 0.1.1

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘SpaDES.core’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# specmine

Version: 2.0.3

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘rcytoscapejs’
    ```

# spectrolab

Version: 0.0.7

## Newly broken

*   checking whether package ‘spectrolab’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: 'devtools::use_package' is deprecated.
    See ‘.../revdep/checks.noindex/spectrolab/new/spectrolab.Rcheck/00install.out’ for details.
    ```

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

Version: 1.10.0

## In both

*   checking package dependencies ... ERROR
    ```
    Packages required but not available: ‘miRNAtap.db’ ‘org.Hs.eg.db’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# StarBioTrek

Version: 1.6.0

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘org.Hs.eg.db’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# sweep

Version: 0.2.1.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘devtools’ ‘lazyeval’ ‘lubridate’ ‘tidyr’
      All declared Imports should be used.
    ```

# syuzhet

Version: 1.0.4

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.1Mb
      sub-directories of 1Mb or more:
        R         1.3Mb
        extdata   3.1Mb
    ```

# taxlist

Version: 0.1.5

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘grDevices’
      All declared Imports should be used.
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 97 marked UTF-8 strings
    ```

# TCGAbiolinks

Version: 2.8.4

## In both

*   R CMD check timed out
    

*   checking dependencies in R code ... WARNING
    ```
    '::' or ':::' import not declared from: ‘tidyr’
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 74.7Mb
      sub-directories of 1Mb or more:
        R      4.1Mb
        data   3.9Mb
        doc   66.4Mb
    ```

*   checking R code for possible problems ... NOTE
    ```
    ...
    TCGAvisualize_SurvivalCoxNET: no visible global function definition for
      ‘dNetPipeline’
      (.../revdep/checks.noindex/TCGAbiolinks/new/TCGAbiolinks.Rcheck/00_pkg_src/TCGAbiolinks/R/visualize.R:161-162)
    TCGAvisualize_SurvivalCoxNET: no visible global function definition for
      ‘dCommSignif’
      (.../revdep/checks.noindex/TCGAbiolinks/new/TCGAbiolinks.Rcheck/00_pkg_src/TCGAbiolinks/R/visualize.R:174)
    TCGAvisualize_SurvivalCoxNET: no visible global function definition for
      ‘visNet’
      (.../revdep/checks.noindex/TCGAbiolinks/new/TCGAbiolinks.Rcheck/00_pkg_src/TCGAbiolinks/R/visualize.R:184-189)
    TCGAvisualize_oncoprint: no visible binding for global variable ‘value’
      (.../revdep/checks.noindex/TCGAbiolinks/new/TCGAbiolinks.Rcheck/00_pkg_src/TCGAbiolinks/R/visualize.R:944)
    readExonQuantification: no visible binding for global variable ‘exon’
      (.../revdep/checks.noindex/TCGAbiolinks/new/TCGAbiolinks.Rcheck/00_pkg_src/TCGAbiolinks/R/prepare.R:234-235)
    readExonQuantification: no visible binding for global variable
      ‘coordinates’
      (.../revdep/checks.noindex/TCGAbiolinks/new/TCGAbiolinks.Rcheck/00_pkg_src/TCGAbiolinks/R/prepare.R:234-235)
    Undefined global functions or variables:
      TabSubtypesCol_merged Tumor.purity barcode c3net clinical coordinates
      dCommSignif dNetInduce dNetPipeline exon knnmi.cross
      limmacontrasts.fit limmamakeContrasts minet portions rse_gene value
      visNet
    ```

# TCGAbiolinksGUI

Version: 1.6.1

## In both

*   checking package dependencies ... ERROR
    ```
    Packages required but not available:
      ‘IlluminaHumanMethylation450kanno.ilmn12.hg19’
      ‘IlluminaHumanMethylation450kmanifest’
      ‘IlluminaHumanMethylation27kmanifest’
      ‘IlluminaHumanMethylation27kanno.ilmn12.hg19’
      ‘IlluminaHumanMethylationEPICanno.ilm10b2.hg19’
      ‘IlluminaHumanMethylationEPICmanifest’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# TCGAutils

Version: 1.0.1

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Quitting from lines 16-22 (TCGAutils.Rmd) 
    Error: processing vignette 'TCGAutils.Rmd' failed with diagnostics:
    there is no package called 'curatedTCGAData'
    Execution halted
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘curatedTCGAData’
    ```

*   checking dependencies in R code ... NOTE
    ```
    Unexported objects imported by ':::' calls:
      ‘BiocGenerics:::replaceSlots’ ‘GenomicRanges:::.normarg_field’
      See the note in ?`:::` about the use of this operator.
    ```

# testthat

Version: 2.0.0

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/test-catch.R’ failed.
    Last 13 lines of output:
      Calls: local ... with_rprofile_user -> with_envvar -> force -> force -> i.p
      In addition: Warning messages:
      1: 'devtools::create' is deprecated.
      Use 'usethis::create_package()' instead.
      See help("Deprecated") and help("devtools-deprecated"). 
      2: 'setup' is deprecated.
      Use 'usethis::create_package()' instead.
      See help("Deprecated") and help("devtools-deprecated"). 
      3: 'create_description' is deprecated.
      Use 'usethis::use_description()' instead.
      See help("Deprecated") and help("devtools-deprecated"). 
      4: 'use_rstudio' is deprecated.
      Use 'usethis::use_rstudio()' instead.
      See help("Deprecated") and help("devtools-deprecated"). 
      Execution halted
    ```

# texmex

Version: 2.4

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.1Mb
      sub-directories of 1Mb or more:
        R     1.6Mb
        doc   3.2Mb
    ```

# timetk

Version: 0.1.1.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘devtools’ ‘forecast’
      All declared Imports should be used.
    ```

# tosca

Version: 0.1-2

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.8Mb
      sub-directories of 1Mb or more:
        data   4.7Mb
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 1946 marked UTF-8 strings
    ```

# toxplot

Version: 0.1.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘tidyr’
      All declared Imports should be used.
    ```

# twoddpcr

Version: 1.4.1

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  6.4Mb
      sub-directories of 1Mb or more:
        data   1.2Mb
        doc    4.1Mb
    ```

# UKgrid

Version: 0.1.0

## In both

*   checking installed package size ... NOTE
    ```
      installed size is 12.0Mb
      sub-directories of 1Mb or more:
        data   3.6Mb
        doc    8.3Mb
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘rlang’
      All declared Imports should be used.
    ```

# umx

Version: 2.8.0

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.4Mb
      sub-directories of 1Mb or more:
        R      2.9Mb
        help   2.2Mb
    ```

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘sem’
    ```

# unitizer

Version: 1.4.5

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/runtt.R’ failed.
    Last 13 lines of output:
      +   warning("Cannot run tests without `testthat` available")
      + }
      Loading required package: testthat
      State tracking is disabled by default to comply with CRAN policies. Add `options(unitizer.state='recommended')` to your 'Rprofile' file to enable, or `options(unitizer.state='off')` to quash this message without enabling.  See `?unitizerState` for details.
      setup packages
      Error in i.p(...) : 
        (converted from warning) installation of package '/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T//Rtmp4lhiBZ/file1352dfa6605/unitizerdummypkg1_0.1.tar.gz' had non-zero exit status
      Error in eval(quote({ : install error
      Calls: source ... local -> eval.parent -> eval -> eval -> eval -> eval
      Removing packages from '.../revdep/checks.noindex/unitizer/new/unitizer.Rcheck'
      (as 'lib' is unspecified)
      Error in find.package(pkgs, lib) : 
        there are no packages called 'unitizerdummypkg1', 'unitizerdummypkg2', 'utzflm'
      Calls: source ... local -> eval.parent -> eval -> eval -> eval -> eval
      Execution halted
    ```

# unvotes

Version: 0.2.0

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 4494 marked UTF-8 strings
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

Version: 0.1.3

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 124 marked UTF-8 strings
    ```

# Wats

Version: 0.10.3

## In both

*   checking installed package size ... NOTE
    ```
      installed size is 12.4Mb
      sub-directories of 1Mb or more:
        doc  12.1Mb
    ```

# weathercan

Version: 0.2.7

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 25 marked UTF-8 strings
    ```

# workflowr

Version: 1.1.1

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      remotes["origin"] == "https://github.com/fakename/fakerepo.git" isn't true.
      
      ── 5. Failure: wflow_git_remote can add a second remote. (@test-wflow_git_remote
      remotes["upstream"] == "https://github.com/fake2/fakerepo2.git" isn't true.
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      OK: 556 SKIPPED: 90 FAILED: 5
      1. Failure: authenticate_git can create HTTPS credentials (@test-wflow_git_push_pull.R#144) 
      2. Failure: authenticate_git can create HTTPS credentials (@test-wflow_git_push_pull.R#145) 
      3. Failure: authenticate_git can create HTTPS credentials (@test-wflow_git_push_pull.R#146) 
      4. Failure: wflow_git_remote can add a remote. (@test-wflow_git_remote.R#45) 
      5. Failure: wflow_git_remote can add a second remote. (@test-wflow_git_remote.R#52) 
      
      Error: testthat unit tests failed
      Execution halted
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

