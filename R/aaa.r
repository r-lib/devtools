onload_assign <-
  local({
    names <- character()
    funs <- list()
    function(name, x) {
      names[length(names) + 1] <<- name
      funs[[length(funs) + 1]] <<- substitute(x)
    }
  })
