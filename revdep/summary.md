# Setup

## Platform

|setting  |value                        |
|:--------|:----------------------------|
|version  |R version 3.2.2 (2015-08-14) |
|system   |x86_64, darwin13.4.0         |
|ui       |RStudio (0.99.863)           |
|language |(EN)                         |
|collate  |en_US.UTF-8                  |
|tz       |America/Chicago              |
|date     |2016-01-21                   |

## Packages

|package    |*  |version |date       |source         |
|:----------|:--|:-------|:----------|:--------------|
|bitops     |   |1.0-6   |2013-08-17 |CRAN (R 3.2.0) |
|curl       |   |0.9.4   |2015-11-20 |CRAN (R 3.2.2) |
|digest     |   |0.6.9   |2016-01-08 |CRAN (R 3.2.3) |
|evaluate   |   |0.8     |2015-09-18 |CRAN (R 3.2.0) |
|git2r      |   |0.13.1  |2015-12-10 |CRAN (R 3.2.3) |
|httr       |   |1.0.0   |2015-06-25 |CRAN (R 3.2.0) |
|jsonlite   |   |0.9.19  |2015-11-28 |CRAN (R 3.2.2) |
|knitr      |   |1.12    |2016-01-07 |CRAN (R 3.2.3) |
|lintr      |   |0.3.3   |2015-09-15 |CRAN (R 3.2.0) |
|memoise    |   |0.2.1   |2014-04-22 |CRAN (R 3.2.0) |
|Rcpp       |   |0.12.3  |2016-01-10 |CRAN (R 3.2.3) |
|rmarkdown  |   |0.9.2   |2016-01-01 |CRAN (R 3.2.3) |
|roxygen2   |   |5.0.1   |2015-11-11 |CRAN (R 3.2.2) |
|rstudioapi |   |0.4.0   |2015-12-09 |CRAN (R 3.2.3) |
|rversions  |   |1.0.2   |2015-07-13 |CRAN (R 3.2.0) |
|testthat   |*  |0.11.0  |2015-10-14 |CRAN (R 3.2.0) |
|whisker    |   |0.3-2   |2013-04-28 |CRAN (R 3.2.0) |
|withr      |   |1.0.0   |2015-09-23 |CRAN (R 3.2.0) |

# Check results
74 checked out of 75 dependencies 

## acmeR (1.1.0)
Maintainer: Robert Wolpert <wolpert@stat.duke.edu>

__OK__

## aRxiv (0.5.10)
Maintainer: Karl Broman <kbroman@biostat.wisc.edu>  
Bug reports: https://github.com/ropensci/aRxiv/issues

__OK__

## assertive.base (0.0-3)
Maintainer: Richard Cotton <richierocks@gmail.com>  
Bug reports: https://bitbucket.org/richierocks/assertive.base/issues

__OK__

## assertive.code (0.0-1)
Maintainer: Richard Cotton <richierocks@gmail.com>  
Bug reports: https://bitbucket.org/richierocks/assertive.code/issues

__OK__

## assertive.data (0.0-1)
Maintainer: Richard Cotton <richierocks@gmail.com>  
Bug reports: https://bitbucket.org/richierocks/assertive.data/issues

__OK__

## assertive.data.uk (0.0-1)
Maintainer: Richard Cotton <richierocks@gmail.com>  
Bug reports: https://bitbucket.org/richierocks/assertive.data.uk/issues

__OK__

## assertive.data.us (0.0-1)
Maintainer: Richard Cotton <richierocks@gmail.com>  
Bug reports: https://bitbucket.org/richierocks/assertive.data.us/issues

__OK__

## assertive.datetimes (0.0-1)
Maintainer: Richard Cotton <richierocks@gmail.com>  
Bug reports: 
        https://bitbucket.org/richierocks/assertive.datetimes/issues

__OK__

## assertive.files (0.0-1)
Maintainer: Richard Cotton <richierocks@gmail.com>  
Bug reports: https://bitbucket.org/richierocks/assertive.files/issues

__OK__

## assertive.matrices (0.0-1)
Maintainer: Richard Cotton <richierocks@gmail.com>  
Bug reports: https://bitbucket.org/richierocks/assertive.matrices/issues

__OK__

## assertive.models (0.0-1)
Maintainer: Richard Cotton <richierocks@gmail.com>  
Bug reports: https://bitbucket.org/richierocks/assertive.models/issues

__OK__

## assertive.numbers (0.0-1)
Maintainer: Richard Cotton <richierocks@gmail.com>  
Bug reports: https://bitbucket.org/richierocks/assertive.numbers/issues

__OK__

## assertive.properties (0.0-1)
Maintainer: Richard Cotton <richierocks@gmail.com>  
Bug reports: 
        https://bitbucket.org/richierocks/assertive.properties/issues

__OK__

## assertive (0.3-1)
Maintainer: Richard Cotton <richierocks@gmail.com>

__OK__

## assertive.reflection (0.0-1)
Maintainer: Richard Cotton <richierocks@gmail.com>  
Bug reports: 
        https://bitbucket.org/richierocks/assertive.reflection/issues

```
checking examples ... ERROR
Running examples in ‘assertive.reflection-Ex.R’ failed
The error most likely occurred in:

> base::assign(".ptime", proc.time(), pos = "CheckExEnv")
> ### Name: assert_is_package_current
> ### Title: Is the installed version of a package current?
> ### Aliases: assert_is_package_current is_package_current
> 
> ### ** Examples
> 
> ## No test: 
> # This test is marked "dont-test" since it involves a connection to
> # repositories which is potentially long running.
> is_package_current("assertive")
Error in installed.packages()[x, , drop = FALSE] : 
  subscript out of bounds
Calls: is_package_current
Execution halted
```
```
DONE
Status: 1 ERROR
```

## assertive.sets (0.0-1)
Maintainer: Richard Cotton <richierocks@gmail.com>  
Bug reports: https://bitbucket.org/richierocks/assertive.sets/issues

__OK__

## assertive.strings (0.0-1)
Maintainer: Richard Cotton <richierocks@gmail.com>  
Bug reports: https://bitbucket.org/richierocks/assertive.strings/issues

__OK__

## assertive.types (0.0-1)
Maintainer: Richard Cotton <richierocks@gmail.com>  
Bug reports: https://bitbucket.org/richierocks/assertive.types/issues

__OK__

## bisectr (0.1.0)
Maintainer: Winston Chang <winston@stdout.org>

__OK__

## BrailleR (0.22.0)
Maintainer: A. Jonathan R. Godfrey <a.j.godfrey@massey.ac.nz>

```
checking whether package ‘BrailleR’ can be installed ... WARNING
Found the following significant warnings:
  Warning: package ‘knitr’ was built under R version 3.2.3
See ‘/private/tmp/RtmptM0N0n/check_cran8960201aed55/BrailleR.Rcheck/00install.out’ for details.
```
```
DONE
Status: 1 WARNING
```

## broman (0.62-1)
Maintainer: Karl W Broman <kbroman@biostat.wisc.edu>

__OK__

## codyn (1.0.1)
Maintainer: Matthew B. Jones <jones@nceas.ucsb.edu>  
Bug reports: https://github.com/laurenmh/codyn/issues

__OK__

## covr (1.2.0)
Maintainer: Jim Hester <james.f.hester@gmail.com>  
Bug reports: https://github.com/jimhester/covr/issues

```
checking dependencies in R code ... NOTE
There are ::: calls to the package's namespace in its code. A package
  almost never needs to use ::: for its own objects:
  ‘count’
```
```
DONE
Status: 1 NOTE
```

## creditr (0.6.1)
Maintainer: Yuanchu Dang <yuanchu.dang@gmail.com>

__OK__

## DataCombine (0.2.18)
Maintainer: Christopher Gandrud <christopher.gandrud@gmail.com>  
Bug reports: https://github.com/christophergandrud/DataCombine/issues

__OK__

## demi (1.1.2)
Maintainer: Sten Ilmjarv <sten.ilmjarv@gmail.com>

```
checking package dependencies ... ERROR
Packages required but not available: ‘affxparser’ ‘affy’ ‘oligo’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```
```
DONE
Status: 1 ERROR
```

## doRNG (1.6)
Maintainer: Renaud Gaujoux <renaud@tx.technion.ac.il>  
Bug reports: http://github.com/renozao/doRNG/issues

```
checking package dependencies ... NOTE
Package suggested but not available for checking: ‘doMPI’
```
```
checking Rd cross-references ... NOTE
Package unavailable to check Rd xrefs: ‘doMPI’
```
```
DONE
Status: 2 NOTEs
```

## dpmr (0.1.7-1)
Maintainer: Christopher Gandrud <christopher.gandrud@gmail.com>  
Bug reports: https://github.com/christophergandrud/dpmr/issues

__OK__

## eurostat (1.2.13)
Maintainer: Lahti Leo <louhos@googlegroups.com>  
Bug reports: https://github.com/ropengov/eurostat/issues

__OK__

## FedData (2.0.3)
Maintainer: R. Kyle Bocinsky <bocinsky@gmail.com>

```
checking package dependencies ... NOTE
Packages suggested but not available for checking: ‘SSOAP’ ‘XMLSchema’
```
```
DONE
Status: 1 NOTE
```

## flacco (1.1)
Maintainer: Pascal Kerschke <kerschke@uni-muenster.de>  
Bug reports: https://github.com/kerschke/flacco/issues

__OK__

## forestFloor (1.9.1)
Maintainer: Soeren Havelund Welling <SOWE@DTU.DK>

__OK__

## gitlabr (0.6.2)
Maintainer: Jirka Lewandowski <jirka.lewandowski@wzb.eu>  
Bug reports: 
        http://gitlab.points-of-interest.cc/points-of-interest/gitlabr/
        issues/

__OK__

## gmwm (1.0.0)
Maintainer: Stephane Guerrier <stephane@illinois.edu>  
Bug reports: https://github.com/SMAC-Group/gmwm/issues

```
checking whether package ‘gmwm’ can be installed ... WARNING
Found the following significant warnings:
  Warning: package ‘ggplot2’ was built under R version 3.2.3
  Warning: replacing previous import by ‘grid::arrow’ when loading ‘gmwm’
  Warning: replacing previous import by ‘grid::unit’ when loading ‘gmwm’
  Warning: replacing previous import by ‘scales::alpha’ when loading ‘gmwm’
See ‘/private/tmp/RtmptM0N0n/check_cran8960201aed55/gmwm.Rcheck/00install.out’ for details.
```
```
DONE
Status: 1 WARNING
```

## graticule (0.1.0)
Maintainer: Michael D. Sumner <mdsumner@gmail.com>  
Bug reports: https://github.com/mdsumner/graticule/issues

__OK__

## h2o (3.6.0.8)
Maintainer: Tom Kraljevic <tomk@0xdata.com>

```
checking whether package ‘h2o’ can be installed ... WARNING
Found the following significant warnings:
  Warning: package ‘statmod’ was built under R version 3.2.3
See ‘/private/tmp/RtmptM0N0n/check_cran8960201aed55/h2o.Rcheck/00install.out’ for details.
```
```
checking installed package size ... NOTE
  installed size is 48.9Mb
  sub-directories of 1Mb or more:
    java  48.0Mb
```
```
DONE
Status: 1 WARNING, 1 NOTE
```

## IalsaSynthesis (0.1.6)
Maintainer: Will Beasley <wibeasley@hotmail.com>  
Bug reports: https://github.com/IALSA/IalsaSynthesis/issues

__OK__

## icd9 (1.3)
Maintainer: Jack O. Wasey <jack@jackwasey.com>  
Bug reports: https://github.com/jackwasey/icd9/issues

```
checking data for non-ASCII characters ... NOTE
  Note: found 14 marked Latin-1 strings
  Note: found 39 marked UTF-8 strings
```
```
DONE
Status: 1 NOTE
```

## iLaplace (1.0.0)
Maintainer: Erlis Ruli <erlisr@yahoo.it>  
Bug reports: https://github.com/erlisR/iLaplace/issues

__OK__

## jiebaR (0.7)
Maintainer: Qin Wenfeng <mail@qinwenfeng.com>  
Bug reports: https://github.com/qinwf/jiebaR/issues

```
checking tests ... ERROR
Running the tests in ‘tests/testthat.R’ failed.
Last 13 lines of output:
  12: test("./CPP_API")
  13: load_all(pkg, quiet = TRUE) at /Users/hadley/Documents/devtools/devtools/R/test.r:50
  14: check_suggested("roxygen2") at /Users/hadley/Documents/devtools/devtools/R/load.r:88
  15: check_dep_version(pkg, version, compare) at /Users/hadley/Documents/devtools/devtools/R/utils.r:63
  16: stop("Dependency package ", dep_name, " not available.") at /Users/hadley/Documents/devtools/devtools/R/package-deps.r:56
  
  testthat results ================================================================
  OK: 14 SKIPPED: 0 FAILED: 2
  1. Error: C_API 
  2. Error: CPP_API 
  
  Error: testthat unit tests failed
  Execution halted
```
```
DONE
Status: 1 ERROR
```

## likert (1.3.3)
Maintainer: Jason Bryer <jason@bryer.org>  
Bug reports: https://github.com/jbryer/likert/issues

```
checking whether package ‘likert’ can be installed ... WARNING
Found the following significant warnings:
  Warning: package ‘ggplot2’ was built under R version 3.2.3
See ‘/private/tmp/RtmptM0N0n/check_cran8960201aed55/likert.Rcheck/00install.out’ for details.
```
```
checking data for non-ASCII characters ... NOTE
  Note: found 7 marked UTF-8 strings
```
```
DONE
Status: 1 WARNING, 1 NOTE
```

## lineup (0.37-6)
Maintainer: Karl W Broman <kbroman@biostat.wisc.edu>

__OK__

## manifestoR (1.1-1)
Maintainer: Jirka Lewandowski <jirka.lewandowski@wzb.eu>  
Bug reports: https://github.com/ManifestoProject/manifestoR/issues

__OK__

## metacom (1.4.3)
Maintainer: Tad Dallas <tdallas@uga.edu>

__OK__

## metafolio (0.1.0)
Maintainer: Sean C. Anderson <sean@seananderson.ca>  
Bug reports: http://github.com/seananderson/metafolio/issues

__OK__

## modules (0.2.0)
Maintainer: Sebastian Warnholz <wahani@gmail.com>  
Bug reports: https://github.com/wahani/modules/issues

__OK__

## myTAI (0.3.0)
Maintainer: Hajk-Georg Drost <hajk-georg.drost@informatik.uni-halle.de>  
Bug reports: https://github.com/HajkD/myTAI/issues

```
checking package dependencies ... ERROR
Package required but not available: ‘edgeR’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```
```
DONE
Status: 1 ERROR
```

## NlsyLinks (2.0.1)
Maintainer: Will Beasley <wibeasley@hotmail.com>  
Bug reports: https://github.com/LiveOak/NlsyLinks/issues

```
checking installed package size ... NOTE
  installed size is  6.3Mb
  sub-directories of 1Mb or more:
    data   4.3Mb
    doc    1.0Mb
```
```
DONE
Status: 1 NOTE
```

## NMF (0.20.6)
Maintainer: Renaud Gaujoux <renaud@tx.technion.ac.il>  
Bug reports: http://github.com/renozao/NMF/issues

```
checking package dependencies ... NOTE
Packages suggested but not available for checking:
  ‘RcppOctave’ ‘doMPI’ ‘Biobase’
```
```
checking whether package ‘NMF’ can be installed ... WARNING
Found the following significant warnings:
  Warning: replacing previous import by ‘ggplot2::unit’ when loading ‘NMF’
  Warning: replacing previous import by ‘ggplot2::arrow’ when loading ‘NMF’
See ‘/private/tmp/RtmptM0N0n/check_cran8960201aed55/NMF.Rcheck/00install.out’ for details.
```
```
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
```
```
checking Rd cross-references ... NOTE
Packages unavailable to check Rd xrefs: ‘RcppOctave’, ‘Biobase’
```
```
checking data for non-ASCII characters ... NOTE
  Error in .requirePackage(package) : 
    unable to find required package 'Biobase'
  Calls: <Anonymous> ... .extendsForS3 -> extends -> getClassDef -> .requirePackage
  Execution halted
```
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
> ###   nmfModel,missing,ANY-method nmfModel,missing,missing-method
> ###   nmfModel,NULL,ANY-method nmfModel,numeric,matrix-method
> ###   nmfModel,numeric,missing-method nmfModel,numeric,numeric-method
> ###   nmfModels
> ### Keywords: methods
> 
> ### ** Examples
> 
> ## Don't show: 
> # roxygen generated flag
> options(R_CHECK_RUNNING_EXAMPLES_=TRUE)
> ## End(Don't show)
> 
> #----------
> # nmfModel,numeric,numeric-method
> #----------
> # data
> n <- 20; r <- 3; p <- 10
> V <- rmatrix(n, p) # some target matrix
> 
> # create a r-ranked NMF model with a given target dimensions n x p as a 2-length vector
> nmfModel(r, c(n,p)) # directly
<Object of class:NMFstd>
features: 20 
basis/rank: 3 
samples: 10 
> nmfModel(r, dim(V)) # or from an existing matrix <=> nmfModel(r, V)
<Object of class:NMFstd>
features: 20 
basis/rank: 3 
samples: 10 
> # or alternatively passing each dimension separately
> nmfModel(r, n, p)
<Object of class:NMFstd>
features: 20 
basis/rank: 3 
samples: 10 
> 
> # trying to create a NMF object based on incompatible matrices generates an error
> w <- rmatrix(n, r)
> h <- rmatrix(r+1, p)
> try( new('NMFstd', W=w, H=h) )
Error in validObject(.Object) : 
  invalid class “NMFstd” object: Dimensions of W and H are not compatible [ncol(W)= 3 != nrow(H)= 4 ]
> try( nmfModel(w, h) )
Error in .local(rank, target, ...) : 
  nmfModel - Invalid number of columns in the basis matrix [3]: it should match the number of rows in the mixture coefficient matrix [4]
> try( nmfModel(r+1, W=w, H=h) )
Error in .local(rank, target, ...) : 
  nmfModel - Objective rank [4] is greater than the number of columns in W [3]
> # The factory method can be force the model to match some target dimensions
> # but warnings are thrown
> nmfModel(r, W=w, H=h)
Warning in .local(rank, target, ...) :
  nmfModel - Objective rank [3] is lower than the number of rows in H [4]: only the first 3 rows of H  will be used
<Object of class:NMFstd>
features: 20 
basis/rank: 3 
samples: 10 
> nmfModel(r, n-1, W=w, H=h)
Warning in .local(rank, target, ...) :
  nmfModel - Number of rows in target is lower than the number of rows in W [20]: only the first 19 rows of W will be used
Warning in .local(rank, target, ...) :
  nmfModel - Objective rank [3] is lower than the number of rows in H [4]: only the first 3 rows of H  will be used
<Object of class:NMFstd>
features: 19 
basis/rank: 3 
samples: 10 
> 
> #----------
> # nmfModel,numeric,missing-method
> #----------
> ## Empty model of given rank
> nmfModel(3)
<Object of class:NMFstd>
features: 0 
basis/rank: 3 
samples: 0 
> 
> #----------
> # nmfModel,missing,ANY-method
> #----------
> nmfModel(target=10) #square
<Object of class:NMFstd>
features: 10 
basis/rank: 0 
samples: 10 
> nmfModel(target=c(10, 5))
<Object of class:NMFstd>
features: 10 
basis/rank: 0 
samples: 5 
> 
> #----------
> # nmfModel,missing,missing-method
> #----------
> # Build an empty NMF model
> nmfModel()
<Object of class:NMFstd>
features: 0 
basis/rank: 0 
samples: 0 
> 
> # create a NMF object based on one random matrix: the missing matrix is deduced
> # Note this only works when using factory method NMF
> n <- 50; r <- 3;
> w <- rmatrix(n, r)
> nmfModel(W=w)
<Object of class:NMFstd>
features: 50 
basis/rank: 3 
samples: 0 
> 
> # create a NMF object based on random (compatible) matrices
> p <- 20
> h <- rmatrix(r, p)
> nmfModel(H=h)
<Object of class:NMFstd>
features: 0 
basis/rank: 3 
samples: 20 
> 
> # specifies two compatible matrices
> nmfModel(W=w, H=h)
<Object of class:NMFstd>
features: 50 
basis/rank: 3 
samples: 20 
> # error if not compatible
> try( nmfModel(W=w, H=h[-1,]) )
Error in .local(rank, target, ...) : 
  nmfModel - Invalid number of columns in the basis matrix [3]: it should match the number of rows in the mixture coefficient matrix [2]
> 
> #----------
> # nmfModel,numeric,matrix-method
> #----------
> # create a r-ranked NMF model compatible with a given target matrix
> obj <- nmfModel(r, V)
> all(is.na(basis(obj)))
[1] TRUE
> 
> #----------
> # nmfModel,matrix,matrix-method
> #----------
> ## From two existing factors
> 
> # allows a convenient call without argument names
> w <- rmatrix(n, 3); h <- rmatrix(3, p)
> nmfModel(w, h)
<Object of class:NMFstd>
features: 50 
basis/rank: 3 
samples: 20 
> 
> # Specify the type of NMF model (e.g. 'NMFns' for non-smooth NMF)
> mod <- nmfModel(w, h, model='NMFns')
> mod
<Object of class:NMFns>
features: 50 
basis/rank: 3 
samples: 20 
theta: 0.5 
> 
> # One can use such an NMF model as a seed when fitting a target matrix with nmf()
> V <- rmatrix(mod)
> res <- nmf(V, mod)
> nmf.equal(res, nmf(V, mod))
[1] TRUE
> 
> # NB: when called only with such a seed, the rank and the NMF algorithm
> # are selected based on the input NMF model.
> # e.g. here rank was 3 and the algorithm "nsNMF" is used, because it is the default
> # algorithm to fit "NMFns" models (See ?nmf).
> 
> #----------
> # nmfModel,matrix,ANY-method
> #----------
> ## swapped arguments `rank` and `target`
> V <- rmatrix(20, 10)
> nmfModel(V) # equivalent to nmfModel(target=V)
<Object of class:NMFstd>
features: 20 
basis/rank: 0 
samples: 10 
> nmfModel(V, 3) # equivalent to nmfModel(3, V)
<Object of class:NMFstd>
features: 20 
basis/rank: 3 
samples: 10 
> 
> #----------
> # nmfModel,formula,ANY-method
> #----------
> # empty 3-rank model
> nmfModel(~ 3)
<Object of class:NMFstd>
features: 0 
basis/rank: 3 
samples: 0 
> 
> # 3-rank model that fits a given data matrix
> x <- rmatrix(20,10)
> nmfModel(x ~ 3)
<Object of class:NMFstd>
features: 20 
basis/rank: 3 
samples: 10 
> 
> # add fixed coefficient term defined by a factor
> gr <- gl(2, 5)
> nmfModel(x ~ 3 + gr)
<Object of class:NMFstd>
features: 20 
basis/rank: 5 
samples: 10 
fixed coef [2]:
  gr = <1, 2>
> 
> # add fixed coefficient term defined by a numeric covariate
> nmfModel(x ~ 3 + gr + b, data=list(b=runif(10)))
<Object of class:NMFstd>
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
```
```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Quitting from lines 385-398 (NMF-vignette.Rnw) 
Error: processing vignette 'NMF-vignette.Rnw' failed with diagnostics:
unable to find required package 'Biobase'
Execution halted

```
```
DONE
Status: 1 ERROR, 1 WARNING, 5 NOTEs
```

## npsm (0.5)
Maintainer: John Kloke <kloke@biostat.wisc.edu>

```
checking S3 generic/method consistency ... NOTE
Found the following apparent S3 methods exported but not registered:
  print.fkk.test print.hogg.test print.rank.test
See section ‘Registering S3 methods’ in the ‘Writing R Extensions’
manual.
```
```
DONE
Status: 1 NOTE
```

## opencpu (1.5.1)
Maintainer: Jeroen Ooms <jeroen.ooms@stat.ucla.edu>  
Bug reports: https://github.com/jeroenooms/opencpu/issues

```
checking package dependencies ... NOTE
Package suggested but not available for checking: ‘RAppArmor’
```
```
DONE
Status: 1 NOTE
```

## packrat (0.4.6-1)
Maintainer: Kevin Ushey <kevin@rstudio.com>  
Bug reports: https://github.com/rstudio/packrat/issues

```
checking package dependencies ... NOTE
Package which this enhances but not available for checking: ‘BiocInstaller’
```
```
DONE
Status: 1 NOTE
```

## pacman (0.3.0)
Maintainer: Tyler Rinker <tyler.rinker@gmail.com>  
Bug reports: https://github.com/trinker/pacman/issues?state=open

__OK__

## Perc (0.1.1)
Maintainer: Jian Jin <jinjian.pku@gmail.com>

__OK__

## pkgmaker (0.22)
Maintainer: Renaud Gaujoux <renaud@tx.technion.ac.il>  
Bug reports: http://github.com/renozao/pkgmaker/issues

```
checking package dependencies ... NOTE
Package suggested but not available for checking: ‘ReportingTools’
```
```
checking dependencies in R code ... NOTE
'library' or 'require' calls in package code:
  ‘argparse’ ‘devtools’ ‘knitr’
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
```
```
checking R code for possible problems ... NOTE
.existsTestLogger: no visible binding for global variable ‘.testLogger’
CLIArgumentParser: no visible global function definition for
  ‘ArgumentParser’
CLIArgumentParser: no visible global function definition for ‘proto’
chunkOutputHook : <anonymous> : <anonymous>: no visible binding for
  global variable ‘knit_hooks’
cite_pkg: no visible global function definition for ‘read.bib’
hook_backspace : <anonymous>: no visible binding for global variable
  ‘knit_hooks’
knit_ex: no visible global function definition for ‘knit2html’
knit_ex: no visible global function definition for ‘knit’
latex_bibliography: no visible binding for global variable ‘knit_hooks’
makeUnitVignette: no visible global function definition for ‘getErrors’
runVignette.rnw_knitr: no visible binding for global variable
  ‘opts_chunk’
runVignette.rnw_knitr: no visible global function definition for
  ‘knit2pdf’
runVignette.rnw_knitr: no visible global function definition for ‘knit’
write_PACKAGES_index: no visible global function definition for
  ‘HTMLReport’
write_PACKAGES_index : linkPackage: no visible global function
  definition for ‘hwrite’
write_PACKAGES_index: no visible global function definition for
  ‘publish’
write_PACKAGES_index: no visible global function definition for
  ‘knit2html’
write_PACKAGES_index: no visible global function definition for
  ‘finish’
utest,RUnitTestSuite : .local: no visible global function definition
  for ‘runTestSuite’
utest,RUnitTestSuite : .local: no visible global function definition
  for ‘printTextProtocol’
utest,RUnitTestSuite : .local: no visible global function definition
  for ‘printHTMLProtocol’
utest,RUnitTestSuite : .local: no visible global function definition
  for ‘getErrors’
utest,character : .local: no visible binding for global variable
  ‘devtools’
utest,character : .local: no visible global function definition for
  ‘is.package’
utest,character : .local: no visible global function definition for
  ‘load_all’
utest,character : .local: no visible global function definition for
  ‘defineTestSuite’
utest,character : .local: no visible global function definition for
  ‘test_dir’
utest,character : .local: no visible global function definition for
  ‘runTestFile’
utest,character : .local: no visible global function definition for
  ‘test_file’
```
```
DONE
Status: 3 NOTEs
```

## plotly (2.0.16)
Maintainer: Carson Sievert <cpsievert1@gmail.com>  
Bug reports: https://github.com/ropensci/plotly/issues

```
checking whether package ‘plotly’ can be installed ... WARNING
Found the following significant warnings:
  Warning: package ‘ggplot2’ was built under R version 3.2.3
See ‘/private/tmp/RtmptM0N0n/check_cran8960201aed55/plotly.Rcheck/00install.out’ for details.
```
```
DONE
Status: 1 WARNING
```

## PSAboot (1.1.3)
Maintainer: Jason Bryer <jason@bryer.org>  
Bug reports: https://github.com/jbryer/PSAboot/issues

```
checking whether package ‘PSAboot’ can be installed ... WARNING
Found the following significant warnings:
  Warning: package ‘ggplot2’ was built under R version 3.2.3
See ‘/private/tmp/RtmptM0N0n/check_cran8960201aed55/PSAboot.Rcheck/00install.out’ for details.
```
```
checking data for non-ASCII characters ... NOTE
  Note: found 4 marked UTF-8 strings
```
```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
  replace==FALSE, but there are more (weighted) control obs than treated obs.  Some control obs will not be matched.  You may want to estimate ATT instead.
Warning in Matching::Match(Y = Y, Tr = Tr, X = ps, estimand = estimand,  :
  replace==FALSE, but there are more (weighted) control obs than treated obs.  Some control obs will not be matched.  You may want to estimate ATT instead.
Warning in Matching::Match(Y = Y, Tr = Tr, X = ps, estimand = estimand,  :
  replace==FALSE, but there are more (weighted) control obs than treated obs.  Some control obs will not be matched.  You may want to estimate ATT instead.
Warning in Matching::Match(Y = Y, Tr = Tr, X = ps, estimand = estimand,  :
  replace==FALSE, but there are more (weighted) control obs than treated obs.  Some control obs will not be matched.  You may want to estimate ATT instead.
Warning in Matching::Match(Y = Y, Tr = Tr, X = ps, estimand = estimand,  :
  replace==FALSE, but there are more (weighted) control obs than treated obs.  Some control obs will not be matched.  You may want to estimate ATT instead.
Warning in Matching::Match(Y = Y, Tr = Tr, X = ps, estimand = estimand,  :
  replace==FALSE, but there are more (weighted) control obs than treated obs.  Some control obs will not be matched.  You may want to estimate ATT instead.
Warning in Matching::Match(Y = Y, Tr = Tr, X = ps, estimand = estimand,  :
  replace==FALSE, but there are more (weighted) control obs than treated obs.  Some control obs will not be matched.  You may want to estimate ATT instead.
Warning in Matching::Match(Y = Y, Tr = Tr, X = ps, estimand = estimand,  :
  replace==FALSE, but there are more (weighted) control obs than treated obs.  Some control obs will not be matched.  You may want to estimate ATT instead.
Warning in Matching::Match(Y = Y, Tr = Tr, X = ps, estimand = estimand,  :
  replace==FALSE, but there are more (weighted) control obs than treated obs.  Some control obs will not be matched.  You may want to estimate ATT instead.
Warning in Matching::Match(Y = Y, Tr = Tr, X = ps, estimand = estimand,  :
  replace==FALSE, but there are more (weighted) control obs than treated obs.  Some control obs will not be matched.  You may want to estimate ATT instead.
Loading required package: knitr
Warning: package 'knitr' was built under R version 3.2.3
Quitting from lines 135-136 (PSAboot.Rmd) 
Error: processing vignette 'PSAboot.Rmd' failed with diagnostics:
Unknown parameters: alhpa
Execution halted

```
```
DONE
Status: 1 WARNING, 2 NOTEs
```

## qtlcharts (0.5-25)
Maintainer: Karl W Broman <kbroman@biostat.wisc.edu>

```
checking installed package size ... NOTE
  installed size is  5.5Mb
  sub-directories of 1Mb or more:
    doc           3.8Mb
    htmlwidgets   1.3Mb
```
```
DONE
Status: 1 NOTE
```

## radiomics (0.1.1)
Maintainer: Joel Carlson <jnkcarlson@gmail.com>

__OK__

## rbundler (0.3.7)
Maintainer: Yoni Ben-Meshulam <yoni.bmesh@gmail.com>

```
checking DESCRIPTION meta-information ... NOTE
Malformed Title field: should not end in a period.
```
```
checking R code for possible problems ... NOTE
install_version: no visible global function definition for
  ‘install_url’
```
```
DONE
Status: 2 NOTEs
```

## Rcereal (1.1.2)
Maintainer: Wush Wu <wush978@gmail.com>

__OK__

## rclinicaltrials (1.4.1)
Maintainer: Michael C Sachs <sachsmc@gmail.com>

__OK__

## readODS (1.4)
Maintainer: Gerrit-Jan Schutten <phonixor@gmail.com>

__OK__

## REDCapR (0.9.3)
Maintainer: Will Beasley <wibeasley@hotmail.com>  
Bug reports: https://github.com/OuhscBbmc/REDCapR/issues

```
checking package dependencies ... NOTE
Package suggested but not available for checking: ‘RODBC’
```
```
DONE
Status: 1 NOTE
```

## rfishbase (2.1.0)
Maintainer: Carl Boettiger <cboettig@ropensci.org>  
Bug reports: https://github.com/ropensci/rfishbase/issues

```
checking data for non-ASCII characters ... NOTE
  Note: found 33 marked UTF-8 strings
```
```
DONE
Status: 1 NOTE
```

## roxygen2 (5.0.1)
Maintainer: Hadley Wickham <hadley@rstudio.com>

__OK__

## rpdo (0.1.1)
Maintainer: Joe Thorley <joe@poissonconsulting.ca>

```
checking package dependencies ... NOTE
Package suggested but not available for checking: ‘datacheckr’
```
```
checking tests ... ERROR
Running the tests in ‘tests/testthat.R’ failed.
Last 13 lines of output:
  
  R is a collaborative project with many contributors.
  Type 'contributors()' for more information and
  'citation()' on how to cite R or R packages in publications.
  
  Type 'demo()' for some demos, 'help()' for on-line help, or
  'help.start()' for an HTML browser interface to help.
  Type 'q()' to quit R.
  
  > library(testthat)
  > library(datacheckr)
  Error in library(datacheckr) : there is no package called 'datacheckr'
  Execution halted
```
```
DONE
Status: 1 ERROR, 1 NOTE
```

## rpivotTable (0.1.5.7)
Maintainer: Enzo Martoglio  <enzo@smartinsightsfromdata.com>

__OK__

## satellite (0.2.0)
Maintainer: Tim Appelhans
 <admin@environmentalinformatics-marburg.de>

```
checking whether package ‘satellite’ can be installed ... WARNING
Found the following significant warnings:
  Warning: package ‘Rcpp’ was built under R version 3.2.3
See ‘/private/tmp/RtmptM0N0n/check_cran8960201aed55/satellite.Rcheck/00install.out’ for details.
```
```
DONE
Status: 1 WARNING
```

## smss (1.0-2)
Maintainer: Jeffrey B. Arnold <jeffrey.arnold@gmail.com>

__OK__

## testthat (0.11.0)
Maintainer: Hadley Wickham <hadley@rstudio.com>  
Bug reports: https://github.com/hadley/testthat/issues

__OK__

## Wats (0.10.3)
Maintainer: Will Beasley <wibeasley@hotmail.com>  
Bug reports: https://github.com/OuhscBbmc/Wats/issues

__OK__

## wikipediatrend (1.1.7)
Maintainer: Peter Meissner <retep.meissner@gmail.com>  
Bug reports: https://github.com/petermeissner/wikipediatrend/issues

```
checking package dependencies ... NOTE
Packages suggested but not available for checking:
  ‘AnomalyDetection’ ‘BreakoutDetection’
```
```
DONE
Status: 1 NOTE
```

## xoi (0.66-9)
Maintainer: Karl W Broman <kbroman@biostat.wisc.edu>

```
checking whether package ‘xoi’ can be installed ... WARNING
Found the following significant warnings:
  Warning: package ‘qtl’ was built under R version 3.2.3
See ‘/private/tmp/RtmptM0N0n/check_cran8960201aed55/xoi.Rcheck/00install.out’ for details.
```
```
DONE
Status: 1 WARNING
```

