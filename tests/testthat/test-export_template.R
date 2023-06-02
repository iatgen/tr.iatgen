test_that("export.template() returns a single value", {
  out_len <- length(export.template())

  expect_equal(out_len, 1)
})

test_that("export.template() returns a value of class character", {
  out_class <- class(export.template())

  expect_equal(out_class, "character")
})

test_that("export.template() returns a path ending in templates/en_en.csv", {
  out_ending <- grepl("templates/en_en.csv$", export.template())

  expect_equal(out_ending, TRUE)
})
