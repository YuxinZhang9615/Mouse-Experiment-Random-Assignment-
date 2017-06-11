library(shiny)
library(shinyBS)
library(shinyjs)

jsResetCode <- "shinyjs.reset = function() {history.go(0)}"

disableActionButton <- function(id,session) {
  session$sendCustomMessage(type="jsCode",
                            list(code= paste("$('#",id,"').prop('disabled',true)"
                                             ,sep="")))
}

shinyServer(function(input, output,session) {
  
  observeEvent(input$reset_button, {js$reset()}) 
  
  observeEvent(input$btn1,({
    updateButton(session, "btn1", style = "danger", disabled = TRUE)})
  )
  observeEvent(input$btn2,({
    updateButton(session, "btn2", style = "danger", disabled = TRUE)})
  )
  observeEvent(input$btn3,({
    updateButton(session, "btn3", style = "danger", disabled = TRUE)})
  )
  observeEvent(input$btn4,({
    updateButton(session, "btn4", style = "danger", disabled = TRUE)})
  )
  observeEvent(input$btn5,({
    updateButton(session, "btn5", style = "danger", disabled = TRUE)})
  )
  observeEvent(input$btn6,({
    updateButton(session, "btn6", style = "danger", disabled = TRUE)})
  )
  observeEvent(input$btn7,({
    updateButton(session, "btn7", style = "danger", disabled = TRUE)})
  )
  observeEvent(input$btn8,({
    updateButton(session, "btn8", style = "danger", disabled = TRUE)})
  )
  observeEvent(input$btn9,({
    updateButton(session, "btn9", style = "danger", disabled = TRUE)})
  )
  observeEvent(input$btn10,({
    updateButton(session, "btn10", style = "danger", disabled = TRUE)})
  )
  observeEvent(input$btn11,({
    updateButton(session, "btn11", style = "danger", disabled = TRUE)})
  )
  observeEvent(input$btn12,({
    updateButton(session, "btn12", style = "danger", disabled = TRUE)})
  )
  observeEvent(input$btn13,({
    updateButton(session, "btn13", style = "danger", disabled = TRUE)})
  )
  observeEvent(input$btn14,({
    updateButton(session, "btn14", style = "danger", disabled = TRUE)})
  )
  observeEvent(input$btn15,({
    updateButton(session, "btn15", style = "danger", disabled = TRUE)})
  )
  observeEvent(input$btn16,({
    updateButton(session, "btn16", style = "danger", disabled = TRUE)})
  )
  observeEvent(input$btn17,({
    updateButton(session, "btn17", style = "danger", disabled = TRUE)})
  )
  observeEvent(input$btn18,({
    updateButton(session, "btn18", style = "danger", disabled = TRUE)})
  )
  observeEvent(input$btn19,({
    updateButton(session, "btn19", style = "danger", disabled = TRUE)})
  )
  observeEvent(input$btn20,({
    updateButton(session, "btn20", style = "danger", disabled = TRUE)})
  )

  # observe({
  #   if (input$btn1 + input$btn2 + input$btn3 + input$btn4 + input$btn5 + input$btn6 + input$btn7 + input$btn8 + input$btn9 + input$btn10 +
  #       input$btn11 + input$btn12 + input$btn13 + input$btn14 + input$btn15 + input$btn16 + input$btn17 + input$btn18 + input$btn19 + input$btn20 > 10)
  #   {disableActionButton("btn1",session)
  #     disableActionButton("btn2",session)
  #     disableActionButton("btn3",session)
  #     disableActionButton("btn4",session)
  #     disableActionButton('btn5', session)
  #     disableActionButton('btn6', session)
  #     disableActionButton('btn7', session)
  #     disableActionButton('btn8', session)
  #     disableActionButton('btn9', session)
  #     disableActionButton('btn10', session)
  #     disableActionButton('btn11', session)
  #     disableActionButton('btn12', session)
  #     disableActionButton('btn13', session)
  #     disableActionButton('btn14', session)
  #     disableActionButton('btn15', session)
  #     disableActionButton('btn16', session)
  #     disableActionButton('btn17', session)
  #     disableActionButton('btn18', session)
  #     disableActionButton('btn19', session)
  #     disableActionButton('btn20', session)}
  # })

  output$num = renderText(input$btn1 + input$btn2 + input$btn3 + input$btn4 + input$btn5 + input$btn6 + input$btn7 + input$btn8 + input$btn9 + input$btn10 +
                            input$btn11 + input$btn12 + input$btn13 + input$btn14 + input$btn15 + input$btn16 + input$btn17 + input$btn18 + input$btn19 + input$btn20)
  
  output$aveWeight = renderText({
    data = read.csv("database.csv")
    colnames(data) = c("Color","Weight(g)","Age(wks)","TumorMass(mg)","Gender")
    print(sum(c(input$btn1,input$btn2,input$btn3,input$btn4,input$btn5,input$btn6,input$btn7,input$btn8,input$btn9,input$btn10,
                                    input$btn11,input$btn12,input$btn13,input$btn14,input$btn15,input$btn16,input$btn17,input$btn18,input$btn19,input$btn20)*data[,"Weight(g)"])/10)})
  output$aveAge = renderText({
    data = read.csv("database.csv")
    colnames(data) = c("Color","Weight(g)","Age(wks)","TumorMass(mg)","Gender")
    print(sum(c(input$btn1,input$btn2,input$btn3,input$btn4,input$btn5,input$btn6,input$btn7,input$btn8,input$btn9,input$btn10,
                input$btn11,input$btn12,input$btn13,input$btn14,input$btn15,input$btn16,input$btn17,input$btn18,input$btn19,input$btn20)*data[,"Age(wks)"])/10)
  })
  output$aveTu = renderText({
    data = read.csv("database.csv")
    colnames(data) = c("Color","Weight(g)","Age(wks)","TumorMass(mg)","Gender")
    print(sum(c(input$btn1,input$btn2,input$btn3,input$btn4,input$btn5,input$btn6,input$btn7,input$btn8,input$btn9,input$btn10,
                input$btn11,input$btn12,input$btn13,input$btn14,input$btn15,input$btn16,input$btn17,input$btn18,input$btn19,input$btn20)*data[,"TumorMass(mg)"])/10)
  })
  output$gend = renderText((input$btn2 + input$btn3 + input$btn6 + input$btn7 + input$btn9 + input$btn12 + input$btn13 + input$btn14 + input$btn15 + input$btn19)/10)
  output$col = renderText((input$btn1 + input$btn4 + input$btn6 + input$btn8 + input$btn12 + input$btn17 + input$btn18 + input$btn19 + input$btn20)/10)
  
  output$aveWeightC = renderText({
    data = read.csv("database.csv")
    colnames(data) = c("Color","Weight(g)","Age(wks)","TumorMass(mg)","Gender")
    print(sum((1-c(input$btn1,input$btn2,input$btn3,input$btn4,input$btn5,input$btn6,input$btn7,input$btn8,input$btn9,input$btn10,
                input$btn11,input$btn12,input$btn13,input$btn14,input$btn15,input$btn16,input$btn17,input$btn18,input$btn19,input$btn20))*data[,"Weight(g)"])/10)})
  output$aveAgeC = renderText({
    data = read.csv("database.csv")
    colnames(data) = c("Color","Weight(g)","Age(wks)","TumorMass(mg)","Gender")
    print(sum((1-c(input$btn1,input$btn2,input$btn3,input$btn4,input$btn5,input$btn6,input$btn7,input$btn8,input$btn9,input$btn10,
                input$btn11,input$btn12,input$btn13,input$btn14,input$btn15,input$btn16,input$btn17,input$btn18,input$btn19,input$btn20))*data[,"Age(wks)"])/10)
  })
  output$aveTuC = renderText({
    data = read.csv("database.csv")
    colnames(data) = c("Color","Weight(g)","Age(wks)","TumorMass(mg)","Gender")
    print(sum((1-c(input$btn1,input$btn2,input$btn3,input$btn4,input$btn5,input$btn6,input$btn7,input$btn8,input$btn9,input$btn10,
                input$btn11,input$btn12,input$btn13,input$btn14,input$btn15,input$btn16,input$btn17,input$btn18,input$btn19,input$btn20))*data[,"TumorMass(mg)"])/10)
  })
  output$gendC = renderText(((1-input$btn2) + (1-input$btn3) + (1-input$btn6) + (1-input$btn7) + (1-input$btn9) + (1-input$btn12) + (1-input$btn13) + (1-input$btn14) + (1-input$btn15) + (1-input$btn19))/10)
  output$colC = renderText(((1-input$btn1) + (1-input$btn4) + (1-input$btn6) + (1-input$btn8) + (1-input$btn12) + (1-input$btn17) + (1-input$btn18) + (1-input$btn19) + (1-input$btn20))/10)
  
  output$weight = renderPlot({
    data = read.csv("database.csv")
    colnames(data) = c("Color","Weight(g)","Age(wks)","TumorMass(mg)","Gender")
    wei = sum(c(input$btn1,input$btn2,input$btn3,input$btn4,input$btn5,input$btn6,input$btn7,input$btn8,input$btn9,input$btn10,
                input$btn11,input$btn12,input$btn13,input$btn14,input$btn15,input$btn16,input$btn17,input$btn18,input$btn19,input$btn20)*data[,"Weight(g)"])/10
    weiC = sum((1-c(input$btn1,input$btn2,input$btn3,input$btn4,input$btn5,input$btn6,input$btn7,input$btn8,input$btn9,input$btn10,
             input$btn11,input$btn12,input$btn13,input$btn14,input$btn15,input$btn16,input$btn17,input$btn18,input$btn19,input$btn20))*data[,"Weight(g)"])/10
    
    barplot(c(wei,weiC),
            names.arg = c("Raspberry Group","Control Group"), main = "Comparison of Average Weight", 
            ylab = "Weight(g)", col = c("#C7053D","beige"))
  }, width = 290)
  output$age = renderPlot({
    data = read.csv("database.csv")
    colnames(data) = c("Color","Weight(g)","Age(wks)","TumorMass(mg)","Gender")
    age = sum(c(input$btn1,input$btn2,input$btn3,input$btn4,input$btn5,input$btn6,input$btn7,input$btn8,input$btn9,input$btn10,
                input$btn11,input$btn12,input$btn13,input$btn14,input$btn15,input$btn16,input$btn17,input$btn18,input$btn19,input$btn20)*data[,"Age(wks)"])/10
    ageC = sum((1-c(input$btn1,input$btn2,input$btn3,input$btn4,input$btn5,input$btn6,input$btn7,input$btn8,input$btn9,input$btn10,
                    input$btn11,input$btn12,input$btn13,input$btn14,input$btn15,input$btn16,input$btn17,input$btn18,input$btn19,input$btn20))*data[,"Age(wks)"])/10
    
    barplot(c(age,ageC),
            names.arg = c("Raspberry Group","Control Group"), main = "Comparison of Average Age", 
            ylab = "Age(wks)", col = c("#C7053D","beige"))
  }, width = 290)
  output$tumor = renderPlot({
    data = read.csv("database.csv")
    colnames(data) = c("Color","Weight(g)","Age(wks)","TumorMass(mg)","Gender")
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