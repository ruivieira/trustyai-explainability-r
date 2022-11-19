library(trustyai)
library(rJava)

center <- 10.0
epsilon <- 2.0

model <- trustyai::TestModels$getSumThresholdModel(center, epsilon)

features <- c(
  feature(name="x1", type="number", value=runif(n = 1, min = 0, max = 30)),
  feature(name="x2", type="number", value=runif(n = 1, min = 0, max = 30)),
  feature(name="x3", type="number", value=runif(n = 1, min = 0, max = 30)))


input <- prediction_input(features)
output <- c(as.list(as.list(model$predictAsync(J("java/util/List")$of(input))$get()$toArray())[[1]]$getOutputs())[[1]])

lime <- new(J("org/kie/trustyai/explainability/local/lime/LimeExplainer"))

prediction <- simple_prediction(features, output)

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
result <- as.double(prediction_fn(l_input))

pref <- toJava(prediction_fn)
model <- Model(pref)

#result <- J("org/kie/trustyai/r/ModelWrapper")$invoke(pref)
#result

lime <- new(J("org/kie/trustyai/explainability/local/lime/LimeExplainer"))
features <- c(
  feature(name="Girth", type="number", value=18.2),
  feature(name="Height", type="number", value=72.0))
output <- c(create_output("prediction", result))
prediction <- simple_prediction(features, output)
saliencies <- lime$explainAsync(prediction, model)$get()
cat(saliencies$asTable())
