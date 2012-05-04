.onAttach <- function(...) {
  # Assume that non-windows users have paths set correctly
  if (.Platform$OS.type != "windows") return()
  
  # Check if Rtools is already set up
  if (all(on_path("ls.exe", "gcc.exe"))) return()
  
  #read from registry
  key <- try(utils::readRegistry("SOFTWARE\\R-core\\Rtools", hive="HLM", view="32-bit"), silent=TRUE)
  if(inherits(key, "try-error")) {
    rtools.home <- normalizePath("c:\\Rtools", mustWork = FALSE)
  } else {
    rtools.home <- key$InstallPath
  }
  if (!file.exists(rtools.home)) {
    packageStartupMessage(
      "Rtools not on path and not installed in default location.")
    return()
  } else {
    rtools <- normalizePath(file.path(rtools.home,'bin'), mustWork=FALSE)
  }
  
  if(key$`Current Version`=="2.15"){ 
    gccbin <- normalizePath(file.path(rtools.home,'gcc-4.6.3','bin'), mustWork=FALSE)
    if(!(gccbin %in% get_path()) && file.exists(gccbin)) try(add_path(gccbin, after=0))
    if(!(rtools %in% get_path()) && file.exists(rtools)) try(add_path(rtools, after=0))
  } else if (!(rtools %in% get_path())) {
    packageStartupMessage("Rtools not in path, adding automatically.")
    gccbin <- normalizePath(file.path(rtools.home, "MinGW","bin"), mustWork=FALSE)
    if(!(gccbin %in% get_path()) && file.exists(gccbin)) try(add_path(gccbin, after=0))
    if(!(rtools %in% get_path()) && file.exists(rtools)) try(add_path(rtools, after=0))
    if (.Platform$r_arch == "x64")
      gcc.64 <- normalizePath(file.path(rtools.home, "MinGW64","bin"), mustWork=FALSE)
      if(!(gcc.64 %in% get_path()) && file.exists(gcc.64)) try(add_path(gcc.64, after=0))
  }
}
