library(shiny)
library(shinyjs)
library(shinyBS)

jsResetCode <- "shinyjs.reset = function() {history.go(0)}"

shinyUI(fluidPage(
  useShinyjs(),                                         
  extendShinyjs(text = jsResetCode),                     

  tags$head(tags$script(HTML('
                             Shiny.addCustomMessageHandler("jsCode",
                             function(message) {
                             console.log(message)
                             eval(message.code);
                             }
                             );
                             '))),
  
  titlePanel("Please choose 10 Mice for the Raspberry Treatment"),
  sidebarLayout(
  sidebarPanel(h3("Raspberries have a high content of many beneficial compounds like vitamins C and E, folic and ellagic acid, calcium, selenium, etc. As a result, researchers have recently been investigating 
                   their anti-cancer properties. The twenty mice in the picture all have a tumor growing just under the skin on their backs. To test if raspberries can help reduce the growth of these tumors, 
               ten mice will be chosen to have raspberries added in their diet and the remaining ten will eat a normal diet without the raspberries."), 
            h3("Please pick the ten mice to receive the raspberry diet (just click on mice you want to include in the raspberry group until you have selected ten, then click the submit selections button)."),
            img(src='raspberry.png', width = 50), img(src='raspberry.png', width = 50),img(src='raspberry.png', width = 50),img(src='raspberry.png', width = 50),img(src='raspberry.png', width = 50),
            img(src='raspberry.png', width = 50), img(src='raspberry.png', width = 50), img(src='raspberry.png', width = 50),
            sliderInput("theta","Adjust theta:", min = 0, value = 0.6, max = 1)),
  
  
  mainPanel(
    
      fluidRow( column(3,bsButton("btn1",label = tags$img(src = 'brown3.png',width = 80))),
                column(5,bsButton("btn2",label = tags$img(src='black3r.png', width = 100))),
                column(4,bsButton("btn3",label = tags$img(src='black3.png', width = 120)))), br(),
      fluidRow( column(2, offset = 1, bsButton("btn4",label = tags$img(src='brown3.png', width = 130))),
                column(5,offset = 1, bsButton("btn5",label = tags$img(src='black3r.png', width = 80)))),
      br(),
      fluidRow( column(5,offset = 4, bsButton("btn6",label = tags$img(src='brown3.png', width = 120))),
                column(2, offset = 1, bsButton("btn7",label = tags$img(src='black3.png', width = 70)))),
      
      fluidRow( column(4, offset = 6, bsButton("btn8",label = tags$img(src='brown3.png', width = 160)))),
      fluidRow( column(5, offset = 1, bsButton("btn9",label = tags$img(src='black3.png', width = 150))),
                column(2, offset = 3, bsButton("btn10",label = tags$img(src='black3.png', width = 80)))),
      fluidRow( column(7, bsButton("btn11",label = tags$img(src='black3r.png', width = 80))),
                column(5, bsButton("btn12",label = tags$img(src='brown3.png', width = 90)))),
      fluidRow( column(5, offset = 2, bsButton("btn13",label = tags$img(src='black3.png', width = 150)))),
      fluidRow( column(6, offset = 5, bsButton("btn14",label = tags$img(src='black3.png', width = 180))),
                column(2, offset = 1, bsButton("btn15",label = tags$img(src='black3.png', width = 80)))),
      fluidRow( column(4, offset = 1, bsButton("btn16",label = tags$img(src='black3.png', width = 100))),
                column(6, bsButton("btn17",label = tags$img(src='brown3.png', width = 80)))),
      fluidRow( column(4, offset = 0, bsButton("btn18",label = tags$img(src='brown3.png', width = 120)))),
      fluidRow( column(3, offset = 6, bsButton("btn19",label = tags$img(src='brown3r.png', width = 110))),
                column(2, offset = 0, bsButton("btn20",label = tags$img(src='brown3.png', width = 150)))),
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
      wellPanel(
        fluidRow(
          column(1,""), column(1,"Total selected"), column(1,"Average Weight(g)"), column(1,"Average Age(wks)"), column(1,"Average Tumor Mass(mg)"), column(1,"Proportion Female"), column(1,"Proportion Brown")
        ), 
        fluidRow(
          column(1,"Rspb.Group"), column(1,"10"), column(1,textOutput("aveWeight")), column(1,textOutput("aveAge")), column(1,textOutput("aveTu")), column(1,textOutput("gend")), column(1,textOutput("col"))
        ),
        fluidRow(
          column(1,"Control Group"), column(1,"10"), column(1,textOutput("aveWeightC")), column(1,textOutput("aveAgeC")), column(1,textOutput("aveTuC")), column(1,textOutput("gendC")), column(1,textOutput("colC"))
        )
      ),
      fluidRow(
        column(2,plotOutput("weight")), column(2,plotOutput("age")), column(2,plotOutput("tumor")), column(2,plotOutput("gender")), column(2,plotOutput("color"))
      ),
      fluidRow(
        actionButton("getdata","Use Raw Data")
      )), conditionalPanel("input.getdata != 0", verbatimTextOutput("dataf"))
      
   )
  )
)
