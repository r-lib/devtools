.onAttach <- function(...) {
  # Assume that non-windows users have paths set correctly
  if (.Platform$OS.type != "windows") return()
  
  # Check if Rtools is already set up
  if (all(on_path("ls.exe", "gcc.exe"))) return()
  
  #read from registry
  key <- try(utils::readRegistry("SOFTWARE\\R-core\\Rtools", hive="HLM", view="32-bit"), silent=TRUE)
  if(class(key) == "try-error")
    rtools.home <- normalizePath("c:\\Rtools", mustWork = FALSE)
  else 
    rtools.home <- key$InstallPath
    
  if (!file.exists(rtools.home)) {
    packageStartupMessage(
      "Rtools not on path and not installed in default location.")
    return()
  } else {
    rtools <- file.path(rtools.home,'bin')
  }
  
  in_path <- (normalizePath(rtools, mustWork = FALSE) %in% get_path())
  if (!in_path) {
    packageStartupMessage("Rtools not in path, adding automatically.")
    add_path(rtools, file.path(rtools.home, "MinGW","bin"))
    if (.Platform$r_arch == "x64")
      add_path( file.path(rtools.home, "MinGW64","bin"), after=0)
  }
}
