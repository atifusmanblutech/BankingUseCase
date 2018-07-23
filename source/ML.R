#### Libraries ####
library("pROC", lib.loc="~/R/win-library/3.4")



#### File Reading and Manipulation ####
bankdata <- read.csv('data/BankData_ML.csv', sep=";")
# 
# for (row in 1:nrow(bankdata))
# {
#   bankdata$id <- as.integer(row)
#   #print(row)
# }

bankdata$id <- seq.int(nrow(bankdata))

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
bankdata$partition <- "df_train"
bankdata$partition[bankdata$rand > 0.75] <- "cv"

# Override data so that 20% is "in the future"
bankdata[(0.8 * nrow(bankdata)):(nrow(bankdata)), "partition"] <- "test"

# Create df_train dataset for exploratory analyses
#Create df_train, cv and test datasets
df_train <- bankdata[bankdata$partition == "df_train", ]
cv <- bankdata[bankdata$partition == "cv", ]
test <- bankdata[bankdata$partition == "test", ]

#### ML: Generalized Linear Model ####
set.seed(0817)

bankdata$campaigngroup <- bankdata$campaign
bankdata$campaigngroup[bankdata$campaign > 15] <- 16

vector <- c("age", "job", "marital",
            "education","default","housing","month","day_of_week","duration","campaign",
            "y")

#"pdays","previous","poutcome",

df_trainFiltered <- df_train[vector]

# df_train model on df_train dataset
glmfit <-
  glm(
    y~.,
    data = df_trainFiltered,
    family = binomial
  )

# Use fitted model to predict CV data, then calculate ROC and AUC
glmpred <- predict.glm(glmfit, newdata = cv, type = "response", progress = "text")

glmTable <- table(glmpred, cv$y)
glmroc <- roc(cv$y, glmpred)

#model accuracy
glmauc <- glmroc$auc

df_glmroc <- as.data.frame(glmroc$response)

myCV <- cv
myCV$predicted <- NULL
myCV$actual <- cv$y
for (row in 1:nrow(myCV))
{
  myCV[row, "predicted"] = as.factor(df_glmroc[row, "glmroc$response"])
  
}

#glmTable2 <- table(glmroc, cv$y)




fun_glmML <- function()
{
  
  # vector <- c(choiceML, "y")
  vector <- c("age", "job", "marital",
              "education","default","housing","month","day_of_week","duration","campaign",
              "y")
  
  #"pdays","previous","poutcome",
  
  df_trainFiltered <- df_train[vector]
  
  # df_train model on df_train dataset
  glmfit <-
    glm(
      y~.,
      data = df_trainFiltered,
      family = binomial
    )
  
  # Use fitted model to predict CV data, then calculate ROC and AUC
  glmpred <- predict.glm(glmfit, newdata = cv, type = "response", progress = "text")
  
  glmTable <- table(glmpred, cv$y)
  glmroc <- roc(cv$y, glmpred)
  
  #model accuracy
  glmauc <- glmroc$auc
  
  df_glmroc <- as.data.frame(glmroc$response)
  
  myCV <- cv
  myCV$predicted <- NULL
  myCV$actual <- cv$y
  for (row in 1:nrow(myCV))
  {
    myCV[row, "predicted"] = as.factor(df_glmroc[row, "glmroc$response"])
    
  }
  
  glmTable2 <- table(glmroc, cv$y)
  # 
  return(glmfit)
  # glmroc <- roc(cv$y, glmpred)
  # glmauc <- glmroc$auc
  # 
}



# 
# fun_filteredDF <- function(choiceML)
# {
#   df_trainFiltered <- df_train[choiceML]
#   return(df_trainFiltered)
# }