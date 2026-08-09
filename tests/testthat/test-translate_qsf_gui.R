# translate.qsf.gui() is interactive: it collects its arguments through
# menu()/file.choose() and then delegates to translate.qsf(). The tests below
# stub out the interactive parts and assert on what gets delegated.

# Returns a function that replies to successive menu() calls with `answers`.
queued_menu <- function(answers) {
  i <- 0

  function(...) {
    i <<- i + 1
    answers[[i]]
  }
}

# Returns a function that replies to successive file.choose() calls with `paths`.
queued_file_choose <- function(paths) {
  i <- 0

  function(...) {
    i <<- i + 1
    paths[[i]]
  }
}

test_that("translate.qsf.gui() translates the menu selection into a language code", {
  captured <- NULL

  local_mocked_bindings(
    # 1: "Ok", 2: language, 3: "Ok", 4: no custom translation file
    menu = queued_menu(list(1L, 2L, 1L, 1L)),
    choose.file = queued_file_choose(list("src.qsf", "dst.qsf")),
    translate.qsf = function(...) {
      captured <<- list(...)
      "dst.qsf"
    }
  )

  out <- translate.qsf.gui()

  # menu() returns the index of the choice, not the choice itself.
  expect_equal(captured$lang, available.languages()$Code[2])
  expect_equal(captured$file, "src.qsf")
  expect_equal(captured$dst_file, "dst.qsf")
  expect_equal(captured$src_lang, "en")
  expect_null(captured$lang_file)
  expect_equal(out, "dst.qsf")
})

test_that("translate.qsf.gui() asks for a custom translation file when requested", {
  captured <- NULL

  local_mocked_bindings(
    # 4: yes, a custom translation file will be supplied
    menu = queued_menu(list(1L, 1L, 1L, 2L)),
    choose.file = queued_file_choose(list("src.qsf", "dst.qsf", "custom.csv")),
    translate.qsf = function(...) {
      captured <<- list(...)
      "dst.qsf"
    }
  )

  translate.qsf.gui()

  expect_equal(captured$lang_file, "custom.csv")
  expect_equal(captured$lang, available.languages()$Code[1])
})

test_that("translate.qsf.gui() aborts when the language selection is cancelled", {
  called <- FALSE

  local_mocked_bindings(
    # menu() returns 0 when the user cancels the dialog.
    menu = queued_menu(list(1L, 0L)),
    choose.file = queued_file_choose(list("src.qsf")),
    translate.qsf = function(...) {
      called <<- TRUE
      "dst.qsf"
    }
  )

  expect_message(out <- translate.qsf.gui(), "No language selected")
  expect_null(out)
  expect_false(called)
})
