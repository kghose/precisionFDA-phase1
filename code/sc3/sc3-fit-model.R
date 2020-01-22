source("code/sc3/sc3-fit-load.R")
source("code/include/stacking.R")

sc3_params_xgb <- readRDS("model-pm/sc3_params_xgb.rds")
sc3_params_lgb <- readRDS("model-pm/sc3_params_lgb.rds")
sc3_params_cat <- readRDS("model-pm/sc3_params_cat.rds")

train_pool <- catboost.load_pool(data = sc3_x_train, label = sc3_y_train)
test_pool <- catboost.load_pool(data = sc3_x_train, label = NULL)
sc3_model <- catboost.train(
  train_pool, NULL,
  params = list(
    loss_function = "Logloss",
    iterations = sc3_params_cat$iterations,
    depth = sc3_params_cat$depth,
    logging_level = "Silent",
    thread_count = parallel::detectCores()
  )
)

# phase 1 model summary
sc3_p1_pred_prob <- catboost.predict(sc3_model, test_pool, prediction_type = "Probability")
sc3_p1_pred_resp <- ifelse(sc3_p1_pred_prob > 0.5, 1L, 0L)
caret::confusionMatrix(table(as.factor(sc3_p1_pred_resp), sc3_y_train))
pROC::auc(sc3_y_train, sc3_p1_pred_prob)

# write the data used for submission
write_tsv(sc3_x_train, "submission/subchallenge_3_data_used_x.tsv")
write_tsv(data.frame("SURVIVAL_STATUS" = sc3_y_train), "submission/subchallenge_3_data_used_y.tsv")
