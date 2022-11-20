#' @export simple_prediction
#' @importFrom rJava .jnew
simple_prediction <- function(inputs, outputs) {
  pred_input <- prediction_input(inputs)
  pred_output <- prediction_output(outputs)
  return(.jnew("org/kie/trustyai/explainability/model/SimplePrediction", pred_input, pred_output))
}
