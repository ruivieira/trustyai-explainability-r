library(rJava)
#' @importFrom rJava .jinit
#' @importFrom rJava .jengine
#' @importFrom rJava J
#' @export TestModels
.onLoad <- function(libname, pkgname) {
  path <- c("~/Sync/code/rh/trusty/trustyai-explainability-r/java/trustyai-explainability-r/target/trustyai-explainability-r-1.0-SNAPSHOT.jar",
    paste(system.file("jri",package="rJava"), "JRIEngine.jar", sep="/"))
  .jinit(classpath=path.expand(path))
  .jengine(TRUE) # Initialise engine for model callbacks

  TestModels <- J("org/kie/trustyai/explainability/utils/models/TestModels")
  assign("TestModels", TestModels, envir = parent.env(environment()))
}

