context("remote-metadata")

test_that("pkg_sha metadata from shallow clone", {

    pkg_sha <- git_sha1(path='shallowRepo')
    expect_equal(pkg_sha, '21d5d94011')

})


test_that("install on packages adds metadata", {
  skip_on_cran()

  # temp libPaths
  withr::with_temp_libpaths({
    test_pkg <- create_in_temp("testMetadataInstall")
    mock_use_github(test_pkg)

    # first do metadata = NULL
    install(test_pkg, quiet = TRUE, metadata = NULL)


    # cleanup code for when we are all finished
    on.exit(unload(test_pkg), add = TRUE)
    on.exit(erase(test_pkg), add = TRUE)

    # first time loading the package
    library("testMetadataInstall")

    pkg_info <- session_info()$packages
    expect_equal(pkg_info[pkg_info[, "package"] %in% "testMetadataInstall", "source"],
                 "local")

    # now use default
    r <- git2r::repository(test_pkg)

    # then use metadata
    install(test_pkg, quiet = TRUE)
    library("testMetadataInstall")
    pkg_info <- session_info()$packages
    pkg_source <- pkg_info[pkg_info[, "package"] %in% "testMetadataInstall", "source"]
    pkg_sha <- substring(git2r::commits(r)[[1]]@sha, 1, 7)
    expect_match(pkg_source, pkg_sha)

    # dirty the repo
    cat("just a test", file = file.path(test_pkg, "test.txt"))
    install(test_pkg, quiet = TRUE)
    pkg_info <- session_info()$packages
    pkg_source <- pkg_info[pkg_info[, "package"] %in% "testMetadataInstall", "source"]
    expect_match(pkg_source, "local")

    # use load_all() and reinstall
    git2r::add(r, file.path(test_pkg, "test.txt"))
    git2r::commit(r, "adding test.txt")
    load_all(test_pkg, quiet = TRUE)
    install(test_pkg, quiet = TRUE)
    pkg_info <- session_info()$packages
    pkg_source <- pkg_info[pkg_info[, "package"] %in% "testMetadataInstall", "source"]
    pkg_sha <- substring(git2r::commits(r)[[1]]@sha, 1, 7)
    expect_match(pkg_source, pkg_sha)

  })
})
