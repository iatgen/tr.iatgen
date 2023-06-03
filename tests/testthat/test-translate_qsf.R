test_that("translate qsf", {
  # test handling non existent file
  # ret <- tryCatch( {
  #  qsf_file <- test_path("non_existent_test.qsf")
  #  translate.qsf(file=qsf_file,lang="pt")
  #  ""
  #},
  #error = function(cond) {
  #  cond$message
  #})
  #expect_equal(ret, "Unable to read input qsf file.")

  qsf_file <- test_path("test.qsf")
  ret_string <- tryCatch({
    ret <- translate.qsf(file=qsf_file, lang=NULL)
    ""
  },
  error = function(cond) { cond$message })
  expect_equal(ret_string, 'Invalid `lang` or `src_lang` provided. Please check `available.languages()` for a list of translations\n');

  qsf_file <- test_path("test.qsf")
  ret_string <- tryCatch({
    ret <- translate.qsf(file=qsf_file, lang="pt", src_lang="something")
    ""
  },
  error = function(cond) { cond$message })
  expect_equal(ret_string, 'Invalid `lang` or `src_lang` provided. Please check `available.languages()` for a list of translations\n');

  qsf_file <- test_path("test.qsf")
  ret <- translate.qsf(file=qsf_file,lang="pt")
  expect_true(file.exists(ret))

  qsf_file <- test_path("test.qsf")
  ret <- translate.qsf(file=qsf_file,lang="en_pt")
  expect_true(file.exists(ret))

  qsf_file <- test_path("test.qsf")
  ret <- translate.qsf(file=qsf_file,lang="en_pt",dst_file=tempfile())
  expect_true(file.exists(ret))

  qsf_file <- test_path("test.qsf")
  csv_file <- export.template()
  ret <- translate.qsf(file=qsf_file,lang="target_language_abbreviation",lang_file=csv_file,dst_file=tempfile())
  expect_true(file.exists(ret))
})
