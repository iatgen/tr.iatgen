#' @title Run a standalone Shiny App for iatgen translation
#'
#' @param ... All parameters are passed to Shiny runApp function
#' 
#' @examples
#' # this will start shiny UI
#' # tr.iatgen::runApp()
#' 
#' @importFrom shiny runApp
#' @export
runApp <- function(...) {
   appDir <- system.file('shiny/app.R', package = 'tr.iatgen')
   shiny::runApp(..., appDir=appDir)
}