library(titanic)
head(titanic_train)
View(titanic_train)

## Drop miss values
nrow(titanic_train)
titanic_train <- na.omit(titanic_train)

## Split data
set.seed(42)
n <- nrow(titanic_train)
id <- sample(1:n, n*0.7) ## 70% Train 30% Test
train_data <- titanic_train[id, ]
test_data <- titanic_train[-id, ]

## Train model
titanic_model <- glm(Survived ~ Sex, data = train_data, family = "binomial")
prob_train <- predict(titanic_model, type = "response") ## probability of Survived
train_data$Prob_Survived <- prob_train
train_data$Pred_Survived <- ifelse(train_data$Prob_Survived >= 0.5, 1, 0)

confus_matrix_train <- table(train_data$Pred_Survived, train_data$Survived, dnn = c("Predicted", "Actual"))

## Test model
prob_test <- predict(titanic_model, newdata = test_data, type = "response")
test_data$Prob_Survived <- prob_test
test_data$Pred_Survived <- ifelse(test_data$Prob_Survived >= 0.5, 1, 0)

confus_matrix_test <- table(test_data$Pred_Survived, test_data$Survived, dnn = c("Predicted", "Actual"))

## Accuracy
cat("Accuracy of train:", (confus_matrix_train[1, 1]+confus_matrix_train[2, 2])/sum(confus_matrix_train))
cat("Precision of train :", confus_matrix_train[2, 2]/(confus_matrix_train[2, 1]+confus_matrix_train[2, 2]))
cat("Recall of train:", confus_matrix_train[2, 2]/(confus_matrix_train[1, 2]+confus_matrix_train[2, 2])) 

cat("Accuracy of test:", (confus_matrix_test[1, 1]+confus_matrix_test[2, 2])/sum(confus_matrix_test))
cat("Precision of test :", confus_matrix_test[2, 2]/(confus_matrix_test[2, 1]+confus_matrix_test[2, 2]))
cat("Recall of test :", confus_matrix_test[2, 2]/(confus_matrix_test[1, 2]+confus_matrix_test[2, 2]))

