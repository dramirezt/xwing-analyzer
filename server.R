shinyServer(function(input, output, session) {

  # Loading values from UI
  
  faction <- reactive({input$faction})
  attack_dice <- reactive({input$attack})
  defense_dice <- reactive({input$defense})
  focus <- reactive({input$focus})
  evade <- reactive({input$evade})
  cloak <- reactive({input$cloak})
  targetlock <- reactive({input$targetlock})
  ship_id <- reactive({input$shipList})
  
  # Getting attack statistics
  
  curr_atk_prolls <- reactive({
    get_atk_prolls(attack_dice(), focus(), targetlock())
  })
  
  # Getting defense statistics
  
  curr_def_prolls <- reactive({
    get_def_prolls(defense_dice(), focus(), cloak())
  })
  
  
  # Getting information from the ship
  
  curr_faction_ships <- reactive({
    get_faction_ships(faction())
  })
  
  curr_ship_name <- reactive({
    get_ship_name(ship_id())
  })
  
  
  # Observe function to update forms with the ship's data
  
  observe({
    updateSliderInput(session, "attack", 
                      value = get_ship_attack(ship_id())
                      )
    updateSliderInput(session, "defense", 
                      value = get_ship_defense(ship_id())
                      )
    updateSliderInput(session, "hull", 
                      value = get_ship_hull(ship_id())
                      )
    updateSliderInput(session, "shield", 
                      value = get_ship_shields(ship_id())
                      )
    updateCheckboxInput(session, "focus", 
                        value = get_ship_focus(ship_id())
                        )
    updateCheckboxInput(session, "evade", 
                        value = get_ship_evade(ship_id())
                        )
    updateCheckboxInput(session, "targetlock", 
                        value = get_ship_targetlock(ship_id())
                        )
    updateCheckboxInput(session, "cloak", 
                        value = get_ship_cloak(ship_id())
                        )
  })
  
  
  output$shipList <- renderUI({
    name_choices <- as.data.frame(curr_faction_ships())[,1:2]
    name_choices <- setNames(name_choices[,1], name_choices[,2])
    selectInput("shipList", "Name: ", choices=c("Select a ship" = 0, name_choices))
  })
  
  atkPlt <- reactive({
    get_attack_plot(curr_atk_prolls())
  })
  
  output$attackPlot <- renderPlot({
    atkPlt()
  })
  
  
  output$defensePlot <- renderPlot({
    get_defense_plot(curr_def_prolls())
  })
  
})



