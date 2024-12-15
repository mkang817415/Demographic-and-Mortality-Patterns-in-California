# Demographic Analysis and Mortality Patterns in California Counties: A Linear Regression Approach

### Author: Mingi Kang

## Overview
This project investigates how demographic factors influence various causes of death across California’s 58 counties. Using data from **2019-2021**, we analyze mortality trends across 15 causes of death and 12 demographic variables (including age and race) through **linear regression models**.

## Data Sources
1. **California Department of Public Health**: Death Profiles by County (2019-2021).
2. **California State Association of Counties**: 2023 California demographic data.

## Key Research Question
**How do various demographic factors impact different causes of death in California?**

## Tools and Technologies
- **Python**: Data cleaning, integration, and exploratory data analysis.
- **R**: Linear regression modeling, AIC/Log Likelihood calculations, and bootstrapping.
- **Visualization**: Heatmaps for population and mortality distributions (ggplot2, tigris, and sf libraries in R).

## Statistical Approach
1. **Model Selection**: Evaluated using **Log Likelihood** and **Akaike Information Criterion (AIC)** to identify the best-fit models for each cause of death.
2. **Exploratory Data Analysis**: Heatmaps visualize population and mortality patterns across counties.
3. **Linear Models**: Multiple linear regression using demographic factors to predict mortality rates.
4. **Bootstrapping**: Evaluated stability and confidence intervals of coefficients.

## Findings
1. **Malignant Neoplasms**: The best model included demographic variables such as Asian, Black, Hispanic, White populations, and ages 0-5. Surprisingly, ages 65+ were not significant.
2. **Intentional Self-Harm (Suicide)**: The best model included the White population and three age groups (0-5, 18-64, 65+). While statistically significant, confidence intervals suggested potential non-significance for the White population.

## Limitations
- **Population disparities**: Large counties disproportionately influence trends.
- **High correlation among variables**: Difficult to isolate individual demographic impacts.
- **Confidence intervals**: Some significant coefficients include zero, suggesting potential non-significance.

## Key Metrics
- **Adjusted R-squared**: Evaluated model fit.
- **AIC**: Balances fit and complexity to choose the best model.
- **Bootstrapping**: Provides robust confidence intervals.

## How to Run
1. Clone the repository.
   ```bash
   git clone <repository-url>
   ```
2. Install dependencies:
   - **Python**: `pandas`, `numpy`, `matplotlib`
   - **R**: `ggplot2`, `dplyr`, `sf`, `tigris`
3. Run Python scripts for data cleaning.
4. Analyze linear models in R using provided scripts.

## Results
Detailed results, including heatmaps, model summaries, and bootstrapping analysis, are provided in the appendix of the project report.

## References
- [Cancer Risk by Age](https://www.cancercenter.com/community/blog/2023/06/cancer-risk-by-age)
- Data from [California Department of Public Health](https://www.cdph.ca.gov) and [California State Association of Counties](https://www.counties.org).

## Future Work
- Explore non-linear models to better capture complex relationships.
- Investigate additional demographic and socio-economic variables for deeper insights.