source("code/sc1/sc1-fit-load.R")
source("code/include/stacking.R")

sc1_params_xgb <- readRDS("model-pm/sc1_params_xgb.rds")
sc1_params_lgb <- readRDS("model-pm/sc1_params_lgb.rds")
sc1_params_cat <- readRDS("model-pm/sc1_params_cat.rds")

xtrain <- as.matrix(convert_num(sc1_x_train))

sc1_model <- lightgbm(
  data = xtrain,
  label = sc1_y_train,
  objective = "binary",
  learning_rate = sc1_params_lgb$learning_rate,
  num_iterations = sc1_params_lgb$num_iterations,
  max_depth = sc1_params_lgb$max_depth,
  num_leaves = 2^sc1_params_lgb$max_depth - 1,
  verbose = -1
)

# phase 1 model summary
sc1_p1_pred_prob <- predict(sc1_model, xtrain)
sc1_p1_pred_resp <- ifelse(sc1_p1_pred_prob > 0.5, 1L, 0L)
caret::confusionMatrix(table(as.factor(sc1_p1_pred_resp), sc1_y_train))
pROC::auc(sc1_y_train, sc1_p1_pred_prob)

# write the data used for submission
write_tsv(sc1_x_train, "submission/subchallenge_1_data_used_x.tsv")
write_tsv(data.frame("SURVIVAL_STATUS" = sc1_y_train), "submission/subchallenge_1_data_used_y.tsv")
