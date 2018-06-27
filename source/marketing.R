#function(input, output, session){
library(ggplot2)  
library(plotly)

library("gmailr", lib.loc="~/R/win-library/3.4")
library("purrr", lib.loc="~/R/win-library/3.4")
library("readr", lib.loc="~/R/win-library/3.4")

#### Email Authentication ####

use_secret_file("blutechtesting.json")
email_sender <- '<blutech.testing@gmail.com>' # your Gmail address
optional_bcc <- 'Anonymous <blutech.testing@gmail.com>'

#### Function:Housing Loan ####

fun_housingPieChart <- function(selectedJobs, minBalance) {
  
  #filter df
  df_housing <- mydata[
    which(
      mydata$housing == "no"
      &
        mydata$loan == "no"
      &
        mydata$job %in% selectedJobs
        #!(mydata$job %in% c("student","unknown", "unemployed", "retired"))
      &
        mydata$balance > minBalance) , ]
  
  #group df with jobs
  df_housing_pieChart <- df_housing %>%
    group_by(job) %>%
    dplyr::summarise(customers = n_distinct(id))
  
  #counting total customers
  totalCustomers <- nrow(df_housing)
  
  m <- list(
    l = 50,
    r = 50,
    b = 10,
    t = 10,
    pad = 4
  )
  
  p <- plot_ly(df_housing_pieChart, labels = ~job, values = ~customers, type = 'pie',
               textposition = 'inside',
               #textinfo = 'label+number',
               insidetextfont = list(color = '#FFFFFF'),
               hoverinfo = 'text',
               text = ~paste(customers, '', job ,' Customers'),
               marker = list(colors = colors,
                             line = list(color = '#FFFFFF', width = 1)),
               showlegend = FALSE) %>%
    layout(title = paste('Total ', totalCustomers,' Customers in Each Type of Job') ,
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
           #autosize = F, width = 500, height = 500, margin = m)
  
  return(p)
}


#### Function:Business Loan ####
fun_businessPieChart <- function(selectedJobs, minBalance) {
  #filter df with selected jobs and minimum balance
  df_business <- mydata[
    which(
        mydata$loan == "no"
      &
        mydata$job %in% selectedJobs
        #mydata$job %in% c("entrepreneur","admin.", "management", "retired")
      &
        mydata$balance > minBalance) , ]
  
  
  df_business_pieChart <- df_business %>%
    group_by(job) %>%
    dplyr::summarise(customers = n_distinct(id))
  
  #counting total customers
  totalCustomers <- nrow(df_business)
  
  p <- plot_ly(df_business_pieChart, labels = ~job, values = ~customers, type = 'pie',
               textposition = 'inside',
               #textinfo = 'label+number',
               insidetextfont = list(color = '#FFFFFF'),
               hoverinfo = 'text',
               text = ~paste(customers, '', job ,' Customers'),
               marker = list(colors = colors,
                             line = list(color = '#FFFFFF', width = 1)),
               showlegend = FALSE) %>%
    layout(title = paste('Business Loan can be provided to the following ', totalCustomers,' Customers') ,
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  
  return(p)
}

#### Function:Student Loan ####
fun_studentPieChart <- function(selectedEducation) {
  #filter df with selected jobs and minimum balance
  df_student <- mydata[
    which(
      mydata$loan == "no"
      &
        mydata$default == "no"
      &
        mydata$job %in% "student"
      &
        mydata$education %in% selectedEducation) , ]
      #selectedEducation
        # c("primary","secondary","tertiary","unknown")
      # &
      #   mydata$agegroup == "adult") , ]
  
  
  df_student_pieChart <- df_student %>%
    group_by(education) %>%
    dplyr::summarise(customers = n_distinct(id))
  
  #counting total customers
  totalCustomers <- nrow(df_student)
  
  p <- plot_ly(df_student_pieChart, labels = ~education, values = ~customers, type = 'pie',
               textposition = 'inside',
               #textinfo = 'label+number',
               insidetextfont = list(color = '#FFFFFF'),
               hoverinfo = 'text',
               text = ~paste(customers, ' having ', education ,' Education'),
               marker = list(colors = colors,
                             line = list(color = '#FFFFFF', width = 1)),
               showlegend = FALSE) %>%
    layout(title = paste('Student Loan can be provided to the following ', totalCustomers,' Customers') ,
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  
  return(p)
}


#### Marketing Campaign:Housing Loan ####


fun_housingCampaign_Email <- function(textToSend, selectedJobs, minBalance){
  
  #creating a dataframe w.r.t choices selected
  df_housing_marketing <- mydata[
    which(
      mydata$housing == "no"
      &
        mydata$loan == "no"
      &
        mydata$job %in% selectedJobs
      #!(mydata$job %in% c("student","unknown", "unemployed", "retired"))
      &
        mydata$balance > minBalance) , ]
  # 
  # df_housing_marketing <- mydata[
  #   which(
  #     mydata$housing == "no"
  #     &
  #       mydata$loan == "no"
  #     &
  #       mydata$job %in% c("student","unknown", "unemployed", "retired")
  #     #!(mydata$job %in% c("student","unknown", "unemployed", "retired"))
  #     &
  #       mydata$balance > 10000) , ]
  
  df_housing_10 <- head(df_housing_marketing,n=10)
  
  df_housingEmail <- df_housing_10 %>%
    dplyr::mutate(
      To = df_housing_10$email,
      Bcc = optional_bcc,
      From = email_sender,
      Subject = "Housing Loan Offer",
      body = textToSend) %>%
    select(To, Bcc, From, Subject, body)
  
  # converting into mime
  mime_df_housingEmail <- df_housingEmail %>%
    pmap(mime)
  
  # its a function to send messages
  safe_send_message <- safely(send_message)
  
  sent_mail <- mime_df_housingEmail %>%
    map(safe_send_message)
  
  # saveRDS(sent_mail,
  #         paste(gsub("\\s+", "_", "Housing Loan Offer"), "sent-emails.rds", sep = "_"))
  # # 
 
  df_housingEmail$marketing <- "Housing Loan"
  df_housingEmail$datetime <- format(Sys.time(), "%D %X")
  write.csv(df_housingEmail, "data/email_marketing_csv.csv",append = TRUE)
  
  showNotification("Emails sent for Housing Loan", type = "message")
  # errors <- sent_mail %>% 
  #   transpose() %>% 
  #   .$error %>% 
  #   map_lgl(Negate(is.null))
  # 
  # errorList <- as.list(errors)
  # 
  # showModal(modalDialog(
  #   title = "SMS Marketing",
  #   "This is an important message!",
  #   easyClose = TRUE
  # ))
  
  #summary(errors)
  #sent_mail[errors]

  # test_email <- mime(
  #   To = "hamza.khan.niazi04@gmail.com",
  #   From = email_sender,
  #   Subject = "this is just a gmailr test",
  #   body = "Can you hear me now?")
  # send_message(test_email)
}


#### Marketing Insgihts:Age ####

fun_ageInsights_marketing <- function()
{
  my_dat <- summarise(group_by(mydata,count = mydata$age))
  
  p_all <- ggplot(mydata, aes(x=mydata$age )) +
    geom_point(aes(x=mydata$age, y=mydata$deposit)) 
  
  
  par(mar = c(5, 5, 4, 4))
  hist(mydata$age,
       main = "Distribution of Customers by Age",
       xlab = "Age in Years",
       col = "#BB8FCE")
  par(new = T)
  plot(
    prop.table(table(mydata$age, mydata$deposit), 1)[, 2],
    xlab = NA,
    ylab = NA,
    axes = F,
    col = "#CB4335",
    pch = 16
  )
  par(new = T)
  mtext("Probability of Conversion", side = 4, line = 3)
  axis(
    4,
    ylim = c(0, 1),
    col = "black",
    col.axis = "black",
    las = 1
  )
}

