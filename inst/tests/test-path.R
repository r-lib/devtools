context("Path manipulation checks")

test_that("Path manipulations",{
  expect_is(get_path(), "character")
  if(.Platform$OS.type == "Windows"){
    windows.dir= Sys.getenv("WINDOWS")
    expect_true(windows.dir %in% get_path())
    expect_true(on_path("notepad.exe"))
  }
  if(.Platform$OS.type == "unix"){
    expect_true("/usr/bin" %in% get_path())
    expect_true(on_path("env"))
  }
  
  newdir = tempdir()
  add_path(newdir)
  expect_true(newdir %in% get_path())
  unlink(newdir)
})

