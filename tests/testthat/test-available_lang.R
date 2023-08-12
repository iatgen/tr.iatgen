test_that("available.languages() works", {
  # the most basic test -- it returns not null
  # the other tests will do more
  expect_true(!is.null(available.languages()))
})
