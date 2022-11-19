#' @export lime
#' @importFrom rJava J
lime <- function(prediction, model) {
  explainer <- new(J("org/kie/trustyai/explainability/local/lime/LimeExplainer"))
  return(explainer$explainAsync(prediction, model)$get())
}
