#Business Loan
BusinessLoan <- mydata[
  which(
    mydata$housing == "yes"
    &
      mydata$loan == "no"
    &
      !(mydata$job %in% c("student","unknown", "unemployed", "retired","housemaid", "self-employed", "technician"))
    &
      mydata$balance > 15000) , ]

BusinessLoan$LoanType <- "Business Loan"

#Housing Loan
HouseLoan <- mydata[
  which(
    mydata$housing =="no"
    &
      mydata$loan == "no"
    &
      mydata$balance > 15000) , ]
HouseLoan$LoanType <- "Housing Loan"

#Student Loan
StudentLoan  <- mydata[
  which(
    mydata$loan == "no"
    &
      mydata$default == "no"
    &
      mydata$balance > 15000
    &
      mydata$job %in% "student"
    &
      mydata$education %in% c("secondary","tertiary")) , ]

StudentLoan$LoanType <- "Student Loan"

#Loane <- rbind(StudentLoan,HouseLoan,BusinessLoan)