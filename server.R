shinyServer(function(input, output, session) {

  r <- reactiveValues(df = read.csv("pollution by sectors and countries.csv", header=TRUE, sep = ";"), source = NULL)
  # You can access the values of the widget (as a vector)
  callModule(plot_Co2, "Co2", reactive(r$df))
  callModule(plot_World_Map,"World Map",reactive(r$df))
})