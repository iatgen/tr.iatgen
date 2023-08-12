#' @title Graphical user interface (GUI) to translate iatgen generate QSF file
#'
#' @description
#' This function allows you to translate an iatgen QSF file by visually
#' selecting the files and settings for the translation.
#'
#' It's a wrapper around 'translate.qsf()', meant to be make it more
#' user-friendly for less technical users.
#'
#' See the official iatgen website for a web based alternative.
#'
#' @return translated file location
#'
#' @examples
#' ## Not run (requires an interactive session)
#' # translate.qsf.gui()
#' @importFrom utils menu
#' @export
translate.qsf.gui <- function() {
  # Ugly hack because file.choose doesn't print a title.
  # choose.files() does but only works on Windows.
  tmp <- menu(c("Ok"),
    graphics = TRUE,
    "After clicking 'Ok' please select the Qualtrics QSF you wish to translate"
  )
  f <- file.choose()
  l <- menu(gsub("^en_", "", langs$Code),
    graphics = TRUE,
    title = "Please select the language you want to translate TO"
  )
  lf <- NULL
  # TODO: If we start accepting src_lang != "en", then add a menu here
  # sl <- menu()
  sl <- "en"
  tmp <- menu(c("Ok"),
    graphics = TRUE,
    title = "After clicking 'Ok' please select the location and name for the file where your translated QSF file will be saved"
  )
  df <- file.choose(new = TRUE)
  custom_lf <- menu(c("no (default)", "yes (you'll be prompted to select it"),
    graphics = TRUE,
    title = "Will you be using a custom translation file?"
  )

  if (custom_lf == 2) {
    lf <- file.choose()
  }

  translate.qsf(file = f, lang = l, lang_file = lf, src_lang = sl, dst_file = df)
}
