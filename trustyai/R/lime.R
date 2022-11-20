#' @export lime
#' @importFrom rJava J
lime <- function(inputs, output, model) {
  prediction <- simple_prediction(inputs = inputs, outputs = output)
  explainer <- new(J("org/kie/trustyai/explainability/local/lime/LimeExplainer"))
  return(explainer$explainAsync(prediction, model)$get())
}
