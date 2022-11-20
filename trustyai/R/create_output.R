#' @export create_output
#' @importFrom rJava J
#' @importFrom rJava .jnew
create_output <- function(name, value, score = 0) {
  o_ <- J("org/kie/trustyai/r/OutputFactory")
  return(o_$newNumericOutput(
    .jnew("java/lang/String", name),
    .jnew("java/lang/Double", value),
    .jnew("java/lang/Double", score)))
}
