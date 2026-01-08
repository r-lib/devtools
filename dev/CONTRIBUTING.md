# NA

## Contributing to devtools

The goal of this guide is to help you contribute to devtools as quickly
and as easily possible. The guide is divided into two main pieces:

1.  Filing a bug report or feature request in an issue.
2.  Suggesting a change via a pull request.

## Issues

Before you file an issue:

1.  Check that you’re using the latest version of devtools. It’s quite
    possible that the problem you’re experiencing has already been
    fixed.

2.  Check that the issue belongs in devtools. Much functionality now
    lives in separate packages. Please read the list below and check if
    you should be submitting your issue on another repo:

    - Building binary packages or anything related to finding R tools:
      [pkgbuild](https://github.com/r-lib/pkgbuild):

    - Anything related to the operation of
      [`load_all()`](https://devtools.r-lib.org/dev/reference/load_all.md):
      [pkgload](https://github.com/r-lib/pkgload).

    - Running R CMD check on one package:
      [rcmdcheck](https://github.com/r-lib/rcmdcheck). Running R CMD
      check on all reverse dependencies:
      [revdepcheck](https://github.com/r-lib/revdepcheck)

    - Installing packages: [remotes](https://github.com/r-lib/remotes)

    - Session info: [sessioninfo](https://github.com/r-lib/sessioninfo)

    - Any function that starts with `use_`:
      [usethis](https://github.com/r-lib/usethis)

3.  Spend a few minutes looking at the existing issues. It’s possible
    that your issue has already been filed. But it’s almost always
    better to open a new issue instead of commenting on an existing
    issue. The only exception is that you are confident that your issue
    is identical to an existing problem, and your contribution will help
    us better understand the general case. It’s generally a bad idea to
    comment on a closed issue or a commit. Those comments don’t show up
    in the issue tracker and are easily misplaced.

When filing an issue, the most important thing is to include a minimal
reproducible example so that we can quickly verify the problem, and then
figure out how to fix it. There are three things you need to include to
make your example reproducible: required packages, data, code.

1.  **Packages** should be loaded at the top of the script, so it’s easy
    to see which ones the example needs. Unless you’ve been specifically
    asked for it, please don’t include the output of
    [`sessionInfo()`](https://rdrr.io/r/utils/sessionInfo.html) or
    [`devtools::session_info()`](https://sessioninfo.r-lib.org/reference/session_info.html).

2.  The easiest way to include **data** is to use
    [`dput()`](https://rdrr.io/r/base/dput.html) to generate the R code
    to recreate it. For example, to recreate the `mtcars` dataset in R,
    I’d perform the following steps:

    1.  Run `dput(mtcars)` in R
    2.  Copy the output
    3.  In my reproducible script, type `mtcars <-` then paste.

    But even better is if you can create a
    [`data.frame()`](https://rdrr.io/r/base/data.frame.html) with just a
    handful of rows and columns that still illustrates the problem.

3.  Spend a little bit of time ensuring that your **code** is easy for
    others to read:

    - make sure you’ve used spaces and your variable names are concise,
      but informative

    - use comments to indicate where your problem lies

    - do your best to remove everything that is not related to the
      problem.  
      The shorter your code is, the easier it is to understand.

    Learn a little
    [markdown](https://help.github.com/articles/basic-writing-and-formatting-syntax/)
    so you can correctly format your issue. The most important thing is
    to surround your code with ```` ``` R ```` and ```` ``` ```` so it’s
    syntax highlighted (which makes it easier to read).

4.  Check that you’ve actually made a reproducible example by using the
    [reprex package](https://github.com/jennybc/reprex).

## Pull requests

- Your pull request will be easiest for us to read if you use a common
  style: <http://r-pkgs.had.co.nz/r.html#style>. Please pay particular
  attention to whitespace.

- You should always add a bullet point to `NEWS.md` motivating the
  change. It should look like “This is what changed (@yourusername,
  \#issuenumber)”. Please don’t add headings like “bug fix” or “new
  features” - these are added during the release process.

- If you can, also write a test. Testing devtools is particularly
  difficult because most devtools functions are called for their
  side-effects, but do the best you can.

- If you’re adding new parameters or a new function, you’ll also need to
  document them with [roxygen2](http://r-pkgs.had.co.nz/man.md). Make
  sure to re-run
  [`devtools::document()`](https://devtools.r-lib.org/dev/reference/document.md)
  on the code before submitting.

A pull request is a process, and unless you’re a practiced contributor
it’s unlikely that your pull request will be accepted as is. Typically
the process looks like this:

1.  You submit the pull request.

2.  We review at a high-level and determine if this is something that we
    want to include in the package. If not, we’ll close the pull request
    and suggest an alternative home for your code.

3.  We’ll take a closer look at the code and give you feedback.

4.  You respond to our feedback, update the pull request and add a
    comment like “PTAL” (please take a look). Adding the comment is
    important, otherwise we don’t get any notification that your pull
    request is ready for review.

Don’t worry if your pull request isn’t perfect. It’s a learning process
and we’ll be happy to help you out.

It can be frustrating that your PR is ignored for months, and then we
request a whole bunch on changes within a short time period. Don’t
worry - if your PR doesn’t make it for this release, it will for the
next one.
