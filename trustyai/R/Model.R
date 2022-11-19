#' @export Model
#' @importFrom rJava J
#' @importFrom rJava toJava
Model <- function(predict_fn) {
    return(J("org/kie/trustyai/r/ModelWrapper")$create(toJava(predict_fn)))
}
