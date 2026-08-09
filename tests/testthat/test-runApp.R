test_that("the bundled shiny app is installed", {
  app <- system.file("shiny/app.R", package = "tr.iatgen")

  expect_true(nzchar(app))
  expect_true(file.exists(app))
})

test_that("the bundled shiny app is syntactically valid", {
  app <- system.file("shiny/app.R", package = "tr.iatgen")

  expect_no_error(parse(app))
})

test_that("runApp() hands the bundled app directory to shiny::runApp()", {
  captured <- NULL

  local_mocked_bindings(
    runApp = function(...) {
      captured <<- list(...)
      invisible(NULL)
    },
    .package = "shiny"
  )

  tr.iatgen::runApp()

  expect_match(captured$appDir, "shiny/app\\.R$")
})

test_that("runApp() passes extra arguments through to shiny::runApp()", {
  captured <- NULL

  local_mocked_bindings(
    runApp = function(...) {
      captured <<- list(...)
      invisible(NULL)
    },
    .package = "shiny"
  )

  tr.iatgen::runApp(port = 1234L, launch.browser = FALSE)

  expect_match(captured$appDir, "shiny/app\\.R$")
  expect_equal(captured$port, 1234L)
  expect_false(captured$launch.browser)
})
