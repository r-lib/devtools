# clustermq

<details>

* Version: 0.8.8
* Source code: https://github.com/cran/clustermq
* URL: https://github.com/mschubert/clustermq
* BugReports: https://github.com/mschubert/clustermq/issues
* Date/Publication: 2019-06-05 22:00:39 UTC
* Number of recursive dependencies: 74

Run `revdep_details(,"clustermq")` for more info

</details>

## In both

*   R CMD check timed out
    

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘R6’ ‘purrr’
      All declared Imports should be used.
    ```

# ctsem

<details>

* Version: 2.9.6
* Source code: https://github.com/cran/ctsem
* URL: https://github.com/cdriveraus/ctsem
* Date/Publication: 2019-05-29 13:40:09 UTC
* Number of recursive dependencies: 103

Run `revdep_details(,"ctsem")` for more info

</details>

## In both

*   R CMD check timed out
    

*   checking installed package size ... NOTE
    ```
      installed size is 10.4Mb
      sub-directories of 1Mb or more:
        R      2.0Mb
        data   1.8Mb
        libs   5.5Mb
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘ggplot2’ ‘pkgbuild’
      All declared Imports should be used.
    ```

# FoldGO

<details>

* Version: 1.2.0
* Source code: https://github.com/cran/FoldGO
* Date/Publication: 2019-05-02
* Number of recursive dependencies: 104

Run `revdep_details(,"FoldGO")` for more info

</details>

## In both

*   checking whether package ‘FoldGO’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘.../revdep/checks.noindex/FoldGO/new/FoldGO.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘FoldGO’ ...
** using staged installation
** R
** data
*** moving datasets to lazyload DB
Warning: namespace ‘topGO’ is not available and has been replaced
by .GlobalEnv when processing object ‘down_annotobj’
Warning: namespace ‘topGO’ is not available and has been replaced
by .GlobalEnv when processing object ‘down_annotobj’
Warning: namespace ‘topGO’ is not available and has been replaced
by .GlobalEnv when processing object ‘up_annotobj’
Warning: namespace ‘topGO’ is not available and has been replaced
by .GlobalEnv when processing object ‘up_annotobj’
** inst
** byte-compile and prepare package for lazy loading
Error in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]) : 
  there is no package called ‘GO.db’
Calls: <Anonymous> ... loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
Execution halted
ERROR: lazy loading failed for package ‘FoldGO’
* removing ‘.../revdep/checks.noindex/FoldGO/new/FoldGO.Rcheck/FoldGO’

```
### CRAN

```
* installing *source* package ‘FoldGO’ ...
** using staged installation
** R
** data
*** moving datasets to lazyload DB
Warning: namespace ‘topGO’ is not available and has been replaced
by .GlobalEnv when processing object ‘down_annotobj’
Warning: namespace ‘topGO’ is not available and has been replaced
by .GlobalEnv when processing object ‘down_annotobj’
Warning: namespace ‘topGO’ is not available and has been replaced
by .GlobalEnv when processing object ‘up_annotobj’
Warning: namespace ‘topGO’ is not available and has been replaced
by .GlobalEnv when processing object ‘up_annotobj’
** inst
** byte-compile and prepare package for lazy loading
Error in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]) : 
  there is no package called ‘GO.db’
Calls: <Anonymous> ... loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
Execution halted
ERROR: lazy loading failed for package ‘FoldGO’
* removing ‘.../revdep/checks.noindex/FoldGO/old/FoldGO.Rcheck/FoldGO’

```
# infer

<details>

* Version: 0.4.0.1
* Source code: https://github.com/cran/infer
* URL: https://github.com/tidymodels/infer
* BugReports: https://github.com/tidymodels/infer/issues
* Date/Publication: 2019-04-22 06:58:08 UTC
* Number of recursive dependencies: 89

Run `revdep_details(,"infer")` for more info

</details>

## In both

*   R CMD check timed out
    

# jwutil

<details>

* Version: 1.2.3
* Source code: https://github.com/cran/jwutil
* URL: https://github.com/jackwasey/jwutil
* BugReports: https://github.com/jackwasey/jwutil/issues
* Date/Publication: 2019-05-06 19:10:03 UTC
* Number of recursive dependencies: 52

Run `revdep_details(,"jwutil")` for more info

</details>

## In both

*   checking whether package ‘jwutil’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘.../revdep/checks.noindex/jwutil/new/jwutil.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘jwutil’ ...
** package ‘jwutil’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/devtools/new/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -g -O0 -Wall -pedantic -fdiagnostics-color=always -Wsign-compare -march=native  -c RcppExports.cpp -o RcppExports.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/devtools/new/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -g -O0 -Wall -pedantic -fdiagnostics-color=always -Wsign-compare -march=native  -c get_current_stdlib.cpp -o get_current_stdlib.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/devtools/new/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -g -O0 -Wall -pedantic -fdiagnostics-color=always -Wsign-compare -march=native  -c jwomp.cpp -o jwomp.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/devtools/new/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -g -O0 -Wall -pedantic -fdiagnostics-color=always -Wsign-compare -march=native  -c rowsorted.cpp -o rowsorted.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/devtools/new/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -g -O0 -Wall -pedantic -fdiagnostics-color=always -Wsign-compare -march=native  -c stdlib.cpp -o stdlib.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/devtools/new/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -g -O0 -Wall -pedantic -fdiagnostics-color=always -Wsign-compare -march=native  -c test-jwutil.cpp -o test-jwutil.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/devtools/new/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -g -O0 -Wall -pedantic -fdiagnostics-color=always -Wsign-compare -march=native  -c test-runner.cpp -o test-runner.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/devtools/new/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -g -O0 -Wall -pedantic -fdiagnostics-color=always -Wsign-compare -march=native  -c util.cpp -o util.o
clang: [0;1;31merror: [0munsupported option '-fopenmp'[0m
make: *** [get_current_stdlib.o] Error 1
clang: [0;1;31mmake: *** Waiting for unfinished jobs....
error: [0munsupported option '-fopenmp'[0m
clang: [0;1;31merror: [0munsupported option '-fopenmp'[0m
clang: [0;1;31merror: [0munsupported option '-fopenmp'[0m
make: *** [stdlib.o] Error 1
make: *** [RcppExports.o] Error 1
make: *** [rowsorted.o] Error 1
clang: [0;1;31merror: [0munsupported option '-fopenmp'[0m
make: *** [jwomp.o] Error 1
clang: [0;1;31merror: [0munsupported option '-fopenmp'[0m
make: *** [test-jwutil.o] Error 1
clang: [0;1;31merror: [0munsupported option '-fopenmp'[0m
clang: [0;1;31merror: [0munsupported option '-fopenmp'[0m
make: *** [test-runner.o] Error 1
make: *** [util.o] Error 1
ERROR: compilation failed for package ‘jwutil’
* removing ‘.../revdep/checks.noindex/jwutil/new/jwutil.Rcheck/jwutil’

```
### CRAN

```
* installing *source* package ‘jwutil’ ...
** package ‘jwutil’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/jwutil/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -g -O0 -Wall -pedantic -fdiagnostics-color=always -Wsign-compare -march=native  -c RcppExports.cpp -o RcppExports.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/jwutil/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -g -O0 -Wall -pedantic -fdiagnostics-color=always -Wsign-compare -march=native  -c get_current_stdlib.cpp -o get_current_stdlib.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/jwutil/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -g -O0 -Wall -pedantic -fdiagnostics-color=always -Wsign-compare -march=native  -c jwomp.cpp -o jwomp.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/jwutil/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -g -O0 -Wall -pedantic -fdiagnostics-color=always -Wsign-compare -march=native  -c rowsorted.cpp -o rowsorted.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/jwutil/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -g -O0 -Wall -pedantic -fdiagnostics-color=always -Wsign-compare -march=native  -c stdlib.cpp -o stdlib.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/jwutil/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -g -O0 -Wall -pedantic -fdiagnostics-color=always -Wsign-compare -march=native  -c test-jwutil.cpp -o test-jwutil.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/jwutil/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -g -O0 -Wall -pedantic -fdiagnostics-color=always -Wsign-compare -march=native  -c test-runner.cpp -o test-runner.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/jwutil/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -g -O0 -Wall -pedantic -fdiagnostics-color=always -Wsign-compare -march=native  -c util.cpp -o util.o
clang: [0;1;31merror: [0munsupported option '-fopenmp'[0m
clang: [0;1;31merror: [0munsupported option '-fopenmp'[0m
clang: [0;1;31merror: [0munsupported option '-fopenmp'[0m
clang: [0;1;31merror: [0mmake: *** [test-jwutil.o] Error 1
make: *** Waiting for unfinished jobs....
make: *** [get_current_stdlib.o] Error 1
unsupported option '-fopenmp'[0m
clangmake: *** [rowsorted.o] Error 1
: [0;1;31merror: [0munsupported option '-fopenmp'[0m
make: *** [jwomp.o] Error 1
clang: [0;1;31merror: [0munsupported option '-fopenmp'[0m
make: *** [stdlib.o] Error 1
make: *** [RcppExports.o] Error 1
clang: [0;1;31merror: [0munsupported option '-fopenmp'[0m
make: *** [test-runner.o] Error 1
clang: [0;1;31merror: [0munsupported option '-fopenmp'[0m
make: *** [util.o] Error 1
ERROR: compilation failed for package ‘jwutil’
* removing ‘.../revdep/checks.noindex/jwutil/old/jwutil.Rcheck/jwutil’

```
# lilikoi

<details>

* Version: 0.1.0
* Source code: https://github.com/cran/lilikoi
* URL: https://github.com/lanagarmire/lilikoi
* BugReports: https://github.com/lanagarmire/lilikoi/issues
* Date/Publication: 2018-07-30 11:10:03 UTC
* Number of recursive dependencies: 130

Run `revdep_details(,"lilikoi")` for more info

</details>

## In both

*   R CMD check timed out
    

*   checking installed package size ... NOTE
    ```
      installed size is  5.4Mb
      sub-directories of 1Mb or more:
        data      4.1Mb
        extdata   1.1Mb
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘Matrix’ ‘devtools’ ‘e1071’ ‘glmnet’ ‘hash’ ‘pamr’ ‘randomForest’
      All declared Imports should be used.
    ```

# link2GI

<details>

* Version: 0.3-5
* Source code: https://github.com/cran/link2GI
* Date/Publication: 2018-10-26 23:00:03 UTC
* Number of recursive dependencies: 89

Run `revdep_details(,"link2GI")` for more info

</details>

## In both

*   R CMD check timed out
    

# mnem

<details>

* Version: 1.0.0
* Source code: https://github.com/cran/mnem
* Date/Publication: 2019-05-02
* Number of recursive dependencies: 142

Run `revdep_details(,"mnem")` for more info

</details>

## In both

*   checking whether package ‘mnem’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘.../revdep/checks.noindex/mnem/new/mnem.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘mnem’ ...
** using staged installation
** libs
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/mnem/Rcpp/include" -I".../revdep/library.noindex/mnem/RcppEigen/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -O3 -c RcppExports.cpp -o RcppExports.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/mnem/Rcpp/include" -I".../revdep/library.noindex/mnem/RcppEigen/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -O3 -c mm.cpp -o mm.o
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:1:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Core:535:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:2:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/LU:47:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:3:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Cholesky:12:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Jacobi:29:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:3:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Cholesky:43:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/QR:17:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Householder:27:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/SVD:48:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:6:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Geometry:58:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:7:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Eigenvalues:58:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:31:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Sparse:26:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/SparseCore:66:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:31:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Sparse:27:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/OrderingMethods:71:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:31:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Sparse:29:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/SparseCholesky:43:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:31:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Sparse:32:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/SparseQR:35:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:31:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Sparse:33:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/IterativeLinearSolvers:46:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:32:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/CholmodSupport:45:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:35:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/unsupported/Eigen/KroneckerProduct:34:
.../revdep/library.noindex/mnem/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:39:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/unsupported/Eigen/Polynomials:135:
.../revdep/library.noindex/mnem/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:40:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/unsupported/Eigen/SparseExtra:51:
.../revdep/library.noindex/mnem/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
17 warnings generated.
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:1:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Core:535:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:2:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/LU:47:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:3:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Cholesky:12:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Jacobi:29:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:3:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Cholesky:43:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/QR:17:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Householder:27:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/SVD:48:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:6:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Geometry:58:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:7:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Eigenvalues:58:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:31:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Sparse:26:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/SparseCore:66:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:31:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Sparse:27:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/OrderingMethods:71:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:31:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Sparse:29:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/SparseCholesky:43:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:31:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Sparse:32:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/SparseQR:35:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:31:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Sparse:33:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/IterativeLinearSolvers:46:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:32:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/CholmodSupport:45:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:35:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/unsupported/Eigen/KroneckerProduct:34:
.../revdep/library.noindex/mnem/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:39:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/unsupported/Eigen/Polynomials:135:
.../revdep/library.noindex/mnem/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:40:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/unsupported/Eigen/SparseExtra:51:
.../revdep/library.noindex/mnem/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
17 warnings generated.
clang++ -std=gnu++11 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/usr/local/lib -o mnem.so RcppExports.o mm.o -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
installing to .../revdep/checks.noindex/mnem/new/mnem.Rcheck/00LOCK-mnem/00new/mnem/libs
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
Error in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]) : 
  there is no package called ‘pcalg’
Calls: <Anonymous> ... loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
Execution halted
ERROR: lazy loading failed for package ‘mnem’
* removing ‘.../revdep/checks.noindex/mnem/new/mnem.Rcheck/mnem’

```
### CRAN

```
* installing *source* package ‘mnem’ ...
** using staged installation
** libs
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/mnem/Rcpp/include" -I".../revdep/library.noindex/mnem/RcppEigen/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -O3 -c RcppExports.cpp -o RcppExports.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/mnem/Rcpp/include" -I".../revdep/library.noindex/mnem/RcppEigen/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -O3 -c mm.cpp -o mm.o
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:1:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Core:535:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:2:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/LU:47:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:3:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Cholesky:12:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Jacobi:29:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:3:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Cholesky:43:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/QR:17:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Householder:27:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/SVD:48:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:6:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Geometry:58:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:7:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Eigenvalues:58:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:31:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Sparse:26:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/SparseCore:66:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:31:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Sparse:27:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/OrderingMethods:71:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:31:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Sparse:29:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/SparseCholesky:43:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:31:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Sparse:32:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/SparseQR:35:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:31:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Sparse:33:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/IterativeLinearSolvers:46:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:32:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/CholmodSupport:45:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:35:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/unsupported/Eigen/KroneckerProduct:34:
.../revdep/library.noindex/mnem/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:39:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/unsupported/Eigen/Polynomials:135:
.../revdep/library.noindex/mnem/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from RcppExports.cpp:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:40:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/unsupported/Eigen/SparseExtra:51:
.../revdep/library.noindex/mnem/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
17 warnings generated.
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:1:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Core:535:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:2:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/LU:47:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:3:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Cholesky:12:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Jacobi:29:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:3:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Cholesky:43:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:4:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/QR:17:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Householder:27:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/SVD:48:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:6:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Geometry:58:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:30:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Dense:7:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Eigenvalues:58:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:31:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Sparse:26:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/SparseCore:66:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:31:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Sparse:27:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/OrderingMethods:71:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:31:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Sparse:29:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/SparseCholesky:43:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:31:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Sparse:32:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/SparseQR:35:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:31:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/Sparse:33:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/IterativeLinearSolvers:46:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:32:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/Eigen/CholmodSupport:45:
.../revdep/library.noindex/mnem/RcppEigen/include/Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:35:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/unsupported/Eigen/KroneckerProduct:34:
.../revdep/library.noindex/mnem/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:39:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/unsupported/Eigen/Polynomials:135:
.../revdep/library.noindex/mnem/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
In file included from mm.cpp:5:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigen.h:25:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/RcppEigenForward.h:40:
In file included from .../revdep/library.noindex/mnem/RcppEigen/include/unsupported/Eigen/SparseExtra:51:
.../revdep/library.noindex/mnem/RcppEigen/include/unsupported/Eigen/../../Eigen/src/Core/util/ReenableStupidWarnings.h:10:30: warning: pragma diagnostic pop could not pop, no matching push [-Wunknown-pragmas]
    #pragma clang diagnostic pop
                             ^
17 warnings generated.
clang++ -std=gnu++11 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/usr/local/lib -o mnem.so RcppExports.o mm.o -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
installing to .../revdep/checks.noindex/mnem/old/mnem.Rcheck/00LOCK-mnem/00new/mnem/libs
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
Error in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]) : 
  there is no package called ‘pcalg’
Calls: <Anonymous> ... loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
Execution halted
ERROR: lazy loading failed for package ‘mnem’
* removing ‘.../revdep/checks.noindex/mnem/old/mnem.Rcheck/mnem’

```
# MoonlightR

<details>

* Version: 1.10.0
* Source code: https://github.com/cran/MoonlightR
* URL: https://github.com/torongs82/Moonlight
* BugReports: https://github.com/torongs82/Moonlight/issues
* Date/Publication: 2019-05-27
* Number of recursive dependencies: 234

Run `revdep_details(,"MoonlightR")` for more info

</details>

## In both

*   checking whether package ‘MoonlightR’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘.../revdep/checks.noindex/MoonlightR/new/MoonlightR.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘MoonlightR’ ...
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
Warning in fun(libname, pkgname) : couldn't connect to display ""
Error in loadNamespace(j <- i[[1L]], c(lib.loc, .libPaths()), versionCheck = vI[[j]]) : 
  there is no package called ‘DO.db’
Calls: <Anonymous> ... loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
Execution halted
ERROR: lazy loading failed for package ‘MoonlightR’
* removing ‘.../revdep/checks.noindex/MoonlightR/new/MoonlightR.Rcheck/MoonlightR’

```
### CRAN

```
* installing *source* package ‘MoonlightR’ ...
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
Warning in fun(libname, pkgname) : couldn't connect to display ""
Error in loadNamespace(j <- i[[1L]], c(lib.loc, .libPaths()), versionCheck = vI[[j]]) : 
  there is no package called ‘DO.db’
Calls: <Anonymous> ... loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
Execution halted
ERROR: lazy loading failed for package ‘MoonlightR’
* removing ‘.../revdep/checks.noindex/MoonlightR/old/MoonlightR.Rcheck/MoonlightR’

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
    

# StarBioTrek

<details>

* Version: 1.10.0
* Source code: https://github.com/cran/StarBioTrek
* URL: https://github.com/claudiacava/StarBioTrek
* BugReports: https://github.com/claudiacava/StarBioTrek/issues
* Date/Publication: 2019-05-02
* Number of recursive dependencies: 236

Run `revdep_details(,"StarBioTrek")` for more info

</details>

## In both

*   checking whether package ‘StarBioTrek’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘.../revdep/checks.noindex/StarBioTrek/new/StarBioTrek.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘StarBioTrek’ ...
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
Error in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]) : 
  there is no package called ‘miRNAtap.db’
Calls: <Anonymous> ... loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
Execution halted
ERROR: lazy loading failed for package ‘StarBioTrek’
* removing ‘.../revdep/checks.noindex/StarBioTrek/new/StarBioTrek.Rcheck/StarBioTrek’

```
### CRAN

```
* installing *source* package ‘StarBioTrek’ ...
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
Error in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]) : 
  there is no package called ‘miRNAtap.db’
Calls: <Anonymous> ... loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
Execution halted
ERROR: lazy loading failed for package ‘StarBioTrek’
* removing ‘.../revdep/checks.noindex/StarBioTrek/old/StarBioTrek.Rcheck/StarBioTrek’

```
# TCGAbiolinks

<details>

* Version: 2.12.2
* Source code: https://github.com/cran/TCGAbiolinks
* URL: https://github.com/BioinformaticsFMRP/TCGAbiolinks
* BugReports: https://github.com/BioinformaticsFMRP/TCGAbiolinks/issues
* Date/Publication: 2019-06-14
* Number of recursive dependencies: 252

Run `revdep_details(,"TCGAbiolinks")` for more info

</details>

## In both

*   R CMD check timed out
    

*   checking whether package ‘TCGAbiolinks’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: objects ‘.Random.seed’, ‘.Random.seed’, ‘.Random.seed’, ‘.Random.seed’, ‘.Random.seed’, ‘.Random.seed’, ‘.Random.seed’, ‘.Random.seed’, ‘.Random.seed’ are created by more than one data call
    See ‘.../revdep/checks.noindex/TCGAbiolinks/new/TCGAbiolinks.Rcheck/00install.out’ for details.
    ```

*   checking for missing documentation entries ... WARNING
    ```
    Undocumented data sets:
      ‘.Random.seed’
    All user-level objects in a package should have documentation entries.
    See chapter ‘Writing R documentation files’ in the ‘Writing R
    Extensions’ manual.
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘dnet’
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 97.0Mb
      sub-directories of 1Mb or more:
        R      2.7Mb
        data   4.3Mb
        doc   89.8Mb
    ```

*   checking dependencies in R code ... NOTE
    ```
    There are ::: calls to the package's namespace in its code. A package
      almost never needs to use ::: for its own objects:
      ‘move’
    ```

*   checking R code for possible problems ... NOTE
    ```
    ...
      (.../revdep/checks.noindex/TCGAbiolinks/new/TCGAbiolinks.Rcheck/00_pkg_src/TCGAbiolinks/R/visualize.R:161-162)
    TCGAvisualize_SurvivalCoxNET: no visible global function definition for
      ‘dCommSignif’
      (.../revdep/checks.noindex/TCGAbiolinks/new/TCGAbiolinks.Rcheck/00_pkg_src/TCGAbiolinks/R/visualize.R:174)
    TCGAvisualize_SurvivalCoxNET: no visible global function definition for
      ‘visNet’
      (.../revdep/checks.noindex/TCGAbiolinks/new/TCGAbiolinks.Rcheck/00_pkg_src/TCGAbiolinks/R/visualize.R:184-189)
    TCGAvisualize_oncoprint: no visible binding for global variable ‘value’
      (.../revdep/checks.noindex/TCGAbiolinks/new/TCGAbiolinks.Rcheck/00_pkg_src/TCGAbiolinks/R/visualize.R:932)
    readExonQuantification: no visible binding for global variable ‘exon’
      (.../revdep/checks.noindex/TCGAbiolinks/new/TCGAbiolinks.Rcheck/00_pkg_src/TCGAbiolinks/R/prepare.R:236-237)
    readExonQuantification: no visible binding for global variable
      ‘coordinates’
      (.../revdep/checks.noindex/TCGAbiolinks/new/TCGAbiolinks.Rcheck/00_pkg_src/TCGAbiolinks/R/prepare.R:236-237)
    readIDATDNAmethylation: no visible global function definition for
      ‘openSesame’
      (.../revdep/checks.noindex/TCGAbiolinks/new/TCGAbiolinks.Rcheck/00_pkg_src/TCGAbiolinks/R/prepare.R:526)
    Undefined global functions or variables:
      Tumor.purity barcode c3net clinical coordinates dCommSignif
      dNetInduce dNetPipeline exon knnmi.cross limmacontrasts.fit
      limmamakeContrasts minet openSesame portions rse_gene value visNet
    ```

# TCGAbiolinksGUI

<details>

* Version: 1.10.0
* Source code: https://github.com/cran/TCGAbiolinksGUI
* Date/Publication: 2019-05-02
* Number of recursive dependencies: 294

Run `revdep_details(,"TCGAbiolinksGUI")` for more info

</details>

## In both

*   checking whether package ‘TCGAbiolinksGUI’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘.../revdep/checks.noindex/TCGAbiolinksGUI/new/TCGAbiolinksGUI.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘TCGAbiolinksGUI’ ...
** using staged installation
** R
** inst
** byte-compile and prepare package for lazy loading
Error in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]) : 
  there is no package called ‘ELMER.data’
Calls: <Anonymous> ... loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
Execution halted
ERROR: lazy loading failed for package ‘TCGAbiolinksGUI’
* removing ‘.../revdep/checks.noindex/TCGAbiolinksGUI/new/TCGAbiolinksGUI.Rcheck/TCGAbiolinksGUI’

```
### CRAN

```
* installing *source* package ‘TCGAbiolinksGUI’ ...
** using staged installation
** R
** inst
** byte-compile and prepare package for lazy loading
Error in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]) : 
  there is no package called ‘ELMER.data’
Calls: <Anonymous> ... loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
Execution halted
ERROR: lazy loading failed for package ‘TCGAbiolinksGUI’
* removing ‘.../revdep/checks.noindex/TCGAbiolinksGUI/old/TCGAbiolinksGUI.Rcheck/TCGAbiolinksGUI’

```
