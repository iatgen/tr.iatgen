#' @title Export blank translation template
#'
#' @param src_lang Source language -- "en" for english is the only supported one.
#'
#' @return The path to the template file (class: character). An error is raised
#'   if no template is shipped for `src_lang`.
#'
#' @examples
#' export.template()
#'
#' @export
export.template <- function(src_lang = "en") {
  template <- pkg.file(file.path("templates", paste0(src_lang, "_", src_lang, ".csv")))

  if (!nzchar(template)) {
    stop(
      "No translation template available for `src_lang` \"", src_lang,
      "\". Only \"en\" is currently supported."
    )
  }

  template
}
