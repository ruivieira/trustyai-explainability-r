#' @export feature
#' @importFrom rJava .jnew
feature <- function(name, type, value, score=0) {
  if (type == "number") {
    return(
      J("org/kie/trustyai/explainability/model/FeatureFactory")$newNumericalFeature(
        .jnew("java/lang/String", name),
        .jnew("java/lang/Double", value)
        )
      )
  }
}
