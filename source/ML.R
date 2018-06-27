#### Libraries ####




#### File Reading and Manipulation ####
bankdata <- read.csv('data/BankData_ML.csv', sep=";")


#Convert to factors, and change job levels
bankdata$job <- as.character(bankdata$job)
bankdata$job[bankdata$job == "blue-collar"] <- "blue.collar"
bankdata$job[bankdata$job == "self-employed"] <- "self.employed"
bankdata$job[is.na(bankdata$job)] <- "unknown"
# bankdata[sapply(bankdata,is.numeric)]<-lapply(bankdata[sapply(bankdata,is.numeric)],as.factor)
bankdata[sapply(bankdata, is.character)] <-
  lapply(bankdata[sapply(bankdata, is.character)], as.factor)


bankdata$y <- as.factor(bankdata$y)

# Split df_training and cv, so we get 60:20:20 proportion
set.seed(0816)
bankdata$rand <- runif(nrow(bankdata), 0, 1)
bankdata$id <- "df_train"
bankdata$id[bankdata$rand > 0.75] <- "cv"

# Override data so that 20% is "in the future"
bankdata[(0.8 * nrow(bankdata)):(nrow(bankdata)), "id"] <- "test"

# Create df_train dataset for exploratory analyses
#Create df_train, cv and test datasets
df_train <- bankdata[bankdata$id == "df_train", ]
cv <- bankdata[bankdata$id == "cv", ]
test <- bankdata[bankdata$id == "test", ]

#### ML: Generalized Linear Model ####
set.seed(0817)

bankdata$campaigngroup <- bankdata$campaign
bankdata$campaigngroup[bankdata$campaign > 15] <- 16

fun_glmML <- function(choiceML)
{
  
  vector <- c(choiceML, "y")
  df_trainFiltered <- df_train[vector]
  
  # df_train model on df_train dataset
  glmfit <-
    glm(
      y~.,
      data = df_trainFiltered,
      family = binomial
    )
  
  # Use fitted model to predict CV data, then calculate ROC and AUC
  # glmpred <- predict(glmfit, newdata = cv, type = "response")
  # 
  # glmTable <- table(glmpred, cv$y)
  # 
  return(glmfit)
  # glmroc <- roc(cv$y, glmpred)
  # glmauc <- glmroc$auc
  # 
}

fun_filteredDF <- function(choiceML)
{
  df_trainFiltered <- df_train[choiceML]
  return(df_trainFiltered)
}