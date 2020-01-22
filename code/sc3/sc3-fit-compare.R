# select a model for each subchallenge from single xgboost,
# single lightgbm, single catboost, or a stacked model of the three.

source("code/sc3/sc3-fit-load.R")
source("code/include/stacking.R")
source("code/include/model-selection.R")

sc3_params_xgb <- readRDS("model-pm/sc3_params_xgb.rds")
sc3_params_lgb <- readRDS("model-pm/sc3_params_lgb.rds")
sc3_params_cat <- readRDS("model-pm/sc3_params_cat.rds")

set.seed(1001)
idx_tr <- sample(1:166, round(166 * 0.8))
idx_te <- setdiff(1:166, idx_tr)
x_train <- sc3_x_train[idx_tr, ]
y_train <- sc3_y_train[idx_tr]
x_test <- sc3_x_train[idx_te, ]
y_test <- sc3_y_train[idx_te]

model_selection(x_train, y_train, sc3_params_xgb, sc3_params_lgb, sc3_params_cat, 1002)

# from below we decide to use the catboost model - it's consistently top 1

# 0.8
# xgboost  : 0.8406593
# lightgbm : 0.9120879
# catboost : 0.9175824
# stacked  : 0.8846154

# 0.7
# xgboost  : 0.745614
# lightgbm : 0.8048246
# catboost : 0.8157895
# stacked  : 0.7828947

# 0.6
# xgboost  : 0.7833133
# lightgbm : 0.7791116
# catboost : 0.8067227
# stacked  : 0.7839136

# 0.5
# xgboost  : 0.8039683
# lightgbm : 0.7952381
# catboost : 0.8420635
# stacked  : 0.8309524
