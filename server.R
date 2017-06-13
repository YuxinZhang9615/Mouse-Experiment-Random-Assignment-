library(shiny)
library(shinyBS)
library(shinyjs)
library(V8)

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
  TuMass = data[,4]
  for (i in 1:20){
    if (val$btn[i] == 0){
      TuMass[i] = TuMass[i] + rnorm(1, mean = 0, sd = 0.05 * TuMass[i])
      }
    else{
      TuMass[i] = TuMass[i] * theta + rnorm(1, mean = 0, sd = 0.05 * (TuMass[i] * theta))
      }
  }
  return(TuMass)
}

##Load and edit the data in global environment for this app
data = read.csv("database.csv")
colnames(data) = c("Color","Weight(g)","Age(wks)","TumorMass(mg)","Gender")
#Change the column color and gender from factor to numeric
data$Color = as.character(data$Color)
for (i in 1:20){
  if (data$Color[i] == "brown"){data$Color[i] = 1}
  else {data$Color[i] = 0}
}
data$Color = as.numeric(data$Color)

data$Gender = as.character(data$Gender)
for (i in 1:20){
  if (data$Gender[i] == "Female"){data$Gender[i] = 1}
  else {data$Gender[i] = 0}
}
data$Gender = as.numeric(data$Gender)


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
  output$gend = renderText(sum(val$btn * data[,"Gender"])/10)
  output$col = renderText(sum(val$btn * data[,"Color"])/10)
  
  #Print everything for control group
  output$aveWeightC = renderText({
    print(sum((1-val$btn)*data[,"Weight(g)"])/10)})
  output$aveAgeC = renderText({
    print(sum((1-val$btn)*data[,"Age(wks)"])/10)
  })
  output$aveTuC = renderText({
    TuM = model(data,val,input$theta)
    print(sum((1-val$btn) * TuM)/10)
  })
  
  # output$tu = renderPrint({
  #   TuM = model(data,val,input$theta)
  #   print(TuM)
  # })
  output$gendC = renderText(sum((1-val$btn) * data[,"Gender"])/10)
  output$colC = renderText(sum((1-val$btn) * data[,"Color"])/10)
  
  output$weight = renderPlot({
    wei = sum(val$btn * data[,"Weight(g)"])/10
    weiC = sum((1 - val$btn) * data[,"Weight(g)"])/10
    barplot(c(wei,weiC),
            names.arg = c("Raspberry Group","Control Group"), main = "Comparison of Average Weight", 
            ylab = "Weight(g)", col = c("#C7053D","beige"))
  }, width = 400)
  
  output$age = renderPlot({
    age = sum(val$btn * data[,"Age(wks)"])/10
    ageC = sum((1 - val$btn) * data[,"Age(wks)"])/10
    barplot(c(age,ageC),
            names.arg = c("Raspberry Group","Control Group"), main = "Comparison of Average Age", 
            ylab = "Age(wks)", col = c("#C7053D","beige"))
  }, width = 400)
  
  output$tumor = renderPlot({
    TuM = model(data,val,input$theta)
    age = sum(val$btn * TuM)/10
    ageC = sum((1-val$btn) * TuM)/10
    barplot(c(age,ageC),
            names.arg = c("Raspberry Group","Control Group"), main = "Comparison of Tumor Mass", 
            ylab = "Tumor Mass(mg)", col = c("#C7053D","beige"))
  },width = 400)
  
  output$gender = renderPlot({
    barplot(prop.table(rbind(c((sum(val$btn * data[,"Gender"])),
                               (sum((1 - val$btn) * data[,"Gender"]))),
                             c((sum(val$btn * (1 - data[,"Gender"]))),
                               (sum((1 - val$btn) * (1 - data[,"Gender"]))))),2),
            col = c("#FBB4AE","#B3CDE3"),names.arg = c("Raspberry Group","Control Group"),main = "Comparison of gender")
  },width = 400)
  
  output$color = renderPlot({
    barplot(prop.table(rbind(c((sum(val$btn * data[,"Color"])),
                               (sum((1 - val$btn) * data[,"Color"]))),
                             c((sum(val$btn * (1 - data[,"Color"]))),
                               (sum((1 - val$btn) * (1 - data[,"Color"]))))),2),
            col = c("#BE996E","black"),names.arg = c("Raspberry Group","Control Group"),main = "Comparison of colors")
  },width = 400)
  
  ##Print raw data with group number (1 for experimental group; 0 for control group)
  output$dataf = renderPrint({
    data$Group = val$btn
    for (i in 1:20){
      if (data$Group[i] == 1){data$Group[i] = "Raspberry"}
      else {data$Group[i] = "Control"}
    }
    
    TuM = model(data,val,input$theta)
    data[,4] = TuM
    
    
    for (i in 1:20){
      if (data$Color[i] == 1){data$Color[i] = "Brown"}
      else {data$Color[i] = "Black"}
    }

    for (i in 1:20){
      if (data$Gender[i] == 1){data$Gender[i] = "Female"}
      else {data$Gender[i] = "Male"}
    }

    print(data)
  })
  
})