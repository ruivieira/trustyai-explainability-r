#' @export Model
#' @importFrom rJava J
Model <- function(predict_fn) {
    return(J("org/kie/trustyai/r/ModelWrapper")$create(predict_fn))
}
