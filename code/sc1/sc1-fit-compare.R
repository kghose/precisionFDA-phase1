# select a model for each subchallenge from single xgboost,
# single lightgbm, single catboost, or a stacked model of the three.

source("code/sc1/sc1-fit-load.R")
source("code/include/stacking.R")
source("code/include/model-selection.R")

sc1_params_xgb <- readRDS("model-pm/sc1_params_xgb.rds")
sc1_params_lgb <- readRDS("model-pm/sc1_params_lgb.rds")
sc1_params_cat <- readRDS("model-pm/sc1_params_cat.rds")

set.seed(1001)
idx_tr <- sample(1:377, round(377 * 0.8))
idx_te <- setdiff(1:377, idx_tr)
x_train <- sc1_x_train[idx_tr, ]
y_train <- sc1_y_train[idx_tr]
x_test <- sc1_x_train[idx_te, ]
y_test <- sc1_y_train[idx_te]

model_selection(x_train, y_train, sc1_params_xgb, sc1_params_lgb, sc1_params_cat, 1003)

# from below we decide to use the lightgbm model - it's consistently top 1 or 2

# 0.8
# xgboost  : 0.7895623
# lightgbm : 0.8484848
# catboost : 0.8686869
# stacked  : 0.8400673

# 0.7
# xgboost  : 0.8354978
# lightgbm : 0.8759019
# catboost : 0.8506494
# stacked  : 0.8629149

# 0.6
# xgboost  : 0.8350042
# lightgbm : 0.8767753
# catboost : 0.8617377
# stacked  : 0.8596491

# 0.5
# xgboost  : 0.8366864
# lightgbm : 0.8405325
# catboost : 0.8420118
# stacked  : 0.8508876
