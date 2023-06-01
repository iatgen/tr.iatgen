#' Title
#'
#' @param file Source CSV file to validate
#' @param src_lang Source language -- "en" for english is the only supported one.
#'
#' @return heading of the second column (langugate identifier) if successful, NULL if error
#' @export
validate.language <- function(file, src_lang="en") {
   csv <- read.csv(file)
   template_csv <- read.csv(system.file('templates/en_en.csv', package = 'tr.iatgen'))
   
   if (
       # check if two columns exists
       ncol(csv) == 2 &&
       # check if the input file has first column "en"
       names(csv)[1] == "en" &&
       nrow(csv) == 28 &&
       # check if the strings in the first column correspond to our template
       all(sort(csv$en) == sort(template_csv$en)) &&
       # check if the second column has non-empty strings
       all(!(csv[,1] == ""))
   ) {
     # return name of the second column if successful
     dst_lang <- names(csv)[2]
     return(dst_lang)
   }
   return(NULL) # -- if error
}