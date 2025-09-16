library(shiny)
library(bslib)

generate_story <- function(noun, verb, adjective, adverb) {
  story <- glue::glue(
    "
    Once upon a time, there was a {adjective} {noun} who loved to
    {verb} {adverb}. It was the funniest thing ever!
  "
  )
  cat(story,file=stderr())
  story
}



ui <- page_sidebar(
  title="Mad Libs Game",
  sidebar=sidebar(
    sidebarPanel(
      textInput("noun1", "Enter a noun:", ""),
      textInput("verb", "Enter a verb:", ""),
      textInput("adjective", "Enter an adjective:", ""),
      textInput("adverb", "Enter an adverb:", "")
    )
    ),
    card(
      card_header("Your Mad Libs Story"),
      textOutput("story")
  )
)

server <- function(input, output) {
  cat(rep("-",100), file=stderr())
  story <- reactive({
    generate_story(input$noun1, input$verb, input$adjective, input$adverb)
  })
  cat(rep("-",100),file=stderr())
  output$story <- renderText({
    story()
  })
  cat(rep("-",100),file=stderr())
}

shinyApp(ui = ui, server = server)
