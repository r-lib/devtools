# ctsem

<details>

* Version: 3.7.1
* GitHub: https://github.com/cdriveraus/ctsem
* Source code: https://github.com/cran/ctsem
* Date/Publication: 2022-08-08 14:00:02 UTC
* Number of recursive dependencies: 135

Run `cloud_details(, "ctsem")` for more info

</details>

## In both

*   checking whether package ‘ctsem’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/tmp/workdir/ctsem/new/ctsem.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘ctsem’ ...
** package ‘ctsem’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
"/opt/R/4.1.1/lib/R/bin/Rscript" -e "source(file.path('..', 'tools', 'make_cc.R')); make_cc(commandArgs(TRUE))" stan_files/ctsm.stan
DIAGNOSTIC(S) FROM PARSER:
Info: integer division implicitly rounds to integer. Found int division: d * d - d / 2
 Positive values rounded down, negative values rounded up or down in platform-dependent way.

Wrote C++ file "stan_files/ctsm.cc"
...
 2340 |     T__ log_prob(std::vector<T__>& params_r__,
      |         ^~~~~~~~
stan_files/ctsm.hpp: In member function ‘T__ model_ctsm_namespace::model_ctsm::log_prob(std::vector<T_l>&, std::vector<int>&, std::ostream*) const [with bool propto__ = false; bool jacobian__ = false; T__ = double]’:
stan_files/ctsm.hpp:2340:9: note: variable tracking size limit exceeded with ‘-fvar-tracking-assignments’, retrying without
g++: fatal error: Killed signal terminated program cc1plus
compilation terminated.
make: *** [/opt/R/4.1.1/lib/R/etc/Makeconf:175: stan_files/ctsm.o] Error 1
rm stan_files/ctsm.cc
ERROR: compilation failed for package ‘ctsem’
* removing ‘/tmp/workdir/ctsem/new/ctsem.Rcheck/ctsem’


```
### CRAN

```
* installing *source* package ‘ctsem’ ...
** package ‘ctsem’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
"/opt/R/4.1.1/lib/R/bin/Rscript" -e "source(file.path('..', 'tools', 'make_cc.R')); make_cc(commandArgs(TRUE))" stan_files/ctsm.stan
DIAGNOSTIC(S) FROM PARSER:
Info: integer division implicitly rounds to integer. Found int division: d * d - d / 2
 Positive values rounded down, negative values rounded up or down in platform-dependent way.

Wrote C++ file "stan_files/ctsm.cc"
...
 2340 |     T__ log_prob(std::vector<T__>& params_r__,
      |         ^~~~~~~~
stan_files/ctsm.hpp: In member function ‘T__ model_ctsm_namespace::model_ctsm::log_prob(std::vector<T_l>&, std::vector<int>&, std::ostream*) const [with bool propto__ = false; bool jacobian__ = false; T__ = double]’:
stan_files/ctsm.hpp:2340:9: note: variable tracking size limit exceeded with ‘-fvar-tracking-assignments’, retrying without
g++: fatal error: Killed signal terminated program cc1plus
compilation terminated.
make: *** [/opt/R/4.1.1/lib/R/etc/Makeconf:175: stan_files/ctsm.o] Error 1
rm stan_files/ctsm.cc
ERROR: compilation failed for package ‘ctsem’
* removing ‘/tmp/workdir/ctsem/old/ctsem.Rcheck/ctsem’


```
# NA

<details>

* Version: NA
* GitHub: NA
* Source code: https://github.com/cran/NA
* Number of recursive dependencies: 0

Run `cloud_details(, "NA")` for more info

</details>

## Error before installation

### Devel

```






```
### CRAN

```






```
# NA

<details>

* Version: NA
* GitHub: NA
* Source code: https://github.com/cran/NA
* Number of recursive dependencies: 0

Run `cloud_details(, "NA")` for more info

</details>

## Error before installation

### Devel

```






```
### CRAN

```






```
# nlmixr2

<details>

* Version: 2.0.7
* GitHub: https://github.com/nlmixr2/nlmixr2
* Source code: https://github.com/cran/nlmixr2
* Date/Publication: 2022-06-27 22:20:02 UTC
* Number of recursive dependencies: 195

Run `cloud_details(, "nlmixr2")` for more info

</details>

## Error before installation

### Devel

```
* using log directory ‘/tmp/workdir/nlmixr2/new/nlmixr2.Rcheck’
* using R version 4.1.1 (2021-08-10)
* using platform: x86_64-pc-linux-gnu (64-bit)
* using session charset: UTF-8
* using option ‘--no-manual’
* checking for file ‘nlmixr2/DESCRIPTION’ ... OK
* this is package ‘nlmixr2’ version ‘2.0.7’
* package encoding: UTF-8
* checking package namespace information ... OK
* checking package dependencies ... ERROR
Packages required but not available:
  'nlmixr2est', 'nlmixr2extra', 'nlmixr2plot'

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
* DONE
Status: 1 ERROR





```
### CRAN

```
* using log directory ‘/tmp/workdir/nlmixr2/old/nlmixr2.Rcheck’
* using R version 4.1.1 (2021-08-10)
* using platform: x86_64-pc-linux-gnu (64-bit)
* using session charset: UTF-8
* using option ‘--no-manual’
* checking for file ‘nlmixr2/DESCRIPTION’ ... OK
* this is package ‘nlmixr2’ version ‘2.0.7’
* package encoding: UTF-8
* checking package namespace information ... OK
* checking package dependencies ... ERROR
Packages required but not available:
  'nlmixr2est', 'nlmixr2extra', 'nlmixr2plot'

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
* DONE
Status: 1 ERROR





```
