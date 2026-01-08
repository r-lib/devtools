# Functions re-exported from the remotes package

These functions are re-exported from the remotes package. They differ
only that the ones in devtools use the
[ellipsis::ellipsis](https://ellipsis.r-lib.org/reference/ellipsis-package.html)
package to ensure all dotted arguments are used.

## Usage

``` r
install_bioc(
  repo,
  mirror = getOption("BioC_git", download_url("git.bioconductor.org/packages")),
  git = c("auto", "git2r", "external"),
  dependencies = NA,
  upgrade = c("default", "ask", "always", "never"),
  force = FALSE,
  quiet = FALSE,
  build = TRUE,
  build_opts = c("--no-resave-data", "--no-manual", "--no-build-vignettes"),
  build_manual = FALSE,
  build_vignettes = FALSE,
  repos = getOption("repos"),
  type = getOption("pkgType"),
  ...
)

install_bitbucket(
  repo,
  ref = "HEAD",
  subdir = NULL,
  auth_user = bitbucket_user(),
  password = bitbucket_password(),
  host = "api.bitbucket.org/2.0",
  dependencies = NA,
  upgrade = c("default", "ask", "always", "never"),
  force = FALSE,
  quiet = FALSE,
  build = TRUE,
  build_opts = c("--no-resave-data", "--no-manual", "--no-build-vignettes"),
  build_manual = FALSE,
  build_vignettes = FALSE,
  repos = getOption("repos"),
  type = getOption("pkgType"),
  ...
)

install_cran(
  pkgs,
  repos = getOption("repos"),
  type = getOption("pkgType"),
  dependencies = NA,
  upgrade = c("default", "ask", "always", "never"),
  force = FALSE,
  quiet = FALSE,
  build = TRUE,
  build_opts = c("--no-resave-data", "--no-manual", "--no-build-vignettes"),
  build_manual = FALSE,
  build_vignettes = FALSE,
  ...
)

install_dev(package, cran_url = getOption("repos")[["CRAN"]], ...)

install_git(
  url,
  subdir = NULL,
  ref = NULL,
  branch = NULL,
  credentials = git_credentials(),
  git = c("auto", "git2r", "external"),
  dependencies = NA,
  upgrade = c("default", "ask", "always", "never"),
  force = FALSE,
  quiet = FALSE,
  build = TRUE,
  build_opts = c("--no-resave-data", "--no-manual", "--no-build-vignettes"),
  build_manual = FALSE,
  build_vignettes = FALSE,
  repos = getOption("repos"),
  type = getOption("pkgType"),
  ...
)

install_github(
  repo,
  ref = "HEAD",
  subdir = NULL,
  auth_token = github_pat(quiet),
  host = "api.github.com",
  dependencies = NA,
  upgrade = c("default", "ask", "always", "never"),
  force = FALSE,
  quiet = FALSE,
  build = TRUE,
  build_opts = c("--no-resave-data", "--no-manual", "--no-build-vignettes"),
  build_manual = FALSE,
  build_vignettes = FALSE,
  repos = getOption("repos"),
  type = getOption("pkgType"),
  ...
)

install_gitlab(
  repo,
  subdir = NULL,
  auth_token = gitlab_pat(quiet),
  host = "gitlab.com",
  dependencies = NA,
  upgrade = c("default", "ask", "always", "never"),
  force = FALSE,
  quiet = FALSE,
  build = TRUE,
  build_opts = c("--no-resave-data", "--no-manual", "--no-build-vignettes"),
  build_manual = FALSE,
  build_vignettes = FALSE,
  repos = getOption("repos"),
  type = getOption("pkgType"),
  ...
)

install_local(
  path = ".",
  subdir = NULL,
  dependencies = NA,
  upgrade = c("default", "ask", "always", "never"),
  force = FALSE,
  quiet = FALSE,
  build = !is_binary_pkg(path),
  build_opts = c("--no-resave-data", "--no-manual", "--no-build-vignettes"),
  build_manual = FALSE,
  build_vignettes = FALSE,
  repos = getOption("repos"),
  type = getOption("pkgType"),
  ...
)

install_svn(
  url,
  subdir = NULL,
  args = character(0),
  revision = NULL,
  dependencies = NA,
  upgrade = c("default", "ask", "always", "never"),
  force = FALSE,
  quiet = FALSE,
  build = TRUE,
  build_opts = c("--no-resave-data", "--no-manual", "--no-build-vignettes"),
  build_manual = FALSE,
  build_vignettes = FALSE,
  repos = getOption("repos"),
  type = getOption("pkgType"),
  ...
)

install_url(
  url,
  subdir = NULL,
  dependencies = NA,
  upgrade = c("default", "ask", "always", "never"),
  force = FALSE,
  quiet = FALSE,
  build = TRUE,
  build_opts = c("--no-resave-data", "--no-manual", "--no-build-vignettes"),
  build_manual = FALSE,
  build_vignettes = FALSE,
  repos = getOption("repos"),
  type = getOption("pkgType"),
  ...
)

install_version(
  package,
  version = NULL,
  dependencies = NA,
  upgrade = c("default", "ask", "always", "never"),
  force = FALSE,
  quiet = FALSE,
  build = FALSE,
  build_opts = c("--no-resave-data", "--no-manual", "--no-build-vignettes"),
  build_manual = FALSE,
  build_vignettes = FALSE,
  repos = getOption("repos"),
  type = "source",
  ...
)

update_packages(
  packages = TRUE,
  dependencies = NA,
  upgrade = c("default", "ask", "always", "never"),
  force = FALSE,
  quiet = FALSE,
  build = TRUE,
  build_opts = c("--no-resave-data", "--no-manual", "--no-build-vignettes"),
  build_manual = FALSE,
  build_vignettes = FALSE,
  repos = getOption("repos"),
  type = getOption("pkgType"),
  ...
)

dev_package_deps(
  pkgdir = ".",
  dependencies = NA,
  repos = getOption("repos"),
  type = getOption("pkgType")
)
```

## Details

Follow the links below to see the documentation.
[`remotes::install_bioc()`](https://remotes.r-lib.org/reference/install_bioc.html),
[`remotes::install_bitbucket()`](https://remotes.r-lib.org/reference/install_bitbucket.html),
[`remotes::install_cran()`](https://remotes.r-lib.org/reference/install_cran.html),
[`remotes::install_dev()`](https://remotes.r-lib.org/reference/install_dev.html),
[`remotes::install_git()`](https://remotes.r-lib.org/reference/install_git.html),
[`remotes::install_github()`](https://remotes.r-lib.org/reference/install_github.html),
[`remotes::install_gitlab()`](https://remotes.r-lib.org/reference/install_gitlab.html),
[`remotes::install_local()`](https://remotes.r-lib.org/reference/install_local.html),
[`remotes::install_svn()`](https://remotes.r-lib.org/reference/install_svn.html),
[`remotes::install_url()`](https://remotes.r-lib.org/reference/install_url.html),
[`remotes::install_version()`](https://remotes.r-lib.org/reference/install_version.html),
[`remotes::update_packages()`](https://remotes.r-lib.org/reference/update_packages.html),
[`remotes::dev_package_deps()`](https://remotes.r-lib.org/reference/package_deps.html).
