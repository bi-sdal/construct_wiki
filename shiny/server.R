library(shiny)

# helpful
# https://gist.github.com/tbadams45/38f1f56e0f2d7ced3507ef11b0a2fdce
# https://www.rstudio.com/resources/webinars/understanding-shiny-modules/
# https://gist.github.com/bborgesr/e1ce7305f914f9ca762c69509dda632e
# https://stackoverflow.com/questions/21636023/r-shiny-simple-reactive-issue
# http://shiny.leg.ufpr.br/daniel/025-loop-ui/
# https://shiny.rstudio.com/gallery/creating-a-ui-from-a-loop.html

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {

    output$vis_network <- renderVisNetwork({
        visNetwork(network_dfs$nodes, network_dfs$edges, width = "100%", height = "75%") %>%
            visEdges(arrows = "from") %>%
            visOptions(manipulation = TRUE,
                       collapse = TRUE) %>%
            visLayout(randomSeed = 42)
    })

    definition_selected <- reactive({
        input$construct_name
    })

    definition_selected_df <- reactive({
        df <- .GlobalEnv$constructs[.GlobalEnv$constructs$construct == definition_selected(), ]
        return(df)
    })

    definition_num <- reactive({
        return(nrow(definition_selected_df()))
    })

    output$definition_count_text <- renderText({
        if (definition_num() == 1) {
            return(sprintf('Definition count: %s', definition_num()))
        } else {
            return(sprintf('Definitions count: %s', definition_num()))
        }
    })

    output$construct_definition <- renderUI({
        # md_text <- .GlobalEnv$parse_md_a('[A document](https://drive.google.com/open?id=0B7onm2yXv1-wX2FJVkxVUUZ3a2c)')
        # print(sprintf('selected: %s', input$construct_name))
        # construct_row_dat <- .GlobalEnv$constructs[.GlobalEnv$constructs$construct == input$construct_name, ]

        # def_count_text <- if_else(nrow(construct_row_dat) == 1,
        #                           sprintf("There is %s definition for this construct", nrow(construct_row_dat)),
        #                           sprintf("There are %s definitions for this construct", nrow(construct_row_dat)))

        # .GlobalEnv$def_meta_boxes(construct_row_dat, def_count_text)

    })

    callModule(def_meta_box, 'defs', definition_selected_df, definition_num)

    output$construct_dt <- DT::renderDataTable({
        .GlobalEnv$constructs
    }, options = list(pageLength = nrow(.GlobalEnv$constructs),
                      lengthMenu = c(5, 10, 15, 20, 50, 100, nrow(.GlobalEnv$constructs)),
                      colReorder = TRUE,
                      fixedHeader = TRUE,
                      extensions = 'Responsive'))
})
