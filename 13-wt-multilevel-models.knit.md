# Walkthrough 7: The Role (and Usefulness) of Multi-Level Models {#c13}

As for the earlier walkthrough using the same data, the *purpose* for this walkthrough is to explore
students' performance in these online courses, focusing on the time spent in the 
course (made available through the learning management system) and the effects 
of being in a particular class.

## Vocabulary

- hierarchical linear model  
- multi-level model  
- dummy coding
- intra-class correlation

## Introduction

### Background: why are we highlighting this? What is the purpose, implications

This walkthrough accompanies the [previous chapter](06-wt-multilevel-models-1),
which focused on preparing the data and beginning to viusualize and model the
data. Here, we focus on an extension of the models we ran, one focused on how to
address the fact that students in our dataset shared classes.

As for the earlier walkthrough using the same data, the *purpose* for this
walkthrough is to explore students' performance in these online courses,
focusing on the time spent in the course (made available throygh the learning
management system) and the effects of being in a particular class.

### Data Source

We use the same data source on students' motivation in online science classes
that we processed in [walkthrough 1](06-wt-multilevel-models-1).


```r
dat <- dataedu::sci_mo_data
```

### Methods

## Load Packages

We will load the tidyverse and a few other packages specific to multi-level models.


```r
library(tidyverse)
library(dummies)
library(sjPlot)
library(lme4)
library(performance)
library(dataedu)
```

## But what about different courses?

Are there course-specific differences in how much time students spend on the
course as well as in how time spent is related to the percentage of points
students earned? There are a number of ways to approach this question. Let's use
our linear model.

Specifically, we can dummy-code the groups. Dummy coding means transforming a variable with multiple categories into multiple, new variables, where each variable indicates the presence and absence of only one of the categories.

### The role of dummy codes

We can see how dummy coding works through using the {dummies} package, though,
as we will see, you often do not need to manually dummy code variables like
this.

Let's consider the `iris` data that comes built into R, but, since we are fans
of the {tidyverse}, we will first change it into a tibble.


```r
iris <- as_tibble(iris)
iris
```

```
## # A tibble: 150 x 5
##    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
##           <dbl>       <dbl>        <dbl>       <dbl> <fct>  
##  1          5.1         3.5          1.4         0.2 setosa 
##  2          4.9         3            1.4         0.2 setosa 
##  3          4.7         3.2          1.3         0.2 setosa 
##  4          4.6         3.1          1.5         0.2 setosa 
##  5          5           3.6          1.4         0.2 setosa 
##  6          5.4         3.9          1.7         0.4 setosa 
##  7          4.6         3.4          1.4         0.3 setosa 
##  8          5           3.4          1.5         0.2 setosa 
##  9          4.4         2.9          1.4         0.2 setosa 
## 10          4.9         3.1          1.5         0.1 setosa 
## # … with 140 more rows
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
## [1] "setosa"     "versicolor" "virginica"
```

When we run the `dummy()` function on the `Species` variable, we can see that it
returns *three* variables, one for each of the three levels of Species -
`setosa`, `versicolor`, and `virginica`.


```r
dummies::dummy(iris$Species) %>%
  head()
```

```
## Warning in model.matrix.default(~x - 1, model.frame(~x - 1), contrasts = FALSE):
## non-list contrasts argument ignored
```

```
##      {\n    args = commandArgs(TRUE)\n    out = do.call(rmarkdown::render, c(args[1], readRDS(args[2]), list(run_pandoc = FALSE, encoding = "UTF-8")))\n    out_expected = xfun::with_ext(args[1], ".md")\n    if (out != out_expected) {\n        file.rename(out, out_expected)\n        attributes(out_expected) = attributes(out)\n        out = out_expected\n    }\n    if (file.exists(args[3])) {\n        res = readRDS(args[3])\n        res[[args[1]]] = out\n        saveRDS(res, args[3])\n    }\n    else saveRDS(setNames(list(out), args[1]), args[3])\n}setosa
## [1,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          1
## [2,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          1
## [3,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          1
## [4,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          1
## [5,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          1
## [6,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          1
##      {\n    args = commandArgs(TRUE)\n    out = do.call(rmarkdown::render, c(args[1], readRDS(args[2]), list(run_pandoc = FALSE, encoding = "UTF-8")))\n    out_expected = xfun::with_ext(args[1], ".md")\n    if (out != out_expected) {\n        file.rename(out, out_expected)\n        attributes(out_expected) = attributes(out)\n        out = out_expected\n    }\n    if (file.exists(args[3])) {\n        res = readRDS(args[3])\n        res[[args[1]]] = out\n        saveRDS(res, args[3])\n    }\n    else saveRDS(setNames(list(out), args[1]), args[3])\n}versicolor
## [1,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              0
## [2,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              0
## [3,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              0
## [4,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              0
## [5,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              0
## [6,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              0
##      {\n    args = commandArgs(TRUE)\n    out = do.call(rmarkdown::render, c(args[1], readRDS(args[2]), list(run_pandoc = FALSE, encoding = "UTF-8")))\n    out_expected = xfun::with_ext(args[1], ".md")\n    if (out != out_expected) {\n        file.rename(out, out_expected)\n        attributes(out_expected) = attributes(out)\n        out = out_expected\n    }\n    if (file.exists(args[3])) {\n        res = readRDS(args[3])\n        res[[args[1]]] = out\n        saveRDS(res, args[3])\n    }\n    else saveRDS(setNames(list(out), args[1]), args[3])\n}virginica
## [1,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             0
## [2,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             0
## [3,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             0
## [4,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             0
## [5,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             0
## [6,]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             0
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
```

```
## Warning in model.matrix.default(~x - 1, model.frame(~x - 1), contrasts = FALSE):
## non-list contrasts argument ignored
```

```r
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

Okay, this covers how dummy codes work: but, how do they work when used in a
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

## Import Data

We will load a built-in dataset from the dataedu package. 


```r
sci_mo_data
```

```
## # A tibble: 550 x 20
##    pre_int pre_uv pre_percomp time_spent course_ID final_grade subject
##      <dbl>  <dbl>       <dbl>      <dbl> <chr>           <dbl> <chr>  
##  1     5     5            4        2168. AnPhA-S1…       93.8  AnPhA  
##  2     4.2   5            4.5      1550. FrScA-S1…       95.9  FrScA  
##  3     4.6   4.33         4.5       851. FrScA-S2…       88.4  FrScA  
##  4     5     4.33         4        3067. AnPhA-S2…       91.3  AnPhA  
##  5     4     3.67         3.5      1800. OcnA-S11…       88.7  OcnA   
##  6     4     4            4         182. BioA-S11…        6.75 BioA   
##  7     2.4   3.67        NA         264. OcnA-S21…       65.0  OcnA   
##  8     4.2   3.67         2.5       822. FrScA-S2…       89.9  FrScA  
##  9     4     4.33         4.5      2363. AnPhA-S2…       91.4  AnPhA  
## 10     4.2   2            3        1479. AnPhA-S1…       73.5  AnPhA  
## # … with 540 more rows, and 13 more variables: enrollment_reason <chr>,
## #   semester <chr>, enrollment_status <chr>, cogproc <dbl>, social <dbl>,
## #   posemo <dbl>, negemo <dbl>, n <dbl>, section <chr>, post_int <dbl>,
## #   post_uv <dbl>, post_percomp <dbl>, WC <dbl>
```

### Using dummy codes

Let's return use online science class data and consider the effect (for a
student) of being in a specific class in the data set.

First, let's determine how many classes there are. We can use the `count()`
function to see how many courses there are.


```r
dat %>% 
  count(course_ID)
```

```
## # A tibble: 23 x 2
##    course_ID         n
##    <chr>         <int>
##  1 AnPhA-S116-01    56
##  2 AnPhA-S116-02    30
##  3 AnPhA-S216-01    44
##  4 AnPhA-S216-02    17
##  5 AnPhA-T116-01    11
##  6 BioA-S116-01     29
##  7 BioA-S216-01      1
##  8 BioA-T116-01      1
##  9 FrScA-S116-01    69
## 10 FrScA-S116-02    15
## # … with 13 more rows
```

## Analysis

### Regression (linear model) analysis with dummy codes

We will save this output to `m_linear_dc`, where the `dc` stands for dummy
code. We will keep the variables we used in our last set of models - `TimeSpent`
and `course_ID` - as independent variables.























