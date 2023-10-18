# Checking that invalid files are reported as such.
# test_that("validate.language() demands two columns", {
#   # Notes:
#   # - I actually think we should accept more than two columns.
#   # - If we refactor we must change the test.
#   # - This test documents what would be potential unexpected behavior.
#   mock_path <- "../mocks/invalid/extra_column.csv"
#
#   expect_equal(is.null(validate.language(mock_path)), TRUE)
# })

test_that("validate.language() demands an 'en' column", {
  # Notes:
  # - I actually think we should accept any value official translation.
  #   Meaning, we could allow for people to translate from a supported
  #   translation to their language.
  # - It would be a simple refactor to validate_language.R.
  # - If we refactor we must change this test.
  mock_path <- "../mocks/invalid/no_en.csv"

  expect_equal(is.null(validate.language(mock_path)), TRUE)
})

test_that("validate.language() checks the translations in the 'en' column are the official ones", {
  mock_path <- "../mocks/invalid/invalid_en.csv"

  expect_equal(is.null(validate.language(mock_path)), TRUE)
})

test_that("validate.language() checks for missing rows", {
  mock_path <- "../mocks/invalid/missing_rows.csv"

  expect_equal(is.null(validate.language(mock_path)), TRUE)
})

test_that("validate.language() checks for missing rows", {
  mock_path <- "../mocks/invalid/missing_cells.csv"

  expect_equal(is.null(validate.language(mock_path)), TRUE)
})

# Checking that valid files are reported as such.
test_that("validate.language() returns correct code for the template", {
  mock_path <- "../mocks/valid/en_en.csv"

  expect_equal(validate.language(mock_path), "target_language_abbreviation")
})

# test_that("validate.language() returns correct code for Japanese", {
#   mock_path <- "../mocks/valid/en_jp.csv"
#
#   expect_equal(validate.language(mock_path), "jp")
# })

# This one shows some behavior that should probably be fixed.
# validate.language() returns pt-br when translate.qsf() expects pt-br.
test_that("validate.language() returns correct code for Brazilian Portuguese", {
  mock_path <- "../mocks/valid/en_pt-br.csv"

  expect_equal(validate.language(mock_path), "pt-br")
})

test_that("validate.language() returns correct code for European Portuguese", {
  mock_path <- "../mocks/valid/en_pt.csv"

  expect_equal(validate.language(mock_path), "pt-pt")
})

test_that("validate.language() returns correct code for Turkish", {
  mock_path <- "../mocks/valid/en_tr.csv"

  expect_equal(validate.language(mock_path), "tr")
})
