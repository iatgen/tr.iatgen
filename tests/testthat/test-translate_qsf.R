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
