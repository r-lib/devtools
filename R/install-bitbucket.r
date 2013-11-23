#' Install a package directly from bitbucket
#'
#' This function is vectorised so you can install multiple packages in
#' a single command.
#'
#' @param repo repo name
#' @param username  bitbucket username
#' @seealso Bitbucket API docs:
#'   \url{https://confluence.atlassian.com/display/BITBUCKET/Use+the+Bitbucket+REST+APIs}
#' @inheritParams install_github
#' @family package installation
#' @export
#' @examples
#' \dontrun{
#' install_bitbucket("paulhiemstra")
#' install_bitbucket(c("testrepo", "testrepo2"))
#' }
install_bitbucket <- function(repo, username, ref = "master", branch = NULL,
                              auth_user = NULL, password = NULL, ...)
{
  if (!is.null(branch)) {
    warning("'branch' is deprecated. In the future, please use 'ref' instead.")
    ref <- branch
  }

  if (!is.null(password)) {
    auth <- authenticate(
      user = auth_user %||% username,
      password = password,
      type = "basic")
  } else {
    auth <- list()
  }

  message("Installing bitbucket repo(s) ",
    paste(repo, ref, sep = "/", collapse = ", "),
    " from ",
    paste(username, collapse = ", "))

  url <- paste("https://bitbucket.org/", username, "/", tolower(repo), "/get/",
    ref, ".zip", sep = "")
  
  # define before_install function that captures the arguments to 
  # install_bitbucket and appends to the description file
  bitbucket_before_install <- function(bundle, pkg_path) {
    
    # Ensure the DESCRIPTION ends with a newline
    desc <- file.path(pkg_path, "DESCRIPTION")
    if (!ends_with_newline(desc))
      cat("\n", sep="", file = desc, append = TRUE)
    
    # Function to append a field to the DESCRIPTION if it's not null
    append_field <- function(name, value) {
      if (!is.null(value)) {
        cat("Bitbucket", name, ":", value, "\n", sep = "", file = desc, append = TRUE)
      }
    }
    
    # Append fields
    append_field("Repo", repo)
    append_field("Username", username)
    append_field("Ref", ref)
    append_field("SHA1", github_extract_sha1(bundle))
    append_field("Branch", branch)
    append_field("AuthUser", auth_user)
    # Don't record password for security reasons
    #append_field("Password" password)
  }
  install_url(url, name = paste(repo, ".zip", sep=""),
              config = auth, before_install = bitbucket_before_install, ...)
  }
