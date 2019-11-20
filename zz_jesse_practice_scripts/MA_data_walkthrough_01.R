#' data: 
#'   Massachusetts public school data, 2016-2017 school year
#' 
#' downloaded on 24/10/2019 from kaggle:
#'   https://www.kaggle.com/ndalziel/massachusetts-public-schools-data/download 
#'   
#' SCOPE:
#'   Basics of navigating and using RStudio
#'   How's and why's of using a Project + here()
#'   Introduction on how packages, functions, and data interact
#'     > import it
#'     > inspect and explore it
#'     > manipulate and reshape it 
#'   How packages and functions interact with the above
#'     integrate throughout the text after an introductory paragraph
#'   Cover the very basics of R
#'   Integrate information on how to get help//use help documentation

# prior to script ---------------------------------------------------------

#' download R/RStudio (previous chapter)
#' successfully set up a Project 
#'   > talk about file structures

# environment setup -------------------------------------------------------

# install.packages("tidyverse")
# install.packages("janitor")
# install.packages("skimr")
# install.packages("here")

#' text: information on installing vs. loading
#' how to find packages
#' exploring a package

library(tidyverse)
library(janitor)
library(skimr)
library(here)

#' text information on:
#'   function, package, argument
#'     > not all terms//items are mutually exclusive
#'   load order
#'   conflicts (and how to resolve - load order, `::`)
#'   why loading should always happen at the top of the script
#'   restarting your R session regularly
#'   file paths and tree structure
#'   commenting
#'     # vs #'
#'     outline mode!
#'   this chapter might be like drinking from a fire hose - read it, but know 
#'   that it will always be here to dip back into as you progress in your R 
#'   journey


# import ------------------------------------------------------------------

# will need to re-format for text
read_csv(here("zz_jesse_practice_scripts/data/for_use", 
              "MA_Public_Schools_2017.csv"))

read_csv(here("zz_jesse_practice_scripts/data/for_use", 
              "MA_Public_Schools_2017.csv")) -> my_data

ma_data_init <- read_csv(here("zz_jesse_practice_scripts/data/for_use", 
                              "MA_Public_Schools_2017.csv"))

#' notes to self:
#'   check for understanding questions - reinforce data, project, package, and 
#'   function concepts: 
#'     what in our code is a package? a function? how do we know?
#'     what's in our data?
#'       using built-in, non-coding tools to get information and do an initial 
#'       exploration of the data
#'     how would you skip the first x lines in reading in a .csv file?
#'       see ?read_csv for additional arguments
#'     how would you import other file types?
#'   how to name things
#'   talk about data types



# inspect and explore -----------------------------------------------------

names(ma_data_init)

glimpse(ma_dat_init)  # intentional error - checking Environment pane
glimpse(ma_data_init)
summary(ma_data_init)

#' using:
#'   $
glimpse(ma_data_init$Town)
summary(ma_data_init$Town)

glimpse(ma_data_init$AP_Test Takers)
glimpse(ma_data_init$`AP_Test Takers`)
summary(ma_data_init$`AP_Test Takers`)

#' another way to explore
ma_data_init %>% 
    group_by(District Name) %>%  # intentional error 
    count()

ma_data_init %>% 
    group_by(`District Name`) %>% 
    count()  #' look into whether or not we need ungroup() here
    
ma_data_init %>% 
    group_by(`District Name`) %>% 
    count() %>% 
    filter(n > 10)

# keep to show error when don't close a parentheses
# ma_data_init %>% 
#     group_by(`District Name`) %>% 
#     count() %>% 
#     filter(n > 10) %>% 
#     arrange(desc(n)

ma_data_init %>%
    group_by(`District Name`) %>%
    count() %>%
    filter(n > 10) %>%
    arrange(desc(n))

#' skimr functions 
ma_data_init %>% 
    skim()

ma_data_init %>% 
    skim(`AP_Test Takers`)

ma_data_init %>% 
    skim(`District Name`, `AP_Test Takers`)

ma_data_init %>% 
    skim(`District Name`:TOTAL_Enrollment)

#' keep the following chunk but caution when running 
#' talk about the red stop button!
ma_data_init %>% 
    group_by(`District Name`) %>% 
    skim()

ma_data_init %>% 
    group_by(`District Name`) %>% 
    skim(TOTAL_Enrollment)

#' notes;
#'   what additional intentional errors can be introduced in order to improve 
#'   the learning experience?
#'   talk about pipes
#'     how long should a pipe be?
#'     pipes loaded with tidyverse
#'     pipes also via magrittr
#'       - give background on this



# manipulate and reshape --------------------------------------------------

#' change names manually, then with janitor::clean_names()

ma_data_init %>% 
    rename(district_name = `District Name`)

ma_data_init %>% 
    rename(district_name = `District Name`) %>% 
    select(district_name)

ma_data_init %>% 
    rename(district_name = `District Name`,
           grade = Grade) %>% 
    select(district_name, grade)

ma_data_init %>% 
    rename(district_name = `District Name`,
           grade = Grade) %>% 
    select(district_name, grade) %>% 
    skim()

#' when to provide arguments and when we don't need them

ma_data %>% 
    clean_names()

01_ma_data <- ma_data_init %>%  #' intentional error
    clean_names()

$_ma_data <- ma_data_init %>%  #' intentional error
    clean_names()

ma_data_01 <- ma_data_init %>% 
    clean_names()  #' thoughts on how to name variables//data?

#' doing a thing vs. doing a thing and saving the thing
#' hypothesizing
#' draw it out

