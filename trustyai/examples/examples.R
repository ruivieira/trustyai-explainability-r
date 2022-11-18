library(trustyai)
library(rJava)

trustyai::init("~/Sync/code/rh/trusty/trustyai-explainability-r/trustyai/deps/explainability-arrow-0.3.0.jar")

center <- 10.0
epsilon <- 2.0

model <- J("org/kie/trustyai/explainability/utils/models/TestModels")$getSumThresholdModel(center, epsilon)

features <- .jnew("java/util/ArrayList")
features$add(feature(name="x1", type="number", value=runif(n = 1, min = 0, max = 10)))
features$add(feature(name="x2", type="number", value=runif(n = 1, min = 0, max = 10)))
features$add(feature(name="x3", type="number", value=runif(n = 1, min = 0, max = 10)))


input <- .jnew("java/util/ArrayList")
input$add(new(J("org/kie/trustyai/explainability/model/PredictionInput"), features))
output <- as.list(model$predictAsync(input)$get())

output[[1]]$getOutputs()
