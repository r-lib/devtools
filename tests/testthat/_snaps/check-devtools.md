# check_bug_reports() passes when BugReports is present

    Code
      check_bug_reports(dir)
    Output
      Checking DESCRIPTION has a BugReports field... OK

# check_bug_reports() warns when BugReports is missing

    Code
      check_bug_reports(dir)
    Output
      Checking DESCRIPTION has a BugReports field...
    Message
      x WARNING: DESCRIPTION is missing a BugReports field.

