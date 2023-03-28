# Load library
library(dplyr)
library(readxl)
library(janitor)
library(caret)

# Read dataset excel file
house_price <- read_excel("House Price India.xlsx")

# format header of dataset
house_price <- house_price %>% clean_names()

glimpse(house_price)

# create split data function
train_test_split <- function(data, trainRatio) {
  set.seed(42)
  n <- nrow(data)
  id <- sample(1:n, size = trainRatio * n)
  train_data <- data[id, ]
  test_data <- data[-id, ]
  return(list(train = train_data, test = test_data))
}
# create function MAE, MSE, RMSE
mae_metric <- function(actual, prediction) {
  # mean absolute error
  abs_error <- abs(actual - prediction)
  mean(abs_error)
}

mse_metric <- function(actual, prediction) {
  # mean squared error
  sq_error <- (actual - prediction) ** 2
  mean(sq_error)
}

rmse_metric <- function(actual, prediction) {
  # root mean squared error
  sq_error <- (actual - prediction) ** 2
  sqrt(mean(sq_error))
}

## Standardization dataset
data_pre <- preProcess(house_price, method = c("center", "scale"))
data_transform <- predict(data_pre, house_price)
summary(train_transform)


## 1. split data
splitData <- train_test_split(data_transform, 0.7)
train_data <- splitData[[1]]
test_data <- splitData[[2]]

## 2. train data
## set resampling
ctrl <- trainControl(
  method = "cv",
  number = 5,
  verboseIter = TRUE ## print log of train
)

## Linear Regression
set.seed(42)
lm_model <- train(price ~ number_of_bedrooms + 
                    number_of_bathrooms +
                    living_area +
                    lot_area +
                    number_of_floors +
                    grade_of_the_house +
                    built_year +
                    renovation_year +
                    condition_of_the_house +
                    number_of_schools_nearby +
                    distance_from_the_airport,
                  data = train_data,
                  method = "lm",
                  metric = "Rsquared",
                  trControl = ctrl)

## knn
set.seed(42)
knn_model <- train(price ~ number_of_bedrooms + 
                    number_of_bathrooms +
                    living_area +
                    lot_area +
                    number_of_floors +
                    grade_of_the_house +
                    built_year +
                    renovation_year +
                    condition_of_the_house +
                    number_of_schools_nearby +
                    distance_from_the_airport,
                  data = train_data,
                  method = "knn",
                  metric = "Rsquared",
                  trControl = ctrl)


## 3. score data
p_lm <- predict(lm_model, newdata = test_data)
p_knn <- predict(knn_model, newdata = test_data)

## 4. evaluate model
cat("MAE of test lm model:", mae_metric(test_data$price, p_lm))
cat("MSE of test lm model:", mse_metric(test_data$price, p_lm))
cat("RMSE of test lm model:", rmse_metric(test_data$price, p_lm))

cat("MAE of test knn model:", mae_metric(test_data$price, p_knn))
cat("MSE of test knn model:", mse_metric(test_data$price, p_knn))
cat("RMSE of test knn model:", rmse_metric(test_data$price, p_knn))
