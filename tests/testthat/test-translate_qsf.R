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
# TODO: test user-provided lang file, test if it runs with no dst_file,
#       test if it returns a character witht the right path,
#       invalid test wrong inputs
