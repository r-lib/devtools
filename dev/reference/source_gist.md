# Run a script on gist

“Gist is a simple way to share snippets and pastes with others. All
gists are git repositories, so they are automatically versioned,
forkable and usable as a git repository.” <https://gist.github.com/>

## Usage

``` r
source_gist(id, ..., filename = NULL, sha1 = NULL, quiet = FALSE)
```

## Arguments

- id:

  either full url (character), gist ID (numeric or character of
  numeric).

- ...:

  other options passed to
  [`source()`](https://rdrr.io/r/base/source.html)

- filename:

  if there is more than one R file in the gist, which one to source
  (filename ending in '.R')? Default `NULL` will source the first file.

- sha1:

  The SHA-1 hash of the file at the remote URL. This is highly recommend
  as it prevents you from accidentally running code that's not what you
  expect. See
  [`source_url()`](https://devtools.r-lib.org/dev/reference/source_url.md)
  for more information on using a SHA-1 hash.

- quiet:

  if `FALSE`, the default, prints informative messages.

## See also

[`source_url()`](https://devtools.r-lib.org/dev/reference/source_url.md)

## Examples

``` r
if (FALSE) { # \dontrun{
# You can run gists given their id
source_gist(6872663)
source_gist("6872663")

# Or their html url
source_gist("https://gist.github.com/hadley/6872663")
source_gist("gist.github.com/hadley/6872663")

# It's highly recommend that you run source_gist with the optional
# sha1 argument - this will throw an error if the file has changed since
# you first ran it
source_gist(6872663, sha1 = "54f1db27e60")
# Wrong hash will result in error
source_gist(6872663, sha1 = "54f1db27e61")

#' # You can speficy a particular R file in the gist
source_gist(6872663, filename = "hi.r")
source_gist(6872663, filename = "hi.r", sha1 = "54f1db27e60")
} # }
```
