rm(list=ls(all=TRUE))

options(digits = 3)

knitr::opts_chunk$set(
    comment = "#>",
    out.width = "100%",
    fig.align = "center",
    fig.path = "/figures",
    warning = FALSE,
    dpi = 300,
    tidy.opts = list(width.cutoff = 80), 
    tidy = TRUE
    )

set.seed(2020)