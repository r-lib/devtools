# install reports stages

    Code
      install(pkg, reload = FALSE, build = FALSE)
    Output
      -- pak::local_install_deps() -------------------------------
    Message
    Output
      -- R CMD INSTALL -------------------------------------------

---

    Code
      install(pkg, reload = FALSE, build = TRUE)
    Output
      -- pak::local_install_deps() -------------------------------
    Message
    Output
      -- R CMD build ---------------------------------------------
      -- R CMD INSTALL -------------------------------------------

