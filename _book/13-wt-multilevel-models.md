
# Walkthrough 7: The Role (and Usefulness) of Multi-Level Models {#c13}

## Vocabulary

- dummy coding
- hierarchical linear model  
- intra-class correlation
- multi-level model  

## Chapter Overview

The *purpose* of this walkthrough is to explore
students' performance in these online courses. While this and the analysis in 
[Walkthrough 1/Chapter 7](#c07) focus on the time students spent in the course, 
this walkthrough is distinguished by a focus on the effects of being in a particular 
course. To do so, we explore the use of *multi-level models*, which are suited
to addressing the fact that the students in our dataset shared classes. While the
conceptual details underlying multi-level models can be complex, the basic problem
that they address - cases, or observations, such as students, grouped within higher
level units, such as classes or schools - is likely familiar to readers of this book.

### Background

Using multi-level models is a way to account for the way in which individual 
cases - like responses for individual students - are "grouped" together into higher-level
units, like classes. As we describe later in this chapter, multi-level models do this by (still) estimating the
effect of being a student in each group, but with a key distinction from a 
regression (or linear model), like those described in 
[Walkthrough 1/Chapter 7](#c07) and [Walkthrough 4/Chapter 10](#c10):
the multi-level model "regularizes" the estimates for each group based upon
systematically different the groups (classes) are, in terms of the dependent variable,
from the overall (across all groups [classes]) values of the dependent variable. 

These are the conceptual details underlying multi-level models, but, fortunately, 
fitting them is straightforward, and should be familiar if you have used R's `lm()` 
function before. So, let's get started!

### Data Source

We use the same data source on students' motivation in online science classes
that we processed in [Walkthrough 1](#c07).

### Methods

Are there course-specific differences in how much time students spend on the
course as well as in how time spent is related to the percentage of points
students earned? There are a number of ways to approach this question. Let's use
our linear model.

Specifically, we can dummy-code the groups. Dummy coding means transforming a variable with multiple categories into multiple, new variables, where each variable indicates the presence and absence of only one of the categories.

## Load Packages

We will load the tidyverse and a few other packages specific to using multi-level models: 
{lme4} [@R-lme4] and {performance} [@R-performance].


```r
library(tidyverse)
library(dummies)
library(sjPlot)
library(lme4)
library(performance)
library(dataedu)
```

## Import Data

### The Role of Dummy Codes

We can see how dummy coding works through using the {dummies} package, though,
as we will see, you often do not need to manually dummy code variables like
this.

Let's consider the `iris` data that comes built into R. Since we are fans
of the {tidyverse}, we will first change it into a tibble.


```r
iris <- as_tibble(iris)
iris
```

```
#> # A tibble: 150 x 5
#>    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
#>           <dbl>       <dbl>        <dbl>       <dbl> <fct>  
#>  1          5.1         3.5          1.4         0.2 setosa 
#>  2          4.9         3            1.4         0.2 setosa 
#>  3          4.7         3.2          1.3         0.2 setosa 
#>  4          4.6         3.1          1.5         0.2 setosa 
#>  5          5           3.6          1.4         0.2 setosa 
#>  6          5.4         3.9          1.7         0.4 setosa 
#>  7          4.6         3.4          1.4         0.3 setosa 
#>  8          5           3.4          1.5         0.2 setosa 
#>  9          4.4         2.9          1.4         0.2 setosa 
#> 10          4.9         3.1          1.5         0.1 setosa 
#> # … with 140 more rows
```

As we can see above, the `Species` variable is a factor. If we consider how we could
include a variable such as this in a linear model, things may become a little
confusing. `Species` seems to be made up of, well, words, such as "setosa." The
common way to approach this is through dummy coding, where you create new
variables for each of the possible values of `Species` (such as "setosa"). Then,
these new variables have a value of 1 when the row is associated with that level
(i.e., the first row in the data frame above would have a 1 for a column named
`setosa`).

Let's return to {dummies}.

How many possible values are there for `Species`? We can check with the `levels`
function.


```r
levels(iris$Species)
```

```
#> [1] "setosa"     "versicolor" "virginica"
```

When we run the `dummy()` function on the `Species` variable, we can see that it
returns *three* variables, one for each of the three levels of Species -
`setosa`, `versicolor`, and `virginica`.


```r
dummies::dummy(iris$Species) %>%
  head()
```

```
#>      {\n    args = commandArgs(TRUE)\n    out = do.call(rmarkdown::render, c(args[1], readRDS(args[2]), list(run_pandoc = FALSE, encoding = "UTF-8")))\n    out_expected = xfun::with_ext(args[1], ".md")\n    if (out != out_expected) {\n        file.rename(out, out_expected)\n        attributes(out_expected) = attributes(out)\n        out = out_expected\n    }\n    if (file.exists(args[3])) {\n        res = readRDS(args[3])\n        res[[args[1]]] = out\n        saveRDS(res, args[3])\n    }\n    else saveRDS(setNames(list(out), args[1]), args[3])\n}setosa
#> [1,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          1
#> [2,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          1
#> [3,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          1
#> [4,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          1
#> [5,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          1
#> [6,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          1
#>      {\n    args = commandArgs(TRUE)\n    out = do.call(rmarkdown::render, c(args[1], readRDS(args[2]), list(run_pandoc = FALSE, encoding = "UTF-8")))\n    out_expected = xfun::with_ext(args[1], ".md")\n    if (out != out_expected) {\n        file.rename(out, out_expected)\n        attributes(out_expected) = attributes(out)\n        out = out_expected\n    }\n    if (file.exists(args[3])) {\n        res = readRDS(args[3])\n        res[[args[1]]] = out\n        saveRDS(res, args[3])\n    }\n    else saveRDS(setNames(list(out), args[1]), args[3])\n}versicolor
#> [1,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              0
#> [2,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              0
#> [3,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              0
#> [4,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              0
#> [5,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              0
#> [6,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              0
#>      {\n    args = commandArgs(TRUE)\n    out = do.call(rmarkdown::render, c(args[1], readRDS(args[2]), list(run_pandoc = FALSE, encoding = "UTF-8")))\n    out_expected = xfun::with_ext(args[1], ".md")\n    if (out != out_expected) {\n        file.rename(out, out_expected)\n        attributes(out_expected) = attributes(out)\n        out = out_expected\n    }\n    if (file.exists(args[3])) {\n        res = readRDS(args[3])\n        res[[args[1]]] = out\n        saveRDS(res, args[3])\n    }\n    else saveRDS(setNames(list(out), args[1]), args[3])\n}virginica
#> [1,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             0
#> [2,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             0
#> [3,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             0
#> [4,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             0
#> [5,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             0
#> [6,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             0
```

We can confirm that every row associated with a specific species has a 1 in the
column it corresponds to. We can do this by binding together the dummy codes and
the `iris` data and then counting, for each of the three species, how many of
the rows for each dummy code were coded with a "1".

For example, when the `Species` is "setosa", the variable `Speciessetosa` always
equals 1 - as is the case for the other species (for their respective
variables). `bind_cols()` is a useful tidyverse function for binding together 
data frames by column.


```r
# create matrix of dummy-coded variables
species_dummy_coded <- dummies::dummy(iris$Species)

# convert matrix to tibble so we can use tidyverse functions
species_dummy_coded <- as_tibble(species_dummy_coded)

# add dummy coded variables to iris
iris_with_dummy_codes <- bind_cols(iris, species_dummy_coded)
```

Let's look at the results.

<!-- I can't figure out why the following won't run - it runs when I run it code chunk-by-chunk, but not when I render! -->


```r
iris_with_dummy_codes %>% 
    count(Species, Speciessetosa, Speciesversicolor, Speciesvirginica)
```

Okay, this covers how dummy codes work. How do they work when used in a
model, like with the linear model we have been using (through `lm()`)?

In the context of using `lm()` (and many other functions in R) is that the
number of levels to be created is always the number of different possible values
minus one, because each group will be modeled in comparison to the group without
a column, or what is commonly called the reference group.

Why can every group not simply have their own dummy-coded column? The reason has
to do with how the dummy codes are used. The purpose of the dummy code is to
show how different the dependent variable is for all of the observations that
are in one group (i.e., all of the flowers that are setosa specimens). In
order to represent how different those flowers are, they have to be compared to
something else - and the intercept of the model usually represents this
"something else." However, if every level of a factor (such as `Species`) is
dummy-coded, then there would be no cases available to estimate an intercept -
in short, the dummy code would not be compared to anything else. For this
reason, one group is typically selected as the reference group, to which every 
other group is compared.

We will load a built-in dataset from the {dataedu} package. 


```r
dat <- dataedu::sci_mo_processed
```

### Using Dummy Codes

Let's return use online science class data and consider the effect (for a
student) of being in a specific class in the data set.

First, let's determine how many classes there are. We can use the `count()`
function to see how many courses there are.


```r
dat %>% 
  count(course_id)
```

```
#> # A tibble: 26 x 2
#>    course_id         n
#>    <chr>         <int>
#>  1 AnPhA-S116-01    43
#>  2 AnPhA-S116-02    29
#>  3 AnPhA-S216-01    43
#>  4 AnPhA-S216-02    17
#>  5 AnPhA-T116-01    11
#>  6 BioA-S116-01     34
#>  7 BioA-S216-01      7
#>  8 BioA-T116-01      2
#>  9 FrScA-S116-01    70
#> 10 FrScA-S116-02    12
#> # … with 16 more rows
```

## Analysis

### Regression (Linear Model) Analysis with Dummy Codes

We will save this output to `m_linear_dc`, where the `dc` stands for dummy
code. We will keep the variables we used in our last set of models - `TimeSpent`
and `course_id` - as independent variables, but will predict students' final grade 
(a variable in the dataset), rather than the `percentage_earned` variable that we 
created in (chapter 7)[#c07].

Since we will be using the final grade variable a lot, we can rename it to make 
it quicker (and easier) to type.


```r
dat <- 
  dat %>% 
  rename(final_grade = FinalGradeCEMS)
```


```r
m_linear_dc <- 
  lm(final_grade ~ TimeSpent_std + course_id, data = dat)
```

The output will be a bit, well, long, because each group will have its own
intercept. Here it is:


```r
sjPlot::tab_model(m_linear_dc)
```

<table style="border-collapse:collapse; border:none;">
<tr>
<th style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm;  text-align:left; ">&nbsp;</th>
<th colspan="3" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">final grade</th>
</tr>
<tr>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  text-align:left; ">Predictors</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">Estimates</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">CI</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">p</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">(Intercept)</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">73.20</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">67.20&nbsp;&ndash;&nbsp;79.20</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">TimeSpent_std</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">9.66</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">7.91&nbsp;&ndash;&nbsp;11.40</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [AnPhA-S116-02]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-1.59</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-10.88&nbsp;&ndash;&nbsp;7.70</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.737</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [AnPhA-S216-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-9.05</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-17.44&nbsp;&ndash;&nbsp;-0.67</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>0.034</strong></td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [AnPhA-S216-02]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-4.51</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-16.41&nbsp;&ndash;&nbsp;7.40</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.457</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [AnPhA-T116-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">7.24</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-6.34&nbsp;&ndash;&nbsp;20.82</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.296</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [BioA-S116-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-3.56</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-12.67&nbsp;&ndash;&nbsp;5.55</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.443</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [BioA-S216-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-14.67</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-31.61&nbsp;&ndash;&nbsp;2.26</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.089</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [BioA-T116-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">9.18</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-18.84&nbsp;&ndash;&nbsp;37.20</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.520</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [FrScA-S116-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">12.02</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">4.33&nbsp;&ndash;&nbsp;19.70</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>0.002</strong></td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [FrScA-S116-02]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-3.14</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-17.36&nbsp;&ndash;&nbsp;11.08</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.665</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [FrScA-S116-03]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">3.51</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-5.43&nbsp;&ndash;&nbsp;12.46</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.441</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [FrScA-S116-04]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">5.23</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-14.98&nbsp;&ndash;&nbsp;25.43</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.612</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [FrScA-S216-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">9.92</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">2.41&nbsp;&ndash;&nbsp;17.43</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>0.010</strong></td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [FrScA-S216-02]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">7.37</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-2.70&nbsp;&ndash;&nbsp;17.45</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.151</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [FrScA-S216-03]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">2.38</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-25.65&nbsp;&ndash;&nbsp;30.40</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.868</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [FrScA-S216-04]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">15.40</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-2.92&nbsp;&ndash;&nbsp;33.72</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.099</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [FrScA-T116-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">8.12</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-12.08&nbsp;&ndash;&nbsp;28.33</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.430</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [OcnA-S116-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">4.06</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-5.67&nbsp;&ndash;&nbsp;13.79</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.413</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [OcnA-S116-02]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">2.02</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-9.89&nbsp;&ndash;&nbsp;13.93</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.739</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [OcnA-S116-03]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-18.75</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-57.86&nbsp;&ndash;&nbsp;20.36</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.347</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [OcnA-S216-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-6.41</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-15.04&nbsp;&ndash;&nbsp;2.22</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.145</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [OcnA-S216-02]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-2.76</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-13.47&nbsp;&ndash;&nbsp;7.95</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.613</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [OcnA-T116-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-2.05</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-16.97&nbsp;&ndash;&nbsp;12.87</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.787</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [PhysA-S116-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">15.35</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">6.99&nbsp;&ndash;&nbsp;23.71</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [PhysA-S216-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">5.40</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-6.01&nbsp;&ndash;&nbsp;16.82</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.353</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [PhysA-T116-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">20.73</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-7.23&nbsp;&ndash;&nbsp;48.70</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.146</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm; border-top:1px solid;">Observations</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="3">573</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">R<sup>2</sup> / R<sup>2</sup> adjusted</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="3">0.252 / 0.216</td>
</tr>

</table>

Wow! That is a lot of effects. In addition to the time spent and subject
variables, the model estimated the difference, accounting for the effects of
being a student in a specific class. Let's count how many classes there are. 

If we count the number of classes, we see that there are 25 - and not 26! One has
been automatically selected as the reference group, and every other class's
coefficient represents how different each class is from it. The intercept's
value of 0.74 represents the percentage of points that students in the reference
group class, which is automatically the first level of the `course_id` variable
when it is converted to a factor, `course_idAnPhA-S116-01` (which represents an anatomy 
and physiology course from semester `S1` (for the fall) of 20`16` in the first
section `01`).

We can choose another class to serve as a reference group. For
example, say that we want `course\_idPhysA-S116-01` (the first section of the
physics class offered during this semester and year) to be the reference group.
The `fct_relevel()` function (which is a part of the {tidyverse} suite of
packages) makes it easy to do this. This function allows us to re-order the
levels within a factor, so that the "first" level will change. We'll also use
`mutate()` again here, which we introduced in the previous chapter. 


```r
dat <-
  dat %>%
  mutate(course_id = fct_relevel(course_id, "PhysA-S116-01"))
```

We can now see that *that* group is no longer listed as an independent variable,
or a predictor: every coefficient in this model is now in reference to it. 


```r
# Here we run a linear model again, predicting percentage earned in the course
# The predictor variables are the (standardized) amount of time spent and the subject of the course (course_id)
m_linear_dc_1 <- 
  lm(final_grade ~ TimeSpent_std + course_id, data = dat)

sjPlot::tab_model(m_linear_dc_1)
```

<table style="border-collapse:collapse; border:none;">
<tr>
<th style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm;  text-align:left; ">&nbsp;</th>
<th colspan="3" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">final grade</th>
</tr>
<tr>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  text-align:left; ">Predictors</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">Estimates</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">CI</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">p</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">(Intercept)</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">88.55</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">82.83&nbsp;&ndash;&nbsp;94.27</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">TimeSpent_std</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">9.66</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">7.91&nbsp;&ndash;&nbsp;11.40</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [AnPhA-S116-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-15.35</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-23.71&nbsp;&ndash;&nbsp;-6.99</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [AnPhA-S116-02]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-16.94</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-26.20&nbsp;&ndash;&nbsp;-7.67</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [AnPhA-S216-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-24.40</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-32.77&nbsp;&ndash;&nbsp;-16.04</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [AnPhA-S216-02]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-19.86</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-31.71&nbsp;&ndash;&nbsp;-8.01</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>0.001</strong></td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [AnPhA-T116-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-8.11</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-21.64&nbsp;&ndash;&nbsp;5.42</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.240</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [BioA-S116-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-18.91</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-27.72&nbsp;&ndash;&nbsp;-10.09</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [BioA-S216-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-30.02</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-46.80&nbsp;&ndash;&nbsp;-13.24</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [BioA-T116-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-6.17</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-34.09&nbsp;&ndash;&nbsp;21.75</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.664</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [FrScA-S116-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-3.33</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-10.76&nbsp;&ndash;&nbsp;4.10</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.379</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [FrScA-S116-02]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-18.49</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-32.58&nbsp;&ndash;&nbsp;-4.39</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>0.010</strong></td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [FrScA-S116-03]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-11.84</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-20.59&nbsp;&ndash;&nbsp;-3.08</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>0.008</strong></td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [FrScA-S116-04]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-10.12</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-30.32&nbsp;&ndash;&nbsp;10.08</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.326</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [FrScA-S216-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-5.43</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-12.62&nbsp;&ndash;&nbsp;1.75</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.138</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [FrScA-S216-02]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-7.97</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-17.85&nbsp;&ndash;&nbsp;1.90</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.113</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [FrScA-S216-03]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-12.97</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-40.89&nbsp;&ndash;&nbsp;14.95</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.362</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [FrScA-S216-04]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.05</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-18.15&nbsp;&ndash;&nbsp;18.25</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.996</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [FrScA-T116-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-7.22</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-27.47&nbsp;&ndash;&nbsp;13.02</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.484</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [OcnA-S116-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-11.29</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-20.98&nbsp;&ndash;&nbsp;-1.60</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>0.022</strong></td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [OcnA-S116-02]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-13.33</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-25.16&nbsp;&ndash;&nbsp;-1.49</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>0.027</strong></td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [OcnA-S116-03]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-34.10</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-73.17&nbsp;&ndash;&nbsp;4.97</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.087</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [OcnA-S216-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-21.76</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-30.29&nbsp;&ndash;&nbsp;-13.23</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [OcnA-S216-02]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-18.11</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-28.66&nbsp;&ndash;&nbsp;-7.56</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>0.001</strong></td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [OcnA-T116-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-17.40</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-32.22&nbsp;&ndash;&nbsp;-2.58</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>0.021</strong></td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [PhysA-S216-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-9.94</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-21.16&nbsp;&ndash;&nbsp;1.28</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.082</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [PhysA-T116-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">5.39</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-22.55&nbsp;&ndash;&nbsp;33.32</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.705</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm; border-top:1px solid;">Observations</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="3">573</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">R<sup>2</sup> / R<sup>2</sup> adjusted</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="3">0.252 / 0.216</td>
</tr>

</table>

Using dummy codes is very common - they are used in nearly every case in which
you are using a model (such as a linear model, through `lm()`) and you have
variables that are factors. A benefit of using `lm()` (and many other functions)
in R for modeling, such as the `lme4::lmer()` function we discuss later, is that
if you have variables which are not factors, but simply character strings, they
will be automatically changed to factors when used in a model. This means, for
instance, that if you have a variable for the subject matter of courses labeled
"mathematics", "science", "english language" (typed like that!), "social
studies", and "art", and you include this variable in an `lm()` model, then the
function will automatically dummy-code these for you. The only essential step
that is not taken for you is choosing which is the reference group.

We note that there are cases in which *not having a reference group* that the
other, dummy-coded groups are compared to is desired. In such cases, no
intercept is estimated. This can be done by passing a -1 as the first value
after the tilde, as follows:


```r
# specifying the same linear model as the previous example, but using a "-1" to indicate that there should not be a reference group
m_linear_dc_2 <- 
  lm(final_grade ~ -1 + TimeSpent_std + course_id, data = dat)

sjPlot::tab_model(m_linear_dc_2)
```

<table style="border-collapse:collapse; border:none;">
<tr>
<th style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm;  text-align:left; ">&nbsp;</th>
<th colspan="3" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">final grade</th>
</tr>
<tr>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  text-align:left; ">Predictors</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">Estimates</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">CI</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">p</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">TimeSpent_std</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">9.66</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">7.91&nbsp;&ndash;&nbsp;11.40</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [PhysA-S116-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">88.55</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">82.83&nbsp;&ndash;&nbsp;94.27</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [AnPhA-S116-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">73.20</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">67.20&nbsp;&ndash;&nbsp;79.20</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [AnPhA-S116-02]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">71.61</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">64.38&nbsp;&ndash;&nbsp;78.83</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [AnPhA-S216-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">64.15</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">58.12&nbsp;&ndash;&nbsp;70.17</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [AnPhA-S216-02]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">68.69</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">58.35&nbsp;&ndash;&nbsp;79.04</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [AnPhA-T116-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">80.44</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">68.20&nbsp;&ndash;&nbsp;92.67</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [BioA-S116-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">69.64</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">62.89&nbsp;&ndash;&nbsp;76.40</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [BioA-S216-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">58.53</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">42.74&nbsp;&ndash;&nbsp;74.32</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [BioA-T116-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">82.38</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">55.04&nbsp;&ndash;&nbsp;109.72</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [FrScA-S116-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">85.22</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">80.46&nbsp;&ndash;&nbsp;89.98</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [FrScA-S116-02]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">70.06</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">57.18&nbsp;&ndash;&nbsp;82.94</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [FrScA-S116-03]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">76.71</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">70.08&nbsp;&ndash;&nbsp;83.34</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [FrScA-S116-04]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">78.43</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">59.08&nbsp;&ndash;&nbsp;97.78</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [FrScA-S216-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">83.12</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">78.72&nbsp;&ndash;&nbsp;87.52</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [FrScA-S216-02]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">80.57</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">72.51&nbsp;&ndash;&nbsp;88.64</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [FrScA-S216-03]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">75.58</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">48.23&nbsp;&ndash;&nbsp;102.92</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [FrScA-S216-04]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">88.60</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">71.31&nbsp;&ndash;&nbsp;105.89</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [FrScA-T116-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">81.32</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">61.94&nbsp;&ndash;&nbsp;100.71</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [OcnA-S116-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">77.26</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">69.49&nbsp;&ndash;&nbsp;85.03</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [OcnA-S116-02]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">75.22</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">64.88&nbsp;&ndash;&nbsp;85.56</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [OcnA-S116-03]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">54.45</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">15.80&nbsp;&ndash;&nbsp;93.10</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>0.006</strong></td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [OcnA-S216-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">66.79</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">60.50&nbsp;&ndash;&nbsp;73.07</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [OcnA-S216-02]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">70.44</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">61.57&nbsp;&ndash;&nbsp;79.31</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [OcnA-T116-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">71.15</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">57.48&nbsp;&ndash;&nbsp;84.81</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [PhysA-S216-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">78.60</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">68.94&nbsp;&ndash;&nbsp;88.27</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">course_id [PhysA-T116-01]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">93.93</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">66.60&nbsp;&ndash;&nbsp;121.27</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm; border-top:1px solid;">Observations</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="3">573</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">R<sup>2</sup> / R<sup>2</sup> adjusted</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="3">0.943 / 0.940</td>
</tr>

</table>

This does not work in many cases, and it is much more common to dummy-code
factors, and so we emphasized that in this walkthrough. However, we want you to be
aware that it is possible (though uncommon) to estimate a model without an
intercept.

### A Deep-Dive into Multi-Level Models

Dummy-coding is a very helpful strategy. It is particularly useful with a small
number of groups (i.e., for estimating the effects of being in one of the five
subjects in the online science data set, as in this walkthrough; we note that in
addition to these five subjects, we also have multiple sections, or classes, for
each subject). With effects such as being a student in a particular class,
though, the output seems to be less useful: it is hard to interpret the 25
different effects (and to compare them to the intercept).

Additionally, analysts often have the goal not of determining the effect of
being in a specific class, *per se*, but rather of accounting for the fact that
students share a class. This is important because linear models (i.e., those 
estiated using `lm()`) have an assumption that the data points are - apart
from sharing levels of the variables that are used in the model - independent,
or not correlated. This is what is meant by the "assumption of independence" or
of "independently and identically distributed" (*i.i.d.*) residuals (Field,
Miles, & Field, 2012).

As we noted in the chapter overview, multi-level models are a way to deal 
with the difficulty of interpreting the
estimated effects for each of many groups, like classes, and to address the
assumption of independence. Multi-level models do this by (still) estimating the
effect of being a student in each group, but with a key distinction from linear
models: Instead of determining how different the observations in a group are
from those in the reference group, the multi-level model "regularizes" (sometimes the term "shrinks" is used) the difference based on how
systematically different the groups are. The reason why "shrinkage" is
occasionally used is that the group-level estimates (e.g., for classes) that are
obtained through multi-level modeling can never be larger than those from a
linear model (regression). As described earlier, when there are groups included
in the model, a regression effectively estimates the effect for each group
independent of all of the others.

Through regularization, groups that comprise individuals who are
consistently different (higher or lower) than individuals on average are not
regularized very much - their estimated difference may be close to the estimate
from a multi-level model - whereas groups with only a few individuals, or with a
lot of variability within individuals, would be regularized a lot~ The way that
a multi-level model does this "regularizing" is by considering the groups (and
not the data points, in this case) to be samples from a larger population of
classes. By considering the effects of groups to be samples from a larger
population, the model is able to use information not only particular to each
group (as the models created using `lm()`), but also information across all of
the data. 

Using multi-level models, then, means that the assumption of independence can
be addressed; their use also means that individual coefficients for classes do
not need to be included (or interpreted, thankfully!), though they are still
included in and accounted for in the model. As we describe, the way that
information about the groups is reported is usually in the form of the
*intra-class correlation coefficient* (ICC), which explains the proportion of
variation in the dependent variable that the groups explain. Smaller ICCs (such
as ICCs with values of 0.05, representing 5% of the variation in the dependent
variable) mean that the groups are not very important; larger ICCs, such as ICCs
with values of 0.10 or larger (values as high as 0.50 are not uncommon!). ICCs
that are larger would indicate that groups are important and that they have to
do with a lot of the differences observed in the dependent variable (and that
not including them may potentially ignore the assumption of independence in a
case in which it may be important to recognize it - and lead to bias in the
results).] In the former case, the multi-level model considers there to be
strong evidence for a group effect, whereas in the latter, the model recognizes
that there is less certainty about a group (class) effect for that particular
group, in part because that group is small. Multi-level models are very common
in educational research for cases such as this: accounting for the way in which
students take the same classes, or even go to the same school (see Raudenbush &
Bryk, 2002).

That was a lot of technical information about multi-level models; thank you for
sticking with us through it!

We wanted to include this as multi-level models
*are* common (and, we think, could usefully be even more common!).Consider how often the data you collect involves students nested (or
grouped) in classes, or classes nested in schools (or even schools nested in
districts - you get the picture!). Educational data is complex, and so it is
not surprising that multi-level models may be encountered in educational data
science analyses, reports, and articles.

### Multi-level model analysis

Fortunately, for all of the complicated details, multi-level models are very
easy to use in R. This requires a new package. One of the most common for
estimating these types of models is {lme4}. We use `lme4::lmer()` very similarly to the `lm()` function, but we pass it an additional argument about what the *groups*
in the data are. This model is often referred to as a "varying intercepts"
multi-level model. What is different between the groups is the effect of
being a student in a class: the intercepts between groups vary.

You'll only need to install {lme4} once to do the rest of this walkthrough. To install {lme4}, type this code in your console: 


```r
install.packages("lme4") 
```

Now we can fit our multi-level model:


```r
m_course <- 
  lmer(final_grade ~ TimeSpent_std + (1|course_id), data = dat)
```

<!-- Preferable to add this as a footnote -->
To say *just* a bit more, there is a connection between multi-level models and Bayesian methods (@gelman2006data); one way to think about the "regularizing" going on is that estimates for each group (class) are made taking account of the data across all of the groups (classes). The data for all of the classes can be interpreted as a *prior* for the group estimates.

In a way, what is going on above is straightforward (and similar to what we have
seen with `lm()`), but, it is also different and potentially confusing.
Parentheses are not commonly used with `lm()`; there is a term (`(1|course_id)`)
in parentheses. Also, the bar symbol - `|` - is not commonly used with `lm()`.

As different as these (the parentheses and bar) are, they are used for a
relatively straightforward purpose: to model the group (in this case, courses)
in the data. With `lmer()`, these group terms are specified in parentheses -
specifically, to the right of the bar. That is what the `|course_id` part means
- it is telling lmer that courses are groups in the data. The left side of the
bar tells lmer that what we want to be specified are varying intercepts for each
group (1 is used to denote the intercept).

There is potentially more to the story: in addition to
the 1, variables which can be specified to have a different effect for each
group can also be specified. These variables are referred to not as varying
intercepts, but as varying slopes. We will not cover these in this walkthrough,
but want you to be aware of them (we recommend the book by West, Welch, and
Galecki [2014] provide an excellent walkthrough on how to specify varying
slopes using `lmer()`). To say *just* a bit more, there is a connection between
multi-level models and Bayesian methods (@gelman2006data); one way to think
about the "regularizing" going on is that estimates for each group (class) are
made taking account of the data across all of the groups (classes). The data for
all of the classes can be interpreted as a *prior* for the group estimates.

## Results

Let's view the results using the `tab_model()` function from {sjPlot}.


```r
tab_model(m_course)
```

There is another part of the above code to mention. The `tab_model()`
function comparably as it does for `lm()` models, providing output for the
model, including some fit statistics as well as coefficients and their standard
errors and estimates. There are two things to note about `lmer()` output:

1.  *p*-values are not automatically provided, due to debates in the wider field
    about how to calculate the degrees of freedom for coefficients^[ Run
    `?lme4::pvalues` to see a discussion of the issue as well as solutions; we
    have found the lmerTest to be helpful as an easy solution, though we note
    that some of the recommendations available through `?lme4::pvalues` may be
    preferable, as the technique lmerTest implements has some known issues.]

2.  In addition to the coefficients, there are also estimates for how much
    variability there is between the groups.

As we mentioned earlier, a common way to understand how much variability is at
the group level is to calculate the *intra-class* correlation. This value is the
proportion of the variability in the outcome (the *y*-variable) that is
accounted for solely by the groups identified in the model. There is a useful
function in the {performance} package for doing this.

You can install the {performance} package by typing this code in your console: 


```r
install.packages("performance")
```

After that, try this function: 


```r
icc(m_course)
```

```
#> # Intraclass Correlation Coefficient
#> 
#>      Adjusted ICC: 0.091
#>   Conditional ICC: 0.076
```

This shows that nearly 17% of the variability in the percentage of points
students earned can be explained simply by knowing what class they are in.

There is much more to do with multi-level models. We briefly discuss a common
extension to the model we just used, adding additional levels.

The data that we are using is all from one school, and so we cannot estimate a
"two-level" model. Imagine, however, that instead of 26 classes, we had data
from students from 230 classes, and that these classes were from 15 schools. We
could estimate a two-level, varying intercepts (where there are now two groups
with effects) model very similar to the model we estimated above, but simply
with another group added for the school. The model will account for the way in
which the classes are nested within the schools automatically (Bates, Maechler,
Bolker, & Walker, 2015).

We don't have a variable containing the name of different schools. If we did we could fit the model like this, where `school_id` is the variable containing different schools: 


```r
# this model would specify a group effect for both the course and school
m_course_school <- 
  lmer(final_grade ~ TimeSpent + (1|course_id) + (1|school_id), data = dat)
```

Were we to estimate this model (and then use the `icc()` function), we would see
two ICC values representing the proportion of the variation in the dependent
variable explained by each of the two groups we added - the course *and* the
school. A common question those using {lme4} have is whether it is necessary to 
explicitly nest the courses within schools; as long as the courses are unique labelled, this is not necessary to do.

You can add further still levels to the model, as the {lme4} package was
designed for complex multi-level models (and even those with not nested, but
crossed random effects; a topic beyond the scope of this walkthrough, but which
is described in West, Welch, & Galecki, 2015).

## Conclusion

In this example (and in many examples in educational research), the groups are
classes. But, multi-level models can be used for other cases in which data is
associated with a common group. For example, if students respond to repeated
measures (such as quizzes) over time, then the multiple quiz responses for each
student could be considered to be "grouped" within students. In such a case,
instead of specifying the model with the course as the "grouping factor",
students could be.

Moreover, multi-level models can include multiple groups (as noted above), even
if the groups are of very different kinds (i.e., if students from multiple
classes responded to multiple quizzes).

We note that the groups in multi-level models do not need to be nested: they can
also be "crossed", as may be the case for data from, for example, teachers in
different schools who attended different teacher preparation programs: not every
teacher in a school necessarily (or even likely) attended the same teacher
preparation program, and graduates from every teacher preparation program are
highly unlikely to all teach in the same school!

There is much more that can be done with multi-level models; we have more
recommendations in the [Additional Resources](#c18) chapter.

Finally, as noted earlier, multi-level models have similarities to the Bayesian
methods which are becoming more common among some R users - and educational data
scientists. There are also references to recommended books on Bayesian methods
in the additional resources chapter.
