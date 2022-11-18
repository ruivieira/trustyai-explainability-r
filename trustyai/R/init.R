#' @export init
#' @importFrom rJava .jinit
init <- function(path) {
  .jinit(classpath=path.expand(path))
}
