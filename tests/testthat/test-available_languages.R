test_that("available languages", {
  p <- available.languages()
  expect_equal(class(p), "data.frame")
  expect_true(ncol(p) == 4)
  expect_true(nrow(p) > 2)
})
