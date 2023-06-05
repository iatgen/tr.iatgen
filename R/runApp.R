#' @title Run a standalone Shiny App for iatgen translation
#' @description
#' This starts R shiny web based application to facilitate iatgen-generated QSF translation.
#' It is a pass through function to shiny::runApp.
#'
#' \figure{../vignettes/runApp.png}
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
  appDir <- system.file("shiny/app.R", package = "tr.iatgen")
  shiny::runApp(..., appDir = appDir)
}
