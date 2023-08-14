#' @title Translate iatgen generated QSF file
#'
#' @description
#' Read-in iatgen generated QSF file and translated it to a target language
#' specified by user either from the list of available languages included
#' in tr.iatgen package or using the custom supplied translation file.
#
# FIXME:
# 1. 'en' -> lang
# 2. src_lang -> 'en' -> lang (optionaly provided either 'en' -> src_lang or 'en' -> lang)
# 3. src_lang -> mid_lang -> 'en' -> lang (provided file src_lang -> mid_lang)
# 4. src_lang -> 'en' -> mid_lang -> lang (provided file mid_lan -> lang)
#'
#' @param file qsf file
#' @param lang Target language (abbreviation).
#' @param lang_file CSV file containing custom translation.
#' @param src_lang Source language -- "en" for english is the only supported one.
#' @param dst_file save the translated file as. If NULL temporary file will be created.
#'
#' @return translated file location
#'
#' @examples
#' # example code
#' my_qsf_file <- system.file("examples/iat-flowins.qsf", package = "tr.iatgen")
#' translate.qsf(file = my_qsf_file, lang = "pt")
#'
#' @importFrom utils read.csv
#' @export
translate.qsf <-
  function(file,
           lang,
           lang_file = NULL,
           src_lang = "en",
           dst_file = NULL) {
    # Load user .qsf contents into memory.

    src_qsf_content <- tryCatch(
      {
        # con <- file(file)
        # try(readLines(con))
        # file_content <- readLines(con, warn=FALSE, error=)
        # close(con)
        # return(file_content)
        suppressWarnings({
          readLines(file, warn = F)
        })


        # con <- file(file, "r", blocking = FALSE)
        # str <- readLines(con, warn=F)
        # close(con)
        # str
      },
      error = function(cond) {
        # message(paste("Unable to read file:", file))
        # message("Here's the original error message:")
        # message(cond)
        stop("Unable to read input qsf file.")
      }
    )

    if (is.null(src_qsf_content)) {
      return(NULL)
    }

    # first check if we are provided with a custom language file
    if (!is.null(lang_file)) {
      ret_lang <- validate.language(file = lang_file, src_lang = src_lang)
      if (is.null(ret_lang)) {
        stop("Invalid language file.")
        return(NULL)
      }
      inst <- tryCatch(
        {
          read.csv(lang_file)
        },
        error = function(cond) {
          stop("Unable to read language file.")
        }
      )

      if (!is.null(lang) &&
        (lang %in% ret_lang || lang %in% paste0("en", "_", ret_lang))
      ) {
        lang <- as.character(lang)
      } else {
        stop(
          "Invalid `lang` or `src_lang` provided. Please check your custom tranlation file\n"
        )
      }

      # if there is no custom langugage file work with built-in translations
    } else {
      available_translation_code <- available.languages()$Code

      if (!is.null(lang) &&
        ((paste0(src_lang, "_", lang) %in% available_translation_code) ||
          lang %in% available_translation_code)) {
        lang <- as.character(lang)
      } else {
        stop(
          "Invalid lang or src_lang provided. Please check by calling available.languages for a list of translations."
        )
      }

      lang_arr <- strsplit(lang, split = "_")[[1]]
      if (length(lang_arr) == 2) {
        lang <- lang_arr[2]

        # FIXME: validate lang_arr[1]?
      }

      builtin_lang_file <- file.path("langs", paste0(src_lang, "_", lang, ".csv"))

      builtin_lang_file <- system.file(builtin_lang_file, package = "tr.iatgen")

      inst <- tryCatch(
        {
          read.csv(builtin_lang_file, check.names = FALSE)
        },
        error = function(cond) {
          message(paste("Unable to read builtin lang file:", builtin_lang_file))
          message("Here's the original error message:")
          message(cond)
          NULL
        }
      )
    }

    if (is.null(inst)) {
      return(NULL)
    }
    
    # now we have inst (mapping from src to dst language)
    if (is.null(dst_file)) {
      dst_file <- tempfile(pattern = "file", tmpdir = tempdir(), fileext = ".qsf")
    }

    # Prepare for translation.
    from <- as.character(src_lang)
    src_qsf_content <- as.character(src_qsf_content)
    if (!lang %in% colnames(inst)) {
      stop(
        paste(
          "The `to` language column name provided is not available in the translations file!\nPlease provide a valid language column name in the tr_iatgen() function call and try again.\n",
          colnames(inst)
        )
      )
    }

    # If src is not english translate to english first.
    if (src_lang != "en") {
      # either the profided file has both src_lang and lang included or we go through 'en'

      if (src_lang %in% colnames(inst)) {
        # src_lang and lang included go direct
        for (i in seq_len(nrow(inst))) {
          src_qsf_content <- gsub(inst[i, src_lang], inst[i, lang], src_qsf_content, fixed = TRUE)
        }
      } else {
        # src_lang not included -- first see if we can "untranslate" to 'en'
      }
    } else {
      # src_lang is 'en'
      if (!src_lang %in% colnames(inst)) {
        stop(
          "The `from` language column name provided is not available in the translations file!\nPlease provide a valid from language column name or none at all in the tr_iatgen() function call and try again.\n"
        )
      }

      # Translate IAT.
      for (i in seq_len(nrow(inst))) {
        src_qsf_content <- gsub(inst[i, src_lang], inst[i, lang], src_qsf_content, fixed = TRUE)
      }
    }
    # Write translated IAT/qsf to `tr_qsf` file.
    writeLines(src_qsf_content, dst_file)
    return(dst_file)
  }
