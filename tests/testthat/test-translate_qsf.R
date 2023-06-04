test_that("translate qsf", {
  # test handling non existent file
  qsf_file <- test_path("non_existent_file.qsf")
  expect_error(
    translate.qsf(file = qsf_file, lang = "pt"),
    "Unable to read input qsf file."
  )

  # missing lang argument
  qsf_file <- test_path("test.qsf")
  expect_error(
    translate.qsf(file = qsf_file, lang = NULL),
    "Invalid lang or src_lang provided. Please check by calling available.languages for a list of translations."
  )

  # invalid src lang
  expect_error(
    translate.qsf(file = qsf_file, lang = "pt", src_lang = "something"),
    "Invalid lang or src_lang provided. Please check by calling available.languages for a list of translations."
  )

  # returned translated file exists for lang="pt"
  qsf_file <- test_path("test.qsf")
  ret <- translate.qsf(file = qsf_file, lang = "pt")
  expect_true(file.exists(ret))

  # returned translated file exists for lang="en_pt"
  qsf_file <- test_path("test.qsf")
  ret <- translate.qsf(file = qsf_file, lang = "en_pt")
  expect_true(file.exists(ret))

  # returned translated file exists if we specify dst_file
  qsf_file <- test_path("test.qsf")
  dst_file <- tempfile()
  ret <- translate.qsf(file = qsf_file, lang = "en_pt", dst_file = dst_file)
  expect_true(file.exists(ret))
  expect_equal(ret, dst_file)

  # returned translated file using a custom translation definition exists
  qsf_file <- test_path("test.qsf")
  csv_file <- export.template()
  ret <- translate.qsf(file = qsf_file, lang = "target_language_abbreviation", lang_file = csv_file)
  expect_true(file.exists(ret))
})
