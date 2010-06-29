eval.echo <- function (exprs, envir = parent.frame()) {
  prompt.echo <- getOption("prompt")
  continue.echo <- getOption("continue")
  
  eval.with.vis <- function(expr, envir = parent.frame(), enclos = if (is.list(envir) || is.pairlist(envir)) parent.frame() else baseenv()) 
  .Internal(eval.with.vis(expr, envir, enclos))
    
  Ne <- length(exprs)

  sd <- "\""
  nos <- "[^\"]*"
  oddsd <- paste("^", nos, sd, "(", nos, sd, nos, sd, ")*", 
    nos, "$", sep = "")

  srcrefs <- attr(exprs, "srcref")
  srcfile <- attr(exprs, "srcfile")
  for (i in 1L:Ne) {
    ei <- exprs[i]
    srcref <- srcrefs[[i]]
    if (i == 1) 
      lastshown <- min(0, srcref[3L] - 1)
    dep <- getSrcLines(srcfile, lastshown + 1, srcref[3L])
    leading <- srcref[1L] - lastshown
    lastshown <- srcref[3L]
    while (length(dep) && length(grep("^[[:blank:]]*$", 
      dep[1L]))) {
      dep <- dep[-1L]
      leading <- leading - 1L
    }
    dep <- paste(rep.int(c(prompt.echo, continue.echo), 
      c(leading, length(dep) - leading)), dep, sep = "", 
      collapse = "\n")
    nd <- nchar(dep, "c")

    if (nd) {
      dep <- substr(dep, 1L, nd)
      cat("\n", dep, "\n", sep = "")
    }
    yy <- eval.with.vis(ei, envir)
    i.symbol <- mode(ei[[1L]]) == "name"
    if (!i.symbol) {
      curr.fun <- ei[[1L]][[1L]]
    }
    if (yy$visible) {
      if (isS4(yy$value)) {
        methods::show(yy$value)
      } else {
        print(yy$value)
      }
    }
  }
  invisible(yy)
}
