# PCA and Logistic Regression Analysis in R

This repository contains a complete PCA-based dimensionality reduction and logistic regression analysis on nutritional intake and disease prevalence data. The analysis was conducted using R and includes preprocessing, PCA visualization, descriptive statistics by tertiles, and logistic regression modeling for diabetes prevalence.

## Project Structure

- `data/`: Input dataset (`alimentos_nutrientes_4900.csv`)
- `scripts/pca_logistic_analysis.R`: R script with full analysis
- `notebook/pca_logistic_analysis.Rmd`: R Markdown version of the analysis
- `README.md`: Project documentation

## Objective

To evaluate the relationship between dietary components and disease prevalence using principal component analysis (PCA) followed by logistic regression. The project includes:

1. Data cleaning and exploration
2. Dimensionality reduction using PCA on food and nutrient variables
3. Visualization of PCA components and variable loadings
4. Creation of PCA-based tertiles to quantify adherence
5. Descriptive statistics and association with sociodemographic variables
6. Logistic regression model to predict diabetes prevalence based on PCA components and covariates

## Tools Used

- `dplyr`, `tidyr`, `readr` for data preprocessing
- `nortest` for normality testing
- `FactoMineR`, `factoextra`, `ggplot2` for PCA
- `gtsummary`, `broom`, `finalfit` for descriptive tables and regression output
- `R Markdown` for reproducible analysis

## Author

**Oscar Saiz Gutierrez**  
MSc in Bioinformatics

---

**Note:** This project was developed as part of the course *Statistics and R for Health Sciences* in the MSc in Bioinformatics.
