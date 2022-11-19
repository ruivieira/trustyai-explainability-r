#' @export init
#' @importFrom rJava .jinit
#' @importFrom rJava .jengine
init <- function(path) {
  .jinit(classpath=path.expand(path))
  .jengine(TRUE) # Initialise engine for model callbacks
}
