
# Pointless test given the cotents of globals.R + available_languages.R
# Maybe it could be useful in the future...but feel free to delete it.
test_that("langs global variable contains the right values", {
  expected <- read.csv("../mocks/valid/available_languages.csv")

  # expect_equal(langs, expected)
  # compare only the current state (not the future state)
  expect_true(all(dplyr::inner_join(available.languages(), expected) == expected))
})
