test_that("export template", {
  p <- export.template()
  expect_equal(class(p), "character")
  expect_true(file.exists(p))
})
