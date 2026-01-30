# fails when NEWS is missing or improperly formatted

    Code
      show_news(pkg)
    Condition
      Error in `find_news()`:
      ! Failed to find NEWS file.

---

    Code
      show_news(pkg)
    Condition
      Error in `show_news()`:
      ! Failed to parse NEWS file.
      Caused by error:
      ! NEWS.Rd: Sections \title, and \name must exist and be unique in Rd files

