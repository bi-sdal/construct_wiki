def_meta_box_UI <- function(id) {
    ns <- NS(id)

    lapply(1:10, function(i) {
        uiOutput(ns(paste0('def', i)))
    })
}

def_meta_box <- function(input, output, session, construct_selected, df_react, def_count_react) {

    observeEvent(construct_selected(), {
        print(sprintf('num def: %s', def_count_react()))

        lapply(1:def_count_react(), function(i) {
            output[[paste0('def', i)]] <- renderUI({
                session$ns(paste0('def', i))

                fluidRow(
                    box(
                        df_react()$definition[i],
                        title = "Definition",
                        solidHeader = TRUE,
                        collapsible = FALSE,
                        collapsed = FALSE,
                        status = 'warning'
                    ),
                    box(
                        h3("Neighboring Construct(s)"),

                        p(str_to_title(unique(neighbors(.GlobalEnv$G, construct_selected(), mode = 'all')$name))),

                        h3("Field(s) of study"),

                        p(df_react()$field[i]),

                        h3("Funded by military?"),

                        p(df_react()$military[i]),

                        h3("Empirical study..."),

                        h4("Target population"),

                        p(df_react()$population[i]),

                        h4("Type of measurement"),

                        p(df_react()$measurement[i]),

                        h4("Instrument used"),

                        p(df_react()$instrument[i]),

                        h4("Additional Notes"),

                        p(df_react()$notes),

                        # a(md_text$display_name, href = md_text$url, target = "_blank"),
                        title = "Metadata",
                        solidHeader = TRUE,
                        collapsible = TRUE,
                        collapsed = FALSE,
                        status = 'danger'
                    )
                )
            })
        })
    })
}
