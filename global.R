# Global R template for Shiny apps

library(devtools)
library(shiny)
library(ggplot2)
library(plotly)

py <- plotly(username="rAPI", key="yu680v5eii", base_url="https://plot.ly")

source("src/plotlyGraphWidget.R")
source("src/read_global_data.R")
source("src/rolls.R")
source("src/read_ship_data.R")
source("src/plots.R")