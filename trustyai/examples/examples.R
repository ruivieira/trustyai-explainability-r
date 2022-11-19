library(trustyai)
library(rJava)

center <- 10.0
epsilon <- 2.0

model <- trustyai::TestModels$getSumThresholdModel(center, epsilon)

features <- .jnew("java/util/ArrayList")
features$add(feature(name="x1", type="number", value=runif(n = 1, min = 0, max = 10)))
features$add(feature(name="x2", type="number", value=runif(n = 1, min = 0, max = 10)))
features$add(feature(name="x3", type="number", value=runif(n = 1, min = 0, max = 10)))


input <- .jnew("java/util/ArrayList")
input$add(new(J("org/kie/trustyai/explainability/model/PredictionInput"), features))
output <- model$predictAsync(input)$get()

as.list(output)[[1]]$getOutputs()

lime <- new(J("org/kie/trustyai/explainability/local/lime/LimeExplainer"))

prediction <- new(J("org/kie/trustyai/explainability/model/SimplePrediction"), as.list(input)[[1]], as.list(output)[[1]])

saliencies <- lime$explainAsync(prediction, model)$get()

cat(saliencies$asTable())

f <- function() { cat("Hello!\n"); 1 }
fref <- toJava(f)

J("org/kie/trustyai/r/ModelWrapper")$call(fref)

# Simple linear regression

data(trees)
head(trees)

fit_3 <- lm(Volume ~ Girth * Height, data = trees)

summary(fit_3)

prediction_fn <- function(df) {
  print("Calling the prediction function")
  return(predict(fit_3, df))
}

input <- data.frame(Girth = 18.2, Height = 72)
output <- prediction_fn(input)

l_input <- list("Girth"=18.2, "Height"=72)
prediction_fn(l_input)

pref <- toJava(prediction_fn)
model <- Model(pref)


result <- J("org/kie/trustyai/r/ModelWrapper")$invoke(pref)
