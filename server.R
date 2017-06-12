library(shiny)
library(shinyBS)
library(shinyjs)

#Use jscode to for reset button to reload the app
jsResetCode <- "shinyjs.reset = function() {history.go(0)}"

#Define the function to disable all the button
disableActionButton <- function(id,session) {
  session$sendCustomMessage(type="jsCode",
                            list(code= paste("$('#",id,"').prop('disabled',true)"
                                             ,sep="")))
}

#Define the function to extract tumor mass from the raspberry experiment model
model <- function(data,val,theta){
  TuMass = c()
  for (i in 1:20){
    if (val$btn[i] == 0){TuMass[i] = data[i,4] + rnorm(1, mean = 0, sd = 0.05 * (data[i,4]))}
    else{TuMass[i] = data[i,4] * theta + rnorm(1, mean = 0, sd = 0.05 * (data[i,4] * theta))}
  }
  return(TuMass)
}

#Load the data in global environment for this app
data = read.csv("database.csv")
colnames(data) = c("Color","Weight(g)","Age(wks)","TumorMass(mg)","Gender")


####################################################
shinyServer(function(input, output,session) {

  #Save all the actionButton input into a vector for later convenience  
  val <- reactiveValues(btn = c())
  observe({
    val$btn[1] = input$btn1
    val$btn[2] = input$btn2
    val$btn[3] = input$btn3
    val$btn[4] = input$btn4
    val$btn[5] = input$btn5
    val$btn[6] = input$btn6
    val$btn[7] = input$btn7
    val$btn[8] = input$btn8
    val$btn[9] = input$btn9
    val$btn[10] = input$btn10
    val$btn[11] = input$btn11
    val$btn[12] = input$btn12
    val$btn[13] = input$btn13
    val$btn[14] = input$btn14
    val$btn[15] = input$btn15
    val$btn[16] = input$btn16
    val$btn[17] = input$btn17
    val$btn[18] = input$btn18
    val$btn[19] = input$btn19
    val$btn[20] = input$btn20
  })

  #reload the app when the reset button is clicked 
  observeEvent(input$reset_button, {js$reset()}) 
  
  #Create 20 updateButtons for 20 bsButtons in ui
  observeEvent(val$btn,({
    for (i in 1:20){
      if (val$btn[i] == 1){
        updateButton(session,paste("btn",i,sep = ""), style = "danger", disabled = TRUE)
      }
    }
  }))

  #When 10 buttons have been clicked, disable all buttons. 
  observe({
    if (sum(val$btn) > 10){
      for (i in 1:20){
        disableActionButton(paste("btn",i,sep = ""),session)
      }
    }
  })

  #Counter: count how many buttons have been clicked
  output$num = renderText(sum(val$btn))
  #Print the average weight for experimental group
  output$aveWeight = renderText({
    print(sum(val$btn * data[,"Weight(g)"])/10)})
  #Print the average age for experimental group
  output$aveAge = renderText({
    print(sum(val$btn * data[,"Age(wks)"])/10)
  })
  #Print the average tumor mass for experimental group
  output$aveTu = renderText({
    #use the "model" function and input theta
    TuM = model(data,val,input$theta)
    print(sum(val$btn * TuM)/10)
  })
  output$gend = renderText((input$btn2 + input$btn3 + input$btn6 + input$btn7 + input$btn9 + input$btn12 + input$btn13 + input$btn14 + input$btn15 + input$btn19)/10)
  output$col = renderText((input$btn1 + input$btn4 + input$btn6 + input$btn8 + input$btn12 + input$btn17 + input$btn18 + input$btn19 + input$btn20)/10)
  
  #Print everything for control group
  output$aveWeightC = renderText({
    print(sum((1-val$btn)*data[,"Weight(g)"])/10)})
  output$aveAgeC = renderText({
    print(sum((1-val$btn)*data[,"Age(wks)"])/10)
  })
  output$aveTuC = renderText({
    print(sum((1-c(input$btn1,input$btn2,input$btn3,input$btn4,input$btn5,input$btn6,input$btn7,input$btn8,input$btn9,input$btn10,
                input$btn11,input$btn12,input$btn13,input$btn14,input$btn15,input$btn16,input$btn17,input$btn18,input$btn19,input$btn20))*data[,"TumorMass(mg)"])/10)
  })
  output$gendC = renderText(((1-input$btn2) + (1-input$btn3) + (1-input$btn6) + (1-input$btn7) + (1-input$btn9) + (1-input$btn12) + (1-input$btn13) + (1-input$btn14) + (1-input$btn15) + (1-input$btn19))/10)
  output$colC = renderText(((1-input$btn1) + (1-input$btn4) + (1-input$btn6) + (1-input$btn8) + (1-input$btn12) + (1-input$btn17) + (1-input$btn18) + (1-input$btn19) + (1-input$btn20))/10)
  
  output$weight = renderPlot({
    wei = sum(c(input$btn1,input$btn2,input$btn3,input$btn4,input$btn5,input$btn6,input$btn7,input$btn8,input$btn9,input$btn10,
                input$btn11,input$btn12,input$btn13,input$btn14,input$btn15,input$btn16,input$btn17,input$btn18,input$btn19,input$btn20)*data[,"Weight(g)"])/10
    weiC = sum((1-c(input$btn1,input$btn2,input$btn3,input$btn4,input$btn5,input$btn6,input$btn7,input$btn8,input$btn9,input$btn10,
             input$btn11,input$btn12,input$btn13,input$btn14,input$btn15,input$btn16,input$btn17,input$btn18,input$btn19,input$btn20))*data[,"Weight(g)"])/10
    
    barplot(c(wei,weiC),
            names.arg = c("Raspberry Group","Control Group"), main = "Comparison of Average Weight", 
            ylab = "Weight(g)", col = c("#C7053D","beige"))
  }, width = 290)
  output$age = renderPlot({
    age = sum(c(input$btn1,input$btn2,input$btn3,input$btn4,input$btn5,input$btn6,input$btn7,input$btn8,input$btn9,input$btn10,
                input$btn11,input$btn12,input$btn13,input$btn14,input$btn15,input$btn16,input$btn17,input$btn18,input$btn19,input$btn20)*data[,"Age(wks)"])/10
    ageC = sum((1-c(input$btn1,input$btn2,input$btn3,input$btn4,input$btn5,input$btn6,input$btn7,input$btn8,input$btn9,input$btn10,
                    input$btn11,input$btn12,input$btn13,input$btn14,input$btn15,input$btn16,input$btn17,input$btn18,input$btn19,input$btn20))*data[,"Age(wks)"])/10
    
    barplot(c(age,ageC),
            names.arg = c("Raspberry Group","Control Group"), main = "Comparison of Average Age", 
            ylab = "Age(wks)", col = c("#C7053D","beige"))
  }, width = 290)
  output$tumor = renderPlot({
    age = sum(c(input$btn1,input$btn2,input$btn3,input$btn4,input$btn5,input$btn6,input$btn7,input$btn8,input$btn9,input$btn10,
                input$btn11,input$btn12,input$btn13,input$btn14,input$btn15,input$btn16,input$btn17,input$btn18,input$btn19,input$btn20)*data[,"TumorMass(mg)"])/10
    ageC = sum((1-c(input$btn1,input$btn2,input$btn3,input$btn4,input$btn5,input$btn6,input$btn7,input$btn8,input$btn9,input$btn10,
                    input$btn11,input$btn12,input$btn13,input$btn14,input$btn15,input$btn16,input$btn17,input$btn18,input$btn19,input$btn20))*data[,"TumorMass(mg)"])/10
    
    barplot(c(age,ageC),
            names.arg = c("Raspberry Group","Control Group"), main = "Comparison of Tumor Mass", 
            ylab = "Tumor Mass(mg)", col = c("#C7053D","beige"))
  },width = 290)
  output$gender = renderPlot({
    barplot(prop.table(rbind(c((input$btn2 + input$btn3 + input$btn6 + input$btn7 + input$btn9 + input$btn12 + input$btn13 + input$btn14 + input$btn15 + input$btn19),
                               (10 - (input$btn2 + input$btn3 + input$btn6 + input$btn7 + input$btn9 + input$btn12 + input$btn13 + input$btn14 + input$btn15 + input$btn19))),
                             c((input$btn1 + input$btn4 + input$btn5 + input$btn8 + input$btn10 + input$btn11 + input$btn16 + input$btn17 + input$btn18 + input$btn20),
                               (10 - (input$btn1 + input$btn4 + input$btn5 + input$btn8 + input$btn10 + input$btn11 + input$btn16 + input$btn17 + input$btn18 + input$btn20)))),2),
            col = c("#FBB4AE","#B3CDE3"),names.arg = c("Raspberry Group","Control Group"),main = "Comparison of gender")
  },width = 290)
  output$color = renderPlot({
    barplot(prop.table(rbind(c((input$btn1 + input$btn4 + input$btn6 + input$btn8 + input$btn12 + input$btn17 + input$btn18 + input$btn19 + input$btn20),
                               (9 - (input$btn1 + input$btn4 + input$btn6 + input$btn8 + input$btn12 + input$btn17 + input$btn18 + input$btn19 + input$btn20))),
                             c((input$btn2 + input$btn3 + input$btn5 + input$btn7 + input$btn9 + input$btn10 + input$btn11 + input$btn13 + input$btn14 + input$btn15 + input$btn16),
                               (11 - (input$btn2 + input$btn3 + input$btn5 + input$btn7 + input$btn9 + input$btn10 + input$btn11 + input$btn13 + input$btn14 + input$btn15 + input$btn16)) )),2),
            col = c("#BE996E","black"),names.arg = c("Raspberry Group","Control Group"),main = "Comparison of colors")
  },width = 290)
  output$dataf = renderPrint({
    data = read.csv("database.csv")
    colnames(data) = c("Color","Weight(g)","Age(wks)","Gender","TumorMass(mg)")
    data$Group = c(1*input$btn1,1*input$btn2,1*input$btn3,1*input$btn4,1*input$btn5,1*input$btn6,1*input$btn7,1*input$btn8,1*input$btn9,1*input$btn10,
                   1*input$btn11,1*input$btn12,1*input$btn13,1*input$btn14,1*input$btn15,1*input$btn16,1*input$btn17,1*input$btn18,1*input$btn19,1*input$btn20)
    print(data)
  })
  
})