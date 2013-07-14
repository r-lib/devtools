# @param arg a vector of command arguments.
# @param env a named character vector of environment variables.  Will be quoted
system_check <- function(cmd, args = character(), env = character(),
                         quiet = FALSE, stdout="", stderr="", ...) {
  
  #workaround for windows file stdout
  winstdout <- identical(.Platform$OS.type, "windows") && is.character(stdout) && nchar(stdout);
  
  if(isTRUE(winstdout)){
    stdout <- TRUE;
  }
                         
  if (quiet) {
    #note: stdout=FALSE has issues on rstudio-win
    stdout <- TRUE
    stderr <- FALSE
  } else {  
    full <- paste(shQuote(cmd), " ", paste(args, collapse = ", "), sep = "")    
    message(wrap_command(full))
    message()
  }

  result <- suppressWarnings(with_envvar(env,
    system2(cmd, args, stdout = stdout, stderr = stderr, ...)
  ))
  
  #workaround for windows
  if(isTRUE(winstdout)){
    cat(result, file=stdout, sep="\n")
  }  

  if (stdout == TRUE) {
    status <- attr(result, "status") %||% 0
  } else {
    status <- result
  }

  if (!identical(as.character(status), "0")) {
    stop("Command failed (", status, ")", call. = FALSE)
  }

  invisible(TRUE)
}


wrap_command <- function(x) {
  lines <- strwrap(x, getOption("width") - 2, exdent = 2)
  continue <- c(rep(" \\", length(lines) - 1), "")
  paste(lines, continue, collapse = "\n")
}

