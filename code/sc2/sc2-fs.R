library("glmnet")

set.seed(2020)
fit <- glmnet(sc2_x2_train, sc2_y_train, family = "binomial", alpha = 1)

apply(fit$beta, 2, function (x) sum(abs(x) > 0L))

# names of the selected features
idx <- 12
cat(colnames(sc2_x2_train)[which(abs(fit$beta[, idx]) > 0L)], sep = ", ")

# selected features
sc2_x2_train_fs <- sc2_x2_train[, which(abs(fit$beta[, idx]) > 0L), drop = FALSE]
sc2_x_train <- cbind(sc2_x1_train, sc2_x2_train_fs)

# save the df for training
saveRDS(sc2_x_train, file = "data-fs/sc2_x_train.rds")
