# book-status.R

library(tidyverse)
library(cloc)
library(wordcountaddin)

# Calculating word count
output <- tibble(file = list.files()) %>% 
    filter(str_detect(file, ".Rmd")) %>% 
    mutate(file = as.character(file)) %>% 
    mutate(wordcount = map_int(unlist(.), word_count))

output %>% 
    summarize(total_wordcount = sum(wordcount))

cloc::cloc_by_file(getwd()) %>% 
    filter(language == "Markdown") %>% 
    summarize(total_loc = sum(loc))