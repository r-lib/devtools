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

