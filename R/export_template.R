#' @title Export blank translation template
#'
#' @param src_lang Source language -- "en" for english is the only supported one.
#'
#' @return the path to the template.
#'
#' @examples
#' export.template()
#'
#' @export
export.template <- function(src_lang = "en") {
  system.file("templates/en_en.csv", package = "tr.iatgen")
}
