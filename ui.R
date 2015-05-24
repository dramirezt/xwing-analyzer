library(shiny)

# Defining the UI

shinyUI(fluidPage(
  
  # Title and header
  title = "X-Wing - Combat Analyzer",
  headerPanel(h1("X-Wing - Combat Analyzer")),
  
  # Sidebar
  sidebarLayout(
    sidebarPanel(
      
      # Faction radio-buttons
      radioButtons("faction", label= "Faction: ", 
                   choices = list("All" = 0,
                                  "Galactic Empire" = 1,
                                  "Rebel Alliance" = 2,
                                  "Scum & Villains" = 3), selected=0),
      # Select ship
      uiOutput("shipList"),
      
      # Ship data
      conditionalPanel(
        condition = 'input.name != "Select a ship"',
        
        sliderInput("attack",
                    "Attack:",
                    min = 0,
                    max = 6,
                    value = 2,
                    step = 1
        ),
        
        sliderInput("defense",
                    "Defense:",
                    min = 0,
                    max = 6,
                    value = 2,
                    step = 1
        ),
        
        sliderInput("hull",
                    "Hull:",
                    min = 1,
                    max = 12,
                    value = 2,
                    step = 1
        ),
        
        sliderInput("shield",
                    "Shields:",
                    min = 0,
                    max = 12,
                    value = 2,
                    step = 1
        ),
        
        fluidRow(
          column(width=6, checkboxInput("focus", "Focus", FALSE)),
          column(width=6, checkboxInput("evade", "Evade", FALSE)),
          column(width=6, checkboxInput("targetlock", "Target Lock", FALSE)),
          column(width=6, checkboxInput("cloak", "Cloak/Decloak", FALSE))
        )
      ),
      
      conditionalPanel(
        condition = 'input.name == "New ship"',
        actionButton("register", "Register")
      )
    ),
    
    mainPanel(
      
      conditionalPanel(
        condition = 'input.name != "Select a ship"',
        fluidRow(
          column(6, plotOutput("attackPlot")),
          column(6, plotOutput("defensePlot"))
          #,
          #column(6, plotOutput("testPlot"))
        )
      )
      
    )
  )
)
)
