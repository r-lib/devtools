# check_doc_fields output - missing fields

    Code
      check_doc_fields(pkg)
    Message
      ! Missing `\value` section in 1 file:
      * man/foo.Rd
      ! Missing `\examples` section in 1 file:
      * man/bar.Rd

# check_doc_fields output - all present

    Code
      check_doc_fields(pkg)
    Message
      v All Rd files have `\value` sections.
      v All Rd files have `\examples` sections.

# check_man works

    Code
      check_man(pkg)
    Message
      i Updating {package} documentation
      i Loading {package}
      i Checking documentation...
    Output
      Rd files without \alias:
        'foo.Rd'
      Rd files without \description:
        'foo.Rd'
      Argument items with no description in Rd file 'foo.Rd':
        'foo'
      Undocumented arguments in Rd file 'foo.Rd'
        'x'
      

