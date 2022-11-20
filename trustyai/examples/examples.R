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

prediction <- simple_prediction(features, output)

saliencies <- lime(features, output, model)

cat(saliencies$asTable())

# Simple linear regression

data(trees)
head(trees)

regression <- lm(Volume ~ Girth * Height, data = trees)

summary(regression)

prediction_fn <- function(df) {
  print("Calling the prediction function")
  return(predict(fit_3, df))
}

input <- data.frame(Girth = 18.2, Height = 72)
pred <- as.double(prediction_fn(input))

model <- Model(prediction_fn)

features <- c(
  feature(name="Girth", type="number", value=18.2),
  feature(name="Height", type="number", value=72.0))

output <- c(create_output("Volume", pred))

saliencies <- lime(inputs=features, output=output, model=model)

cat(saliencies$asTable())

# Random forests

require(randomForest)
require(MASS)

attach(Boston)
set.seed(23)

train <- sample(1:nrow(Boston),300)

rf <- randomForest(medv ~ . , data = Boston , subset = train)

prediction_fn <- function(df) {
  return(predict(rf, df))
}
input <- data.frame(crim=0.02731, zn=0, indus=7.07, chas=0, nox=0.469,
                    rm=6.421, age=78.9, dis=4.9671, rad=2, tax=242,
                    ptratio=17.8, black=396.9, lstat=9.14)
pred <- as.double(prediction_fn(input))


model <- Model(prediction_fn)

features <- df_to_features(input)
output <- c(create_output("medv", pred))

saliencies <- lime(inputs=features, output=output, model=model)

cat(saliencies$asTable())
