# package_file() gives useful errors

    Code
      package_file(path = 1)
    Condition
      Error in `package_file()`:
      ! `path` must be a string.
    Code
      package_file(path = "doesntexist")
    Condition
      Error in `package_file()`:
      ! 'doesntexist' is not a directory.
    Code
      package_file(path = "/")
    Condition
      Error in `package_file()`:
      ! Could not find package root.
      i Is '/' inside a package?

# create argument is deprecated

    Code
      x <- as.package(path, create = TRUE)
    Condition
      Warning:
      The `create` argument of `as.package()` is deprecated as of devtools 2.5.0.

