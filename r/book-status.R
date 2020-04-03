# book-status.R

library(tidyverse)
# library(tidycode) # wondering if we can also count code
library(wordcountaddin)

# Calculating word count
tibble(file = list.files()) %>% 
    filter(str_detect(file, ".Rmd")) %>% 
    mutate(file = as.character(file)) %>% 
    mutate(wordcount = map_int(unlist(.), word_count)) %>% View()

tibble(file = list.files()) %>% 
    filter(str_detect(file, ".Rmd")) %>% 
    mutate(file = as.character(file)) %>% 
    mutate(wordcount = map_int(unlist(.), word_count)) %>% 
    summarize(total_wordcount = sum(wordcount))

cloc::cloc_by_file(getwd())

cloc::cloc_by_file(getwd()) %>% 
    summarize(total_loc = sum(loc))
