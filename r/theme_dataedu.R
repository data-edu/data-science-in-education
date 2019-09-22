#' Data Science in Education
#' Plot Theme

#' Reference --------------------------------------------------------------
#' http://joeystanley.com/blog/custom-themes-in-ggplot2

#' Custom Theme  ----------------------------------------------------------

#' Libraries
library(tidyverse)
if (!require("extrafont")) install.packages("extrafont")
library(extrafont)
font_import(pattern = "Arial Rounded Bold")

#' Function
theme_dataedu <-
    function () {
        theme_minimal(
            base_size = 12, 
            base_family = "ArialRoundedMTBold") %+replace% 
            theme(
                legend.background = element_rect(fill="transparent", colour=NA),
                legend.key = element_rect(fill = "transparent", colour = NA)
            )
    }