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
# modify superclasses that are in a different package. For example, suppose you
# have package pkgA with class A, and pkgB with class B, which contains A. If
# pkgB is loaded with load_all(), then class B will have a reference to class A,
# and unloading pkgB the normal way, with unloadNamespace("pkgB"), will result
# in some errors. They happen because R will look at B, see that it is a
# superclass of A, then it will try to modify A by removing subclass references
# to B.
#
# This function sidesteps the problem by modifying B: it removes all the
# superclass references in B, then removes B itself. (If removeClass("B") were
# called before removing the reference to A, then R would try to modify A
# first.) Strictly speaking, it's probably not necessary to delete the class
# here, because unloadNamespace would do it later in the process.
#
# @param classname The name of the class.
# @param pkg The package object which contains the class.
remove_s4_class <- function(classname, pkg) {
  pkg <- as.package(pkg)
  nsenv <- ns_env(pkg)

  # Make a copy of the class
  class <- getClassDef(classname, package = pkg$package, inherits = FALSE)

  # Remove all the references to classes that this one
  # contains/extends/{is a superclass of} so that R doesn't try to modify them.
  class@contains <- list()

  # Assign the class back into the package
  assignClassDef(classname, class, where = nsenv)

  # Remove the class.
  removeClass(classname, where = nsenv)
}
