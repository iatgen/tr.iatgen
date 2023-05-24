## code to prepare `langs` dataset goes here

langs <- read.csv("langs/langs.csv")

# names(langs) <- "langs"

usethis::use_data(langs, overwrite = TRUE)
