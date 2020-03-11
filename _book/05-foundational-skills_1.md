
# Getting Started with R and RStudio {#c05}

## Chapter Overview

This chapter is designed to take you from installing R and RStudio all the way through the very basics of data loading and manipulation using the {tidyverse} [@wickham2019]. 

We will be covering the following topics in this chapter: 

- Installing R and RStudio
- RStudio environment and pane layout
- Basics of customizing your RStudio environment
- Steps for working through new and unfamiliar content
- Accessing the data sets used in this book

First, you will need to download the latest versions of R [@rcoreteam] and RStudio [@rstudio]. 
R is a free environment for statistical computing and graphics using the programming language R. 
RStudio is a set of integrated tools that allows for a more user-friendly experience for using R.

Although you will likely use RStudio as your main console and editor, _you must first install R_, as RStudio uses R behind-the-scenes. 
Both R and RStudio are freely-available, cross-platform, and open-source.

## Downloading R and RStudio

### To download R:

- Visit this page to download R: [https://cran.r-project.org/](https://cran.r-project.org/)
- Find your operating system (Mac, Windows, or Linux)
- Download the 'latest release' on the page for your operating system and download and install the application

Don't worry; you will not mess anything up if you download (or even install!) the wrong file. 
Once you've installed R, you can get started.

### To download RStudio:

- Visit this page to download RStudio: [https://www.rstudio.com/products/rstudio/download/](https://www.rstudio.com/products/rstudio/download/)
- Under the column called "RStudio Desktop FREE", click Download
- Find your operating system (Mac, Windows, or Linux)
- Download the 'latest release' on the page for your operating system and download and install the application

If you do have issues, consider this [page](https://datacarpentry.org/R-ecology-lesson/), and then reach out for help. 
Another excellent place to get help is the [RStudio Community](https://community.rstudio.com/).

## Getting to know R through RStudio

Now that we've installed both R and RStudio, we will be accessing R _through_ RStudio. 
One of the most reliable ways to tell if you're opening R or RStudio is to look at the icons: 

<center>
![](./man/figures/icons.png)
</center>

RStudio is an **I**ntegrated **D**evelopment **E**nvironment (IDE), and comes with built-in features that make using R a little easier. 
If you'd like more information on the difference between R and RStudio, we recommend the **Getting Started** section of the [Modern Dive](https://moderndive.com/1-getting-started.html#) @statisticalinf textbook.

You do not _have_ to use RStudio to access R, and many people don't! 

Other IDEs that work with R include:

- [Jupyter notebook](https://jupyter.org/)
- [VisualStudio](https://visualstudio.microsoft.com/services/visual-studio-online/)
- [VIM](https://github.com/jalvesaq/Nvim-R)
- [IntelliJ IDEA](https://plugins.jetbrains.com/plugin/6632-r-language-for-intellij)
- [EMACS Speaks Statistics (ESS)](https://ess.r-project.org/)

This is a non-exhaustive list, and most of these options require a good deal of familiarity with a given IDE.
However we bring up alternative IDEs -- particularly ESS -- because RStudio, as of this writing, is not fully accessible for learners who utilize screen readers.
We have chosen to use RStudio in this text in order to standardize the experience, but encourage you to choose the IDE that best suits your needs!

When we open RStudio for the first time, we're likely to see this:

<center>
![](https://i.imgur.com/2rhZmMg.png?1)
</center>  
  
These three "panes" are referred to as the **console** pane, the **environment** pane, and the **files** pane. 
The large square on the left is the **console**, the pane in the top right is the **environment** pane, and the square in the bottom right is the **files** pane.  

When we create a new file, such as an `R script`, an `R Markdown` file, or a `Shiny app`, RStudio will open a fourth pane, known as the **source** pane. 
You can try this out by going to `File -> New File -> R Script`.

When we type out code, we do so in either the **console** or **source** pane. 
It is generally better to type code in an `R script`, which saves as an `.R` file, than to type your code in the console. 
This is because anything you type in the console will be lost as soon as you close R, whereas you can save everything in an `.R` script and see/use it again later.  

**Running code in an R Script**  

There are several ways to run code in an R script:  

- Highlight the line(s) of code you'd like to run and press **Ctrl + Enter**  
- Highlight the line(s) of code you'd like to run and click the **Run** button in the `R script` pane  
- To run _every_ line of code in your file you can press **Ctrl + Shift + Enter**  

**Creating and running code in an R Markdown file**

R Markdown is a highly convenient way to communicate and share results. Navigate to "New File" and then "R Markdown".

Then, click "Knit to PDF", "Knit to HTML", or "Knit to Word".

**Changing your RStudio theme**  

- Explore the various themes available to you in RStudio by going to _Tools -> Global Options -> Appearance_
    + Choose a theme that works best for you and apply it
    
## Steps for working through new and unfamiliar content

## Using the dataedu package to access the data used in this book

We created the {dataedu} package to provide our readers an opportunity to jump into R however they see fit.

We describe how to install the package in the next chapter. The package serves four functions:

1. Mass installation of all the packages used in the book
2. Reproducible code for the walkthroughs
3. Access to the data used in each of the walkthroughs

### Mass Installation of Packages

We strived to use packages that we use in our daily work when creating the walkthroughs in the book. Because we covered a variety of subjects, that means we used a lot of packages! As described in the Foundational Skills chapter, you can install the packages individually as they suit your needs. 

However, if you want to quickly get started and download all the packages at once, please use `install_dataedu()`.

``` r
dataedu::install_dataedu()
```

To see the packages used in the book, run:


```r
dataedu::dataedu_packages
```

```
#>  [1] "apaTables"   "caret"       "dummies"     "ggraph"      "here"       
#>  [6] "janitor"     "lme4"        "lubridate"   "performance" "readxl"     
#> [11] "rtweet"      "randomNames" "sjPlot"      "textdata"    "tidygraph"  
#> [16] "tidylog"     "tidyverse"   "tidytext"
```

**A special note on {tabulizer}:** One of the walkthroughs uses [tabulizer](https://github.com/ropensci/tabulizer), created by ROpenSci to read PDFs. {tabulizer} requires the installation of [RJava](https://cran.r-project.org/web/packages/rJava/index.html), which can be a tricky process on Mac computers. {tabulizer} is not included in `mass_install()` and we recommend reading through the notes on its Github repo if installing.

### Reproducible Code for Walkthroughs

<!-- Need to add -->

### Accessing the Walkthrough Data

You can call the dataset as mentioned in the walkthrough.

``` r
dataedu::course_data
```

## Steps for working through new and unfamiliar content

Need to add
