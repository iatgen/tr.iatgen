#' @title Translate iatgen generated QSF file
#' 
#' @description
#' Read-in iatgen generated QSF file and translated it to a target language
#' specified by user either from the list of available languages included
#' in tr.iatgen package or using the custom supplied translation file.
#' 
#'
#' @param file qsf file
#' @param lang Target language (abbreviation).
#' @param lang_file CSV file containing custom translation. 
#' @param src_lang Source language -- "en" for english is the only supported one.
#' @param dst_file save the translated file as. If NULL temporary file will be created.
#'
#' @return translated file location
#' @importFrom utils read.csv
#' @export
translate.qsf <-
  function(file,
           lang,
           lang_file = NULL,
           src_lang = "en",
           dst_file = NULL) {
    
    # Load user .qsf contents into memory.
    
    src_qsf_content <- tryCatch({
      readLines(file)
    },error=function(cond) {
      message(paste("Unable to read file:", file))
      message("Here's the original error message:")
      message(cond)
      NULL
    })
    
    if (is.null(src_qsf_content)) {
      return(NULL)
    }
    
    if (is.null(lang)) {
      stop(
        "No `lang` argument provided. Please provide a valid language column name in the translate.qsf() function call and try again.\n"
      )
    } else {
      lang <- as.character(lang)
    }
    if (is.null(src_lang)) {
      from <- "en"
    } else {
      src_lang <- as.character(src_lang)
    }
    
    lang_arr <- strsplit(lang, split = "_")[[1]]
    if (length(lang_arr) == 2)  {
       lang <- lang_arr[1]
    }
    
    builtin_lang_file <- file.path("langs", paste0(src_lang, "_", lang, ".csv"))
    
    builtin_lang_file <- system.file(builtin_lang_file, package = 'tr.iatgen')
    
    if (!is.null(lang_file)) {
      inst <- tryCatch({
        ret <- validate.language(file=lang_file, src_lang=src_lang)
        if (is.null(ret)) {
          # error
          stop("invalidate language file")
          return(NULL)
        }
        read.csv(lang_file)
      },error=function(cond) {
        message(paste("Unable to read lang file:", lang_file))
        message("Here's the original error message:")
        message(cond)
        NULL
      })
    } else {
      inst <- tryCatch({
        read.csv(builtin_lang_file, check.names = FALSE)
      },error=function(cond) {
        message(paste("Unable to read builtin lang file:", builtin_lang_file))
        message("Here's the original error message:")
        message(cond)
        NULL
      })
    }
    
    if (is.null(inst)) {
      return(NULL)
    }
    
    if (is.null(dst_file))
      dst_file <- tempfile(pattern = "file", tmpdir = tempdir(), fileext = "qsf")
    
    # Prepare for translation.
    from <- as.character(src_lang)
    src_qsf_content <- as.character(src_qsf_content)
    if (!lang %in% colnames(inst))
      stop(
        paste(
          "The `to` language column name provided is not available in the translations file!\nPlease provide a valid language column name in the tr_iatgen() function call and try again.\n",
          colnames(inst)
        )
      )
    if (!src_lang %in% colnames(inst))
      stop(
        "The `from` language column name provided is not available in the translations file!\nPlease provide a valid from language column name or none at all in the tr_iatgen() function call and try again.\n"
      )
    # Translate IAT.
    for (i in seq_len(nrow(inst)))
      src_qsf_content <- gsub(inst[i, src_lang], inst[i, lang], src_qsf_content, fixed = TRUE)
    # Write translated IAT/qsf to `tr_qsf` file.
    writeLines(src_qsf_content, dst_file)
}