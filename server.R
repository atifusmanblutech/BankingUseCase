#### Libraries ####
library(shiny)
library(shinydashboard)
library(plotly)
library(ggplot2)
library(DT)

library("ggplot2", lib.loc="~/R/win-library/3.4")
library("DT", lib.loc="~/R/win-library/3.4")



#### SOURCE FILES ####
source('source/marketing.R')
source('source/loan.R')
source('source/ML.R')
source('source/EDR.R')
source('source/LoanType.R')
#### ---------------- ####

mydata <- read.csv('data/BankData.csv')

#convert email column type to character
mydata$email <- as.character(mydata$email)

#ignore
#mydata$balance <- sapply(mydata$balance, FUN = function(x) { if(x>0){x=x*10}else{x=x}})
#write.csv(mydata,"BankData.csv")
#loandata <- read.csv('LoanData.csv')

shinyServer(function(input, output, session) {
  
  #### Deposite Insights (Done) ####
  output$age_and_deposit <- renderPlotly({
    plot7
    print(
      ggplotly(plot7)
    )
  })
  
  output$job_and_deposit <- renderPlotly({
    plot8
    print(
      ggplotly(plot8)
    )
  })
  output$marital_and_deposit <- renderPlotly({
    plot9
    print(
      ggplotly(plot9)
    )
  })
  output$edu_and_deposit <- renderPlotly({
    plot10
    print(
      ggplotly(plot10)
    )
  })
  output$default_and_deposit <- renderPlotly({
    plot11
    print(
      ggplotly(plot11)
    )
  })
  output$balance_and_deposit <- renderPlotly({
    plot12
    print(
      ggplotly(plot12)
    )
  })
  output$housing_and_deposit <- renderPlotly({
    plot13
    print(
      ggplotly(plot13)
    )
  })
  output$loan_and_deposit <- renderPlotly({
    plot14
    print(
      ggplotly(plot14)
    )
  })
  output$month_and_deposit <- renderPlotly({
    plot15
    print(
      ggplotly(plot15)
    )
  })
  output$camp_and_deposit <- renderPlotly({
    plot16
    print(
      ggplotly(plot16)
    )
  })
  output$duration_and_deposit <- renderPlotly({
    plot17
    print(
      ggplotly(plot17)
    )
  })
  
  #### Job and marital status graph (Done) ####
  output$job_and_marital_fun <- renderPlotly({
    plot1 <- ggplot(mydata, aes(x = job,
                                fill = marital)) +
      geom_bar()
    print(
      ggplotly(plot1)
    )
  })
  #### Job and housing status graph (Done) ####
  output$job_and_housing_fun <- renderPlotly({
    
    plot2 <- ggplot(mydata, aes(x = job,
                                fill = housing)) +
      geom_bar()
    print(
      ggplotly(plot2)
    )
  })
  
  #### Job and housing status == no graph (LEFT) ####
  output$Plot3 <- renderPlotly({
    
    filter1 <- mydata$housing == "no"
    mydata_filter1 <- mydata[filter1,]
    
    plot3 <- ggplot(mydata_filter1, aes(x = job,
                                        fill = housing)) + 
      geom_bar() + 
      ggtitle("Job and No Housing")
    print(
      ggplotly(plot3)
    )
  })
  
  #### Age < 30, job and education (Done) ####
  output$age30_job_and_edu <- renderPlotly({
    
    filter2 <- mydata$age < 30
    mydata_filter2 <- mydata[filter2, ]
    plot4 <- ggplot(mydata_filter2, aes(x = job,
                                        fill = education)) + 
      geom_bar()
    print(
      ggplotly(plot4)
    )
  })
  
  #### housing, loan and balance > 10000 (Done) ####
  output$housing_and_loan_bal10000 <- renderPlotly({
    
    new_mydata <- mydata[
      which(
        # mydata$housing == "no"
        # &
        #   mydata$loan == "no"
        # &
        mydata$balance > 10000) , ]
    plot5 <- ggplot(new_mydata, aes(x = loan,
                                    fill = housing)) + 
      geom_bar()
    print(
      ggplotly(plot5)
    )
  })
  #### Campaign outcome with respect to months (Done) ####
    output$poutcome_and_month<- renderPlotly({
    
    plot6 <- ggplot(mydata , aes(x=month,
                                 fill=poutcome)) + 
      geom_bar()
    print(
      ggplotly(plot6)
    )
  })
    
    
  #### Marketing Section:Housing Loan ####
    output$marketingHousingLoan <- renderPlotly({
      #taking input
      selectedJobs <- input$choice_jobsPieChart
      minBalance <- input$slider_minBalance
      
      #calling function
      graph <- fun_housingPieChart(selectedJobs, minBalance)
      
      print(
        ggplotly(
          graph 
        )
      )
    })
    
  #### Marketing Section:Banking Loan ####
    output$plotly_businessLoan <- renderPlotly({
      #taking input
      selectedJobs <- input$choice_jobsPieChart_businessLoan
      minBalance <- input$slider_minBalance_businessLoan
      
      
      #calling function
      graph <- fun_businessPieChart(selectedJobs, minBalance)
      
      print(
        ggplotly(
          graph 
        )
      )
    
      })
    
    
  #### Marketing Section:Student Loan ####
    output$plotly_studentLoan <- renderPlotly({
      #taking input
      selectedEducation <- input$choice_jobsPieChart_studentLoan
      
      #calling function
      graph <- fun_studentPieChart(selectedEducation)
      
      print(
        ggplotly(
          graph 
        )
      )
      
    })
    
    
    
  #### Marketing Campaign:Housing Loan Email  ####
    observeEvent(input$btn_EmailMarketing_Housing, {

      #showing data model for verification from user
      showModal(dataModal_HousingLoan())

    })
    
    #Notification fuction
    updateNotification <- function(){
    
    notiMessage <- "Emails sent with Housing Loan Offer."
    output$notifcation_email <- renderMenu({
    
    dropdownMenu(notificationItem(text = notiMessage,icon = shiny::icon("envelope"), status = "success"), type = "notification")
    
    })
  }
    
    #Marketing: Housing Model Dialog#
    dataModal_HousingLoan <- function(failed = FALSE) {
      
      modalDialog(title = "Housing Loan Marketing Confirmation",
        
        span('Are you sure you want to send Emails for Housing Loan? '),
        
        footer = tagList(
          modalButton("Cancel"),
          actionButton("ok_HousingLoan", "OK")
        )
      )
    }
    
    # When OK button is pressed, send the emails.
    observeEvent(input$ok_HousingLoan, {
    
      textToSend <- input$input_housingLoan
      selectedJobs <- input$choice_jobsPieChart
      minBalance <- input$slider_minBalance
      
      sendEmails <- fun_housingCampaign_Email(textToSend, selectedJobs, minBalance)
      
      #updating notification menu
      updateNotification()
      
      removeModal()
      
    })
    
    
    #### Marketing Campaign: Business Loan ####
    observeEvent(input$btn_EmailMarketing_BusinessLoan, {
      
      #Show Confirmation Dialogue
      confirmSweetAlert(
        session = session,
        inputId = "confirm_BusinessLoan",
        type = "info",
        title = "Confirm Action!",
        text = tags$b(
          icon("envelope"),
          "Do you really want to send these emails ?",
          style = "color: #FA5858;"
        ),
        danger_mode = F
      )
      
      
      
      
    })
    
    observeEvent(input$confirm_BusinessLoan, {
      if (isTRUE(input$confirm_BusinessLoan)) {
        showNotification("True", type = "message")
      } else {
        showNotification("False", type = "warning")
      }
    }, ignoreNULL = TRUE)
    
    
    
  #### Loan Insights Section:Housing Loan ####
    output$loan_HousingLoan <- renderPlotly({

      #calling function
      graph <- fun_housingPieChart_loan()

      print(
        ggplotly(
          graph
          #source = "event_loanPredHousing"
        )
      )
      
      #DT_loan_HousingLoan button click
      # output$aprioriDT <- DT::renderDataTable(
      #   x,
      #   options = list(scrollX = TRUE)
      # )
      # output$DT_loan_HousingLoan <- DT::renderDataTable(
      #   #paste("Revenue Per Customer Click: ","<br>")
      #   # str(input$plot_click)
      #   
      #   d <- event_data("plotly_click",source = "event_loanPredHousing"),
      #   if (is.null(d))
      #   {
      #     #"Click on a state to view event data"
      #   }
      #   else
      #   {
      #     d
      #     
      #   },
      #   options = list(scrollx = T)
      # )
    })
    
    #### Loan Insights Section:Business Loan ####
    output$loan_BusinessLoan <- renderPlotly({
      
      #calling function
      graph <- fun_businessPieChart_loan()
      
      print(
        ggplotly(
          graph 
        )
      )
    })
    
    #### Loan Insights Section:Student Loan ####
    output$loan_StudentLoan <- renderPlotly({
      
      #calling function
      graph <- fun_studentPieChart_loan()
      
      print(
        ggplotly(
          graph 
        )
      )
    })
    
    
    #### Loan Insights Section:Loan Taken Per Job Type ####
    output$loan_LoanPerJob <- renderPlotly({
      
      new_mydata <- mydata[
        which(
          # mydata$housing == "no"
          # &
          #   mydata$loan == "no"
          # &
          mydata$balance > 10000) , ]
      
      
      plot5 <- ggplot(new_mydata, aes(x = job,
                                      fill = loan)) + 
        geom_bar()
      print(
        ggplotly(plot5,source = "A")
      )
      
     
    })
    
    eventReactive <- reactive({
      d <- event_data("plotly_click",source = "A")
      
      #df_Customers <- mydata[mydata$id %in% d$y]
      
      return(d)
      
    })
    
    # fillDT <- function(df){
      
      
      output$DT_loan_LoanPerJob <- DT::renderDataTable(
        #paste("Revenue Per Customer Click: ","<br>")
        # str(input$plot_click)
        
          df <- eventReactive()
          
        ,
        options = list(scrollx = T)
      )
      
      ######### Loan Inshal ###########
      observeEvent(input$BusinessBtn, {
        toggle('busdiv')
      })
      
      observeEvent(input$HouseBtn, {
        toggle('houdiv')
      })
      
      observeEvent(input$stdBtn, {
        toggle('stddiv')
      })
      
      output$mytableb = DT::renderDataTable({
        BusinessLoan
      })
      
      output$mytableh = DT::renderDataTable({
        HouseLoan
      })
      
      output$mytables = DT::renderDataTable({
        StudentLoan
      })
      
      #### Marketing Prediction Section:Marketing Effectiveness ####
      output$DT_ML_GLM <- DT::renderDataTable({
        
        #model will be trained on this df
        df_trainFiltered
        
      })
      
      
      
      #Train Model 
      observeEvent(input$btn_GLM_predModel, {
        #show summary box
        shinyjs::show("div_mktSummary")
        
        #display accuracy
        output$uiOutput_Summary <- renderUI({
          tags$blockquote(paste("Model Accuracy: ", glmauc))  
        })
        
        
        df_CV <- myCV[c("id","age","default","housing","actual","predicted"
                        )]
        
        # dat <- datatable(df_CV, options = list(dom = 'Bfrtip',
        #                                        searching = T,
        #                                        pageLength = 25,
        #                                        searchHighlight = TRUE,
        #                                        colReorder = TRUE,
        #                                        fixedHeader = TRUE,
        #                                        filter = 'top',
        #                                        buttons = c('copy', 'csv', 'excel', 'print'),
        #                                        paging    = TRUE,
        #                                        deferRender = TRUE,
        #                                        scroller = TRUE,
        #                                        scrollX = TRUE,
        #                                        scrollY = 550)) %>%
        #   formatStyle('predicted',  color = 'white', backgroundColor = 'green', fontWeight = 'bold')
        
        # sign_formatter <- formatter("span", 
        #                             style = x ~ style(color = ifelse(x = "yes" , "green", 
        #                                                              ifelse(x = "no", "red", "black"))))
        # sign_formatter(c("no","yes"))
        
        #display response dataframe
        output$DT_ML_PRED <- DT::renderDataTable(
          #dat
          DT::datatable(
            df_CV,
            selection = "single",
            filter = 'top',
            extensions = c('Buttons', 'ColReorder', 'FixedHeader', 'Scroller'),
            rownames = FALSE,
            options = list(
              dom = 'Bfrtip',
              searching = T,
              pageLength = 25,
              searchHighlight = TRUE,
              colReorder = TRUE,
              fixedHeader = TRUE,
              filter = 'top',
              buttons = c('copy', 'csv', 'excel', 'print'),
              paging    = TRUE,
              deferRender = TRUE,
              scroller = TRUE,
              scrollX = TRUE,
              scrollY = 400
            )
          ) %>%
            formatStyle('predicted',  
                        color = 'white', fontWeight = 'bold',
                        background = styleEqual(c('yes','no'), c('green', 'red')))
            # %>%
            # formattable("")
          
            # Style cells with max_val vector
            # formatStyle(
            #   columns = 2:5,
            #   backgroundColor = styleEqual(levels = max_val, values = rep("yellow", length(max_val)))
            # )
            # 
        )
        
      })
      
      
      # output$text_ML_GLM <- renderPrint({
      #   
      #   selectedCols <- input$choice_GLM
      #   tt <- fun_glmML(selectedCols)
      #   
      #   summary(tt)
      # })
      
      output$plot_ML_GLM <- renderPlot({
        
        
        # tt <- fun_glmML()
        # glmpred2 <- predict(glmfit, newdata = cv, type = "response")
        # 
        # #prune.fit<-prune(tt, cp=0.001)
        # # prune the treefirst then plot the pruned tree 
        # plot(glmpred2, uniform=TRUE, 
        #      main="Pruned Classification Tree for iris data")
        
        #text(glmpred2, use.n=TRUE, all=TRUE, cex=.8)
        
        #require(graphics)
        
        ## Predictions
        # x <- rnorm(15)
        # y <- x + rnorm(15)
        # predict(lm(y ~ x))
        # new <- data.frame(x = seq(-3, 3, 0.5))
        # predict(lm(y ~ x), new, se.fit = TRUE)
        # pred.w.plim <- predict(lm(y ~ x), new, interval = "prediction")
        # pred.w.clim <- predict(lm(y ~ x), new, interval = "confidence")
        # matplot(new$x, cbind(pred.w.clim, pred.w.plim[,-1]),
        #         lty = c(1,2,2,3,3), type = "l", ylab = "predicted y")
         
      })
    
})