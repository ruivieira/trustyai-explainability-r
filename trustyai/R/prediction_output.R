#' @export prediction_output
#' @importFrom rJava J
prediction_output <- function(outputs) {
  joutputs <- .jnew("java/util/ArrayList")
  for (output in outputs) {
    joutputs$add(output)
  }
  return(new(J("org/kie/trustyai/explainability/model/PredictionOutput"), joutputs))
}
