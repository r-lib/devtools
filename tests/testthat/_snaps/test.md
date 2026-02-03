# test_coverage_active_file() computes coverage

    Code
      test_coverage_active_file(file.path(pkg, "R", "math.R"), report = "zero")
    Message
      Uncovered lines in 'R/math.R':
      * `compute()`: 4-5
      * `multiply()`: 2

# test_coverage_active_file() reports full coverage

    Code
      test_coverage_active_file(file.path(pkg, "R", "math.R"), report = "zero")
    Message
      v All lines covered!

# report_default() does its job

    Code
      report_default("bad")
    Condition
      Error:
      ! `report` must be one of "silent", "zero", or "html", not "bad".

