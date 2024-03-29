#' @title Run a standalone Shiny App for iatgen translation
#' @description
#' This starts R shiny web based application to facilitate iatgen-generated QSF translation.
#' It is a pass through function to shiny::runApp.
#'
#' \figure{runApp.png}
#'
#' @param ... All parameters are passed to Shiny runApp function
#' @return No return value, called for side effects (running the shiny App UI)
#'
#' @examplesIf interactive()
#' # this will start the shiny UI
#' tr.iatgen::runApp()
#'
#' @importFrom shiny runApp
#' @export
runApp <- function(...) {
  appDir <- system.file("shiny/app.R", package = "tr.iatgen")
  shiny::runApp(..., appDir = appDir)
}
