

#' Check for the presence of git on the system.
#' 
#' Check to see if git is present.
#' \code{win_has_git} will automatically add git to the path when called and
#' if it finds git in the standard installation folder.
#' 
#' @family git
#' @export
has_git <- function(){
    if (on_path('git')) return(TRUE)
    if (.Platform$OS.type != "windows") {
        wp <- win_has_git()
        add_path(wp)
        return(TRUE)
    }
    FALSE
}

#' @rdname has_git
win_has_git <- function(){
    pfx64 <- Sys.getenv("PROGRAMFILES")
    pfx86 <- Sys.getenv("PROGRAMFILES(x86)") 
    if (file.exists(fp <- file.path(pfx64, "Git", 'bin'))) return(fp)
    if (file.exists(fp <- file.path(pfx86, "Git", 'bin'))) return(fp)
    return('')
}

is_git_repo <- function(path='.'){
    out <- suppressWarnings(in_dir(path, system2("git", "rev-parse --git-dir", TRUE, TRUE)))
    if(!is.null(attr(out,'status')) && attr(out,'status') != 0) return(FALSE)
    if(out != '' && file.path(path, out)) return(TRUE)
}

git.status.map <- c('M' = 'Modified'
                  , 'A' = 'Added'
                  , 'D' = 'Deleted'
                  , 'R' = 'Renamed'
                  , 'C' = 'Copied'
                  , 'U' = 'Updated'
                  , '?' = 'Untracked'
                  , '??' = 'Untracked')

#' Check the status of a git repository.
#' 
#' If the specified directory is a git repository, then check the status.
#' 
#' @param path the path to consider.
#' @param show.untracked  Should untracked files be shown?
#' @param show.ignored Should ignored files be shown?
#' 
#' @return A data.frame with status and file for the changed files.
#' 
#' @family git
#' @export
git_status <- function(path = '.', show.untracked = c('all', 'normal', 'no')
                      , show.ignored=FALSE){
    show.untracked <- match.arg(show.untracked)
    opts <- paste0('status --porcelain'
                  ,' --untracked-files=', show.untracked
                  , ifelse(show.ignored, ' --ignored', ''))
    lines <- in_dir(path, system2('git', opts, TRUE, TRUE))
    if(!is.null(attr(lines, 'status')) && attr(lines, 'status') != 0)  
        stop(lines)
    status <- gsub(' ', '', substring(lines, 1, 3))
    files <- substring(lines, 4)
    data.frame(status=status, file=files)
}
    

#' Add a tag to the git repository.
#' 
#' @param path The path to tag.
#' @param name The name of the tag.
#' @param 
#' 
#' @family git
#' @export
git_tag <- function(name, message, path = '.'){
    if(missing(name) || missing(message)) 
        stop("Will not git-tag without a name and message")
    if(git_check_ref_format(name))
        stop(sprintf("'name' failed to meet criteria for a git name.", name))
    out <- in_dir(path, system2('git-tag', paste0(name, ' -m "', message, '"')))
    if (!is.null(attr(out, 'status')) && attr(out, 'status') != 0)
        stop("Error tagging.")
}

git_check_ref_format <- function(name){
    opts <- paste("check-ref-format", shQuote(name))
    suppressWarnings(out <- system2("git", opts, TRUE, TRUE))
    if(!is.null(attr(out, 'status')) && attr(out, 'status') != 0) return(FALSE)
    TRUE
}

#' Commit changes in a git repository.
#'
#' Commits changes to a folder except new files.
#'
#' @param message The commit message.
#' @param path The path to commit.
#' 
#' @family git
#' @export
git_commit <- function(message, path = '.'){
    opts <- paste('commit', '-m', shQuote(message))
    in_dir(path, system2("git", opts))
}

#' @rdname git_commit
#' @export
git_commit_all <- function(message, path = '.'){
    opts <- paste('commit --all', '-m', shQuote(message))
    in_dir(path, system2("git", opts))
}

#' Stage files for commit
#' 
#' @param file a vector of files to add to the repository.
#' 
#' @family git
#' @export
git_add <- Vectorize(function(file) {
    dir <- path.expand(dirname(file))
    opts <- paste('add', basename(file))
    out <- in_dir(dir, system2('git', opts))
    if(!is.null(attr(out,'status')) && attr(out,'status') != 0)
        stop(sprintf("could not git-add file '%s'", file))
    invisible(TRUE)
})

#' Stage all files for a commit.
#' 
#' @param path The path to the files.
#' 
#' @family git
#' @export
git_add_new <- function(path = '.') {
    files <- git_status(path, 'all')
    new.files <- subset(files, files$status %in% c('?', '??'))
    git_add(new.files$file)
}

