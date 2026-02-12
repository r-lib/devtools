# can determine when to document

    Code
      result <- can_document("1.0.0", installed = "2.0.0")
    Output
      == Documenting =================================================================
    Message
      i Installed roxygen2 version (2.0.0) doesn't match declared (1.0.0)
      x `check()` will not re-document this package.
      i Do you need to re-run `document()`?

