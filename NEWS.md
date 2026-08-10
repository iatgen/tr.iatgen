# tr.iatgen 1.1.5

* Fixed `translate.qsf.gui()`, which passed the menu *index* rather than the
  selected language code to `translate.qsf()` and so failed on every run. It
  now also aborts cleanly when the language dialog is cancelled.
* `translate.qsf()` accepts a full `"<src>_<dst>"` translation identifier
  (e.g. `"en_cs"`) when a custom `lang_file` is supplied. Previously the
  prefix was only stripped for built-in translations.
* `translate.qsf()` no longer mangles custom translation columns whose name
  contains an underscore: `"pt_br"` is treated as a destination language, and
  `"en_pt_br"` resolves to it rather than to `"pt"`.
* `translate.qsf()` now reports an error when `src_lang` is not one of the
  columns of a custom translation file. It previously wrote out an
  untranslated file and reported success.
* `translate.qsf()` reports an unreadable `lang_file` as such instead of
  raising an error from `read.csv()`.
* `validate.language()` returns `NULL` for files it cannot read, and for files
  containing missing (`NA`) cells, as documented. Both previously raised an
  error.
* `export.template()` honours `src_lang` and errors for source languages that
  have no template, instead of silently returning the English one.
* Fixed the broken `runApp()` screenshot link in the README.
* Added test coverage reporting to Codecov via GitHub Actions; the package
  is now fully covered by its test suite.

# tr.iatgen 1.1.4

* Updated `inst/CITATION` to prioritize citing the associated paper (Santos et al., 2026, PLOS ONE) and protocol (Santos et al., 2024, protocols.io) before the R package itself.

# tr.iatgen 1.1.2

* Added examples in the vignette, pointing to
  [Santos and collaborators (2023)](https://doi.org/10.17504/protocols.io.kxygx34jdg8j/v1),
  for a comprehensive tutorial.
* Fixed German and Italian or translation.

# tr.iatgen 1.1.1

* Fixed German translation.

# tr.iatgen 1.1.0

* Added Spanish as an official translation.

# tr.iatgen 1.0.0

* Added a `NEWS.md` file to track changes to the package.
