# These are probably better labeled as usage rather than unit tests.
# translate.qsf() doesn't take that many parameters so we can probably 
# fuzzy test all combinations as this is the most important function.
test_that("translate.qsf() works in a case similar to the example in the manual", {

  translate.qsf(file = "../mocks/valid/iat-flowins.qsf",
                lang = "pt", dst_file = "../tmp.qsf")

  expect_equal(readLines("../tmp.qsf"),
               readLines("../mocks/valid/iat-flowins_pt.qsf"))
})

test_that("translate.qsf() can translate to Japanese", {

  translate.qsf(file = "../mocks/valid/iat-flowins.qsf",
                lang = "jp", dst_file = "../tmp.qsf")

  expect_equal(readLines("../tmp.qsf"),
               readLines("../mocks/valid/iat-flowins_jp.qsf"))
})

test_that("translate.qsf() can translate to Turkish", {

  translate.qsf(file = "../mocks/valid/iat-flowins.qsf",
                lang = "tr", dst_file = "../tmp.qsf")

  expect_equal(readLines("../tmp.qsf"),
               readLines("../mocks/valid/iat-flowins_tr.qsf"))
})

# This one has been done before but the example can change.
test_that("translate.qsf() can translate to Portuguse", {

  translate.qsf(file = "../mocks/valid/iat-flowins.qsf",
                lang = "pt", dst_file = "../tmp.qsf")

  expect_equal(readLines("../tmp.qsf"),
               readLines("../mocks/valid/iat-flowins_pt.qsf"))
})

test_that("translate.qsf() can translate to Portuguse", {

  translate.qsf(file = "../mocks/valid/iat-flowins.qsf",
                lang = "pt-BR", dst_file = "../tmp.qsf")

  expect_equal(readLines("../tmp.qsf"),
               readLines("../mocks/valid/iat-flowins_pt-br.qsf"))
})

test_that("translate.qsf() can translate with user provided language file.", {

  translate.qsf(file = "../mocks/valid/iat-flowins.qsf",
                lang = "pt", lang_file = "../mocks/valid/en_pt.csv",
                dst_file = "../tmp.qsf")

  expect_equal(readLines("../tmp.qsf"),
               readLines("../mocks/valid/iat-flowins_pt.qsf"))
})


test_that("translate.qsf() can translate with no dst_file.", {

  dst_path <- translate.qsf(file = "../mocks/valid/iat-flowins.qsf", lang = "jp")

  expect_no_error(translate.qsf(file = "../mocks/valid/iat-flowins.qsf", lang = "jp"))
  expect_no_warning(translate.qsf(file = "../mocks/valid/iat-flowins.qsf", lang = "jp"))
  expect_no_message(translate.qsf(file = "../mocks/valid/iat-flowins.qsf", lang = "jp"))

  expect_match(dst_path, ".*Rtmp.*")
})

# Testing invalid inputs.
test_that("translate.qsf() returns error with no file.", {

  # We get a standard error message here, and we can test its value.
  expect_error(translate.qsf(lang = "jp"),
               "argument \"file\" is missing, with no default")
  # Doesn't report an error we can test again if we run the line below.
  # I think we should refactor translate.qsf to return error messages.
  #expect_error; expect_warning; expect_message all fail or get us a
  # warning in `devtools::test()`
  #expect_error(translate.qsf(file = "invalid", lang = "jp"))
})

test_that("translate.qsf() returns error with invalid lang", {

  expect_error(translate.qsf(lang = "xx"))
  # We don't seem to be able to test against an error message string.
  #expect_error(translate.qsf(lang = "xx"), "error string") # will fail
})
# TODO: test invalid lang file, invalid dst_file, and some combinations.
