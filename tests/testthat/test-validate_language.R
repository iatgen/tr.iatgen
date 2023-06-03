test_that("validate language", {
  csv_file <- export.template()
  ret <- validate.language(csv_file)
  expect_equal(ret, "target_language_abbreviation")

  csv_file <- test_path("test_broken_lang.csv")
  ret <- validate.language(csv_file)
  expect_equal(ret, NULL)
})
