# PCA and Logistic Regression Analysis
# Author: Oscar Saiz Gutierrez
# Date: 2024-06-18

# Load libraries
library(readr)
library(factoextra)
library(pscl)
library(caret)
library(reshape2)
library(dplyr)
library(FactoMineR)
library(car)
library(nortest)
library(gtsummary)

# Load data
data <- read_csv("data/alimentos_nutrientes_4900.csv")

# Normality test (Anderson-Darling) for food and nutrient variables
for (i in 1:131) {
  alimentos <- ad.test(data[[paste0("alimento", i)]])
}
for (i in 1:19) {
  nutrientes <- ad.test(data[[paste0("nutriente", i)]])
}

# Create PCA dataset and standardize
food_vars <- paste0("alimento", 1:131)
nutrient_vars <- paste0("nutriente", 1:19)
datapca <- data[, c(food_vars, nutrient_vars)]
datapca_scaled <- scale(datapca)

# Run PCA
pca <- prcomp(datapca_scaled)
PVE <- 100 * pca$sdev^2 / sum(pca$sdev^2)
write.csv(data.frame(PC = 1:length(PVE), R2 = PVE), "output/pca_variance.csv")

# Extract loadings
loadings <- pca$rotation[, 1:2]
write.csv(loadings, "output/pca_loadings.csv")

# Assign PCA scores and compute tertiles
data$scores_PC1 <- pca$x[, 1]
data$scores_PC2 <- pca$x[, 2]
data$Tertile_PC1 <- cut(pca$x[, 1], breaks = quantile(pca$x[, 1], probs = seq(0, 1, 1/3)), labels = FALSE)
data$Tertile_PC2 <- cut(pca$x[, 2], breaks = quantile(pca$x[, 2], probs = seq(0, 1, 1/3)), labels = FALSE)

# Convert categorical variables
data$diab_prev <- factor(data$diab_prev)
data$sexo <- factor(data$sexo)
cat_vars <- c("estado_civil", "tabaco", "colesterol", "hdl", "HTA",
              "hipercolesterolemia", "hipertrigliceridemia", "ECV_prev")
for (var in cat_vars) {
  data[[var]] <- as.factor(data[[var]])
}

# Logistic regression models
model1 <- glm(diab_prev ~ Tertile_PC1 + Tertile_PC2 + sexo + edad + hdl,
              data = data, family = "binomial")

model2 <- glm(diab_prev ~ Tertile_PC1 + Tertile_PC2 + sexo + edad + altura + peso +
                tabaco + colesterol + hdl + HTA + hipercolesterolemia +
                hipertrigliceridemia + ECV_prev,
              data = data, family = "binomial")

# Model summaries and pseudo-R²
summary(model1)
summary(model2)

OR1 <- exp(coef(model1))
OR2 <- exp(coef(model2))

R2_model1 <- 1 - (model1$deviance / model1$null.deviance)
R2_model2 <- 1 - (model2$deviance / model2$null.deviance)

print(OR1)
print(OR2)
print(paste("Pseudo R² (Model 1):", R2_model1))
print(paste("Pseudo R² (Model 2):", R2_model2))
