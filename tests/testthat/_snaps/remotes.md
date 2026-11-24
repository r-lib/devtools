# github_ functions are deprecated

    Code
      . <- github_pull(1)
    Condition
      Warning:
      `github_pull()` was deprecated in devtools 2.5.0.
      i Please use `remotes::github_pull()` instead.
    Code
      . <- github_release()
    Condition
      Warning:
      `github_release()` was deprecated in devtools 2.5.0.
      i Please use `remotes::github_release()` instead.

# update_packages() recommends remotes for installed packages

    Code
      withRestarts(update_packages(), skip_package_update = function() invisible(NULL))
    Condition
      Warning:
      `update_packages()` was deprecated in devtools 2.5.0.
      i Please use `remotes::update_packages()` instead.

