# Remove s4 classes created by this package.
# This is only necessary if the package was loaded with devtools. If the
# package was NOT loaded by devtools, it's not necessary to remove the
# classes this way, and attempting to do so will result in errors.
remove_s4_classes <- function(pkg = ".") {
  pkg <- as.package(pkg)

  classes <- getClasses(ns_env(pkg))
  lapply(classes, remove_s4_class, pkg)
}

# Remove an s4 class from a package loaded by devtools
#
# For classes loaded with devtools, this is necessary so that R doesn't try to
# modify superclasses that don't have references to this class. For example,
# suppose you have package pkgA with class A, and pkgB with class B, which
# contains A. If pkgB is loaded with load_all(), then class B will have a
# reference to class A, and unloading pkgB the normal way, with
# unloadNamespace("pkgB"), will result in some errors. They happen because R
# will look at B, see that it is a superclass of A, then it will try to modify
# A by removing subclass references to B.
#
# This function sidesteps the problem by modifying B. It finds all the classes
# in B@contains which also have references back to B, then modifes B to keep
# references to those classes, but remove references to all other classes.
# Finally, it removes B. Calling removeClass("B") tells the classes referred to
# in B@contains to remove their references back to B.
#
# It is entirely possible that this code is necessary only because of bugs in
# R's S4 implementation.
#
# @param classname The name of the class.
# @param pkg The package object which contains the class.
remove_s4_class <- function(classname, pkg) {
  pkg <- as.package(pkg)
  nsenv <- ns_env(pkg)

  # Make a copy of the class
  class <- getClassDef(classname, package = pkg$package, inherits = FALSE)

  # Find all the references to classes that (this one contains/extends AND
  # have backreferences to this class) so that R doesn't try to modify them.
  keep_idx <- contains_backrefs(classname, pkg$package, class@contains)
  class@contains <- class@contains[keep_idx]

  # Assign the modified class back into the package
  assignClassDef(classname, class, where = nsenv)

  # Remove the class.
  removeClass(classname, where = nsenv)
}


# Given a list of SClassExtension objects, this returns a logical vector of the
# same length. Each element is TRUE if the corresponding object has a reference
# to this class, FALSE otherwise.
contains_backrefs <- function(classname, pkgname, contains) {

  # If class_a in pkg_a has class_b in pkg_b as a subclass, return TRUE,
  # otherwise FALSE.
  has_subclass_ref <- function(class_a, pkg_a, class_b, pkg_b) {
    x <- getClassDef(class_a, package = pkg_a)
    if (is.null(x)) return(FALSE)

    subclass_ref <- x@subclasses[[class_b]]

    if(!is.null(subclass_ref) && subclass_ref@package == pkg_b) {
      return(TRUE)
    }

    FALSE
  }

  if (length(contains) == 0) {
    return()
  }

  # Get a named vector of 'contains', where each item's name is the class,
  # and the value is the package.
  contain_pkgs <- sapply(contains, "slot", "package")

  mapply(has_subclass_ref, names(contain_pkgs), contain_pkgs, classname, pkgname)
}
