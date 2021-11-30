Co2_UI <- function(id){
  ns <- NS(id)
  list(
  fluidPage(
  titlePanel("Co2 emission for each contry in years"),
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
    #validate(need(df, "Waiting for data."), errorClass = "vis")
    #Plot med sliders sådan at du kan se hvordan det bliver gjort
    #plot <- df_vis %>% ggplot(aes(x=year, y = co2)) + geom_point() + xlim(input$slider) + ylim(input$slider2)
    # Now we can create a plot of the data.
    if(!is.null(input$checkGroup)){
    print(input$checkGroup)
    df_vis <- df() %>% filter(df()$country %in% input$checkGroup)
    }
    else {
      df_vis <- df()
    }
    plot <- df_vis %>% ggplot(aes(x=year, y = co2)) + geom_point()
    plot <- ggplotly(plot)
    return(plot)
  })}
