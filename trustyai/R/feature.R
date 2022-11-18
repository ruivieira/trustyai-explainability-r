#' @export feature
#' @importFrom rJava J
feature <- function(name, type, value, score=0) {
  if (type == "number") {
    return(J("org/kie/trustyai/explainability/model/FeatureFactory")$newNumericalFeature(new(J("java.lang.String"), name), new(J("java.lang.Double"), value)))
  }
}
