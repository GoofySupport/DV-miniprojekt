Co2_bar_UI <- function(id){
  ns <- NS(id)
  list(
    fluidPage(
      titlePanel("Emission types for each contry over time"),
      plotlyOutput(ns("speedPlot")),
      #sliderInput("slider","try to drag", value=c(0,10),min=0,max=10),
      #sliderInput("slider2","try to drag", value=c(1,3),min=1,max=3, step = 0.1),
      # Copy the chunk below to make a group of checkboxes
      checkboxGroupInput(ns("checkGroup"), label = h3("Checkbox group"), 
                         choices = list("Afghanistan" , "Africa", "Albania","Denmark"),
                         selected = "Afghanistan"),
    )
  )
}
# plot_ggplot
# This is our server function of the module.
# Beyond storing the namespace, all computations must happen inside the
# plotlyOutput reactive context.
plot_Co2 <- function(input, output, session, df) {
  observeEvent(df,{
    contries <- unique(df()$country)
    updateCheckboxGroupInput(session,"checkGroup", label=paste("Checkboxgroup label", length(contries)),
                             choices = contries,
                             selected = "Denmark")
  }
  )
  output$speedPlot <- renderPlotly({
    if(!is.null(input$checkGroup)){
      print(input$checkGroup)
      df_vis <- df() %>% filter(df()$country %in% input$checkGroup)
    }
    else {
      df_vis <- df()
    }
    plot <- df_vis %>% ggplot(aes(x=year, y = c(coal_co2,cement_co2,flaring_co2,gas_co2,oil_co2,other_industry_co2))) + geom_point()
    plot <- ggplotly(plot)
    return(plot)
  })}
