# Setup

## Platform

|setting  |value                        |
|:--------|:----------------------------|
|version  |R version 3.2.1 (2015-06-18) |
|system   |x86_64, darwin13.4.0         |
|ui       |RStudio (0.99.601)           |
|language |(EN)                         |
|collate  |en_US.UTF-8                  |
|tz       |Europe/Zurich                |
|date     |2015-06-25                   |

## Packages

|package    |*  |version |date       |source         |
|:----------|:--|:-------|:----------|:--------------|
|curl       |   |0.9     |2015-06-19 |CRAN (R 3.2.0) |
|digest     |   |0.6.8   |2014-12-31 |CRAN (R 3.2.0) |
|evaluate   |   |0.7     |2015-04-21 |CRAN (R 3.2.0) |
|git2r      |   |0.10.1  |2015-05-07 |CRAN (R 3.2.0) |
|httr       |   |0.6.1   |2015-01-01 |CRAN (R 3.2.0) |
|jsonlite   |   |0.9.16  |2015-04-11 |CRAN (R 3.2.0) |
|knitr      |   |1.10.5  |2015-05-06 |CRAN (R 3.2.0) |
|lintr      |   |0.2.0   |2014-12-01 |CRAN (R 3.2.0) |
|memoise    |   |0.2.1   |2014-04-22 |CRAN (R 3.2.0) |
|Rcpp       |   |0.11.6  |2015-05-01 |CRAN (R 3.2.0) |
|rmarkdown  |   |0.7     |2015-06-13 |CRAN (R 3.2.0) |
|roxygen2   |   |4.1.1   |2015-04-15 |CRAN (R 3.2.0) |
|rstudioapi |   |0.3.1   |2015-04-07 |CRAN (R 3.2.0) |
|rversions  |   |1.0.1   |2015-06-06 |CRAN (R 3.2.0) |
|testthat   |*  |0.10.0  |2015-05-22 |CRAN (R 3.2.0) |
|whisker    |   |0.3-2   |2013-04-28 |CRAN (R 3.2.0) |

# Check results
32 checked out of 34 dependencies 

## aRxiv (0.5.10)
Maintainer: Karl Broman <kbroman@biostat.wisc.edu>  
Bug reports: https://github.com/ropensci/aRxiv/issues

__OK__

## assertive (0.2-6)
Maintainer: Richard Cotton <richierocks@gmail.com>

__OK__

## bisectr (0.1.0)
Maintainer: Winston Chang <winston@stdout.org>

__OK__

## broman (0.55-2)
Maintainer: Karl W Broman <kbroman@biostat.wisc.edu>

```
checking R code for possible problems ... NOTE
Found the following calls to attach():
File ‘broman/R/loadfile.R’:
  attach(file)
See section ‘Good practice’ in ‘?attach’.
```
```
DONE
Status: 1 NOTE
```

## covr (1.0.0)
Maintainer: Jim Hester <james.f.hester@gmail.com>

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

## DataCombine (0.2.9)
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

## gender (0.4.3)
Maintainer: Lincoln Mullen <lincoln@lincolnmullen.com>  
Bug reports: https://github.com/ropensci/gender/issues

__OK__

## h2o (3.0.0.22)
Maintainer: Tom Kraljevic <tomk@0xdata.com>

```
checking installed package size ... NOTE
  installed size is 45.2Mb
  sub-directories of 1Mb or more:
    java  44.3Mb
```
```
DONE
Status: 1 NOTE
```

## icd9 (1.2)
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

## likert (1.2)
Maintainer: Jason Bryer <jason@bryer.org>  
Bug reports: https://github.com/jbryer/likert/issues

```
checking DESCRIPTION meta-information ... NOTE
Malformed Description field: should contain one or more complete sentences.
```
```
checking dependencies in R code ... NOTE
'library' or 'require' call to ‘shiny’ in package code.
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
```
```
checking data for non-ASCII characters ... NOTE
  Note: found 7 marked UTF-8 strings
```
```
DONE
Status: 3 NOTEs
```

## metacom (1.4.3)
Maintainer: Tad Dallas <tdallas@uga.edu>

__OK__

## metafolio (0.1.0)
Maintainer: Sean C. Anderson <sean@seananderson.ca>  
Bug reports: http://github.com/seananderson/metafolio/issues

```
checking whether package ‘metafolio’ can be installed ... ERROR
Installation failed.
See ‘/private/tmp/Rtmp9Gfxhv/check_cran4018202f649d/metafolio.Rcheck/00install.out’ for details.
```
```
DONE
Status: 1 ERROR
```

## myTAI (0.1.0)
Maintainer: Hajk-Georg Drost <hajk-georg.drost@informatik.uni-halle.de>  
Bug reports: https://github.com/HajkD/myTAI/issues

__OK__

## NlsyLinks (1.302)
Maintainer: Will Beasley <wibeasley@hotmail.com>

```
checking DESCRIPTION meta-information ... NOTE
Malformed Title field: should not end in a period.
Malformed Description field: should contain one or more complete sentences.
```
```
checking dependencies in R code ... NOTE
Namespace in Imports field not imported from: ‘methods’
  All declared Imports should be used.
```
```
checking R code for possible problems ... NOTE
ReadCsvNlsy79Gen1: no visible binding for global variable
  ‘SubjectDetails79’
ReadCsvNlsy79Gen2: no visible binding for global variable
  ‘SubjectDetails79’
```
```
DONE
Status: 3 NOTEs
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
checking R code for possible problems ... NOTE
.wrapResult: no visible global function definition for ‘exprs’
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
Status: 1 ERROR, 5 NOTEs
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

## opencpu (1.4.6)
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

## packrat (0.4.4)
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
```
```
DONE
Status: 3 NOTEs
```

## PSAboot (1.1)
Maintainer: Jason Bryer <jason@bryer.org>  
Bug reports: https://github.com/jbryer/PSAboot/issues

```
checking dependencies in R code ... NOTE
'library' or 'require' call to ‘ggthemes’ in package code.
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
```
```
checking R code for possible problems ... NOTE
boxplot.PSAboot: no visible global function definition for
  ‘geom_tufteboxplot’
```
```
checking data for non-ASCII characters ... NOTE
  Note: found 4 marked UTF-8 strings
```
```
DONE
Status: 3 NOTEs
```

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

## rclinicaltrials (1.4.1)
Maintainer: Michael C Sachs <sachsmc@gmail.com>

__OK__

## readODS (1.4)
Maintainer: Gerrit-Jan Schutten <phonixor@gmail.com>

__OK__

## REDCapR (0.7-1)
Maintainer: Will Beasley <wibeasley@hotmail.com>

```
checking package dependencies ... NOTE
Package suggested but not available for checking: ‘RODBC’
```
```
checking dependencies in R code ... NOTE
'library' or 'require' calls in package code:
  ‘RODBC’ ‘testthat’
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
```
```
DONE
Status: 2 NOTEs
```

## smss (1.0-1)
Maintainer: Jeffrey B. Arnold <jeffrey.arnold@gmail.com>

__OK__

## testthat (0.10.0)
Maintainer: Hadley Wickham <hadley@rstudio.com>  
Bug reports: https://github.com/hadley/testthat/issues

__OK__

## Wats (0.2-16)
Maintainer: Will Beasley <wibeasley@hotmail.com>

```
checking DESCRIPTION meta-information ... NOTE
Malformed Description field: should contain one or more complete sentences.
```
```
DONE
Status: 1 NOTE
```

## wikipediatrend (1.1.4)
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

