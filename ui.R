#### Libraries ####
library(shiny)
library(shinydashboard)
library(plotly)
library(ggplot2)

library("shinyWidgets", lib.loc="~/R/win-library/3.4")
library("plotly", lib.loc="~/R/win-library/3.4")
library("ggplot2", lib.loc="~/R/win-library/3.4")
library("shinydashboard", lib.loc="~/R/win-library/3.4")

library("shinyjs", lib.loc="~/R/win-library/3.4")



#### --------- ####

dashboardPage(
  #### Application title ####
  dashboardHeader(title = "Bank Data Analysis", dropdownMenuOutput("notifcation_email")),
  #### Sidebar ####
  dashboardSidebar(
    width = 270,
    sidebarMenu(id = "sidebar",
                menuItem("Deposit Estimates",
                         tabName = "deposit_insight",
                         icon = icon("menu-hamburger",
                                     lib = "glyphicon")),
                menuItem("Customer Analysis",
                         tabName = "customer_analysis",
                         icon = icon("menu-hamburger",
                                     lib = "glyphicon")
                ),
                menuItem("Loan",
                         #tabName = "loan_prediction",
                         icon = icon("menu-hamburger",
                                     lib = "glyphicon"),
                         menuSubItem("Loan Insights",
                                     tabName = "loan_pred",
                                     icon = icon("menu-hamburger",
                                                 lib = "glyphicon")),
                         menuSubItem("Loan Prediction",
                                     tabName = "loan_insgihts",
                                     icon = icon("menu-hamburger",
                                                 lib = "glyphicon"))),
                menuItem("Fraud Detection",
                         tabName = "fraud_detection",
                         icon = icon("menu-hamburger",
                                     lib = "glyphicon")),
                menuItem("Marketing",
                         tabName = "marketing",
                         icon = icon("menu-hamburger",
                                     lib = "glyphicon"),
                         menuSubItem("Marketing Insights",
                                     tabName = "marketing_insights",
                                     icon = icon("menu-hamburger",
                                                 lib = "glyphicon")),
                         menuSubItem("Marketing Action",
                                     tabName = "marketing",
                                     icon = icon("menu-hamburger",
                                                 lib = "glyphicon")),
                         
                         menuSubItem("Marketing Prediction",
                                     tabName = "marketing_ML",
                                     icon = icon("menu-hamburger",
                                                 lib = "glyphicon")))
    )
  ),
  #### Dashboard Body####
  dashboardBody(
    tabItems(
      #### Deposit Estimate ####
      #### Deposit Insights ####
      tabItem(tabName = "deposit_insight",
              ##### Age vs Deposit Graph ####
              fluidRow(
                box(fluid = TRUE,
                    width = 12,
                    status = "primary",
                    collapsible = T,
                    solidHeader = T,
                    title = "Age vs Deposit",
                    plotlyOutput("age_and_deposit"),
                    h3("Older people have high deposit rate",
                       align = 'center',
                       style= "color: #3c8dbc;")
                )
              ),
              ##### Job vs Deposit Graph ####
              fluidRow(
                box(fluid = TRUE,
                    width = 12,
                    status = "primary",
                    collapsible = T,
                    solidHeader = T,
                    title = "Job vs Deposit",
                    plotlyOutput("job_and_deposit"),
                    h3("People at management deposit more followed by technician and bluecollar",
                       align = 'center',
                       style= "color: #3c8dbc;")
                )
              ),
              ##### Marital vs Deposit Graph ####
              fluidRow(
                box(fluid = TRUE,
                    width = 12,
                    status = "primary",
                    collapsible = T,
                    solidHeader = T,
                    title = "Marital vs Deposit",
                    plotlyOutput("marital_and_deposit"),
                    h3("Married people deposit more than others",
                       align = 'center',
                       style= "color: #3c8dbc;")
                )
              ),
              ##### Education vs Deposit Graph ####
              fluidRow(
                box(fluid = TRUE,
                    width = 12,
                    status = "primary",
                    collapsible = T,
                    solidHeader = T,
                    title = "Education vs Deposit",
                    plotlyOutput("edu_and_deposit"),
                    h3("People who have secondary level education deposit more",
                       align = 'center',
                       style= "color: #3c8dbc;")
                )
              ),
              ##### Default vs Deposit Graph ####
              fluidRow(
                box(fluid = TRUE,
                    width = 12,
                    status = "primary",
                    collapsible = T,
                    solidHeader = T,
                    title = "Default vs Deposit",
                    plotlyOutput("default_and_deposit"),
                    h3("People having no credit default deposit more & people having credit default almost have no deposit",
                       align = 'center',
                       style= "color: #3c8dbc;")
                )
              ),
              ##### Balance vs Deposit Graph ####
              fluidRow(
                box(fluid = TRUE,
                    width = 12,
                    status = "primary",
                    collapsible = T,
                    solidHeader = T,
                    title = "Balance vs Deposit",
                    plotlyOutput("balance_and_deposit"),
                    h3("People who have below 500 balance, deposit more",
                       align = 'center',
                       style= "color: #3c8dbc;")
                )
              ),
              ##### Housing vs Deposit Graph ####
              fluidRow(
                box(fluid = TRUE,
                    width = 12,
                    status = "primary",
                    collapsible = T,
                    solidHeader = T,
                    title = "Housing vs Deposit",
                    plotlyOutput("housing_and_deposit"),
                    h3("People who don't have house deposit more than people who have house",
                       align = 'center',
                       style= "color: #3c8dbc;")
                )
              ),
              ##### Loan vs Deposit Graph ####
              fluidRow(
                box(fluid = TRUE,
                    width = 12,
                    status = "primary",
                    collapsible = T,
                    solidHeader = T,
                    title = "Loan vs Deposit",
                    plotlyOutput("loan_and_deposit"),
                    h3("People who don't have personal loan deposit more than people who have personal loan",
                       align = 'center',
                       style= "color: #3c8dbc;")
                )
              ),
              ##### Month vs Deposit Graph ####
              fluidRow(
                box(fluid = TRUE,
                    width = 12,
                    status = "primary",
                    collapsible = T,
                    solidHeader = T,
                    title = "Month vs Deposit",
                    plotlyOutput("month_and_deposit"),
                    h3("People who are contacted in the month of May deposit more followed by August, July and April",
                       align = 'center',
                       style= "color: #3c8dbc;")
                )
              ),
              ##### Campaign vs Deposit Graph ####
              fluidRow(
                box(fluid = TRUE,
                    width = 12,
                    status = "primary",
                    collapsible = T,
                    solidHeader = T,
                    title = "Campaign vs Deposit",
                    plotlyOutput("camp_and_deposit"),
                    h3("People who are contacted for less than 5 times deposit more",
                       align = 'center',
                       style= "color: #3c8dbc;")
                )
              ),
              ##### Duration vs Deposit Graph ####
              fluidRow(
                box(fluid = TRUE,
                    width = 12,
                    status = "primary",
                    collapsible = T,
                    solidHeader = T,
                    title = "Duration vs Deposit",
                    plotlyOutput("duration_and_deposit"),
                    h3("People whose duration of contact is less than 5 minutes deposit more",
                       align = 'center',
                       style= "color: #3c8dbc;")
                )
              )
      ),
      #### Customer Analysis ####
      tabItem(tabName = "customer_analysis",
              #Job VS Marital status Graph
              fluidRow(
                box(fluid = TRUE,
                    width = 12,
                    status = "primary",
                    collapsible = T,
                    solidHeader = T,
                    title = "Job VS Marital status",
                    plotlyOutput("job_and_marital_fun")
                )
              ),
              #Job VS Housing status Graph
              fluidRow(
                box(fluid = TRUE,
                    width = 12,
                    status = "primary",
                    collapsible = T,
                    solidHeader = T,
                    title = "Job VS Housing status",
                    plotlyOutput("job_and_housing_fun")
                )
              ),
              #Age < 30, job and education
              fluidRow(
                box(fluid = TRUE,
                    width = 12,
                    status = "primary",
                    collapsible = T,
                    solidHeader = T,
                    title = "Job and Education above 30 years old",
                    plotlyOutput("age30_job_and_edu")
                )
              ),
              #housing, loan and balance > 10000
              fluidRow(
                box(fluid = TRUE,
                    width = 12,
                    status = "primary",
                    collapsible = T,
                    solidHeader = T,
                    title = "Loan and Housing with more then 10000 Balance",
                    plotlyOutput("housing_and_loan_bal10000")
                )
              ),
              #Campaign outcome with respect to months
              fluidRow(
                box(fluid = TRUE,
                    width = 12,
                    status = "primary",
                    collapsible = T,
                    solidHeader = T,
                    title = "Monthly Outcome of Campaign",
                    plotlyOutput("poutcome_and_month")
                )
              )
      ),
      #### Loan Insights ####
      tabItem(tabName = "loan_insights",
            
              fluidRow(
                
                         box(width = 12, title = "Housing Loan Insights", status = "primary",solidHeader = T, collapsible = T,
                             plotlyOutput("loan_HousingLoan"),
                             tags$hr(),
                             tags$blockquote("Housing Loan can be provided to customers having",
                                             strong(" no House"),",",
                                             strong(" no previous Loan"),", ",
                                             strong(" selected job(s)"),", and ",
                                             strong(" having a Bank balance above 10,000."))
                         ),
                         # box(
                         #   width = 12,  status = "primary", collapsible = T, solidHeader = T, title = "Housing Pie Chart Expanded", 
                         #   DT::dataTableOutput("DT_loan_HousingLoan")
                         # ),
                         box(width = 12, title = "Business Loan Insights", status = "primary",solidHeader = T, collapsible = T,
                             plotlyOutput("loan_BusinessLoan"),
                             tags$hr(),
                             tags$blockquote("Business Loan can be provided to customers having",
                                      #strong(" no House"),",",
                                             strong(" no previous Loan"),", ",
                                             strong(" selected job(s)"),", and ",
                                             strong(" having a Bank balance above 10,000."))
                              
                         ),
                         box(width = 12, title = "Student Loan Insights", status = "primary",solidHeader = T, collapsible = T,
                             plotlyOutput("loan_StudentLoan"),
                             tags$hr(),
                             tags$blockquote("Student Loan will be provided to customers having",
                                             #strong(" no House"),",",
                                             strong(" no previous Loan"),", ",
                                             strong(" selected education level(s)"))
                             
                         ),
                         box(width = 12, title = "Loans taken Per Job Type", status = "primary",solidHeader = T, collapsible = T,
                             plotlyOutput("loan_LoanPerJob"),
                             tags$hr(),
                             tags$blockquote("This graph shows that most of the Loans are taken by ",
                                             strong(" admins"),", ",
                                             strong(" blue-colors"),", and ",
                                             strong(" managers. "),
                                             "While the rest of the job holders hardly take any loans. "
                                             )
                         ),
                         box(width = 12, title = "Detail", status = "primary",solidHeader = T, collapsible = T,
                             DT::dataTableOutput("DT_loan_LoanPerJob")
                         )
                             
                         
              )#end of fluid row
                
             
      ),
      
      ## Loan Prediction ####
      tabItem(tabName = "loan_pred",
              
              fluidRow( useShinyjs(),
                        
                        box(width = 12, title = "Business Loan", status = "primary",solidHeader = T, collapsible = T,
                            tags$blockquote("Customers Eligible for Business Loan would be having",
                                            strong(" no House"),",",
                                            strong(" no previous Loan"),", ",
                                            strong(" selected job"),", and ",
                                            strong(" having a Bank balance above selected value.")),
                            actionBttn(inputId = "BusinessBtn",label = "Predict",icon = icon("search", lib = "glyphicon"),color = "primary",style = "material-flat"),
                            tags$script(HTML('document.getElementById("BusinessBtn").onclick = function(){$(this).hide() }')),
                            hidden(
                              div(id="busdiv",style = 'overflow-x: scroll', DT::dataTableOutput('mytableb'))
                            )),
                        
                        
                        box(width = 12, title = "Housing Loan", status = "primary",solidHeader = T, collapsible = T,
                            tags$blockquote("Customers Eligible for Housing Loan would be having",
                                            strong(" no House"),",",
                                            strong(" no previous Loan"),", and ",
                                            strong(" having a Bank balance above selected value.")),
                            actionBttn(inputId = "HouseBtn",label = "Predict",icon = icon("search", lib = "glyphicon"),color = "primary",style = "material-flat"),
                            tags$script(HTML('document.getElementById("HouseBtn").onclick = function(){$(this).hide() }')),
                            hidden(
                              div(id="houdiv",style = 'overflow-x: scroll', DT::dataTableOutput('mytableh'))
                            )),
                        
                        box(width = 12, title = "Student Loan", status = "primary",solidHeader = T, collapsible = T,
                            tags$blockquote("Students Eligible for Student Loan would be having",
                                            strong(" no previous Loan"),", ",
                                            strong(" selected education"),", and ",
                                            strong(" having a Bank balance above selected value.")),
                            actionBttn(inputId = "stdBtn",label = "Predict",icon = icon("search", lib = "glyphicon"),color = "primary",style = "material-flat"),
                            tags$script(HTML('document.getElementById("stdBtn").onclick = function(){$(this).hide() }')),
                            hidden(
                              div(id="stddiv",style = 'overflow-x: scroll', DT::dataTableOutput('mytables'))
                            ))
                        
              )#end of fluid row
      ),
      
      #### Fraud Detection ####
      tabItem(tabName = "fraud_detection",
              fluidRow(
                box(width = 12,
                    print("Fraud Detection")
                )
              )
      ),
      #### Marketing ####
      tabItem(tabName = "marketing",
              #marketing for housing loan
              fluidRow(
                box(width = 12, title = "Marketing for Housing Loan",
                    status = "primary", collapsible = T, solidHeader = T,
                    
                      box(width = 8, title = "Graph", status = "primary",solidHeader = T,
                          plotlyOutput("marketingHousingLoan"),
                          tags$hr(),
                          tags$blockquote("Housing Loan will be provided to customers having",
                                          strong(" no House"),",",
                                          strong(" no previous Loan"),", ",
                                          strong(" selected job"),", and ",
                                          strong(" having a Bank balance above selected value."))
                          
                          ),
                      box(width = 4, title = "Marketing", status = "warning",solidHeader = T,
                          checkboxGroupButtons(
                            inputId = "choice_jobsPieChart", label = "Filter Jobs :", 
                            choices = c("admin.", "blue-collar", "entrepreneur",
                                        "housemaid","management","retired",
                                        "self-employed","services","student",
                                        "technician","unemployed","unknown"),
                            selected = c("admin.", "blue-collar", "entrepreneur",
                                         "housemaid","management",
                                         "selff-employed","services",
                                         "technician"),
                            justified = F, direction = "horizontal", status = "warning",
                            checkIcon = list(yes = icon("ok", lib = "glyphicon"), no = icon("remove", lib = "glyphicon"))
                          ),
                          sliderInput("slider_minBalance", "Minimum Bank Balance:",
                                      min = 100, max = 100000,
                                      value = 10000),
                          br(),
                          textAreaInput(
                            "input_housingLoan",
                            "Enter campaign text or offers to send: ", value = "",
                            placeholder = "You having been selected for Housing Loan.
                            To avail this offer, kindly contact our customer support at 111-222-333!",
                            width = "100%",
                            height = "200px",
                            resize = "vertical"
                          ),
                          #verbatimTextOutput("value"),
                          br(),
                          actionButton("btn_EmailMarketing_Housing", "Launch Email Campaign",icon("envelope"),
                                       style = "color: #fff; background-color: orange; 
                                       border-color: orange; width: 100%; padding-left: 2dp; margin: 5dp;"
                          )
                          )#end of marketing box
                     
                ) #end of box1 of marketing housing loan
              ),
              
              #marketing for business loan
              fluidRow(
                box(width = 12, title = "Marketing for Business Loan",
                    status = "primary", collapsible = T, solidHeader = T,
                    box(width = 8, title = "Graph", status = "primary",solidHeader = T,
                        plotlyOutput("plotly_businessLoan"),
                        tags$blockquote("Business Loan will be provided to customers having",
                                        #strong(" no House"),",",
                                        strong(" no previous Loan"),", ",
                                        strong(" selected job(s)"),", and ",
                                        strong(" having a Bank balance above selected value."))
                        # 
                        # helpText("Business Loan will be provided to customers having",
                        #          #strong(" no House"),",",
                        #          strong(" no previous Loan"),", ",
                        #          strong(" selected job(s)"),", and ",
                        #          strong(" having a Bank balance above selected value."))
                    ),
                    box(width = 4, title = "Marketing", status = "warning",solidHeader = T,
                        checkboxGroupButtons(
                          inputId = "choice_jobsPieChart_businessLoan", label = "Filter Jobs :", 
                          choices = c("admin.", "blue-collar", "entrepreneur",
                                      "management","retired"
                          ),
                          selected = c("admin.","entrepreneur",
                                       "management",
                                       "retired"),
                          justified = F, direction = "horizontal", status = "warning",
                          checkIcon = list(yes = icon("ok", lib = "glyphicon"), no = icon("remove", lib = "glyphicon"))
                        ),
                        sliderInput("slider_minBalance_businessLoan", "Minimum Bank Balance:",
                                    min = 100, max = 100000,
                                    value = 10000),
                        #verbatimTextOutput("value"),
                        br(),
                        actionButton("btn_EmailMarketing_BusinessLoan", "Launch Email Campaign",icon("envelope"),
                                     style = "color: #fff; background-color: orange; border-color: orange; width: 100%; padding-left: 2dp: margin: 5dp;"
                        )
                    ) #ned of marketing sub-box of business
                ) #end of box2 of business marketing
              ),
              
              #marketing for student loan
              fluidRow(
                box(width = 12, title = "Marketing for Student Loan",
                    status = "primary", collapsible = T, solidHeader = T,
                    box(width = 8, title = "Graph", status = "primary",solidHeader = T,
                        plotlyOutput("plotly_studentLoan"),
                        helpText("Student Loan will be provided to customers who are",
                                 strong(" students"),",",
                                 strong(" having no previous Loan"),", ",
                                 strong(" selected education level(s)."))
                    ),
                    box(width = 4, title = "Marketing", status = "warning",solidHeader = T,
                        checkboxGroupButtons(
                          inputId = "choice_jobsPieChart_studentLoan", label = "Filter Education Level :", 
                          choices = c("primary","secondary","tertiary","unknown"),
                          selected = c("primary","secondary","tertiary","unknown"),
                          justified = F, direction = "horizontal", status = "warning",
                          checkIcon = list(yes = icon("ok", lib = "glyphicon"), no = icon("remove", lib = "glyphicon"))
                        ),
                        
                        #verbatimTextOutput("value"),
                        br(),
                        actionButton("btn_EmailMarketing_BusinessLoan", "Launch Email Campaign",icon("envelope"),
                                     style = "color: #fff; background-color: orange; border-color: orange; width: 100%; padding-left: 2dp: margin: 5dp;"
                        )
                    ) #ned of marketing sub-box of business
                ) #end of box2 of business marketing
                
              )#end of fluidrow
                
              
      ),#End of Marketing
      #### Marketing Insights ####
      tabItem(tabName = "marketing_insights",
              
              fluidRow(
                
                box(width = 12, title = "Age wise Effectiveness of Marketing", status = "primary",solidHeader = T, collapsible = T,
                    plotlyOutput("plotly_ageInsights_marketing"),
                    tags$hr(),
                    tags$blockquote("Housing Loan can be provided to customers having",
                                    strong(" no House"),",",
                                    strong(" no previous Loan"),", ",
                                    strong(" selected job(s)"),", and ",
                                    strong(" having a Bank balance above 10,000."))
                ),

                box(width = 12, title = "Job Marketing Insights", status = "primary",solidHeader = T, collapsible = T,
                    # plotlyOutput("loan_BusinessLoan"),
                    # tags$hr(),
                    # tags$blockquote("Business Loan can be provided to customers having",
                    #                 #strong(" no House"),",",
                    #                 strong(" no previous Loan"),", ",
                    #                 strong(" selected job(s)"),", and ",
                    #                 strong(" having a Bank balance above 10,000."))
                    # 
                    print("hello")
                ),
                box(width = 12, title = "Day of Week Insights", status = "primary",solidHeader = T, collapsible = T,
                    # plotlyOutput("loan_StudentLoan"),
                    # tags$hr(),
                    # tags$blockquote("Student Loan will be provided to customers having",
                    #                 #strong(" no House"),",",
                    #                 strong(" no previous Loan"),", ",
                    #                 strong(" selected education level(s)"))
                    # 
                    print("hello")
                )
                
                
              )#end of fluid row
              
              
      ),
      
      ##### Marketing ML #####
      tabItem(tabName = "marketing_ML",
              
              fluidRow(
                
                box(width = 12, title = "GLM", status = "primary",solidHeader = T, collapsible = T,
                    box(width = 8, title = "Table", status = "primary",solidHeader = T, collapsible = T,
                        #DT::dataTableOutput("DT_ML_GLM", width = "100%")
                        div(id="stddiv",style = 'overflow-x: scroll', DT::dataTableOutput('DT_ML_GLM'))
                    
                    ),
                    box(width = 4, title = "ML Choice", status = "primary",solidHeader = T, collapsible = T,
                        checkboxGroupButtons(
                          inputId = "choice_GLM", label = "Filter factors for Machine Learning  :", 
                          choices = c("age", "job", "marital",
                                      "education","default","housing",
                                      "loan","month","day_of_week","duration","campaign",
                                      "pdays","previous","poutcome"),
                          selected = c("age", "job", "marital",
                                       "education","default","housing",
                                       "loan","month","day_of_week","duration","campaign",
                                       "pdays","previous","poutcome"),
                          justified = F, direction = "horizontal", status = "warning",
                          checkIcon = list(yes = icon("ok", lib = "glyphicon"), no = icon("remove", lib = "glyphicon"))
                        ),
                        br(),
                        actionButton("btn_GLM_prediction", "Predict Marketing Campaign Result",icon("envelope"),
                                     style = "color: #fff; background-color: orange; 
                                     border-color: orange; width: 100%; padding-left: 2dp; margin: 5dp;"
                        )
                    ),
                    box(width = 12, title = "Summary", status = "primary",solidHeader = T, collapsible = T,
                        verbatimTextOutput('text_ML_GLM')
                    ),
                    box(width = 12, title = "Plot", status = "primary",solidHeader = T, collapsible = T,
                        plotOutput('plot_ML_GLM')
                    )
                    
                )
              )
      )
     
      #### ------------------- ####
    )#end of tabItems
  )#end of dashboardBody
)
