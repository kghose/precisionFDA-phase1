library("glmnet")

set.seed(2020)
fit <- glmnet(sc1_x2_train, sc1_y_train, family = "binomial", alpha = 1)

apply(fit$beta, 2, function (x) sum(abs(x) > 0L))

# names of the selected features
idx <- 17
cat(colnames(sc1_x2_train)[which(abs(fit$beta[, idx]) > 0L)], sep = ", ")

# selected features
sc1_x2_train_fs <- sc1_x2_train[, which(abs(fit$beta[, idx]) > 0L), drop = FALSE]
sc1_x_train <- cbind(sc1_x1_train, sc1_x2_train_fs)

# save the df for training
saveRDS(sc1_x_train, file = "data-fs/sc1_x_train.rds")
