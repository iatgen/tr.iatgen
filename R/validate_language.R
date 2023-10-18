#' @title Validate user-supplied file to translate iatgen generated QSF file
#'
#' @description
#' The validate.language function reads in csv file which is expected to contain
#' 2 columns and 28 rows:
#' * the first column contains the english language text (as compared to the template file)
#' * the second column contains the translation of the first column in a target language
#' The first rows contains heading -- heading of the first column is "en" for English
#' and the heading of the second colum is iana formatted target langugage specifier.
#'
#' @param file Source CSV file to validate
#' @param src_lang Source language -- "en" for english is the only supported one.
#'
#' @return heading of the second column (langugate identifier) if successful, NULL if error
#'
#' @examples
#' my_csv_file <- system.file("langs/en_jp.csv", package = "tr.iatgen")
#' validate.language(file = my_csv_file)
#'
#' @importFrom utils read.csv
#' @export
validate.language <- function(file, src_lang = "en") {
  csv <- read.csv(file, check.names = FALSE)
  template_csv <- read.csv(system.file("templates/en_en.csv", package = "tr.iatgen"))



  if (
    # check if at least two columns exists
    ncol(csv) >= 2 &&
      # check if the input file has first column "en"
      names(csv)[1] == "en" &&
      nrow(csv) == nrow(template_csv) &&
      # check if the strings in the first column correspond to our template
      all(sort(csv$en) == sort(template_csv$en)) &&
      # check if the all cells have non-empty strings
      all(!(csv == "")) &&
      # if multiple translations make sure they are called distinctly
      length(unique(names(csv)[-1])) == length(names(csv)[-1])
  ) {
    # return name of the second column if successful
    dst_lang <- names(csv)[-1]
    return(dst_lang)
  }
  return(NULL) # -- if error
}
