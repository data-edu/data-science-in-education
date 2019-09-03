# book-status.R

library(tidyverse)
# library(tidycode) # wondering if we can also count code
library(wordcountaddin)

rmd_files <- list.files() %>% 
    as.data.frame() %>% 
    set_names("filename") %>% 
    filter(str_detect(filename, ".Rmd")) %>% 
    mutate(filename = as.character(filename))

rmd_files %>% 
    mutate(wordcount = map(unlist(rmd_files), word_count))


