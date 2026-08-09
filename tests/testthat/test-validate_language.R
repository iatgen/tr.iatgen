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
  mock_path <- "../mocks/valid/en_pt-pt.csv"

  expect_equal(validate.language(mock_path), "pt-pt")
})

test_that("validate.language() returns correct code for Turkish", {
  mock_path <- "../mocks/valid/en_tr.csv"

  expect_equal(validate.language(mock_path), "tr")
})

# Files that cannot be read at all are reported as invalid, per the
# documented "NULL if error" contract.
test_that("validate.language() returns NULL for a file that does not exist", {
  expect_null(validate.language("../mocks/valid/no_such_file.csv"))
})

test_that("validate.language() returns NULL for a file that is not a CSV", {
  expect_null(validate.language("../mocks/valid/iat-flowins.qsf"))
})

test_that("validate.language() returns NULL when a cell is NA", {
  csv <- read.csv("../mocks/valid/en_cs.csv", check.names = FALSE)
  csv$cs[1] <- NA

  path <- tempfile(fileext = ".csv")
  on.exit(unlink(path), add = TRUE)
  write.csv(csv, path, row.names = FALSE)

  # This used to raise "missing value where TRUE/FALSE needed".
  expect_null(validate.language(path))
})

test_that("validate.language() accepts a file with several target languages", {
  expect_equal(
    validate.language("../mocks/valid/en_cs_de.csv"),
    c("cs", "de")
  )
})

test_that("validate.language() returns correct code for Czech", {
  expect_equal(validate.language("../mocks/valid/en_cs.csv"), "cs")
})
