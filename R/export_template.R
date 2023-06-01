#' @title Export blank translation template
#'
#' @param src_lang Source language -- "en" for english is the only supported one.
#'
#' @return something
#' @export
export.template <- function(src_lang="en") {
   system.file('templates/en_en.csv', package = 'tr.iatgen')
}