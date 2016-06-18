# Setup

## Platform

|setting  |value                        |
|:--------|:----------------------------|
|version  |R version 3.3.0 (2016-05-03) |
|system   |x86_64, darwin13.4.0         |
|ui       |X11                          |
|language |(EN)                         |
|collate  |en_US.UTF-8                  |
|tz       |America/Chicago              |
|date     |2016-06-17                   |

## Packages

|package    |*  |version     |date       |source                           |
|:----------|:--|:-----------|:----------|:--------------------------------|
|bitops     |   |1.0-6       |2013-08-17 |CRAN (R 3.3.0)                   |
|covr       |   |2.0.1       |2016-04-06 |CRAN (R 3.3.0)                   |
|crayon     |   |1.3.1       |2015-07-13 |CRAN (R 3.3.0)                   |
|curl       |   |0.9.7       |2016-04-10 |CRAN (R 3.3.0)                   |
|devtools   |*  |1.11.1.9000 |2016-06-17 |local (hadley/devtools@aaa4b61)  |
|digest     |   |0.6.9       |2016-01-08 |CRAN (R 3.3.0)                   |
|evaluate   |   |0.9         |2016-04-29 |CRAN (R 3.3.0)                   |
|git2r      |   |0.15.0      |2016-05-11 |CRAN (R 3.3.0)                   |
|gmailr     |   |0.7.1       |2016-04-12 |CRAN (R 3.3.0)                   |
|httr       |   |1.2.0       |2016-06-15 |cran (@1.2.0)                    |
|hunspell   |   |1.2         |2016-03-19 |CRAN (R 3.3.0)                   |
|jsonlite   |   |0.9.22      |2016-06-15 |cran (@0.9.22)                   |
|knitr      |   |1.13        |2016-05-09 |CRAN (R 3.3.0)                   |
|lintr      |   |1.0.0       |2016-04-16 |CRAN (R 3.3.0)                   |
|memoise    |   |1.0.0       |2016-01-29 |CRAN (R 3.3.0)                   |
|Rcpp       |   |0.12.5      |2016-05-14 |CRAN (R 3.3.0)                   |
|rmarkdown  |   |0.9.6       |2016-05-01 |CRAN (R 3.3.0)                   |
|roxygen2   |   |5.0.1       |2015-11-11 |CRAN (R 3.3.0)                   |
|rstudioapi |   |0.5         |2016-01-24 |CRAN (R 3.3.0)                   |
|rversions  |   |1.0.2       |2015-07-13 |CRAN (R 3.3.0)                   |
|testthat   |*  |1.0.2.9000  |2016-06-16 |Github (hadley/testthat@d3e20b9) |
|whisker    |   |0.3-2       |2013-04-28 |CRAN (R 3.3.0)                   |
|withr      |   |1.0.1       |2016-02-04 |CRAN (R 3.3.0)                   |

# Check results
7 packages with problems

## biomartr (0.0.3)
Maintainer: Hajk-Georg Drost <hgd23@cam.ac.uk>  
Bug reports: https://github.com/HajkD/biomartr/issues

1 error  | 0 warnings | 0 notes

```
checking package dependencies ... ERROR
Packages required but not available: ‘biomaRt’ ‘Biostrings’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## demi (1.1.2)
Maintainer: Sten Ilmjarv <sten.ilmjarv@gmail.com>

1 error  | 0 warnings | 0 notes

```
checking package dependencies ... ERROR
Packages required but not available: ‘affxparser’ ‘affy’ ‘oligo’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## gsrc (1.0.1)
Maintainer: Fabian Grandke <grafabian@gmail.com>  
Bug reports: http://github.com/grafab/gsrc/issues

1 error  | 0 warnings | 0 notes

```
checking package dependencies ... ERROR
Packages required but not available: ‘illuminaio’ ‘limma’ ‘preprocessCore’

Packages suggested but not available for checking: ‘DNAcopy’ ‘brassicaData’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## myTAI (0.4.0)
Maintainer: Hajk-Georg Drost <hgd23@cam.ac.uk>  
Bug reports: https://github.com/HajkD/myTAI/issues

1 error  | 0 warnings | 0 notes

```
checking package dependencies ... ERROR
Package required but not available: ‘edgeR’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## NMF (0.20.6)
Maintainer: Renaud Gaujoux <renaud@tx.technion.ac.il>  
Bug reports: http://github.com/renozao/NMF/issues

1 error  | 1 warning  | 4 notes

```
checking examples ... ERROR
Running examples in ‘NMF-Ex.R’ failed
The error most likely occurred in:

> base::assign(".ptime", proc.time(), pos = "CheckExEnv")
> ### Name: nmfModel
> ### Title: Factory Methods NMF Models
> ### Aliases: nmfModel nmfModel,data.frame,data.frame-method
> ###   nmfModel,formula,ANY-method nmfModel,matrix,ANY-method
> ###   nmfModel,matrix,matrix-method nmfModel-methods
... 222 lines ...
features: 20 
basis/rank: 6 
samples: 10 
fixed coef [3]:
  gr = <1, 2>
  b = 0.0101301828399301, 0.21454192395322, ..., 0.767450851621106
> 
> # 3-rank model that fits a given ExpressionSet (with fixed coef terms)
> e <- ExpressionSet(x)
Error: could not find function "ExpressionSet"
Execution halted

checking re-building of vignette outputs ... WARNING
Error in re-building vignettes:
  ...
Quitting from lines 385-398 (NMF-vignette.Rnw) 
Error: processing vignette 'NMF-vignette.Rnw' failed with diagnostics:
unable to find required package 'Biobase'
Execution halted


checking package dependencies ... NOTE
Packages suggested but not available for checking:
  ‘RcppOctave’ ‘doMPI’ ‘Biobase’

checking R code for possible problems ... NOTE
.wrapResult: no visible global function definition for ‘exprs’
algorithm,NMFStrategyOctave: no visible global function definition for
  ‘fstop’
evar,ANY: no visible binding for global variable ‘Biobase’
nmf,matrix-numeric-NMFStrategy : run.all: no visible binding for global
  variable ‘n’
nmf,matrix-numeric-NMFStrategy : run.all: no visible binding for global
  variable ‘RNGobj’
nmfModel,formula-ANY : merge_pdata: no visible global function
  definition for ‘pData’
nmfModel,formula-ANY: no visible global function definition for ‘exprs’
rss,matrix: no visible binding for global variable ‘Biobase’
Undefined global functions or variables:
  Biobase RNGobj exprs fstop n pData

checking Rd cross-references ... NOTE
Packages unavailable to check Rd xrefs: ‘RcppOctave’, ‘Biobase’

checking data for non-ASCII characters ... NOTE
  Error in .requirePackage(package) : 
    unable to find required package 'Biobase'
  Calls: <Anonymous> ... .extendsForS3 -> extends -> getClassDef -> .requirePackage
  Execution halted
```

## REDCapR (0.9.3)
Maintainer: Will Beasley <wibeasley@hotmail.com>  
Bug reports: https://github.com/OuhscBbmc/REDCapR/issues

1 error  | 0 warnings | 1 note 

```
checking tests ... ERROR
Running the tests in ‘tests/test-all.R’ failed.
Last 13 lines of output:
  returned_object$outcome_messages does not match "The initial call failed with the code: 411.".
  Actual value: "The initial call failed with the code: 501."
  
  
  testthat results ================================================================
  OK: 55 SKIPPED: 43 FAILED: 4
  1. Failure: One Shot: Bad Uri -Not HTTPS (@test-read_errors.R#21) 
  2. Failure: One Shot: Bad Uri -Not HTTPS (@test-read_errors.R#23) 
  3. Failure: Batch: Bad Uri -Not HTTPS (@test-read_errors.R#59) 
  4. Failure: Batch: Bad Uri -Not HTTPS (@test-read_errors.R#63) 
  
  Error: testthat unit tests failed
  Execution halted

checking package dependencies ... NOTE
Package suggested but not available for checking: ‘RODBC’
```

## Ryacas (0.3-1)
Maintainer: G. Grothendieck <ggrothendieck@gmail.com>  
Bug reports: https://github.com/ggrothendieck/ryacas/issues

0 errors | 1 warning  | 0 notes

```
checking whether package ‘Ryacas’ can be installed ... WARNING
Found the following significant warnings:
  yacas/include/yacas/utf8/core.h:309:55: warning: multiple unsequenced modifications to 'it' [-Wunsequenced]
  yacas/include/yacas/utf8/core.h:320:39: warning: multiple unsequenced modifications to 'it' [-Wunsequenced]
See ‘/Users/hadley/Documents/devtools/devtools/revdep/checks/Ryacas.Rcheck/00install.out’ for details.
```

