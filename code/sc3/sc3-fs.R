library("glmnet")

set.seed(2020)
fit <- glmnet(sc3_x2_train, sc3_y_train, family = "binomial", alpha = 1)

apply(fit$beta, 2, function (x) sum(abs(x) > 0L))

# names of the selected features
idx <- 12
cat(colnames(sc3_x2_train)[which(abs(fit$beta[, idx]) > 0L)], sep = ", ")

# selected features
sc3_x2_train_fs <- sc3_x2_train[, which(abs(fit$beta[, idx]) > 0L), drop = FALSE]
sc3_x_train <- cbind(sc3_x1_train, sc3_x2_train_fs)

# save the df for training
saveRDS(sc3_x_train, file = "data-fs/sc3_x_train.rds")
