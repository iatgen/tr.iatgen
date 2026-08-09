#' Locate a file shipped with the package
#'
#' Thin wrapper around [base::system.file()] that fills in the package name,
#' giving a single place where bundled files are resolved (and a seam that
#' tests can stub out to simulate a broken installation).
#'
#' @param ... Path components, passed on to [base::system.file()].
#'
#' @return The absolute path, or `""` when the file is not installed
#'   (class: character).
#'
#' @noRd
pkg.file <- function(...) {
  system.file(..., package = "tr.iatgen")
}

#' Prompt the user for a file
#'
#' Thin wrapper around [base::file.choose()]. It exists so the interactive
#' file prompts can be stubbed out when testing [translate.qsf.gui()].
#'
#' @param ... Passed on to [base::file.choose()].
#'
#' @return The selected path (class: character).
#'
#' @noRd
# nocov start -- interactive, cannot be exercised in a test run
choose.file <- function(...) {
  file.choose(...)
}
# nocov end
