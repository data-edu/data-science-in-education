# book-status.R

library(tidyverse)
# library(tidycode) # wondering if we can also count code
library(wordcountaddin)

list.files() %>% 
    as.data.frame() %>% 
    set_names("filename") %>% 
    filter(str_detect(filename, ".Rmd")) %>% 
    mutate(filename = as.character(filename)) %>% 
    mutate(wordcount = map(unlist(.), word_count))


