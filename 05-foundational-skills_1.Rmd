# Getting Started with R and RStudio {#c05}

## Chapter overview

This chapter is designed to take you from installing R and RStudio all the way through the very basics of data loading and manipulation using the `tidyverse` [@R-tidyverse]. 

We will be covering the following topics in this chapter: 

- Installing R and RStudio
- RStudio environment and pane layout
- Basics of customizing your RStudio environment
- Introduction to help documentation
- Steps for working through new and unamiliar content
- Downloading and accessing the data sets used in this book

## Getting Started

First, you will need to download the latest versions of R and RStudio. 
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

[IMG]

RStudio is an **I**ntegrated **D**evelopment **E**nvironment (IDE), and comes with built-in features that make using R a little easier. 
If you'd like more information on the difference between R and RStudio, we recommend the **Getting Started** section of the [Modern Dive](https://moderndive.com/1-getting-started.html#) textbook.


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
  
These three "panes" are referred to as the **console** pane, the **environment** 
pane, and the **files** pane. The large square on the left is the **console**, 
the pane in the top right is the **environment** pane, and the square in the 
bottom right is the **files** pane.  

When we create a new file, such as an `R script`, an `R Markdown` file, or a 
`Shiny app`, RStudio will open a fourth pane, known as the **source** pane. You 
can try this out by going to `File -> New File -> R Script`.

When we type out code, we do so in either the **console** or **source** pane. It 
is generally better to type code in an `R script`, which saves as an `.R` file, 
than to type your code in the console. This is because anything you type in the 
console will be lost as soon as you close R, whereas you can save everything in 
an `.R` script and see/use it again later.  

**Running code in an R Script**  
There are several ways to run code in an R script:  

* Highlight the line(s) of code you'd like to run and press **Ctrl+Enter**  
* Highlight the line(s) of code you'd like to run and click the **Run** button 
in the `R script` pane  
* To run _every_ line of code in your file you can press **Ctrl+Shift+Enter**  

### Getting to Know R: Challenge Questions 
**Script vs. Console**  

* Use the _console_ as a calculator
* Create an **`.R` script** _(File -> New File -> R script)_ and use it as a 
calculator  
* What are the similarities and differences between coding in the **console** 
versus coding in an **.R script**?

**Assignment operator**  

* What is the assignment operator, and how does it work?

**Commenting code**  

* When might we want to comment out code?
* _How_ do we comment out code in an **`.R script`**?
* What are two ways to comment code?

**Exploring the workspace**  

_For each of the challenges below, you'll need to go to Tools -> Global Options_  

* Explore the various themes available to you in RStudio by going to 
_Tools -> Global Options -> Appearance_
    + Choose a theme that works best for you and apply it
* Change some of the default options in RStudio by going to _Tools -> Global 
Options -> General_ and ensure that the following options are selected/deselected:  

<center>
![](https://i.imgur.com/fQ3kitV.png?1)
</center>  

* Lastly we'll add in our margin indicator by going to _Tools -> Global Options 
-> Code_ and then selecting/deselecting the following:  

<center>
![](https://i.imgur.com/YQqTP6i.png?1)
</center>  

## Diving a little deeper into R with `swirl`

If you're eager to get started exploring everything that R can do, we recommend installing and learning through [`swirl`](https://swirlstats.com/students.html). 
`swirl` is set of packages (more on those shortly!) that you can download, providing an interactive method for learning R by using R.

We are not affiliated with `swirl` in any way, nor is it required to progress through this text.   

## Introduction to Help Documentation
Very few - if any - people in the world know everything there is to know about R.
This means that we all need to look things up, sometimes every few minutes!
Thankfully there are some excellent built-in resources that we can leverage as we use R. 

From within RStudio we can access the `Help` documentation by using `?` or `??` in the console.
For example, if I wanted to look up information on the `data()` function, I can type `?data` or `data()` next to the carat `>` in the Console and hit `Enter`. 
You should see the `Help` panel on the bottom right side of your RStudio environment populate with documentation on the `data()` function. 

This works because the `data()` function is part of something called **base R** - that is, all of the functions included with R when you first install it. 
As you use R throughout this book, we'll be asking you to install additional packages.
These packages extend the functionality of base R by providing us with access to new functions. 
This means that instead of writing a function to do a common data analysis task, such as creating a new variable out of existing variables, someone has written that function and made it available for you to use at no charge. 

<!-- ON HOLD - not working as anticipated
One of the functions that can accomplish this task is called `mutate()`. 
What happens when you type `?mutate` (or `mutate()`) into the Console and hit `Enter`?  

We've gotten one of our first error messages!  

[IMG] 

This is a fantastic error message because not only has it told us that something is wrong (there is no documentation for `mutate`), it tells us what we should try to do to solve the error. 
Let's see what happens when we follow the error message instructions by typing `??mutate` (or `??mutate()`) into the Console and hitting `Enter`. 
What happens?-->

## Downloading and accessing the data sets used in this book

<!-- On hold - have we solidified this with the package? 
If yes, link is [here](https://github.com/data-edu/dataedu) -->
