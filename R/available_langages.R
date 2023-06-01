#' @title Return the list of available languages for iatgen translation
#'
#' @returns Returns dataframe listing the supported languages.
#'
#' \describe{
#'   \item{Code}{Translation identifier}
#'   \item{Description}{Verbose translation description}
#' }
#'
#' @examples
#' available.languages()
#'
#' @export
available.languages <- function() {
  langs
}
