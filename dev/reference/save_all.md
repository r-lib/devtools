# Save all documents in an active IDE session

Helper function wrapping IDE-specific calls to save all documents in the
active session. In this form, callers of `save_all()` don't need to
execute any IDE-specific code. This function can be extended to include
other IDE implementations of their equivalent
[`rstudioapi::documentSaveAll()`](https://rstudio.github.io/rstudioapi/reference/rstudio-documents.html)
methods.

## Usage

``` r
save_all()
```
