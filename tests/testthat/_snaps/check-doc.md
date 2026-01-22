# check_doc_fields output - missing fields

    Code
      check_doc_fields(pkg)
    Message
      ! Missing `\value` section in 1 file:
      * foo.Rd
      ! Missing `\examples` section in 1 file:
      * bar.Rd

# check_doc_fields output - all present

    Code
      check_doc_fields(pkg)
    Message
      v All Rd files have `\value` sections.
      v All Rd files have `\examples` sections.

