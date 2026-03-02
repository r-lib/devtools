# Ensure that we don't affect the user's cache when testing
withr::local_envvar(
  R_PKG_CACHE_DIR = tempfile(),
  .local_envir = teardown_env()
)
