# print shows all checks passed

    Code
      print(x)
    Message
      -- R -------------------------------------------------------
      * version: 4.4.0
      * path: '/usr/lib/R'
      -- devtools ------------------------------------------------
      * version: 2.4.6
      -- dev package ---------------------------------------------
      * package: <unset>
      * path: <unset>
      v All checks passed

# print warns when R is out of date

    Code
      print(x)
    Message
      -- R -------------------------------------------------------
      * version: 4.3.0
      * path: '/usr/lib/R'
      ! R is out of date (4.3.0 vs 4.4.0)
      -- devtools ------------------------------------------------
      * version: 2.4.6
      -- dev package ---------------------------------------------
      * package: <unset>
      * path: <unset>

# print warns about outdated devtools deps

    Code
      print(x)
    Message
      -- R -------------------------------------------------------
      * version: 4.4.0
      * path: '/usr/lib/R'
      -- devtools ------------------------------------------------
      * version: 2.4.6
      ! devtools or its dependencies out of date:
        "cli"
        Update them with `devtools::update_packages("devtools")`
      -- dev package ---------------------------------------------
      * package: <unset>
      * path: <unset>

# print warns about outdated package deps

    Code
      print(x)
    Message
      -- R -------------------------------------------------------
      * version: 4.4.0
      * path: '/usr/lib/R'
      -- devtools ------------------------------------------------
      * version: 2.4.6
      -- dev package ---------------------------------------------
      * package: "mypkg"
      * path: '/tmp/mypkg'
      ! mypkg dependencies out of date:
        "dplyr" and "tidyr"
        Update them with `devtools::install_dev_deps()`

# print shows RStudio update message

    Code
      print(x)
    Message
      -- R -------------------------------------------------------
      * version: 4.4.0
      * path: '/usr/lib/R'
      -- RStudio -------------------------------------------------
      * version: "2024.04.0"
      ! RStudio is out of date.
      -- devtools ------------------------------------------------
      * version: 2.4.6
      -- dev package ---------------------------------------------
      * package: <unset>
      * path: <unset>

# check_for_rstudio_updates

    Code
      writeLines(check_for_rstudio_updates("windows", "haha-no-wut", TRUE))
    Output
      Unable to check for RStudio updates (you're using haha-no-wut).

---

    Code
      writeLines(check_for_rstudio_updates("darwin", "0.0.1", TRUE))
    Output
      RStudio {VERSION} is now available (you're using 0.0.1).
      Download at: https://www.rstudio.com/products/rstudio/download/

---

    Code
      writeLines(check_for_rstudio_updates("windows", "1.4.1717", TRUE))
    Output
      RStudio {VERSION} is now available (you're using 1.4.1717).
      Download at: https://www.rstudio.com/products/rstudio/download/

---

    Code
      writeLines(check_for_rstudio_updates("darwin", "2021.09.1+372", TRUE))
    Output
      RStudio {VERSION} is now available (you're using 2021.09.1+372).
      Download at: https://www.rstudio.com/products/rstudio/download/

---

    Code
      writeLines(check_for_rstudio_updates("windows", "2021.09.0-daily+328", TRUE))
    Output
      RStudio {VERSION} is now available (you're using 2021.09.0-daily+328).
      Download at: https://www.rstudio.com/products/rstudio/download/

