# Setup

## Platform

|setting  |value                        |
|:--------|:----------------------------|
|version  |R version 3.2.3 (2015-12-10) |
|system   |x86_64, darwin13.4.0         |
|ui       |RStudio (0.99.875)           |
|language |(EN)                         |
|collate  |en_US.UTF-8                  |
|tz       |America/Chicago              |
|date     |2016-02-11                   |

## Packages

|package    |*  |version     |date       |source                            |
|:----------|:--|:-----------|:----------|:---------------------------------|
|bitops     |   |1.0-6       |2013-08-17 |CRAN (R 3.2.0)                    |
|covr       |   |1.2.0       |2015-06-25 |CRAN (R 3.2.0)                    |
|crayon     |   |1.3.1       |2015-07-13 |CRAN (R 3.2.0)                    |
|curl       |   |0.9.5       |2016-01-23 |CRAN (R 3.2.3)                    |
|devtools   |*  |1.10.0.9000 |2016-02-11 |local (hadley/devtools)           |
|digest     |   |0.6.9       |2016-01-08 |CRAN (R 3.2.3)                    |
|evaluate   |   |0.8         |2015-09-18 |CRAN (R 3.2.0)                    |
|git2r      |   |0.13.1      |2015-12-10 |CRAN (R 3.2.3)                    |
|gmailr     |   |0.7.0.9000  |2016-02-11 |Github (jimhester/gmailr@5ae820f) |
|httr       |   |1.1.0       |2016-01-28 |CRAN (R 3.2.3)                    |
|jsonlite   |   |0.9.19      |2015-11-28 |CRAN (R 3.2.2)                    |
|knitr      |   |1.12.3      |2016-01-22 |CRAN (R 3.2.3)                    |
|lintr      |   |0.3.3       |2015-09-15 |CRAN (R 3.2.0)                    |
|memoise    |   |1.0.0       |2016-01-29 |CRAN (R 3.2.3)                    |
|Rcpp       |   |0.12.3      |2016-01-10 |CRAN (R 3.2.3)                    |
|rmarkdown  |   |0.9.2       |2016-01-01 |CRAN (R 3.2.3)                    |
|roxygen2   |   |5.0.1       |2015-11-11 |CRAN (R 3.2.2)                    |
|rstudioapi |   |0.5         |2016-01-24 |CRAN (R 3.2.3)                    |
|testthat   |*  |0.11.0      |2015-10-14 |CRAN (R 3.2.0)                    |
|whisker    |   |0.3-2       |2013-04-28 |CRAN (R 3.2.0)                    |
|withr      |   |1.0.1       |2016-02-04 |CRAN (R 3.2.3)                    |

# Check results
4 packages with problems

## demi (1.1.2)
Maintainer: Sten Ilmjarv <sten.ilmjarv@gmail.com>

1 error  | 0 warnings | 0 notes

```
checking package dependencies ... ERROR
Packages required but not available: ‘affxparser’ ‘affy’ ‘oligo’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## myTAI (0.3.0)
Maintainer: Hajk-Georg Drost <hajk-georg.drost@informatik.uni-halle.de>  
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

1 error  | 1 warning  | 5 notes

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

checking whether package ‘NMF’ can be installed ... WARNING
Found the following significant warnings:
  Warning: replacing previous import by ‘ggplot2::unit’ when loading ‘NMF’
  Warning: replacing previous import by ‘ggplot2::arrow’ when loading ‘NMF’
See ‘/Users/hadley/Documents/devtools/devtools/revdep/checks/NMF.Rcheck/00install.out’ for details.

checking package dependencies ... NOTE
Packages suggested but not available for checking:
  ‘RcppOctave’ ‘doMPI’ ‘Biobase’

checking R code for possible problems ... NOTE
.wrapResult: no visible global function definition for ‘exprs’
algorithm,NMFStrategyOctave : .local: no visible global function
  definition for ‘fstop’
evar,ANY : .local: no visible binding for global variable ‘Biobase’
nmf,matrix-numeric-NMFStrategy : .local : run.all: no visible binding
  for global variable ‘n’
nmf,matrix-numeric-NMFStrategy : .local : run.all: no visible binding
  for global variable ‘RNGobj’
nmfModel,formula-ANY : .local : merge_pdata: no visible global function
  definition for ‘pData’
nmfModel,formula-ANY : .local: no visible global function definition
  for ‘exprs’
rss,matrix : .local: no visible binding for global variable ‘Biobase’

checking Rd cross-references ... NOTE
Packages unavailable to check Rd xrefs: ‘RcppOctave’, ‘Biobase’

checking data for non-ASCII characters ... NOTE
  Error in .requirePackage(package) : 
    unable to find required package 'Biobase'
  Calls: <Anonymous> ... .extendsForS3 -> extends -> getClassDef -> .requirePackage
  Execution halted

checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Quitting from lines 385-398 (NMF-vignette.Rnw) 
Error: processing vignette 'NMF-vignette.Rnw' failed with diagnostics:
unable to find required package 'Biobase'
Execution halted

```

## plotly (2.0.16)
Maintainer: Carson Sievert <cpsievert1@gmail.com>  
Bug reports: https://github.com/ropensci/plotly/issues

1 error  | 0 warnings | 0 notes

```
checking tests ... ERROR
Running the tests in ‘tests/testthat.R’ failed.
Last 13 lines of output:
  [1] "Running test: histogram-density"
  [1] "Running test: histogram-fill"
  [1] "Running test: histogram-fixed-fill-color"
  [1] "Running test: histogram-density-binwidth"
  [1] "Running test: histogram-fill-factor"
  [1] "Running test: histogram-fill-factor-identity"
  [1] "Running test: histogram-fill-factor-dodge"
  [1] "Running test: histogram-fill-factor-facets"
  [1] "Running test: histogram-vline"
  [1] "Running test: histogram-dates"
  
  There were 50 or more warnings (use warnings() to see the first 50)
  Execution halted
```

