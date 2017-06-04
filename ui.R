library(shiny)

shinyUI(fluidPage(
  tags$head(tags$script(HTML('
                             Shiny.addCustomMessageHandler("jsCode",
                             function(message) {
                             console.log(message)
                             eval(message.code);
                             }
                             );
                             '))
  ),
  
  titlePanel("Please choose 10 Mice for the Raspberry Treatment"),
  
  mainPanel(
    wellPanel(
      
      fluidRow( column(3,img(src='brown3.png', width = 80), actionButton("btn1","")),
                column(5,img(src='black3r.png', width = 100), actionButton("btn2",'')),
                column(4,img(src='black3.png', width = 120), actionButton("btn3",''))), br(),
      fluidRow( column(2, offset = 1, img(src='brown3.png', width = 130), actionButton("btn4",'')),
                column(5,offset = 1,img(src='black3r.png', width = 80), actionButton("btn5",""))),
      br(),
      fluidRow( column(5,offset = 4, img(src='brown3.png', width = 120), actionButton("btn6",'')),
                column(2, offset = 1, img(src='black3.png', width = 70), actionButton("btn7",''))),
      
      fluidRow( column(4, offset = 6, img(src='brown3.png', width = 160), actionButton("btn8",""))),
      fluidRow( column(5, offset = 1, img(src='black3.png', width = 150), actionButton("btn9",'')),
                column(2, offset = 3, img(src='black3.png', width = 80), actionButton("btn10",''))),
      fluidRow( column(7, img(src='black3r.png', width = 80),  actionButton("btn11","")),
                column(5, img(src='brown3.png', width = 90),actionButton("btn12",''))),
      fluidRow( column(5, offset = 2, img(src='black3.png', width = 150), actionButton("btn13",""))),
      fluidRow( column(6, offset = 5, img(src='black3.png', width = 180), actionButton("btn14",'')),
                column(2, offset = 1, img(src='black3.png', width = 80), actionButton("btn15",''))),
      fluidRow( column(4, offset = 1, img(src='black3.png', width = 100), actionButton("btn16","")),
                column(6, img(src='brown3.png', width = 80), actionButton("btn17",''))),
      fluidRow( column(4, offset = 0, img(src='brown3.png', width = 120), actionButton("btn18",""))),
      fluidRow( column(3, offset = 6, img(src='brown3r.png', width = 110), actionButton("btn19",'')),
                column(2, offset = 0, img(src='brown3.png', width = 150), actionButton("btn20",''))),
      br(),
      br(),
      br(),
      fluidRow(textOutput("num")," number of chosen mice."),
      fluidRow(column(2,offset = 10,actionButton("submit","Submit Selection")))
      )
  ),
  
  sidebarPanel(h3("Raspberries have a high content of many beneficial compounds like vitamins C and E, folic and ellagic acid, calcium, selenium, etc. As a result, researchers have recently been investigating 
                   their anti-cancer properties. The twenty mice in the picture all have a tumor growing just under the skin on their backs. To test if raspberries can help reduce the growth of these tumors, 
                   ten mice will be chosen to have raspberries added in their diet and the remaining ten will eat a normal diet without the raspberries."), 
               h3("Please pick the ten mice to receive the raspberry diet (just click on mice you want to include in the raspberry group until you have selected ten, then click the submit selections button)."),
               img(src='raspberry.png', width = 50), img(src='raspberry.png', width = 50),img(src='raspberry.png', width = 50),img(src='raspberry.png', width = 50),img(src='raspberry.png', width = 50),
               img(src='raspberry.png', width = 50), img(src='raspberry.png', width = 50), img(src='raspberry.png', width = 50)),
  br(),
  br(),
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
