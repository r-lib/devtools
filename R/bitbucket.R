bitbucket_consumer_key <- function () {
  Sys.getenv("BITBUCKET_CONSUMER_KEY")
}

bitbucket_oauth_app <- function (key = bitbucket_consumer_key()) {
  httr::oauth_app("bitbucket", key)
}

bitbucket_oauth_endpoint <- function () {
  httr::oauth_endpoint(authorize = "authorize", access = "access_token",
    base_url = "https://bitbucket.org/site/oauth2")
}

bitbucket_pat <- function (key = bitbucket_consumer_key()) {
  # Only OAuth2.0 supported
  if (file.exists("~/.httr-oauth")) {
    httr::oauth2.0_token(bitbucket_oauth_endpoint(),
      bitbucket_oauth_app(), cache = "~/.httr-oauth")
  } else {
    current_wd <- getwd()
    setwd("~/")
    on.exit(setwd(current_wd))
    httr::oauth2.0_token(bitbucket_oauth_endpoint(), bitbucket_oauth_app())
  }
}
