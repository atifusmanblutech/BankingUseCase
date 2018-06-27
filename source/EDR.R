library(ggplot2)

#### Estimate Deposit Age (Done) ####
plot7 <- ggplot(mydata, aes(agegroup,
                            fill = deposit)) +
  geom_bar()

#### Estimate Deposit with respect to Jobs (Done) ####
plot8  <- ggplot(mydata, aes(job,
                             fill = deposit)) +
  geom_bar()

#### Estimate Deposit with respect to Marital status (Done) ####
plot9 <- ggplot(mydata, aes(marital,
                            fill = deposit)) +
  geom_bar()
#### Estimate Deposit with respect to Education (Done) ####
plot10 <- ggplot(mydata, aes(education,
                             fill = deposit)) +
  geom_bar()
#### Estimate Deposit with respect to Default (Done) ####
plot11 <- ggplot(mydata, aes(default,
                             fill = deposit)) +
  geom_bar()
#### Estimate Deposit with respect to Balance (Done) ####
#filter_edr1 <- mydata$balance < 500
#mydatafilter_edr1 <- mydata
#[filter_edr1,]
plot12 <- ggplot(mydata, aes(balance)) +
  geom_histogram(aes(fill = deposit),
                 color="black")

#### Estimate Deposit with respect to housing (Done) ####
plot13 <- ggplot(mydata, aes(housing,
                             fill = deposit)) +
  geom_bar()

#### Estimate Deposit with respect to loan (Done)####
plot14 <- ggplot(mydata, aes(loan,
                             fill = deposit)) +
  geom_bar()

#### Estimate Deposit with respect to months (Done) ####
plot15 <- ggplot(mydata, aes(month,
                             fill = deposit)) +
  geom_bar()

#### Estimate Deposit with respect to Campaign (Done) ####
plot16 <- ggplot(mydata, aes(campaign)) +
  geom_histogram(aes(fill = deposit),
                 color = "black",
                 binwidth = 2)

#### Estimate Deposit with respect to Duration (Done)####
plot17 <- ggplot(mydata, aes(duration,
                             fill = deposit)) +
  geom_bar()


