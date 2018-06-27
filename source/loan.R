library(ggplot2)  
library(plotly)

#### Function:Housing Loan  ####
fun_housingPieChart_loan <- function() {
  
  #filter df
  df_housing <- mydata[
    which(
      mydata$housing == "no"
      &
        mydata$loan == "no"
      &
        !(mydata$job %in% c("student","unknown", "unemployed", "retired","housemaid", "self-employed", "technician"))
      #!(mydata$job %in% c("student","unknown", "unemployed", "retired"))
      &
        mydata$balance > 10000) , ]
  
  #group df with jobs
  df_housing_pieChart <- df_housing %>%
    group_by(job) %>%
    dplyr::summarise(customers = n_distinct(id))
  
  #counting total customers
  totalCustomers <- nrow(df_housing)
  
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
  
  return(p)
}


#### Function:Business Loan ####
fun_businessPieChart_loan <- function() {
  #filter df with selected jobs and minimum balance
  df_business <- mydata[
    which(
      mydata$loan == "no"
      &
        mydata$job %in% c("entrepreneur","admin.", "management", "retired")
      #mydata$job %in% c("entrepreneur","admin.", "management", "retired")
      &
        mydata$balance > 10000) , ]
  
  
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
fun_studentPieChart_loan <- function() {
  #filter df with selected jobs and minimum balance
  df_student <- mydata[
    which(
      mydata$loan == "no"
      &
        mydata$default == "no"
      &
        mydata$job %in% "student"
      &
        mydata$education %in% c("primary","secondary","tertiary","unknown")) , ]
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