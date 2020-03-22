
# Getting Started with R and RStudio {#c05}

## Chapter Overview

This chapter is designed to take you from installing R and RStudio all the way through the very basics of data loading and manipulation using the {tidyverse} [@wickham2019]. 

We will be covering the following topics in this chapter: 

- Installing R and RStudio
- RStudio environment, layout, and customization
- How to run code in R
- Installing the {dataedu} package
- Help documentation
- Steps for working through new and unfamiliar content
- Getting started with {swirl}

## Downloading R and RStudio

First, you will need to download the latest versions of R [@rcoreteam] and RStudio [@rstudio]. 
R is a free environment for statistical computing and graphics using the programming language R. 
RStudio is a set of integrated tools that allows for a more user-friendly experience for using R.

Although you will likely use RStudio as your main console and editor, _you must first install R_, as RStudio uses R behind-the-scenes.  
Both R and RStudio are freely-available, cross-platform, and open-source.

### To Download R:

- Visit [CRAN](https://cran.r-project.org/) (https:[]()//cran.r-project.org/) to download R 
- Find your operating system (Mac, Windows, or Linux)
- Download the 'latest release' on the page for your operating system and download and install the application

Don't worry; you will not mess anything up if you download (or even install!) the wrong file. 
Once you've installed R, you can get started.

### To Download RStudio:

- Visit [RStudio's website](https://www.rstudio.com/products/rstudio/download/) (https[]()://www.rstudio.com/products/rstudio/download/) to download RStudio s
- Under the column called "RStudio Desktop FREE", click Download
- Find your operating system (Mac, Windows, or Linux)
- Download the 'latest release' on the page for your operating system and download and install the application

If you do have issues, consider [the Data Carpentry page](https://datacarpentry.org/R-ecology-lesson/) (https[]()://datacarpentry.org/R-ecology-lesson/) and then reach out for help. Another excellent place to get help is the [RStudio Community foums](https://community.rstudio.com/) (https[]()://community.rstudio.com/).

## RStudio Layout and Customization: Getting to Know R through RStudio

Now that we've installed both R and RStudio, we will be accessing R _through_ RStudio. 
One of the most reliable ways to tell if you're opening R or RStudio is to look at the icons: 

<div class="figure" style="text-align: center">
<img src="./man/figures/Figure 5.1.png" alt="Icons" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-2)Icons</p>
</div>

Whenever we want to work with R, we'll open RStudio.
RStudio interfaces directly with R, and is an **I**ntegrated **D**evelopment **E**nvironment (IDE).
This means that RStudio comes with built-in features that make using R a little easier. 
If you'd like more information on the difference between R and RStudio, we recommend the **Getting Started** section of the [Modern Dive](https://moderndive.com/1-getting-started.html#) (https[]()://moderndive.com/1-getting-started.html#) @statisticalinf textbook.

You do not _have_ to use RStudio to access R, and many people don't! 

Other IDEs that work with R include:

- [Jupyter notebook](https://jupyter.org/) (https[]()://jupyter.org/)
- [VisualStudio](https://visualstudio.microsoft.com/services/visual-studio-online/) (https[]()://visualstudio.microsoft.com/services/visual-studio-online/)
- [VIM](https://github.com/jalvesaq/Nvim-R) (https[]()://github.com/jalvesaq/Nvim-R)
- [IntelliJ IDEA](https://plugins.jetbrains.com/plugin/6632-r-language-for-intellij) (https[]()://plugins.jetbrains.com/plugin/6632-r-language-for-intellij)
- [EMACS Speaks Statistics (ESS)](https://ess.r-project.org/) (https[]()://ess.r-project.org/)

This is a non-exhaustive list, and most of these options require a good deal of familiarity with a given IDE.
However we bring up alternative IDEs -- particularly ESS -- because RStudio, as of this writing, is not fully accessible for learners who utilize screen readers.
We have chosen to use RStudio in this text in order to standardize the experience, but encourage you to choose the IDE that best suits your needs!

### RStudio layout 

When we open RStudio for the first time, we're should see something similar to this:

<div class="figure" style="text-align: center">
<img src="./man/figures/Figure 5.2.png" alt="RStudio Layout" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-3)RStudio Layout</p>
</div>

We'll refer to these three "panes" as the **Console** pane, the **Environment** pane, and the **Files** pane. 
The large square on the left is the **Console** pane, the square in the top right is the **Environment** pane, and the square in the bottom right is the **Files** pane.  

As you work with R more, you'll find yourself using the tabs within each of the panes.

When we create a new file, such as an R script, an R Markdown file, or a Shiny app, RStudio will open a fourth pane, known as the **source** pane.  
The source pane should show up as a square in the top left.
We can open up an `.R` script in the source pane by going to File, selecting New File, and then selecting R Script:

<div class="figure" style="text-align: center">
<img src="./man/figures/Figure 5.3.png" alt="Creating a new R Script in RStudio" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-4)Creating a new R Script in RStudio</p>
</div>

You do not need to do anything specific with this file, but we encourage you to experiment with it if you would like!  

### Customizing RStudio  

One of the balances we've tried to strike in this text is a balance between best practices in your _workflow_ (how you'll use R in your projects) and your _R code_.
A best practice for your _workflow_ is to ensure that you're starting with a blank slate every time you open R (through RStudio). 
To accomplish this, go to Tools and select Global Options from the dropdown menu.

<div class="figure" style="text-align: center">
<img src="./man/figures/Figure 5.4.png" alt="Selecting Global Options from the Tool Dropdown Menu" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-5)Selecting Global Options from the Tool Dropdown Menu</p>
</div>

The General tab will open, with several checkboxes selected and unselected.
The most important thing you can do is select "Never" next to the **Save workspace to .RData on exit:** prompt.
After selecting "Never", go through and check and uncheck boxes so that your General tab looks like this: 

<div class="figure" style="text-align: center">
<img src="./man/figures/Figure 5.5.png" alt="General tab from Global Options" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-6)General tab from Global Options</p>
</div>

Last, but certainly not least, click on the "Appearance" tab from within the Global Options. 
From here you can select your RStudio Font, Font Size, and Theme.
Go through the options and select an appearance that works best for you, and know that you can _always_ come back and change it!
    
### Minimized and Missing Panes

If at any point you find that one of your panes seems to have "disappeared," one of two things has likely happened: 

- A pane has been minimized
- A pane has been closed

Let's look at the Environment pane as an example.
If the Environment pane has been minimized, we'll see something like this:  

<div class="figure" style="text-align: center">
<img src="./man/figures/Figure 5.6.png" alt="RStudio layout with the Environment Pane Minimized" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-7)RStudio layout with the Environment Pane Minimized</p>
</div>

We know that the Environment pane has been minimized, because we can see the pane headers in the top right, we just can't see the information _within_ the Environment pane.
To fix this we can click on the icon of two squares in the top right of the Environment pane.
If you click on the icon of the large square in the top right of the Environment pane you'll maximize the Environment pane and minimize the Files pane.  

If the Environment pane has somehow been closed, you can recover it by going to the View menu, selecting Panes, and then selecting Pane Layout, like so: 

<div class="figure" style="text-align: center">
<img src="./man/figures/Figure 5.7.png" alt="Accessing the Pane Layout from the View Dropdown Menu" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-8)Accessing the Pane Layout from the View Dropdown Menu</p>
</div>

When we select Pane Layout, we'll see this: 

<div class="figure" style="text-align: center">
<img src="./man/figures/Figure 5.8.png" alt="Pane Layout options within RStudio" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-9)Pane Layout options within RStudio</p>
</div>

From here you can select which tabs you'd like to appear within each pane, and even change where each pane appears within RStudio. 
So if our Environment Pane had been closed, we would select it from the Pane Layout in order to re-open it within RStudio.

## Writing and Running Code in RStudio

Up to this point we've been exploring the RStudio interface and setting up our preferences.
Now we'll shift to some basic coding practices.
In order to run code in R you need to type your code either in the Console or within an `.R` script.  

We generally recommend creating an `.R` script as you're learning, as it allows you to type all of your code, add comments, and then save your `.R` script for reference.
If instead you work entirely in the Console, anything that you type in the Console will disappear as soon as you restart or close R and you will not be able to reference it in the future.    

### Writing Code in the Console

To run code in the Console, you type your code next to the `>` and hit 'Enter'.  
We'll spend a little time practicing running code in the Console by exploring some basic properties of coding in R.  

In the Console, type `3 + 4` and hit `Enter`. 
You should see the following:  

<div class="figure" style="text-align: center">
<img src="./man/figures/Figure 5.9.png" alt="Using the Console as a Calculator" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-10)Using the Console as a Calculator</p>
</div>

We've just used R to add the numbers 3 and 4. 
R has returned the sum of `3 + 4` on a new line, next to `[1]`.
The `[1]` tells us that there is one row of data.

We can also use R to print out text.
Type the following in the Console and hit `Enter`: 


```r
print("I am learning R")
```

We should see this in the Console:

<div class="figure" style="text-align: center">
<img src="./man/figures/Figure 5.10.png" alt="Printing Text to the Console" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-12)Printing Text to the Console</p>
</div>

There's one error that you're likely going to come across, both when running code in the Console as well as in an R script. 
Let's explore that error now, by running the following code in the Console and hitting `Enter`: 


```r
print("This is going to cause a problem"
```

Make sure that you left off the closing parentheses! 
What you'll see in the Console is: 

<div class="figure" style="text-align: center">
<img src="./man/figures/Figure 5.11.png" alt="Incomplete Parentheses Change what R Expects Next" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-14)Incomplete Parentheses Change what R Expects Next</p>
</div>

When we're missing a closing parentheses, R is expecting us to provide more code.
We know this because instead of seeing a carat `>` in our Console, we see a `+`, and R has not returned the print statement that we were expecting! 
There are two ways to fix this problem: 

- Type the closing `)` in the Console and hit Enter
- Hit the `Esc` key

Go ahead and run this intentional error and try each of the options above.
Compare the output of each, and think about how they're different.
Can you think of when you might want to use one option instead of the other? 

### Writing Code in an R Script

There are three main ways to run code in an `.R` script:  
- Highlight the line(s) of code you'd like to run and press **Ctrl + Enter**  
- Highlight the line(s) of code you'd like to run and click the **Run** button in the `R script` pane  
- To run _every_ line of code in your file you can press **Ctrl + Shift + Enter** 

Create a new `.R` script, or using the one you created earlier in this chapter, type in the following code and run it using each of the options listed above.


```r
print("We're going to use R as a calculator.")
print("First up, addition!")

12 + 8
632 + 41

print("Next, subtraction!")

48 - 6
0.65 - 1.42
```

Feel free to spend some more time writing and running code within your `.R` script, or move on to the next section, where we'll add comments to our code.  

### Commenting Your Code in R

It is considered good practice to comment your code when working in an `.R` script. 
Even if you are the only person to ever work on your code, it can be helpful to write yourself notes about what you were trying to do with a specific piece of code. 
Moreover, writing comments in your code as you work through the examples in this book is a great way to help reinforce what you're learning.
Comments are ignored by R when running a script, so they will not affect your code or analysis. 

To comment out a line of code, you can place a pound sign (also called an octothorpe!) `#` in front of the line of code that you want to exclude when you're running your script.
Be careful when doing this, especially in longer files, as it can be easy to forget where you've commented out code. 
It is often better to simply start a new section of code to tinker with until you get it working as expected, rather than commenting out lines of code.

We can also write comments in-line with our code, like this: 


```r
#' this will be a short code example.
#' you are not expected to know what this does,
#' nor do you need to try running it on your computer.

library(readr)  # load the readr package
library(here)  # load the here package

data <- read_csv(here("file_path", "file_name.csv"))  # save file_name.csv as data
```


If you think you'll be writing more than one line of code, you can do a pound sign followed by a single quotation mark (`#'`). 
This will continue to comment out lines of text or code each time you hit "Enter."
You can delete the `#'` on a new line where you want to write code for R to run.
This method is useful when you're writing a description of what you're doing in R.

_Note: when we refer to "commenting" we're referring to adding in actual text comments, whereas "commenting out" refers to using the pound sign (octothorpe) in front of a line of code so that R ignores it._
_We will also use the phrase "uncomment code," which means you should delete (or omit when typing out) the `#` or `#'` in an example._
    
## Installing the {dataedu} package 
This next section will briefly go over installing the {dataedu} package that's used throughout this book.
We created the {dataedu} package to provide our readers an opportunity to jump into R however they see fit.

The package serves three main functions:

1. Mass installation of all the packages used in the book
2. Reproducible code for the walkthroughs
3. Access to the data used in each of the walkthroughs  

If you feel that you need more information before you're ready to install the package, you can skip this section and rest assured that we'll cover packages, their installation, and how to load them into R in more depth in Chapter 6.
However, if you're feeling a bit adventurous, go ahead and give it a shot by running the code below:


```r
# install devtools
install.packages("devtools", repos = "http://cran.us.r-project.org")

# install the dataedu package
devtools::install_github("data-edu/dataedu")
```

## Exploring R with the {swirl} package

If you were able to install the {dataedu} package without any issues or concerns, and you're eager to get started exploring everything that R can do, you can supplement your learning through [{swirl}](https://swirlstats.com/students.html) (https[]()://swirlstats.com/students.html).  

You can install {swirl} by running the following code:  

```r
install.packages("swirl")
```

{swirl} is set of packages (more on packages in Chapter 6!) that you can download, providing an interactive method for learning R by using R in the RStudio Console.  
You can follow the instructions on the {swirl} webpage (you've already installed R, RStudio, and the {swirl} package), or run the following code _in your console pane_ to get started with a beginner-level course in {swirl}:


```r
library(swirl)
install_course("R_Programming_E")
swirl()
```

There are multiple courses available on {swirl}, and you can access them by installing them and then running the `swirl()` command in your console.
We are not affiliated with {swirl} in any way, nor is it required to use {swirl} in order to progress through this text, but it's a great resource that we want to make sure that you're aware of!  

## Conclusion

Congratulations! At this point in the book you've installed R and RStudio, explored the RStudio IDE, and even written some basic code. 
At this point you're set up to either move on to Chapter 6, where we'll go in-depth on Projects, packages, and functions, and how those relate to the data you'll work with, as well as information on Help documentation and some skills for when you're working with new or unfamiliar information. 
If that information is something you're already comfortable with, you can jump ahead to a walkthrough of your choosing! 
