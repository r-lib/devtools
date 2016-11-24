context("Load: Non-ASCII Encoding")

test_that("Load nonASCII encoded files correctly", {
  load_all("testNonASCII")
  expect_message(printChineseMsg(), "我是GB2312的中文字符。")
  expect_output(print(printChineseMsg), "我是GB2312的中文字符。")
})
