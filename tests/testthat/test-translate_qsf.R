# These are probably better labeled as usage rather than unit tests.
# translate.qsf() doesn't take that many parameters so we can probably
# fuzzy test many combinations as this is the most important function.
test_that("translate.qsf() works in a case similar to the example in the manual", {
  translate.qsf(
    file = "../mocks/valid/iat-flowins.qsf",
    lang = "pt-pt", dst_file = "../tmp.qsf"
  )

  expect_equal(
    readLines("../tmp.qsf"),
    readLines("../mocks/valid/iat-flowins_pt.qsf")
  )
})

test_that("translate.qsf() can translate to Japanese", {
  translate.qsf(
    file = "../mocks/valid/iat-flowins.qsf",
    lang = "jp", dst_file = "../tmp.qsf"
  )

  expect_equal(
    readLines("../tmp.qsf"),
    readLines("../mocks/valid/iat-flowins_jp.qsf")
  )
})

test_that("translate.qsf() can translate to Turkish", {
  translate.qsf(
    file = "../mocks/valid/iat-flowins.qsf",
    lang = "tr", dst_file = "../tmp.qsf"
  )

  expect_equal(
    readLines("../tmp.qsf"),
    readLines("../mocks/valid/iat-flowins_tr.qsf")
  )
})

# This one has been done before but the example can change.
test_that("translate.qsf() can translate to Portuguse", {
  translate.qsf(
    file = "../mocks/valid/iat-flowins.qsf",
    lang = "pt-pt", dst_file = "../tmp.qsf"
  )

  expect_equal(
    readLines("../tmp.qsf"),
    readLines("../mocks/valid/iat-flowins_pt.qsf")
  )
})

# translat.qsf only accepts English as the source language.
# I think we should teach it to translate from and to other languages.
test_that("translate.qsf() taskes a valid src_lang", {
  translate.qsf(
    file = "../mocks/valid/iat-flowins.qsf",
    lang = "jp", src_lang = "en", dst_file = "../tmp.qsf"
  )

  expect_equal(
    readLines("../tmp.qsf"),
    readLines("../mocks/valid/iat-flowins_jp.qsf")
  )
})

test_that("translate.qsf() can translate with user provided language file.", {
  translate.qsf(
    file = "../mocks/valid/iat-flowins.qsf",
    lang = "pt-pt", lang_file = "../mocks/valid/en_pt-pt.csv",
    dst_file = "../tmp.qsf"
  )

  expect_equal(
    readLines("../tmp.qsf"),
    readLines("../mocks/valid/iat-flowins_pt.qsf")
  )
})

test_that("translate.qsf() can translate with no dst_file.", {
  dst_path <- translate.qsf(file = "../mocks/valid/iat-flowins.qsf", lang = "jp")

  expect_no_error(translate.qsf(file = "../mocks/valid/iat-flowins.qsf", lang = "jp"))
  expect_no_warning(translate.qsf(file = "../mocks/valid/iat-flowins.qsf", lang = "jp"))
  expect_no_message(translate.qsf(file = "../mocks/valid/iat-flowins.qsf", lang = "jp"))

  expect_match(dst_path, ".*Rtmp.*")
})

# Testing invalid inputs.
test_that("translate.qsf() returns error with invalid or no file.", {
  # This test is failing, we should refactor the code so it passes.
  # qsf_file <- test_path("invalid.qsf")

  # expect_error(translate.qsf(file = qsf_file, lang = "jp"),
  # "Unable to read input qsf file.")
  # I reckon we should refactor the code to provide a standard error.
  # "argument "file" is missing, with no default
  expect_error(
    translate.qsf(lang = "jp"),
    "Unable to read input qsf file."
  )
})

test_that("translate.qsf() returns error with invalid lang", {
  qsf_file <- "../mocks/valid/iat-flowins.qsf"
  err <- "Invalid lang or src_lang provided. Please check by calling available.languages for a list of translations."

  expect_error(
    translate.qsf(file = qsf_file, lang = "xx"),
    err
  )
  expect_error(
    translate.qsf(file = qsf_file, lang = "pt-pt", src_lang = "something"),
    err
  )
})

test_that("translate.qsf() returns error with invalid lang_file", {
  # Shouldn't it read "invalid" vs "invalidate" language file.
  # "Unable to read lang file: .." is not outputed as an error message,
  # but as something else.
  expect_error(
    translate.qsf(
      file = "../mocks/valid/iat-flowins.qsf",
      lang = "tr",
      lang_file = "../mocks/invalid/missing_cells.csv"
    ),
    "Invalid language file."
  )
})

# TODO: find some way to provide an invalid file or one which cannot
#       be oppened.
# test_that("translate.qsf() returns error with invalid dst_file", {
#  expect_error(translate.qsf(file = "../mocks/valid/iat-flowins.qsf",
#                             lang = "jp",
#                             dst_file = "invalid.qsf"))
# })

test_that("translate.qsf() returns error with invalid src_lang", {
  expect_error(translate.qsf(
    file = "../mocks/valid/iat-flowins.qsf",
    lang = "jp", src_lang = "something"
  ))
})

# ---------------------------------------------------------------------------
# Translation identifiers.

test_that("translate.qsf() accepts a full '<src>_<dst>' identifier", {
  translate.qsf(
    file = "../mocks/valid/iat-flowins.qsf",
    lang = "en_pt-pt", dst_file = "../tmp.qsf"
  )

  expect_equal(
    readLines("../tmp.qsf"),
    readLines("../mocks/valid/iat-flowins_pt.qsf")
  )
})

test_that("translate.qsf() accepts a full identifier with a custom translation file", {
  # Regression: the "<src>_" prefix used to be stripped for built-in
  # translations only, so a custom file could only be used as "<dst>".
  prefixed <- translate.qsf(
    file = "../mocks/valid/iat-flowins.qsf",
    lang = "en_cs", lang_file = "../mocks/valid/en_cs.csv"
  )
  plain <- translate.qsf(
    file = "../mocks/valid/iat-flowins.qsf",
    lang = "cs", lang_file = "../mocks/valid/en_cs.csv"
  )

  expect_equal(readLines(prefixed), readLines(plain))
  expect_false(
    identical(readLines(prefixed), readLines("../mocks/valid/iat-flowins.qsf"))
  )
})

test_that("translate.qsf() leaves column names containing '_' alone", {
  # "target_language_abbreviation" must not be truncated to "language".
  dst <- translate.qsf(
    file = "../mocks/valid/iat-flowins.qsf",
    lang = "target_language_abbreviation",
    lang_file = "../mocks/valid/en_en.csv"
  )

  expect_true(file.exists(dst))
})

test_that("translate.qsf() returns the dst_file it was given", {
  dst <- file.path(tempdir(), "explicit-dst.qsf")
  on.exit(unlink(dst), add = TRUE)

  expect_equal(
    translate.qsf(
      file = "../mocks/valid/iat-flowins.qsf", lang = "jp", dst_file = dst
    ),
    dst
  )
  expect_true(file.exists(dst))
})

# ---------------------------------------------------------------------------
# Translating between two non-English languages.

test_that("translate.qsf() can translate from a non-English source language", {
  cs <- translate.qsf(
    file = "../mocks/valid/iat-flowins.qsf",
    lang = "cs", lang_file = "../mocks/valid/en_cs.csv"
  )
  de <- translate.qsf(
    file = cs, lang = "de", src_lang = "cs",
    lang_file = "../mocks/valid/en_cs_de.csv"
  )

  # Confirm the Czech intermediate really does carry the text we expect to
  # see replaced, so the assertions below cannot pass vacuously.
  expect_true(
    any(grepl("Opravte chyby stisken jakekoliv klavesy.", readLines(cs), fixed = TRUE))
  )

  out <- readLines(de)

  # The Czech source text is gone and German has taken its place.
  expect_false(any(grepl("Opravte chyby stisken jakekoliv klavesy.", out, fixed = TRUE)))
  expect_true(any(grepl("Alle Inhalte werden geladen.", out, fixed = TRUE)))
})

test_that("translate.qsf() errors when src_lang is absent from the translation file", {
  # Previously this silently wrote out an *untranslated* file and reported
  # success.
  expect_error(
    translate.qsf(
      file = "../mocks/valid/iat-flowins.qsf",
      lang = "cs", src_lang = "de",
      lang_file = "../mocks/valid/en_cs.csv"
    ),
    "The `from` language column \"de\" is not available",
    fixed = TRUE
  )
})

# ---------------------------------------------------------------------------
# Further invalid inputs.

test_that("translate.qsf() errors when lang is absent from the custom translation file", {
  expect_error(
    translate.qsf(
      file = "../mocks/valid/iat-flowins.qsf",
      lang = "xx", lang_file = "../mocks/valid/en_cs.csv"
    ),
    "Invalid `lang` or `src_lang` provided",
    fixed = TRUE
  )
})

test_that("translate.qsf() errors when the language file cannot be read", {
  expect_error(
    translate.qsf(
      file = "../mocks/valid/iat-flowins.qsf",
      lang = "cs", lang_file = "../mocks/valid/no_such_file.csv"
    ),
    "Unable to read language file.",
    fixed = TRUE
  )
})

test_that("translate.qsf() errors on a NULL lang", {
  expect_error(
    translate.qsf(file = "../mocks/valid/iat-flowins.qsf", lang = NULL),
    "Invalid lang or src_lang provided",
    fixed = TRUE
  )
})

test_that("translate.qsf() reports a missing built-in translation file", {
  # Simulates a broken installation: the built-in translation cannot be found.
  local_mocked_bindings(pkg.file = function(...) "")

  msgs <- capture_messages(
    out <- translate.qsf(file = "../mocks/valid/iat-flowins.qsf", lang = "jp")
  )

  expect_match(paste(msgs, collapse = ""), "Unable to read builtin lang file")
  expect_null(out)
})

test_that("translate.qsf() keeps a custom column name containing an underscore", {
  # "pt_br" is a destination language in its own right -- it must not be
  # truncated to "br" the way the "<src>_<dst>" form is stripped.
  csv <- read.csv("../mocks/valid/en_cs.csv", check.names = FALSE)
  names(csv)[2] <- "pt_br"

  lang_file <- tempfile(fileext = ".csv")
  on.exit(unlink(lang_file), add = TRUE)
  write.csv(csv, lang_file, row.names = FALSE)

  dst <- translate.qsf(
    file = "../mocks/valid/iat-flowins.qsf",
    lang = "pt_br", lang_file = lang_file
  )

  expect_true(
    any(grepl("Opravte chyby stisken jakekoliv klavesy.", readLines(dst), fixed = TRUE))
  )
})

# ---------------------------------------------------------------------------
# Corrupt installations: the built-in translation file exists but its columns
# do not match what the requested translation needs. These guards are not
# reachable through valid inputs, so the lookup of the bundled file is stubbed.

test_that("translate.qsf() errors when the built-in file lacks the target column", {
  # Asks for Japanese but is handed a Czech translation file.
  local_mocked_bindings(pkg.file = function(...) "../mocks/valid/en_cs.csv")

  expect_error(
    translate.qsf(file = "../mocks/valid/iat-flowins.qsf", lang = "jp"),
    "The `to` language column name provided is not available",
    fixed = TRUE
  )
})

test_that("translate.qsf() errors when the built-in file lacks the source column", {
  # A translation file whose source column is not "en".
  csv <- read.csv("../mocks/valid/en_cs.csv", check.names = FALSE)
  names(csv) <- c("xx", "jp")

  broken <- tempfile(fileext = ".csv")
  on.exit(unlink(broken), add = TRUE)
  write.csv(csv, broken, row.names = FALSE)

  local_mocked_bindings(pkg.file = function(...) broken)

  expect_error(
    translate.qsf(file = "../mocks/valid/iat-flowins.qsf", lang = "jp"),
    "The `from` language column name provided is not available",
    fixed = TRUE
  )
})

test_that("translate.qsf() resolves the prefixed form of an underscored column", {
  # "en_pt_br" must resolve to the "pt_br" column rather than to "pt".
  csv <- read.csv("../mocks/valid/en_cs.csv", check.names = FALSE)
  names(csv)[2] <- "pt_br"

  lang_file <- tempfile(fileext = ".csv")
  on.exit(unlink(lang_file), add = TRUE)
  write.csv(csv, lang_file, row.names = FALSE)

  prefixed <- translate.qsf(
    file = "../mocks/valid/iat-flowins.qsf",
    lang = "en_pt_br", lang_file = lang_file
  )
  plain <- translate.qsf(
    file = "../mocks/valid/iat-flowins.qsf",
    lang = "pt_br", lang_file = lang_file
  )

  expect_equal(readLines(prefixed), readLines(plain))
})
