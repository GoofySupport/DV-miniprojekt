# ui.R - Bastian I. Hougaard
# Here we define the design and layout of our R Shiny application (Bootstrap).
shinyUI(
  fluidPage(
    titlePanel("Co2 Graph´s from the world"),
    
     navlistPanel(
#       "Co2 emission data",
       tabPanel("Co2 showed in Graph",Co2_UI("Co2")),
#       "Co2 for Contries",
#       tabPanel("Catagorical"),
       tabPanel("Co2 showed on map in time ",WorldMap_UI("World Map")),
#       tabPanel("Component 4")),
#       tabPanel("Component 5")),
# 
)
)
)

