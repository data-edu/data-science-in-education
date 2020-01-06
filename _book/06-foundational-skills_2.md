# Foundational Skills {#c06}

## Chapter overview
This chapter is designed to give you the skills and knowledge necessary to _get started_ in any of the walk through chapters. 
Our goal is to get you working with R using the RStudio *I*ntegrated *D*evelopment *E*nvironment (IDE) through a series of applied examples. 
If you have not yet installed R and/or RStudio, please go through the steps outlined in Chapter 05A before beginning this chapter.    

<!-- Each walkthrough chapter also has its own supplemental *Foundational Skills* section, which is intended to bridge the gap between material covered in this chapter and the material covered within a specific walk through.   -->

Please note that this chapter is not intended to be a full and complete introduction to programming with R, nor for using R for data science. 
There are many excellent resources available which provide this kind of instruction, and we've listed them for you on page [AAA] in the **Resources** section [link for bookdown version].  

## Foundational Skills Framework
No two data science projects are the same, and rather than be overly prescriptive, this chapter errs on the side of creating a general framework for you to use as a home base as you work through this text. 
The four basic concepts we will use to build our framework are:  

* **Data**
* **Projects**  
* **Packages**  
* **Functions**  

You're likely using this text because you have some data that you'd like to do something with, and you'd like to try doing said thing using R. 
The framework we'll use assumes that your data exists externally from R in a `.csv` file, and needs to be brought into R so that we can work with it.  

There are a multitude of file types that data can be stored in.
We've provided additional resources for loading data from Excel, SAV, and Google Sheets at the end of this chapter.

While it is possible to connect directly to a database from within R, we do not cover those skills in this text. 
For those curious as to how to accomplish this, we recommend the following resources [AAA].  

[We'll say more about each component later in this chapter, but for now let's break down this image: [INSERT ILLUSTRATION].  

[Illustration of framework]

We have **data** that we bring into a Project within RStudio. 
RStudio is the interface that we use to access and manipulate R. 
Sometimes you'll hear RStudio referred to as an IDE, or "Interactive Development Environment." 
We use an IDE - in this case RStudio, although you could use others - because it adds features that make our analytical lives a little (and sometimes a lot!) easier. 
You can read more about everything that RStudio offers here (I couldn't find a great resource on this - does anyone have one? Might be worth creating a blog post on it!)  

Within RStudio we set up a **Project**. 
This is the home for all of the files, images, reports, and code that we'll create for a single project.
While there are a myriad of ways to set up the files in your Project, the method we'll use in this text is:  

[IMAGE with src, data (sub: raw, for use), results, images] 

It's OK (and totally normal) for your initial projects to consist of only one or two files. 
As your skill set grows and develops you'll need more and more files, and laying the groundwork for a file structure now will make future you very happy.  

We use Projects because they create a self-contained file for a given analysis in R. 
This means that if you want to share your Project with a colleague they will not have to reset file paths (or even know anything about file paths!) in order to re-run your analysis.  

And even if the only person you ever collaborate with is a future version of yourself, using a Project for each of your analyses will mean that you can move the Project folder around on your computer, or even move it to a new computer, and remain confident that the analysis will run in the future, at least in terms of file path structures. 
You may run into issues with packages being out of date and functions being deprecated - in which case you may be interested in learning more about how to set up a Project within Docker [AAA].  

## Setting up your Project
note: how in-depth into file structures do we want to go?

**How do I create a Project?**  
Creating a Project is one of the first steps in working on an R-based data science project in RStudio (if we were using GitHub for this we'd absolutely recommend setting up your repository first!) 
To create a Project you will need to be in RStudio.  

From within RStudio, follow these steps:  

1. Click on File
2. Select New Project
3. Choose New Directory
4. Click on New Project
5. Enter your Project's name in the box that says "Directory name"
6. Choose where to save your Project by clicking on "Browse" next to the box labeled "Create project as a subdirectory of: "
7. Click "Create Project"  

If you are looking for more resources, including information on using a git repository, whether or not you should open in a new session, etc., please see AAA and BBB resources.  

### Coding in RStudio 

-- import from 05A
## Packages

"Packages" are shareable collections of R code that provide functions (i.e., a command to perform a specific task), data and documentation,. Packages increase the functionality of R by improving and expanding on base R (basic R functions). 

### Installing and Loading Packages

To download a package, you must call `install.packages()`:


```r
install.packages("dplyr", repos = "http://cran.us.r-project.org")
```

You can also navigate to the Packages pane, and then click "Install", which will work the same as the line of code above. 
This is a way to install a package using code or part of the RStudio interface. Usually, writing code is a bit quicker, but using the interface can be very useful and complimentary to use of code. 

*After* the package is installed, it must be loaded into your RStudio session using `library()`:


```r
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

We only have to install a package once, but to use it, we have to load it each time we start a new R session.

> A package is a like a book, a library is like a library; you use library() to check a package out of the library.
> - Hadley Wickham, Chief Scientist, RStudio

### Running Functions from Packages

Once you have loaded the package in your session, you can run the functions that are contained within that package. 
To find a list of all those functions, you can run this in the RStudio console:


```r
help(package = dplyr)
```

The documentation should tell you what the function does, what arguments (i.e., details) needed for it to successfully run, examples, and what the output should look like.

If you know the specific function that you want to look up, you can run this in the RStudio console:


```r
??dplyr::filter
```

Once you know what you want to do with the function, you can run it in your code:


```r
dat <- # example data frame
    data.frame(stringsAsFactors=FALSE,
               letter = c("A", "A", "A", "B", "B"),
               number = c(1L, 2L, 3L, 4L, 5L))

dat
```

```
##   letter number
## 1      A      1
## 2      A      2
## 3      A      3
## 4      B      4
## 5      B      5
```

```r
filter(dat, letter == "A") # using dplyr::filter
```

```
##   letter number
## 1      A      1
## 2      A      2
## 3      A      3
```

-- end import

**Import your data**  

Talk about previous chapter - which goes into different data sources.
Why are we skimming over it here? 
Should we instead focus on data types and structures?


R comes with built in data sets, the list of which you can see by running `data()` in the Console (go ahead, try it! 
You can do this by typing `data()` in the Console window and hitting Enter.) 
You may be familiar with some of the data sets, such as `mtcars` or `iris`, which often get used in vignettes (link out//define) and other various examples. 
Using built-in data sets are a great way to work with R code using a data set that "just works."   

Think of any data science project as consisting of data and code. 
We use code to manipulate data, which means that when we are troubleshooting we need to think about whether or not our code is the source of the error, if our data is the source of the error, or if the error comes from the interaction of the code with the data.  

For this chapter we'll be using data from the Massachusetts Public School System that was originally downloaded from Kaggle on October 23, 2019. Access the data by ???. 

Save your data to the `data --> raw` folder, make a copy of your data, and put the new copy into the `data --> for_use` folder. 

When working with downloaded data (in other words, data files, as opposed to pulling your data directly into R through an API, database connection, or webscraping) it's good practice to keep the initial copy of your data in a folder and to never open that data, _especially if that data is in an `.xls* or .csv` format!_ 
Excel has an overly aggressive way of trying to be helpful with your data, and when you open a file you may find that [your numeric values have been converted to dates](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-016-1044-7). 
At best you need to re-download the file, and at worst you've made a significant amount of work for yourself.    

## Code for Foundational Skills

The following code comprises all of the code that we'll use in this chapter. 
We present it here in its entirety, and then break it down into chunks in order to explain what's happening.  

This code may resemble the start of an analytical workflow, but does not walk you through a complete analysis. 
Instead, the code chosen below is used to highlight key features and foundational skills that comprise the interaction of packages and functions with data.
We recommend the text [R for Data Science]("https://r4ds.had.co.nz/") for those looking for a more in-depth look into completing an analytical workflow in R.   

We do not recommend running the following block of code all at once! 
It intentionally contains errors that will prevent it from running in its entirety. 
Instead we recommend creating a new `.R` script and adding chunks of code as we discuss them in the book, running each chunk of code as we go along in order to better see what is happening in a given line of code. (define a code chunk)    

### See Ryan's work on prefacing functions - need to preface dplyr::arrange()!


```r
# Installing packages

# install.packages("tidyverse")
# install.packages("janitor")
# install.packages("skimr")
# install.packages("here")

# Setting up your environment
library(tidyverse)
library(janitor)
library(skimr)
library(here)

# Importing data
read_csv(here("zz_jesse_practice_scripts/data/for_use", 
              "MA_Public_Schools_2017.csv"))  # change path once finalized in book

read_csv(here("zz_jesse_practice_scripts/data/for_use", 
              "MA_Public_Schools_2017.csv")) -> my_data

ma_data_init <- read_csv(here("zz_jesse_practice_scripts/data/for_use", 
                              "MA_Public_Schools_2017.csv"))

# Exploring and manipulating your data
names(ma_data_init)

glimpse(ma_dat_init)  
glimpse(ma_data_init)
summary(ma_data_init)

glimpse(ma_data_init$Town)
summary(ma_data_init$Town)

glimpse(ma_data_init$`AP_Test Takers`)
glimpse(ma_data_init$`AP_Test Takers`)
summary(ma_data_init$`AP_Test Takers`)

ma_data_init %>% 
    group_by(`District Name`) %>%  
    count()

ma_data_init %>% 
    group_by(`District Name`) %>% 
    count()  
    
ma_data_init %>% 
    group_by(`District Name`) %>% 
    count() %>% 
    filter(n > 10)

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

ma_data_init %>%
    group_by(`District Name`) %>%
    count() %>%
    filter(n = 10) %>%
    arrange(desc(n))

ma_data_init %>%
    group_by(`District Name`) %>%
    count() %>%
    filter(n == 10) %>%
    arrange(desc(n))

ma_data_init %>% 
    rename(district_name = `District Name`,
           grade = Grade) %>% 
    select(district_name, grade)

ma_data %>% 
    clean_names()

01_ma_data <- ma_data_init %>%  #' intentional error
    clean_names()

$_ma_data <- ma_data_init %>%  #' intentional error
    clean_names()

ma_data_01 <- ma_data_init %>% 
    clean_names()
```

## Packages and Functions

**From the outside in**  
Packages are a collection of functions, and most packages are designed for: a specific data set, a specific field, a specific set of tasks. 
Functions are individual components within a package, and functions are what we use to interact with our data.  

**From the inside out**  
To put it another way, an R user might write a series of functions that they find themselves needing to use repeatedly in a variety of projects. 
Instead of re-writing (or copying and pasting) the functions each time they need to use them, an R user can collect all of these individual functions inside a package. 
The R user can then load the package any time that they want to use the functions, using a single line of code instead of tens to tens of thousands of lines of code for each function.  

Most of the packages we'll be working with in this book are available on the **C**omprehensive **R** **A**rchive **N**etwork, or [CRAN]9https://cran.r-project.org/), which means that we can install them using the same set of commands from within R.  

The process of submitting a package and having it published through CRAN is beyond the scope of this book, and it's important to point out that you - yes, you! - can create a package for yourself and never submit it for publication. (why?)  

Lastly, some packages are available directly from developers via GitHub.  

[image]

**The Tidyverse, a package of packages**
The `tidyverse` is a single package that contains additional packages, and within each of those individual packages are a set of functions. The `tidyverse` is an excellent tool that has a cohesive syntax across all functions, and the packages allow you do to the bulk of an analytical workflow. As of this writing, the `tidyverse` is the only known package of packages.  

[image]

## Installing and loading a package

It is entirely possible to do all of your work in R without ever using a package, however we do not recommend that approach due to the wealth of packages available that help reduce both the learning curve associated with R as well as the amount of time spent on any given analytical project.  

In order to access the functions within a package, you must first install the package on your computer. 
If the package is on CRAN we can install it by running the following code:  
`install.packages("package_name")`  

Once a package is installed on your computer you do not have to re-install it in order to use the functions in the package (until you update R - is this still the case, or am I thinking of something else?).  

It is common to load a package into your R environment if you know that you'll be using the functions from within the package. We load a package using the following code:  

`library(package_name)`  

Sometimes you'll see `require()` instead of `library()`. 
We strongly advocate for the use of `library()`, as it forces R to load the package, and if the package is not installed or there are issues with the package, will give you an error message. 
`require()` on the other hand will not give an error if the package is not available or if there are issues with the package. 
Using `library()` will help to eliminate sources of confusion later on.  

### Recognizing a function
Functions in R can be spotted by the use of a word adjacent to a set of parentheses, like so: `word()`

The word (or set of words) represent the name of the function, and the parenthesis are where we can provide arguments to a function, if arguments are needed for the function to run. 
Many functions in R packages do not _require_ arguments, and will use a set of default arguments unless you provide something different from the default.

### Running code in R  
In order to run code in R you need to type your code either in the Console or within an `.R` (or `.Rmd`) script. 
For the purposes of this chapter we recommend creating an `.R` script to type all of your code because you can add comments and then save your `.R` script for reference, whereas anything that you type in the Console will disappear as soon as you restart or close R.  

To run code in the Console, you type your code and hit 'Enter'.  

To run code in an R script, you can run a single line by highlighting it (or placing your cursor at the end of the line) and hitting `Ctrl` + `Enter` (get Mac codes).  

You can also run your code by highlighting it and clicking the `Run` button.

[image]

### Run this code
Take a few minutes to type out and run each of the following code chunks:  


```r
# Installing packages

install.packages("tidyverse")
install.packages("janitor")
install.packages("skimr")
install.packages("here")

# Setting up your environment
library(tidyverse)
library(janitor)
library(skimr)
library(here)
```

What did you notice happening in the Console?  

### How to find a package
CRAN TaskViews
Twitter
Google searches

### How to learn more about a package
Vignettes
Blog posts

### Function conflicts: between packages, between base R and loaded packages
Changing the load order
Using `::` (provide example)

### Commenting in R
`#` and `#'`

## Using functions to import data

### Run this code

```r
read_csv(here("zz_jesse_practice_scripts/data/for_use", 
              "MA_Public_Schools_2017.csv"))  # change path once finalized in book

read_csv(here("zz_jesse_practice_scripts/data/for_use", 
              "MA_Public_Schools_2017.csv")) -> my_data

ma_data_init <- read_csv(here("zz_jesse_practice_scripts/data/for_use", 
                              "MA_Public_Schools_2017.csv"))
```

What do you notice happening in the Console? 

### The assignment operator
`<-` and `->`

### The `here` package 
Works in concert with Projects in RStudio

### Data types
There are different types
We can change data types through coercion
See [Hands on Programming With R]() and [Advanced R]() for more in-depth information

## Datasets and variables

### Run the following code

```r
# Exploring and manipulating your data
names(ma_data_init)

glimpse(ma_dat_init)  
glimpse(ma_data_init)
summary(ma_data_init)

glimpse(ma_data_init$Town)
summary(ma_data_init$Town)

glimpse(ma_data_init$AP_Test Takers)
glimpse(ma_data_init$`AP_Test Takers`)
summary(ma_data_init$`AP_Test Takers`)
```

What differences do you see between each line of code?
What changes in the output to the Console with each line of code that you run?

### Tibbles and dataframes, oh my!
Difference between the two
Other data structures you may encounter (resource: Hands on Programming with R) 

### The `$` operator
Many ways to isolate a single variable 

### Spaces in variable names

## The pipe operator


```r
ma_data_init %>% 
    group_by(District Name) %>%  
    count()

ma_data_init %>% 
    group_by(`District Name`) %>% 
    count()  
    
ma_data_init %>% 
    group_by(`District Name`) %>% 
    count() %>% 
    filter(n > 10)

# ma_data_init %>% 
#     group_by(`District Name`) %>% 
#     count() %>% 
#     filter(n > 10) %>% 
#     arrange(desc(n)
```

### Piping practices 
The `magrittr` package
`dplyr` and package dependencies 
"Correct" pipe length (careful - will need to stick to this throughout text)

### Closing your parentheses
Seeing the `+` sign in the Console
Fixing it by pressing `Esc`

## Finicky functions (rename this section)


```r
ma_data_init %>%
    group_by(`District Name`) %>%
    count() %>%
    filter(n > 10) %>%
    arrange(desc(n))

ma_data_init %>%
    group_by(`District Name`) %>%
    count() %>%
    filter(n = 10) %>%
    arrange(desc(n))

ma_data_init %>%
    group_by(`District Name`) %>%
    count() %>%
    filter(n == 10) %>%
    arrange(desc(n))

ma_data_init %>% 
    rename(district_name = `District Name`,
           grade = Grade) %>% 
    select(district_name, grade)
```

### When functions need arguments and when they don't
(Is there any way to know for sure?) 
Help documentation 

### Functions within functions
Saw in import as well

### The difference between `=` and `==` 
Assignment vs. equality

### Writing your own functions
Basic function structure
Quosures - out of scope of this chapter

## SECTION ON c() and %in%




## Creating objects
In R, everything is an object 

```r
ma_data %>% 
    clean_names()

01_ma_data <- ma_data_init %>%  #' intentional error
    clean_names()

$_ma_data <- ma_data_init %>%  #' intentional error
    clean_names()

ma_data_01 <- ma_data_init %>% 
    clean_names()
```

### Object-oriented programming (OOP)  
How in-depth should we go? May not be relevant

### Analysis vs. development  
Using pre-made functions vs. writing our own functions and packages, exploring pre-made functions 


-- import from 05A: plug in as needed

## Creating Projects

Before proceeding, we're going to take a few steps to set ourselves to make the analysis easier; namely, through the use of Projects, an RStudio-specific organizational tool. 

To create a project, in RStudio, navigate to "File" and then "New Directory". 

Then, click "New Project". 
Choose a directory name for the project that helps you to remember that this is a project that involves data science in education; it can be convenient if the name is typed in `lower-case-letters-separated-by-dashes`, like that. 
You can also choose the sub-directory. 
If you are just using this to learn and to test out creating a Project, you may consider placing it in your downloads or another temporary directory so that you remember to remove it later.

Even if you do not create a Project, you can always check where your working directory (i.e., where your R is pointing) is by running `getwd()`. 
To change it manually, run `setwd(desired/file/path/here)`.


### Track Two: Welcome to the Tidyverse

The `tidyverse` is a set of packages for data manipulation, exploration, and visualization using the design philosophy of 'tidy' data. 
Tidy data has a specific structure: each variable is a column, each observation is a row, and each type of observational unit is a table.

The packages contained in the `tidyverse` provide useful functions that augment base R functionality.

You can installing and load the complete `tidyverse` with:


```r
install.packages("tidyverse")
```


```r
library(tidyverse)
```

**For more information on tidy data, check out [Hadley Wickhams's Tidy Data paper](http://vita.had.co.nz/papers/tidy-data.html).**

## Include at end of chapter!
## Loading Data from Excel, SAV, and Google Sheets

### Loading Excel Files

We will now do the same with an Excel file. 
You might be thinking that you can open the file in Excel and then save it as a `.csv`. 
This is generally a good idea. 
At the same time, sometimes you may need to directly read a file from Excel. 
Note that, when possible, we recommend the use of `.csv` files. 
They work well across platforms and software (i.e., even if you need to load the file with some other software, such as Python).

The package for loading Excel files, `readxl`, is not a part of the tidyverse, so we will have to install it first (remember, we only need to do this once), and then load it using `library(readxl)`. Note that the command to install `readxl` is grayed-out below: The `#` symbol before `install.packages("readxl")` indicates that this line should be treated as a comment and not actually run, like the lines of code that are not grayed-out. It is here just as a reminder that the package needs to be installed if it is not already.

Once we have installed readxl, we have to load it (just like tidyverse):


```r
install.packages("readxl")
```


```r
library(readxl)
```

We can then use the function `read_excel()` in the same way as `read_csv()`, where "path/to/file.xlsx" is where an Excel file you want to load is located (note that this code is not run here):


```r
my_data <-
    read_excel("path/to/file.xlsx")
```

Of course, were this run, you can replace `my_data` with a name you like. Generally, it's best to use short and easy-to-type names for data as you will be typing and using it a lot. 

Note that one easy way to find the path to a file is to use the "Import Dataset" menu. It is in the Environment window of RStudio. Click on that menu bar option, select the option corresponding to the type of file you are trying to load (e.g., "From Excel"), and then click The "Browse" button beside the File/URL field. Once you click on the, RStudio will automatically generate the file path - and the code to read the file, too - for you. You can copy this code or click Import to load the data.

### Loading SAV Files

The same factors that apply to reading Excel files apply to reading `SAV` files (from SPSS). NOte that you can also read `.csv` file directly into SPSS and so because of this and the benefits of using CSVs (they are simple files that work across platforms and software), we recommend using CSVs when possible. First, install the package `haven`, load it, and the use the function `read_sav()`:


```r
install.packages("haven")
```


```r
library(haven)
my_data <-
    read_sav("path/to/file.xlsx")
```

### Google Sheets

Finally, it can sometimes be useful to load a file directly from Google Sheets, and this can be done using the Google Sheets package.


```r
install.packages("googlesheets")
```


```r
library(googlesheets)
```

When you run the command below, a link to authenticate with your Google account will open in your browser. 


```r
my_sheets <- gs_ls()
```

You can then simply use the `gs_title()` function in conjunction with the `gs_read()` function:


```r
df <- gs_title('title')
df <- gs_read(df)
```


This section goes into depth on loading various types of data sources.
The next chapter covers a very specific `.csv` import and looks more at data types and the tidy data structure.

In this section, we'll load data.

You might be thinking that an Excel file is the first that we would load, but there happens to be a format which you can open and edit in Excel that is even easier to use between Excel and R as well as SPSS and other statistical software, like MPlus, and even other programming languages, like Python. That format is `.csv`, or a comma-separated-values file. 

The `.csv` file is useful because you can open it with Excel and save Excel files as `.csv` files. 
Additionally, and as its name indicates, a `.csv` file is rows of a spreadsheet with the columns separated by commas, so you can view it in a text editor, like TextEdit for Macintosh, as well. 
Not surprisingly, Google Sheets easily converts `.csv` files into a Sheet, and also easily saves Sheets as `.csv` files. 
However we would be remiss if we didn't point out that there is a package, `googlesheets`, which can be used to read a Google Sheet directly into R.

For these reasons, we start with - and emphasize - reading `.csv` files. 

### Saving a File from the Web

You'll need to copy this URL:

`https://goo.gl/bUeMhV`

Here's what it resolves to (it's a `.csv` file):

`https://raw.githubusercontent.com/data-edu/data-science-in-education/master/data/pisaUSA15/stu-quest.csv`

This next chunk of code downloads the file to your working directory. 
Run this to download it so in the next step you can read it into R. 
As a note: There are ways to read the file directory (from the web) into R. 
Also, of course, you could do what the next (two) lines of code do manually: Feel free to open the file in your browser and to save it to your computer (you should be able to 'right' or 'control' click the page to save it as a text file with a `.csv` extension).


```r
student_responses_url <-
    "https://goo.gl/bUeMhV"

student_responses_file_name <-
    paste0(getwd(), "/data/student-responses-data.csv")

download.file(
    url = student_responses_url,
    destfile = student_responses_file_name)
```

It may take a few seconds to download as it's around 20 MB.

The process above involves many core data science ideas and ideas from programming/coding. 
We will walk through them step-by-step.

1. The *character string* `"https://goo.gl/wPmujv"` is being saved to an *object* called `student_responses_url`.


```r
student_responses_url <-
    "https://goo.gl/bUeMhV"
```

2. We concatenate your working directory file path to the desired file name for the `.csv` using a *function* called `paste0`. 
This is stored in another *object* called `student_reponses_file_name`. 
This creates a file name with a *file path* in your working directory and it saves the file in the folder that you are working in. 


```r
student_responses_file_name <-
    paste0(getwd(), "/data/student-responses-data.csv")
```

3. The `student_responses_url` *object* is passed to the `url` argument of the *function* called `download.file()` along with `student_responses_file_name`, which is passed to the `destfile` argument.

In short, the `download.file()` function needs to know
- where the file is coming from (which you tell it through the `url`) argument and
- where the file will be saved (which you tell it through the `destfile` argument).


```r
download.file(
    url = student_responses_url,
    destfile = student_responses_file_name)
```

Understanding how R is working in these terms can be helpful for troubleshooting and reaching out for help. 
It also helps you to use functions that you have never used before because you are familiar with how some functions work.

Now, in RStudio, you should see the downloaded file in the Files tab. 
This should be the case if you created a project with RStudio; if not, it should be whatever your working directory is set to. 
If the file is there, great. 
If things are *not* working, consider downloading the file in the manual way and then move it into the directory that the R Project you created it. 

### Loading a `.csv` File

Okay, we're ready to go. 
The easiest way to read a `.csv` file is with the function `read_csv()` from the package `readr`, which is contained within the Tidyverse.

Let's load the tidyverse library:


```r
library(tidyverse) # so tidyverse packages can be used for analysis
```

You may have noticed the hash symbol after the code that says `library(tidyverse`)`. 
It reads `# so tidyverse packages can be used for analysis`. 
That is a comment and the code after it (but not before it) is not run (the code before it runs just like normal). 
Comments are useful for showing *why* a line of code does what it does. 

After loading the tidyverse packages, we can now load a file. 
We are going to call the data `student_responses`:


```r
# readr::write_csv(pisaUSA15::stu_quest, here::here("data", "pisaUSA15", "stu_quest.csv"))
student_responses <-
    read_csv("./data/student-responses-data.csv")
```

```
## Parsed with column specification:
## cols(
##   .default = col_double(),
##   CNT = col_character(),
##   CYC = col_character(),
##   NatCen = col_character(),
##   STRATUM = col_character(),
##   Option_Read = col_character(),
##   Option_Math = col_character(),
##   ST011D17TA = col_character(),
##   ST011D18TA = col_character(),
##   ST011D19TA = col_character(),
##   ST124Q01TA = col_logical(),
##   IC001Q01TA = col_logical(),
##   IC001Q02TA = col_logical(),
##   IC001Q03TA = col_logical(),
##   IC001Q04TA = col_logical(),
##   IC001Q05TA = col_logical(),
##   IC001Q06TA = col_logical(),
##   IC001Q07TA = col_logical(),
##   IC001Q08TA = col_logical(),
##   IC001Q09TA = col_logical(),
##   IC001Q10TA = col_logical()
##   # ... with 420 more columns
## )
```

```
## See spec(...) for full column specifications.
```

Since we loaded the data, we now want to look at it. 
We can type its name in the function `glimpse()` to print some information on the dataset (this code is not run here).


```r
glimpse(student_responses)
```

Woah, that's a big data frame (with a lot of variables with confusing names, to boot)!

Great job loading a file and printing it! 
We are now well on our way to carrying out analysis of our data.


### Saving Files

Using our data frame `student_responses`, we can save it as a `.csv` (for example) with the following function. The first argument, `student_reponses`, is the name of the object that you want to save. The second argument, `student-responses.csv`, what you want to call the saved dataset.


```r
write_csv(student_responses, "student-responses.csv")
```

That will save a `.csv` file entitled `student-responses.csv` in the working directory. If you want to save it to another directory, simply add the file path to the file, i.e. `path/to/student-responses.csv`. To save a file for SPSS, load the haven package and use `write_sav()`. There is not a function to save an Excel file, but you can save as a `.csv` and directly load it in Excel.

### Conclusion

We will detail the functions used to read every file in a folder (or, to write files to a folder).

## Processing Data

Now that we have loaded `student_responses` into an object, we can process it. This section highlights some common data processing functions. 

We're also going to introduce a powerful, unusual *operator* in R, the pipe. The pipe is this symbol: `%>%`. It lets you *compose* functions. It does this by passing the output of one function to the next. A handy shortcut for writing out `%>%` is Command + Shift + M.

Here's an example. Let's say that we want to select a few variables from the `student_responses` dataset and save those variables into a new object, `student_mot_vars`. Here's how we would do that using `dplyr::select()`.


```r
student_mot_vars <- # save object student_mot_vars by...
    student_responses %>% # using dataframe student_responses
    select(SCIEEFF, JOYSCIE, INTBRSCI, EPIST, INSTSCIE) # and selecting only these five variables
```

Note that we saved the output from the `select()` function to `student_mot_vars` but we could also save it back to `student_responses`, which would simply overwrite the original data frame (the following code is not run here):


```r
student_responses <- # save object student_responses by...
    student_responses %>% # using dataframe student_responses
    select(student_responses, SCIEEFF, JOYSCIE, INTBRSCI, EPIST, INSTSCIE) # and selecting only these five variables
```

We can also rename the variables at the same time we select them. I put these on separate lines so I could add the comment, but you could do this all in the same line, too. It does not make a difference in terms of how `select()` will work.


```r
student_mot_vars <- # save object student_mot_vars by...
    student_responses %>% # using dataframe student_responses
    select(student_efficacy = SCIEEFF, # selecting variable SCIEEFF and renaming to student_efficiency
           student_joy = JOYSCIE, # selecting variable JOYSCIE and renaming to student_joy
           student_broad_interest = INTBRSCI, # selecting variable INTBRSCI and renaming to student_broad_interest
           student_epistemic_beliefs = EPIST, # selecting variable EPIST and renaming to student_epistemic_beliefs
           student_instrumental_motivation = INSTSCIE # selecting variable INSTSCIE and renaming to student_instrumental_motivation
    )
```

[will add more on creating new variables, filtering grouping and summarizing, and joining data sets]

## Communicating / Sharing Results

R Markdown is a highly convenient way to communicate and share results. Navigate to "New File" and then "R Markdown". [add]

Then, click "Knit to PDF", "Knit to HTML", or "Knit to Word".

### miscellaneous from import
`clipr` is a package to easily copy data into and out of R using the clipboard. [add more]

`datapasta` is another option. [add more]
-- end of import



## Old text - keep until reincorporated//readdressed
To break that down another way, it's helpful to know that R reads everything on the left of the assignment operator, `<-`, first, and while it reads from left to right, it starts with the innermost set of parentheses per object.  

We can recognize functions in R by the use of parentheses. For example, `data()` is a function that pulls up all of the existing data sets within R.  
The parentheses within a function can be empty, but sometimes a function requires arguments in order to work. Arguments are the components that go inside the parentheses of a function, like when we coerced our `UCBAdmissions` data into a tibble.  

We can see which arguments a function uses by calling up the help documentation. We do this by going to the Console and typing a `?` followed by the function's name, then hitting enter. For example, run `?data` in the Console (notice that there is not a space between the question mark and the function's name).  

Now try `?mutate` - what's different?   

`mutate` is a function from the `dplyr` package - a package we'll use extensively throughout this book. But because we haven't brought the `dplyr` package into R yet (how does this fit into the mental model? Is this the right place to talk about this? - might be too far out of scope and belong at the end, in the explanations section.) R doesn't "see" the `mutate` function as existing.  

If we want to search all of R's packages (on our computer? look into this - may require package installation section) we can use `??function_name`, in this case `??mutate`.  

This brings up the entire list of packages that mention a `mutate` function. It's important to note that there is no requirement that function names be specific within the entire world of R (OK this definitely goes at the end). There's not a lot stopping every package on CRAN (all 10,000+ of them!) from having their own `mutate` function. That's not necessarily a problem, as you likely won't be running every package on CRAN simultaneously over the course of this book.  

However we can address two quick ways of dealing with this:  

The order in which you load your packages matters! If there are conflicting functions between packages, the package loaded most recently will take priority.   

But what if you need a function from a package that was loaded earlier?  

It might be tempting to re-load the earlier package, but we don't recommend this - it's going to cause you headaches further down the line when you try to re-run your script. Instead, keep in mind option two:  

Explicitly tell R which package to load a function from - independent of the order in which you loaded the packages - by using a double colon (is this what it's called?) `::`.   

This brings us full circle back to translating everything we did with the `UCBAdmissions` data, where we saw the code `tibble::as_tibble(UCBAdmissions)`. The use of the `::` is how we tell R to go to the `tibble` package and pull out the `as_tibble` function.   

"But wait!" you say, "we've never loaded a package!" Exactly! We can call functions from packages without loading the package into our environment by using the `::`. The only requirement is that the package be installed on the machine that we're using (confirm that this is true).  

 

## May not need
**Grab your data**  
[Kaggle Massachusetts Public Schools Data](https://www.kaggle.com/ndalziel/massachusetts-public-schools-data/download)  

Comes as a .zip file (explain this?)
