#' @export prediction_input
#' @importFrom rJava J
prediction_input <- function(features) {
  jinputs <- new(J("java/util/ArrayList"))
  for (feature in features) {
    jinputs$add(feature)
  }
  return(new(J("org/kie/trustyai/explainability/model/PredictionInput"), jinputs))
}
