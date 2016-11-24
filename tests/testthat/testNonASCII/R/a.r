# This script is intended to be saved in GB2312 to test if non UTF-8 encoding is
# supported.

#' 中文注释
#'
#' @note 我爱中文。
printChineseMsg <- function() {
  message("我是GB2312的中文字符。")
}
