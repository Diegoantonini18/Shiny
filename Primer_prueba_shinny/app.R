library(shiny)
library(shinyShortcut)
ui=fluidPage(
    titlePanel("Bienvenidos
               
               "),
    textInput(inputId="name", label="¿Cuál es su nombre?"),
    textOutput("q")
)
server=function(input,output){
    output$q=renderText({
        paste("¿Qué querés para comer",input$name,"?")
    })
    
}


shinyApp(ui=ui, server=server)
shinyShortcut()
