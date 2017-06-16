library(shiny)
library(shinyjs)
library(shinyBS)
library(ggplot2)
library(V8)

#Use jscode to for reset button to reload the app
jsResetCode <- "shinyjs.reset = function() {history.go(0)}"

shinyUI(

  
  navbarPage("Random Assignment",
            
             tabPanel("Generate by Hand",
                      #Use jscode to for reset button to reload the app
                      useShinyjs(),
                      extendShinyjs(text = jsResetCode),
                      #Use jscode to disable all the buttons
                      tags$head(tags$script(HTML('
                                                 Shiny.addCustomMessageHandler("jsCode",
                                                 function(message) {
                                                 console.log(message)
                                                 eval(message.code);
                                                 }
                                                 );
                                                 '))),
                      fluidPage(
                        # #Use jscode to for reset button to reload the app
                        # useShinyjs(),
                        # extendShinyjs(text = jsResetCode),
                        # #Use jscode to disable all the buttons
                        # tags$head(tags$script(HTML('
                        #                            Shiny.addCustomMessageHandler("jsCode",
                        #                            function(message) {
                        #                            console.log(message)
                        #                            eval(message.code);
                        #                            }
                        #                            );
                        #                            '))),
                        
                        titlePanel("Please choose 10 Mice for the Raspberry Treatment"),
                        sidebarLayout(
                          sidebarPanel(h3("Raspberries have a high content of many beneficial compounds like vitamins C and E, folic and ellagic acid, calcium, selenium, etc. As a result, researchers have recently been investigating 
                                          their anti-cancer properties. The twenty mice in the picture all have a tumor growing just under the skin on their backs. To test if raspberries can help reduce the growth of these tumors, 
                                          ten mice will be chosen to have raspberries added in their diet and the remaining ten will eat a normal diet without the raspberries."), 
                                       h3("Please pick the ten mice to receive the raspberry diet (just click on mice you want to include in the raspberry group until you have selected ten, then click the submit selections button)."),
                                       img(src='raspberry.png', width = 50), img(src='raspberry.png', width = 50),img(src='raspberry.png', width = 50),img(src='raspberry.png', width = 50),img(src='raspberry.png', width = 50),
                                       img(src='raspberry.png', width = 50), img(src='raspberry.png', width = 50), img(src='raspberry.png', width = 50)
                                       #verbatimTextOutput("tu")
                          ),
                          
                          mainPanel(
                            
                            fluidRow( column(3,bsButton("btn1",label = tags$img(src = 'brown3.png',width = 55))),
                                      column(4,bsButton("btn2",label = tags$img(src='brown3.png', width = 58))),
                                      column(4,bsButton("btn19",label = tags$img(src='black3.png', width = 195)))), br(),
                            fluidRow( column(2, offset = 1, bsButton("btn4",label = tags$img(src='black3.png', width = 66))),
                                      column(5,offset = 1, bsButton("btn5",label = tags$img(src='brown3.png', width = 69)))),
                            br(),
                            fluidRow( column(5,offset = 4, bsButton("btn6",label = tags$img(src='brown3.png', width = 74))),
                                      column(2, offset = 1, bsButton("btn7",label = tags$img(src='brown3.png', width = 76)))),
                            
                            fluidRow( column(4, offset = 6, bsButton("btn8",label = tags$img(src='black3.png', width = 83)))),
                            fluidRow( column(5, offset = 1, bsButton("btn9",label = tags$img(src='black3.png', width = 83))),
                                      column(2, offset = 3, bsButton("btn10",label = tags$img(src='black3.png', width = 83)))),
                            fluidRow( column(7, bsButton("btn11",label = tags$img(src='brown3.png', width = 85))),
                                      column(5, bsButton("btn12",label = tags$img(src='brown3.png', width = 105)))),
                            fluidRow( column(5, offset = 2, bsButton("btn13",label = tags$img(src='black3.png', width = 121)))),
                            fluidRow( column(6, offset = 5, bsButton("btn14",label = tags$img(src='brown3.png', width = 125))),
                                      column(2, offset = 1, bsButton("btn15",label = tags$img(src='brown3.png', width = 130)))),
                            fluidRow( column(4, offset = 1, bsButton("btn16",label = tags$img(src='black3.png', width = 130))),
                                      column(6, bsButton("btn17",label = tags$img(src='brown3.png', width = 132)))),
                            fluidRow( column(4, offset = 0, bsButton("btn18",label = tags$img(src='brown3.png', width = 165)))),
                            fluidRow( column(3, offset = 6, bsButton("btn3",label = tags$img(src='black3.png', width = 66))),
                                      column(2, offset = 0, bsButton("btn20",label = tags$img(src='black3.png', width = 214)))),
                            br(),
                            fluidRow(textOutput("num")," number of chosen mice."),
                            fluidRow(
                              column(8,actionButton("reset_button", "Reset")),
                              column(2,actionButton("submit","Submit Selection")))
                            
                          )
                          ),
                        
                        
                        hr(),
                        conditionalPanel(
                          condition = "(output.num == 10)&(input.submit != 0)",
                          fluidPage(
                            fluidRow(h2("Summary of the mice Hand-Selected for Comparison:")),
                            fluidRow(column(9,
                                            wellPanel(
                                              fluidRow(
                                                column(2,""), column(2,"Total selected"), column(2,"Average Weight(g)"), column(2,"Average Age(wks)"), column(2,"Average Tumor Mass(mg)"), column(1,"Proportion Female"), column(1,"Proportion Brown")
                                              ), 
                                              fluidRow(
                                                column(2,"Rspb.Group"), column(2,"10"), column(2,textOutput("aveWeight")), column(2,textOutput("aveAge")), column(2,textOutput("aveTu")), column(1,textOutput("gend")), column(1,textOutput("col"))
                                              ),
                                              fluidRow(
                                                column(2,"Control Group"), column(2,"10"), column(2,textOutput("aveWeightC")), column(2,textOutput("aveAgeC")), column(2,textOutput("aveTuC")), column(1,textOutput("gendC")), column(1,textOutput("colC"))
                                              )
                                            )
                            ),
                            column(3, sliderInput("theta","Adjust theta:",min = 0, max = 1, value = 0.6))
                            ),
                            fluidRow(
                              column(4,plotOutput("weight")), column(4,plotOutput("age")), column(4,plotOutput("tumor")) 
                            ),
                            fluidRow(
                              column(4,plotOutput("gender")), column(4,plotOutput("color"))
                            ),
                            fluidRow(
                              actionButton("getdata","Use Raw Data")
                            )), conditionalPanel("input.getdata != 0", verbatimTextOutput("dataf"))
                          
                        )
                        )
                      
                      ),
             tabPanel("Generate by Computer",
                      fluidPage(
                        wellPanel(
                          fluidRow(
                                   column(1,numericInput("times", "Simulations", value = 1)),
                                   column(5,h4("Enter number to run multiple trials with one button press."))
                                   )
                          ),
                        fluidRow(
                          column(6, tableOutput("computerTable")),
                          column(6, sliderInput("compTheta","Adjust theta:",min = 0, max = 1, value = 0.6))
                        ),
                        fluidRow(
                          column(4,plotOutput("compWeightBar")), column(4,plotOutput("compAgeBar")), column(4,plotOutput("compTumorBar"))
                        ),
                        fluidRow(
                          column(4,plotOutput("compWeightHist")), column(4,plotOutput("compAgeHist")), column(4,plotOutput("compTumorHist"))
                        ),
                    
                            fluidRow(
                              actionButton("compGetdata","Use Raw Data")
                            )
                            , conditionalPanel("input.compGetdata != 0", 
                                               column(6,verbatimTextOutput("dataf")),
                                               column(6,verbatimTextOutput("compDataf")))
                          )
                          
                        
                      )
                      
             
             
             
             
             
             
             )
  
  
  
  
)
