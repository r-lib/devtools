# Setup

## Platform

|setting  |value                        |
|:--------|:----------------------------|
|version  |R version 3.1.2 (2014-10-31) |
|system   |x86_64, darwin13.4.0         |
|ui       |RStudio (0.99.167)           |
|language |(EN)                         |
|collate  |en_US.UTF-8                  |
|tz       |America/Chicago              |

## Packages

|package       |*  |version  |date       |source         |
|:-------------|:--|:--------|:----------|:--------------|
|BiocInstaller |*  |1.14.3   |2014-10-14 |Bioconductor   |
|digest        |*  |0.6.8    |2014-12-31 |CRAN (R 3.1.2) |
|evaluate      |*  |0.5.5    |2014-04-29 |CRAN (R 3.1.0) |
|httr          |*  |0.6.1    |2015-01-01 |CRAN (R 3.1.2) |
|jsonlite      |*  |0.9.14   |2014-12-01 |CRAN (R 3.1.2) |
|knitr         |*  |1.8      |2014-11-11 |CRAN (R 3.1.2) |
|MASS          |*  |7.3-37   |2015-01-10 |CRAN (R 3.1.2) |
|memoise       |*  |0.2.1    |2014-04-22 |CRAN (R 3.1.0) |
|Rcpp          |*  |0.11.3   |2014-09-29 |CRAN (R 3.1.1) |
|RCurl         |*  |1.95-4.5 |2014-12-06 |CRAN (R 3.1.2) |
|rmarkdown     |*  |0.4.2    |2014-12-22 |CRAN (R 3.1.2) |
|roxygen2      |*  |4.1.0    |2014-12-13 |CRAN (R 3.1.2) |
|rstudioapi    |*  |0.2      |2014-12-31 |CRAN (R 3.1.2) |
|testthat      |   |0.9.1    |2014-10-01 |CRAN (R 3.1.1) |
|whisker       |*  |0.3-2    |2013-04-28 |CRAN (R 3.1.0) |

# Check results
24 checked out of 25 dependencies 

## aRxiv (0.5.8)
Maintainer: Karl Broman <kbroman@biostat.wisc.edu>  
Bug reports: https://github.com/ropensci/aRxiv/issues

__OK__

## bisectr (0.1.0)
Maintainer: Winston Chang <winston@stdout.org>

__OK__

## broman (0.48-2)
Maintainer: Karl W Broman <kbroman@biostat.wisc.edu>

```
checking R code for possible problems ... NOTE
Found the following calls to attach():
File ‘broman/R/loadwork.R’:
  attach(file)
  attach(file)
See section ‘Good practice’ in ‘?attach’.
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

## gender (0.4.3)
Maintainer: Lincoln Mullen <lincoln@lincolnmullen.com>  
Bug reports: https://github.com/ropensci/gender/issues

__OK__

## icd9 (0.5)
Maintainer: Jack O. Wasey <jack@jackwasey.com>  
Bug reports: https://github.com/jackwasey/icd9/issues

```
checking R code for possible problems ... NOTE
icd9Benchmark: no visible global function definition for
  ‘microbenchmark’
icd9ComorbiditiesAhrq: no visible binding for global variable
  ‘ahrqComorbid’
icd9ComorbiditiesAhrq: no visible binding for global variable
  ‘ahrqComorbidNamesAbbrev’
icd9ComorbiditiesAhrq: no visible binding for global variable
  ‘ahrqComorbidNames’
icd9ComorbiditiesAhrq: no visible binding for global variable
  ‘ahrqComorbidNamesHtnAbbrev’
icd9ComorbiditiesAhrq: no visible binding for global variable
  ‘ahrqComorbidNamesHtn’
icd9ComorbiditiesElixhauser: no visible binding for global variable
  ‘elixhauserComorbid’
icd9ComorbiditiesElixhauser: no visible binding for global variable
  ‘elixhauserComorbidNamesAbbrev’
icd9ComorbiditiesElixhauser: no visible binding for global variable
  ‘elixhauserComorbidNames’
icd9ComorbiditiesElixhauser: no visible binding for global variable
  ‘elixhauserComorbidNamesHtnAbbrev’
icd9ComorbiditiesElixhauser: no visible binding for global variable
  ‘elixhauserComorbidNamesHtn’
icd9ComorbiditiesQuanDeyo: no visible binding for global variable
  ‘quanDeyoComorbid’
icd9ComorbiditiesQuanDeyo: no visible binding for global variable
  ‘charlsonComorbidNamesAbbrev’
icd9ComorbiditiesQuanDeyo: no visible binding for global variable
  ‘charlsonComorbidNames’
icd9ComorbiditiesQuanElixhauser: no visible binding for global variable
  ‘quanElixhauserComorbid’
icd9ComorbiditiesQuanElixhauser: no visible binding for global variable
  ‘quanElixhauserComorbidNamesAbbrev’
icd9ComorbiditiesQuanElixhauser: no visible binding for global variable
  ‘quanElixhauserComorbidNames’
icd9ComorbiditiesQuanElixhauser: no visible binding for global variable
  ‘quanElixhauserComorbidNamesHtnAbbrev’
icd9ComorbiditiesQuanElixhauser: no visible binding for global variable
  ‘quanElixhauserComorbidNamesHtn’
icd9CondenseToExplain: no visible binding for global variable
  ‘icd9Hierarchy’
icd9CondenseToExplain: no visible binding for global variable
  ‘icd9ChaptersMajor’
icd9Explain.character: no visible binding for global variable
  ‘icd9ChaptersMajor’
icd9Explain.character: no visible binding for global variable
  ‘icd9Hierarchy’
icd9GetChapters: no visible binding for global variable ‘icd9Chapters’
icd9GetChapters: no visible binding for global variable
  ‘icd9ChaptersSub’
icd9GetChapters: no visible binding for global variable
  ‘icd9ChaptersMajor’
icd9RealShort: no visible binding for global variable ‘icd9Hierarchy’
parseAhrqSas: no visible binding for global variable
  ‘ahrqComorbidNamesHtnAbbrev’
parseElixhauser: no visible binding for global variable
  ‘elixhauserComorbidNamesHtnAbbrev’
parseQuanDeyoSas: no visible binding for global variable
  ‘charlsonComorbidNamesAbbrev’
parseQuanElixhauser: no visible binding for global variable
  ‘quanElixhauserComorbidNamesHtnAbbrev’
```
```
checking data for non-ASCII characters ... NOTE
  Note: found 7 marked UTF-8 strings
```

## likert (1.2)
Maintainer: Jason Bryer <jason@bryer.org>  
Bug reports: https://github.com/jbryer/likert/issues

```
checking data for non-ASCII characters ... NOTE
  Note: found 7 marked UTF-8 strings
```

## metacom (1.4.2)
Maintainer: Tad Dallas <tdallas@uga.edu>

__OK__

## metafolio (0.1.0)
Maintainer: Sean C. Anderson <sean@seananderson.ca>  
Bug reports: http://github.com/seananderson/metafolio/issues

```
checking whether package ‘metafolio’ can be installed ... ERROR
Installation failed.
See ‘/private/tmp/Rtmp8qyC6V/check_cran23351aa25160/metafolio.Rcheck/00install.out’ for details.
```

## myTAI (0.0.2)
Maintainer: Hajk-Georg Drost <hajk-georg.drost@informatik.uni-halle.de>

__OK__

## NlsyLinks (1.302)
Maintainer: Will Beasley <wibeasley@hotmail.com>

```
checking dependencies in R code ... NOTE
Namespace in Imports field not imported from: ‘methods’
  All declared Imports should be used.
See the information on DESCRIPTION files in the chapter ‘Creating R
packages’ of the ‘Writing R Extensions’ manual.
```
```
checking R code for possible problems ... NOTE
ReadCsvNlsy79Gen1: no visible binding for global variable
  ‘SubjectDetails79’
ReadCsvNlsy79Gen2: no visible binding for global variable
  ‘SubjectDetails79’
```

## NMF (0.20.5)
Maintainer: Renaud Gaujoux <renaud@tx.technion.ac.il>  
Bug reports: http://github.com/renozao/NMF/issues

```
checking package dependencies ... NOTE
Packages suggested but not available for checking: ‘RcppOctave’ ‘doMPI’
```
```
checking R code for possible problems ... NOTE
devnmf: no visible global function definition for ‘load_all’
nmfReport: no visible global function definition for ‘knit2html’
posICA: no visible binding for global variable ‘fastICA’
posICA: no visible global function definition for ‘fastICA’
runit.lsnmf: no visible global function definition for ‘checkTrue’
setupLibPaths: no visible global function definition for ‘load_all’
test.match_atrack : .check: no visible global function definition for
  ‘checkEquals’
```
```
checking Rd cross-references ... NOTE
Package unavailable to check Rd xrefs: ‘RcppOctave’
```

## npsm (0.5)
Maintainer: John Kloke <kloke@biostat.wisc.edu>

__OK__

## opencpu (1.4.5)
Maintainer: Jeroen Ooms <jeroen.ooms@stat.ucla.edu>  
Bug reports: http://github.com/jeroenooms/opencpu/issues

```
checking package dependencies ... NOTE
Package suggested but not available for checking: ‘RAppArmor’
```

## packrat (0.4.2-1)
Maintainer: Kevin Ushey <kevin@rstudio.com>  
Bug reports: https://github.com/rstudio/packrat/issues

__OK__

## pkgmaker (0.22)
Maintainer: Renaud Gaujoux <renaud@tx.technion.ac.il>  
Bug reports: http://github.com/renozao/pkgmaker/issues

```
checking package dependencies ... NOTE
Package suggested but not available for checking: ‘ReportingTools’
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

## PSAboot (1.1)
Maintainer: Jason Bryer <jason@bryer.org>  
Bug reports: https://github.com/jbryer/PSAboot/issues

```
checking R code for possible problems ... NOTE
boxplot.PSAboot: no visible global function definition for
  ‘geom_tufteboxplot’
```
```
checking data for non-ASCII characters ... NOTE
  Note: found 4 marked UTF-8 strings
```

## rbundler (0.3.7)
Maintainer: Yoni Ben-Meshulam <yoni.bmesh@gmail.com>

```
checking R code for possible problems ... NOTE
install_version: no visible global function definition for
  ‘install_url’
```

## rclinicaltrials (1.4)
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
checking tests ... ERROR
Running the tests in ‘tests/test-all.R’ failed.
Last 13 lines of output:
                 character()
             else names(CURLcodeValues)[i]
         }
         typeName = gsub("^CURLE_", "", typeName)
         fun = (if (asError) 
             stop
         else warning)
         fun(structure(list(message = msg, call = sys.call()), class = c(typeName, "GenericCurlError", 
             "error", "condition")))
     }(35L, "Unknown SSL protocol error in connection to bbmc.ouhsc.edu:-9800", TRUE)
  
  Error: Test failures
  Execution halted
```

## smss (1.0-1)
Maintainer: Jeffrey B. Arnold <jeffrey.arnold@gmail.com>

__OK__

## testthat (0.9.1)
Maintainer: Hadley Wickham <hadley@rstudio.com>  
Bug reports: https://github.com/hadley/testthat/issues

__OK__

## Wats (0.2-16)
Maintainer: Will Beasley <wibeasley@hotmail.com>

__OK__

