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
install_bitbucket <- function(repo, username=getOption('bitbucket.user'), 
                              ref = "master", pull = NULL, branch = NULL,
                              auth_user = NULL, password = NULL, ...)
{
  if (!is.null(branch)) {
    warning("'branch' is deprecated. In the future, please use 'ref' instead.")
    ref <- branch
  }
  
  if (!xor(is.null(pull), is.null(ref))) {
    stop("Must specify either a ref or a pull request, not both. ",
         "Perhaps you want to use 'ref=NULL'?")
  }
  
  if(!is.null(pull)) {
    pullinfo <- bitbucket_pull_info(repo, username, pull)
    username <- pullinfo$username
    ref <- pullinfo$ref
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

bitbucket_pull_info <- function (repo, username, pull) {
  host <- "https://bitbucket.org/api/2.0"
  # https://bitbucket.org/api/2.0/repositories/{owner}/{repo_slug}/pullrequests/{id}
  # Unofficial, but official: 
  # http://restbrowser.bitbucket.org
  path <- paste("repositories", username, repo, "pullrequests", pull, sep = "/")
  r <- GET(paste(host, path, sep='/'))
  stop_for_status(r)
  head <- parsed_content(r)
  
  repo <- head$source$repository$full_name
  repo <- unlist(strsplit(repo, '/'))
  
  list(repo = repo[2], 
       username = repo[1],
       ref = head$source$branch$name)
}