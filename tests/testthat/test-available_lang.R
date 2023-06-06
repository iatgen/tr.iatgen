test_that("available.languages() works", {
  expected <- read.csv("../mocks/valid/available_languages.csv")

  expect_equal(available.languages(), expected)
})
