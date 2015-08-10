#' Interface to `make` for package building
#'
#' \code{make} calls make for the specified target.
#'
#' @param target Makefile target, use \code{make_geteasytargets} to get a list of possible targets.
#' @param path path where makefile resides
#' @param makefile the Makefile to be used
#' @param ... further parameters are handed to \code{\link[base]{system2}}.
#' @include make.R
#' @export
#' @examples
#' \dontrun{
#' make ("build")
#' }
make <- function (target = "all", path = "./", makefile = "Makefile", ...){

	## make sure we leave in the same directory where we started
  oldwd <- getwd ()
  on.exit (setwd (oldwd))

  setwd (path)
  if (! file.exists (makefile))
    stop ("Makefile (", getwd (), "/", makefile, ") not found.")

  system2 ("make", args = paste ("-f", makefile, target), ...)
}

#'
#' \code{make_gettargets} extracts the targets from the makefile,
#' \code{make_geteasytargets} returns only the "easy" target names,
#' non-complex (no "%") targets that are also not filenames.
#'
#' @export
#' @rdname make
#' @examples
#'
#' \dontrun{
#' make_gettargets ()
#' make_geteasytargets ()
#' }
make_gettargets <- function (makefile = "Makefile"){
	makefile <- readLines(makefile)

	# target lines have a colon
	targets <- makefile [grepl (":", makefile)]
	# and don't start with tab
	targets <- targets [! grepl ("^([\t])", targets)]

	# exclude comments
	targets <- targets [! grepl ("#.*:)", targets)]

	# and definitions
	targets <- targets [! grepl (":=", targets)]

	# the target name is before the colon
	gsub (":.*$", "", targets)
}

#' @export
#' @rdname make
make_geteasytargets <- function (makefile = "Makefile"){
  targets <- make_gettargets (makefile = makefile)

  ## now prune everything that is not an "easy" target
  targets <- targets [! grepl ("%", targets)] # no complex targets
  targets <- targets [! grepl ("^[.]", targets)] # no hidden targets
  targets <- targets [! grepl ("/", targets)] # no targets in subdirectories

  targets [! file.exists (targets)]
}

