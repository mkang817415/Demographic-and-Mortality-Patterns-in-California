library(corrplot)
library(ggplot2)




# function to calculate log likelihood for a linear model 
calc.llk.lm <- function(lm.in){
  eps <- lm.in$residuals
  N <- length(eps) 
  var <- 1/(N) *sum(eps^2, na.rm=TRUE)
  llk <- sum(dnorm(eps, 0, sqrt(var), log=TRUE), na.rm=TRUE)
  return (llk) 
}

# Function to calculate the AIC
calc.aic <- function(model){
  # Getting number of parameters  
  # nolint: trailing_whitespace_linter.
  K <-length(coef(model)) + 1 
  
  
  # Getting the log likelihood
  llk <- calc.llk.lm(model)
  
  aic <- 2 * K - 2 * llk 
  return (aic)
}

## Optional : Function to calculate the number of parameters in a linear model 
calc.num.parameters <- function(lm.in){
  K <-length(coef(lm.in)) + 1 
  return (K)
}


# Function to generate all possible subsets of a vector
getSubsets <- function(vec) {
  n <- length(vec)
  subsets <- list()
  for (i in 0:n) {
    subsets <- c(subsets, combn(vec, i, simplify = FALSE))
  }
  return(subsets)
}



# Get data for demographic and death data
data.set <- read.csv("Data/Final Data/demographic_death.csv")

# attaching variable names to columns
column.names <- c("County", "Population", 
                    "American-Indian", "Asian", "Black", "Hispanic", "Muli-Racial", "Pacific-Islander", "White",  # nolint
                    "0-5", "6-17", "18-64", "65+", 
                    "All-Causes", "Alzheimer-Disease", "Malignant-Neoplasms", 
                    "Chronic-Lower-Respiratory-Disease", "Diabetes-Mellitus", "Assult-Homicide",
                    "Disease-of-Heart", 
                    "Essential-Hypertension-Hypertensive-Renal-Disease", "Accident-Unintentional", 
                    "Chronic-Liver-Disease-Cirrhosis", "Nephritis-Nephrotic-Syndrome-Nephrosis",
                    "Parkinsons-Disease", "Influenza-Pneumonia", 
                    "Cerebrovascular-Disease", "Intentional-Self-Harm-Suicide")

# Attaching variable names to columns
names(data.set) <- c("C", "P", "AI", "A", "B", "H", "MR", "HPI", "W", 
                     "X0_5", "X6_17", "X18_64", "X65_plus", 
                     "AC", "AD", "MN", "CLRD", "DM", "AH", "DOH", "EHHRD", "AU", "CLDC", 
                     "NNSN", "PD", "IP", "CD", "ISHS")

# Demographic variables
dem <- c("P", "AI", "A", "B", "H", "MR", "HPI", "W", 
         "X0_5", "X6_17", "X18_64", "X65_plus")

# Cause of death variables
dea <- c("AC", "AD", "MN", "CLRD", "DM", "AH", "DOH", "EHHRD", "AU", "CLDC", 
         "NNSN", "PD", "IP", "CD", "ISHS")

# Correlation matrix
cor.mat <- cor(data.set[, -1])
corrplot(cor.mat)

# Function to generate all possible linear models
generateModels <- function(response, predictors, data) {
  # Get all subsets of predictors
  predictorSubsets <- getSubsets(predictors)
  
  # Initialize a list to store the models
  models <- list()
  
  # For each subset of predictors...
  for (i in 1:length(predictorSubsets)) { # nolint
    # Skip if the subset is empty
    if (length(predictorSubsets[[i]]) == 0) next
    
    # Generate the formula for the linear model
    formula <- as.formula(paste(response, "~", paste(predictorSubsets[[i]], collapse = "+")))
    
    # Fit the linear model and store it in the list
    model <- try(lm(formula, data=data), silent=TRUE)
    if (!inherits(model, "try-error")) {
      models[[length(models) + 1]] <- model
    }
  }
  
  return(models)
}





response <- dea[1]  # Get the name of the response variable
predictors <- dem  # Get the names of the predictor variables
models <- generateModels(response, predictors, data.set)

# Calculate LLK for each model 
llk.values <- sapply(models, calc.llk.lm)
maxLLKIndex <- which.max(llk.values)

# Calculate AIC for each model
aic.values <- sapply(models, calc.aic)
minAICIndex <- which.min(aic.values)

print(summary(models[[minAICIndex]]))

# Plot the AIC values
ggplot(data.frame(AIC=aic.values), aes(x=1:length(aic.values), y=aic.values)) +
  geom_point() +
  geom_line() +
  geom_vline(xintercept=minAICIndex, color="red") +
  labs(title="AIC values for all models", x="Model", y="AIC")


 # Standardizing the data
std.data.set <- data.set 
for (i in 2:ncol(data.set)) {
  std.data.set[, i] <- (data.set[, i] - mean(data.set[,i], na.rm=TRUE))
  std.data.set[, i] <- std.data.set[,i]/sd(data.set[,i], na.rm=TRUE)
}

attach(std.data.set)

### Standardized data 
response <- dea[1]  # Get the name of the response variable
predictors <- dem  # Get the names of the predictor variables
std.models <- generateModels(response, predictors, std.data.set)




# Calculate LLK for each model 
std.llk.values <- sapply(std.models, calc.llk.lm)
std.maxLLKIndex <- which.max(std.llk.values)

# Calculate AIC for each model
std.aic.values <- sapply(std.models, calc.aic)
std.minAICIndex <- which.min(std.aic.values)

print(summary(std.models[[std.minAICIndex]]))

