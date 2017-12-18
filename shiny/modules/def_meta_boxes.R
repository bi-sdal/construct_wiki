def_meta_box_UI <- function(id) {
    ns <- NS(id)

    fluidRow(
        box(
            'hello',
            title = "Definition",
            solidHeader = TRUE,
            collapsible = FALSE,
            collapsed = FALSE,
            status = 'warning'
        ),
        box(
            'world',
            title = "Metadata",
            solidHeader = TRUE,
            collapsible = TRUE,
            collapsed = TRUE,
            status = 'danger'
        )
    )
}

def_meta_box <- function(input, output, session) {

}
