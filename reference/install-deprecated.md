# Deprecated package installation functions

**\[deprecated\]**

These functions have been deprecated in favor of
[pak](https://pak.r-lib.org/), as that is what we now recommend for
package installation. There are a few functions which have no pak
equivalent, where you can instead call the old remotes functions
directly.

### Migration guide

|                                   |                                                                                     |
|-----------------------------------|-------------------------------------------------------------------------------------|
| devtools function                 | Replacement                                                                         |
| `install_bioc("pkg")`             | `pak::pak("bioc::pkg")`                                                             |
| `install_bitbucket("user/repo")`  | `remotes::install_bitbucket("user/repo")`                                           |
| `install_cran("pkg")`             | `pak::pak("pkg")`                                                                   |
| `install_dev("pkg")`              | `remotes::install_dev("pkg")`                                                       |
| `install_git("url")`              | `pak::pak("git::url")`                                                              |
| `install_github("user/repo")`     | `pak::pak("user/repo")`                                                             |
| `install_gitlab("user/repo")`     | `pak::pak("gitlab::user/repo")`                                                     |
| `install_local("path")`           | `pak::pak("local::path")`                                                           |
| `install_svn("url")`              | `remotes::install_svn("url")`                                                       |
| `install_url("url")`              | `pak::pak("url::url")`                                                              |
| `install_version("pkg", "1.0.0")` | `pak::pak("pkg@1.0.0")`                                                             |
| `update_packages("pkg")`          | `pak::pak("pkg")`                                                                   |
| `dev_package_deps()`              | [`pak::local_dev_deps()`](https://pak.r-lib.org/reference/local_deps.html)          |
| `github_pull("123")`              | `remotes::github_pull("123")`                                                       |
| `github_release()`                | [`remotes::github_release()`](https://remotes.r-lib.org/reference/github_refs.html) |

## Usage

``` r
install_bioc(...)

install_bitbucket(...)

install_cran(...)

install_dev(...)

install_git(...)

install_github(...)

install_gitlab(...)

install_local(...)

install_svn(...)

install_url(...)

install_version(...)

update_packages(...)

dev_package_deps(...)

github_pull(...)

github_release(...)
```
