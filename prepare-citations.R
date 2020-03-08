# for packages

knitr::write_bib(c("bookdown", "tidyverse", "dplyr", "tidyr", 
                 "ggplot2", "sjPlot", "lme4", "ggraph", "tidygraph", 
                 "caret", "readxl", "here", "lubridate", "dummies",
                 "janitor", "dataedu", "tidyverse", dataedu:::all_packages), "packages.bib")

library(RefManageR)

b <- ReadBib('book.bib')
b_packages <- ReadBib('packages.bib')

b <- sort(b)
b_packages <- sort(b_packages)

WriteBib(b, "book.bib")
WriteBib(b_packages, "packages.bib")
