#' @title Export blank translation template
#'
#' @param src_lang Source language -- "en" for english is the only supported one.
#'
#' @return The path to the template file (class: character).
#'
#' @examples
#' export.template()
#'
#' @export
export.template <- function(src_lang = "en") {
  system.file("templates/en_en.csv", package = "tr.iatgen")
}
