library(dplyr)
library(ggplot2)
library(datasets)
library(shiny)

df=read.csv("gdp.csv",T,";")
paises=data.frame(colnames(df))
paises=paises[-1,]

ui=fluidPage(
  titlePanel("PLOT GDP"),
  selectInput(inputId="opcion1",label="Select a country",choices = paises),
  selectInput(inputId="opcion2",label="Select a country",choices = paises),
  mainPanel(
    plotOutput("plot")
  )
)

server=function(input,output){

output$plot=renderPlot({
  data= df %>%
    select(rgdpnapc,input$opcion1,input$opcion2)
  data=data[601:nrow(data),]
  b=as.numeric(data[which.max(data[,3]),3]) + 10000
  ggplot(data) +  
    geom_point(aes(x=data[,1],y=data[,2],color=input$opcion1),size=1.5) +
    geom_point(aes(x=data[,1],y=data[,3],col=input$opcion2),size=1.5) +
    scale_x_discrete(breaks=seq(1880,2018,10)) +
    scale_y_discrete(limits=c(0:b),breaks=seq(0,b,10000)) +
    labs(title="GDP per capita USA vs Argentina",caption="Fuente: Madison Data Project",x="Año",y="GDP",subtitle="") 

  })

}

shinyApp(ui=ui, server=server)
