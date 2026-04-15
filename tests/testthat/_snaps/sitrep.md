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

# print warns when devtools is out of date

    Code
      print(x)
    Message
      -- R -------------------------------------------------------
      * version: 4.4.0
      * path: '/usr/lib/R'
      -- devtools ------------------------------------------------
      * version: 2.4.6
      ! devtools is out of date (2.4.6 vs 2.5.0).
        Update it with `pak::pak("devtools")`.
      -- dev package ---------------------------------------------
      * package: <unset>
      * path: <unset>

# print notes when devtools is ahead of CRAN

    Code
      print(x)
    Message
      -- R -------------------------------------------------------
      * version: 4.4.0
      * path: '/usr/lib/R'
      -- devtools ------------------------------------------------
      * version: 2.5.0.9000
      i devtools is ahead of CRAN (2.5.0.9000 vs 2.5.0).
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
      ! 1 devtools dependency is out of date.
        Update it with `pak::pak("devtools")`.
         cli (behind: 0.5.0 vs 1.0.0)
      -- dev package ---------------------------------------------
      * package: <unset>
      * path: <unset>

# print warns about missing devtools deps

    Code
      print(x)
    Message
      -- R -------------------------------------------------------
      * version: 4.4.0
      * path: '/usr/lib/R'
      -- devtools ------------------------------------------------
      * version: 2.4.6
      ! 1 devtools dependency is not installed.
        Install it with `pak::pak("devtools")`.
         somepkg (missing)
      -- dev package ---------------------------------------------
      * package: <unset>
      * path: <unset>

# print notes dev versions of devtools deps

    Code
      print(x)
    Message
      -- R -------------------------------------------------------
      * version: 4.4.0
      * path: '/usr/lib/R'
      -- devtools ------------------------------------------------
      * version: 2.4.6
      i 1 devtools dependency is ahead of CRAN.
        usethis (ahead: 3.2.1.9000 vs 3.2.1)
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
      ! 2 mypkg dependencies are out of date.
        Update them with `pak::local_install_dev_deps()`.
         dplyr (behind: 1.0.0 vs 1.1.0)
         tidyr (behind: 1.0.0 vs 1.1.0)

# print notes dev versions of package deps

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
      i 1 mypkg dependency is ahead of CRAN.
        usethis (ahead: 3.2.1.9000 vs 3.2.1)

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

