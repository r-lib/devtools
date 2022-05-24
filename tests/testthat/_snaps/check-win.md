# change_maintainer_email checks fields

    Code
      change_maintainer_email(path, "x@example.com")
    Condition
      Error:
      ! DESCRIPTION must use Authors@R field when changing `email`

---

    Code
      change_maintainer_email(path, "x@example.com")
    Condition
      Error:
      ! DESCRIPTION can't use Maintainer field when changing `email`

