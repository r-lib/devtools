# gist with multiple files uses first with warning

    Code
      source_gist("605a984e764f9ed358556b4ce48cbd08", sha1 = "f176f5e1fe0", local = environment())
    Message
      2 .R files in gist, using first
      i Sourcing gist "605a984e764f9ed358556b4ce48cbd08"

# errors with bad id

    Code
      source_gist("xxxx")
    Condition
      Error in `source_gist()`:
      ! Invalid gist id specification "xxxx"

# error if file doesn't exist or no files

    Code
      find_gist("605a984e764f9ed358556b4ce48cbd08", 1)
    Condition
      Error:
      ! `filename` must be `NULL`, or a single filename ending in .R/.r
    Code
      find_gist("605a984e764f9ed358556b4ce48cbd08", "c.r")
    Condition
      Error:
      ! 'c.r' not found in gist
    Code
      find_gist("c535eee2d02e5f47c8e7642811bc327c")
    Condition
      Error:
      ! No R files found in gist

# check_sha1() checks or reports sha1 as needed

    Code
      check_sha1(path, NULL)
    Message
      i SHA-1 hash of file is "9f7efafc467018e11a7efc4bb7089ff0e5bff371"
    Code
      check_sha1(path, "f")
    Condition
      Error in `check_sha1()`:
      ! `sha1` must be at least 6 characters, not 1.
    Code
      check_sha1(path, "ffffff")
    Condition
      Error in `check_sha1()`:
      ! `sha1` ("ffffff") doesn't match SHA-1 hash of downloaded file ("9f7efa")

