# Welcome

TBD

# Useful commands

## Build man pages
``` r
roxygen2::roxygenise()
```

## Build manual
``` r
devtools::build_manual()
```

## Run Examples
``` r
devtools::run_examples()
```

## Style R files
``` r
styler::style_pkg()
# or single files: styler::style_file("R/validate_language.R")
```

## Check tests coverage
``` r
covr::package_coverage()
```
