# Pointless test given the cotents of globals.R + available_languages.R
# Maybe it could be useful in the future...but feel free to delete it.
test_that("langs global variable contains the right values", {
  expected <- read.csv("../mocks/valid/available_languages.csv")

  expect_equal(langs, expected)
})

