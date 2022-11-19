#' @export create_output
#' @importFrom rJava J
#' @importFrom rJava .jnew
create_output <- function(name, value, score = 0) {
  o_ <- J("org/kie/trustyai/r/OutputFactory")
  return(o_$newNumericOutput(
    new(J("java/lang/String"), name),
    new(J("java/lang/Double"), value),
    new(J("java/lang/Double"), score)))
}
