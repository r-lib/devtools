# find_active_file() gives useful error if no RStudio

    Code
      find_active_file()
    Condition
      Error:
      ! `file` is absent but must be supplied.

# fails if can't find tests

    Code
      find_test_file("R/foo.blah")
    Condition
      Error:
      ! Don't know how to find tests associated with the active file 'foo.blah'
    Code
      find_test_file("R/foo.R")
    Condition
      Error:
      ! No test files found

