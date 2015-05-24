library(shiny)
library(ggplot2)

ships <<- read.csv("ships.csv", sep=",", header=TRUE)
ships <<- ships[order(ships$Name, ships$Faction), ]

empire <<- ships[ships$Faction == 1, ]

rebels <<- ships[ships$Faction == 2, ]

scum <<- ships[ships$Faction == 3, ]

shinyServer(function(input, output, session) {
  
  faction <- reactive({input$faction})
  attack_dice <- reactive({input$attack})
  defense_dice <- reactive({input$defense})
  focus <- reactive({as.numeric(input$focus)})
  evade <- reactive({input$evade})
  cloak <- reactive({input$cloak})
  targetlock <- reactive({input$targetlock})  
  
  shipid <- reactive({input$name})
  
  observe({
    updateSliderInput(session, "attack", value = as.numeric(unlist(data()[data()$id == shipid(), 4])))
    updateSliderInput(session, "defense", value = as.numeric(unlist(data()[data()$id == shipid(), 5])))
    updateSliderInput(session, "hull", value = as.numeric(unlist(data()[data()$id == shipid(), 6])))
    updateSliderInput(session, "shield", value = as.numeric(unlist(data()[data()$id == shipid(), 7])))
#     updateCheckboxInput(session, "focus", value = as.logical(unlist(data()[data()$id == shipid(), 8])))
#     updateCheckboxInput(session, "evade", value = as.logical(unlist(data()[data()$id == shipid(), 9])))
#     updateCheckboxInput(session, "targetlock", value = as.logical(unlist(data()[data()$id == shipid(), 10])))
#     updateCheckboxInput(session, "cloak", value = as.logical(unlist(data()[data()$id == shipid(), 11])))
  })
  
  data <- reactive({
    if(faction() != 0){
      n <- as.numeric(faction())
      if(n == 1) empire
      else if(n == 2) rebels
      else if(n == 3) scum
    }
    else{
      ships
    }
  })
  
  output$shipList <- renderUI({
    
    name_choices <- as.data.frame(data())[,1:2]
    name_choices <- setNames(name_choices[,1], name_choices[,2])
    selectInput("name", "Name: ", choices=c("Select a ship", name_choices))
    
  })
  
  
  output$attackPlot <- renderPlot({
    x <- seq(0, attack_dice(), by=1)
    
    if(focus() == 1)
      p = 6/8
    else
      p = 4/8
    
    if(targetlock() == 1)
      p = p + (1-p)*p
    
    barplot(
      dbinom(x, attack_dice(), p)*100,
      main="Attack statistics",
      ylab="Probability",
      xlab="# of hits",
      names.arg = x,
      ylim = c(0, 100),
      col = "red",
    )
    
  })
  
  
  output$defensePlot <- renderPlot({
    
    defense <- defense_dice()
    if(cloak() == 1)
      defense <- defense+2
    
    x <- seq(0, defense, by=1)
    
    if(focus() == 1)
      p = 5/8
    else
      p = 3/8
    
    start = 0
    if(evade() == 1)
      start = 1
    
    barplot(
      dbinom(x, defense, p)*100,
      main="Defense statistics",
      ylab="Probability",
      xlab="# of evades",
      names.arg = x+start,
      ylim = c(0, 100),
      col = "green"
    )
  })
  
#   output$testPlot <- renderPlot({
#     
#     defense <- defense_dice()
#     x <- seq(0, defense, by=1)
#     
#     normal <- dbinom(x, defense, 3/8)*100
#     focused <- dbinom(x, defense, 5/8)*100
#     
#     dnormal <- data.frame(x = x, prob = normal, p = "Normal")
#     dfocused <- data.frame(x = x, prob = focused, p = "Focused")
#     devaded <- dfocused
#     devaded$x <- devaded$x+1
#     
#     data <- merge(dnormal, dfocused, all=TRUE)
#     
#     print(data)
#     
#     g <- ggplot(data, aes(factor(x), fill=prob), environment = environment())
#     g + geom_density() + facet_wrap(~ p)
#     
#     
#   })
  
})