# Walkthrough 7: The Role (and Usefulness) of Multilevel Models {#c13}

## Topics Emphasized

- Transforming data
- Modeling data
- Communicating results

## Functions Introduced

- `dummies::dummy()`
- `dplyr::bind_cols()`
- `lme4::lmer()`
- `performance::icc()`

## Vocabulary

- dummy coding
- hierarchical linear model  
- intra-class correlation
- multilevel model  

## Chapter Overview

The *purpose* of this walkthrough is to explore students' performance in these online courses. While this and the analysis in [Walkthrough 1/Chapter 7](#c07) focus on the time students spent in the course, this walkthrough focuses on the effects of being in a particular course. To do that, we'll use of *multilevel models*, which can help us consider that the students in our dataset shared classes. While the conceptual details underlying multilevel models can be complex, they do address a basic problem that is relatable to educators: How can we include variables like cases and student grouping levels like classes or schools in our model? We note that while carrying out multi-level models is very accessible through R, some of the concepts remain challenging, and, in such cases, we think it can be helpful to try to run such a model with data that you have collected; later, the technical details (described here and in other, recommended resources) can help you to go deeper with analyses and to further your understanding of multi-level models.

### Background

Using multilevel models help us account for the way that individual students are "grouped" together into higher-level units, like classes. Multilevel models do something different than a simple linear regression like the ones described in [Walkthrough 1/Chapter 7](#c07) and [Walkthrough 4/Chapter 10](#c10): they estimate the effect of being a student in a particular group. A multilevel model uses a different way to standardize the estimates for each group based on how systematically different the groups are from the other groups, relative to the effect on the dependent variable.

Though these conceptual details are complex,fitting them is fortunately straightforward and should be familiar if you have used R's `lm()` function before. So, let's get started!

### Data Source

We'll use the same data source on students' motivation in online science classes that we processed in [Walkthrough 1](#c07).

### Methods

Does the amount of time students spend on a course depend on the specific course they're in? Does the amount of time students spend on a course affect the points they earn in? There are a number of ways to approach these questions. Let's use our linear model.

To do this, we'll assign codes to the groups so we can include them in our model. We'll use a technique called "dummy-coding". Dummy coding means transforming a variable with multiple categories into new variables, where each variable indicates the presence and absence of each category.

## Load Packages

We will load the tidyverse and a few other packages specific to using multilevel models: 
{lme4} [@R-lme4] and {performance} [@R-performance].

If you have not before - as for other packages used for the first time - you'll need to install {lme4}, {performance}, and {dummies} once to do the rest of this walkthrough. If helpful, head to the [Packages](#c06p) section of the [Foundational Skills](#c06) chapter for an overview of installing packages.

The remaining packages ({tidyverse}, {sjPlot}, and {dataedu}) are used in other chapters, but, if you have not installed these before, you will to install these, too, using the `install.packages()` function, with the name of the package included (in quotations), just like for the previous three packages.


```r
library(tidyverse)
library(dummies)
library(sjPlot)
library(lme4)
library(performance)
library(dataedu)
```

## The Role of Dummy Codes

Before we import our data, let's spend some time learning about a process called dummy-coding. In this discussion, we'll see how dummy coding works through using the {dummies} package, though you often do not need to manually dummy code variables like this. A note that the {dummies} package tends to work better with base R as opposed to the {tidyverse}. In this section, we will use base R and data.frame instead of the {tidyverse} and tibbles.

Let's look at the `iris` data that comes built into R.


```r
str(iris)
```

```
## 'data.frame':	150 obs. of  5 variables:
##  $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
##  $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
##  $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
##  $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
##  $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
```

As we can see above, the `Species` variable is a factor. Recall that factor data types are categorical variables. They associate a row with a specific category, or level, of that variable. So how do we consider factor variables in our model? `Species` seems to be made up of, well, words, such as "setosa."

A common way to approach this is through dummy coding, where you create new
variables for each of the possible values of `Species` (such as "setosa").These new variables will have a value of 1 when the row is associated with that level
(i.e., the first row in the data frame above would have a 1 for a column named
`setosa`).

Let's put the {dummies} package to work on this task. How many possible values are there for `Species`? We can check with the `levels` function: 


```r
levels(iris$Species)
```

```
## [1] "setosa"     "versicolor" "virginica"
```

The function `dummy.data.frame()` takes a data frame and creates a `data.frame` where all the specified columns are given dummy attributes. We use it to turn `iris` into a dummy data frame. Then we run the `get.dummy()` function specifically on the `Species` variable. It returns *three* variables, one for each of the three levels of Species - `setosa`, `versicolor`, and `virginica`.

Please note that the code below will trigger a warning. A warning will run the code but alert you that something should be changed. This warning is because of an outdated parameter in the `dummy.data.frame()` function that hasn't been updated. R 3.6 and above triggers a warning when this happens. This is a good reminder that packages evolve (or don't) and you have to be aware of any changes when using them for analysis.


```r
d_iris <-
  dummy.data.frame(iris)
```

```
## Warning in model.matrix.default(~x - 1, model.frame(~x - 1), contrasts = FALSE):
## non-list contrasts argument ignored
```

```r
get.dummy(d_iris, name = "Species") %>% 
  head()
```

```
##   Speciessetosa Speciesversicolor Speciesvirginica
## 1             1                 0                0
## 2             1                 0                0
## 3             1                 0                0
## 4             1                 0                0
## 5             1                 0                0
## 6             1                 0                0
```

Let's confirm that every row associated with a specific species has a 1 in the
column it corresponds to. We can do this by binding together the dummy codes and
the `iris` data and then counting how many rows were coded with a "1" for each dummy code. For example, when the `Species` is "setosa", the variable `Speciessetosa` always
equals 1 - as is the case for the other species. 

Now we need to combine the dummy-coded variables with the `iris` dataset. `bind_cols()` is a useful {tidyverse} function for binding together data frames by column.           


```r
# create matrix of dummy-coded variables
species_dummy_coded <- 
  get.dummy(d_iris, name = "Species")

# add dummy coded variables to iris
iris_with_dummy_codes <- 
  bind_cols(iris, species_dummy_coded)
```

Let's look at the results.


```r
iris_with_dummy_codes %>% 
  count(Species, Speciessetosa, Speciesversicolor, Speciesvirginica)
```

```
## # A tibble: 3 x 5
##   Species    Speciessetosa Speciesversicolor Speciesvirginica     n
##   <fct>              <int>             <int>            <int> <int>
## 1 setosa                 1                 0                0    50
## 2 versicolor             0                 1                0    50
## 3 virginica              0                 0                1    50
```

Now that we have a basic understanding of how dummy codes work, let's now explore how we use them in our model. When fitting models in R that include factor variables, R displays coefficients for all but one level in the model output. The factor level that's not explicitly named is called the "reference group". The reference group is the level that all other levels are compare to.

So why can't R explicitly name every level of a dummy-coded column? It has to do with how the dummy codes are used to facilitate comparison of groups. The purpose of the dummy code is to show how different the dependent variable is for all of the observations that are in one group. Let's go back to our `iris` example. Consider all the flowers that are in the "setosa" group. To represent how different those flowers are, they have to be compared to another group of flowers. In R, we would compare all the flowers in the "setosa" group to the reference group of flowers. Recall that the reference group of flowers would be the group that is not explicitly named in the model output.

However, if every level of flower groups is dummy-coded, there would be no single group to compare to. For this reason, one group is typically selected as the reference group, to which every other group is compared.

## Import Data 

Now that we have some background on dummy codes, let's return to the online science class data. We'll be using the same dataset that we used in [Chapter 7](#c07). Let's load that dataset now from the {dataedu} package. 


```r
dat <- dataedu::sci_mo_processed
```

To wrap up our discussion about factor variables, levels, and dummy codes, let's look at how many classes are represented in the `course_id` variable. These classes will be our factor levels that we'll be using in our model soon. We can use the `count()` function to see how many courses there are: 


```r
dat %>% 
  count(course_id)
```

```
## # A tibble: 26 x 2
##    course_id         n
##    <chr>         <int>
##  1 AnPhA-S116-01    43
##  2 AnPhA-S116-02    29
##  3 AnPhA-S216-01    43
##  4 AnPhA-S216-02    17
##  5 AnPhA-T116-01    11
##  6 BioA-S116-01     34
##  7 BioA-S216-01      7
##  8 BioA-T116-01      2
##  9 FrScA-S116-01    70
## 10 FrScA-S116-02    12
## # … with 16 more rows
```

## Analysis

### Regression (Linear Model) Analysis with Dummy Codes

Before we fit our model, let's talk about our dataset. We will keep the variables we used in our last set of models - `TimeSpent` and `course_id` - as independent variables. Recall that `TimeSpent` is the amount of time in minutes that a student spent in a course and `course_id` is a unique identifier for a particular course. In this walkthrough we'll predict students' final grade rather than the `percentage_earned` variable that we created in [Chapter 7](#c07).

Since we will be using the final grade variable a lot let's rename it to make it easier to type.


```r
dat <- 
  dat %>% 
  rename(final_grade = FinalGradeCEMS)
```

Now we can fit our model. We will save the model object to `m_linear_dc`, where the `dc` stands for dummy code. Later we'll be working with `course_id` as a factor variable, so we can expect to see `lm()` treat it as a dummy coded variable. This means that the model output will include a reference variable for `course_id` that all other levels of `course_id` will be compared against. 


```r
m_linear_dc <- 
  lm(final_grade ~ TimeSpent_std + course_id, data = dat)
```

The output from the model will be long. This is because each course in the `course_id` variable will get its own line in the model output. We can see that using `tab_model()` from {sjPlot}:


```r
tab_model(m_linear_dc,
          title = "Table 13.1")
```

<table style="border-collapse:collapse; border:none;">
<caption style="font-weight: bold; text-align:left;">Table 13.1</caption>
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



Wow! Those are a lot of effects. The model estimates the effects of being in each class, accounting for the time students spent on a course and the class they were in. We know this because the model output includes the time spent (`TimeSpent_std`) variable and subject variables (like `course_id[AnPhA-S116-02]`). 

If we count the number of classes, we see that there are 25 - and not 26! One has
been automatically selected as the reference group, and every other class's
coefficient represents how different each class is from it. The intercept's
value of 0.74 represents the percentage of points that students in the reference
group class have. `lm()` automatically picks the first level of the `course_id` variable as the reference group when it is converted to a factor. In this case, the course associated with course ID `course_idAnPhA-S116-01`, a first semester physiology course, is picked as the reference variable.

What if we want to pick another class as the reference variable? For example, say that we want `course\_idPhysA-S116-01` (the first section of the physics class offered during this semester and year) to be the reference group. We can do this by using the `fct_relevel()` function, which is a part of the {tidyverse} suite of packages. Note that before using `fct_relevel()`, the variable `course_id` was a character data type, which `lm()` coerced into a factor data type when we included it as a predictor variable. Using `fct_relevel()` will explicitly convert `course_id` to a factor data type. 

Now let's use `fct_relevel()` and `mutate()` to re-order the levels within a factor, so that the "first" level will change:


```r
dat <-
  dat %>%
  mutate(course_id = fct_relevel(course_id, "PhysA-S116-01"))
```

We can now see that "PhysA-S116-01" the group is no longer listed as an independent variable. Now every coefficient listed in this model is in comparison to the new reference variable, "PhysA-S116-01". We also see that `course_id` is now recognized as a factor data type. 

Now let's fit our model again with the newly releveled `course_id` variable. We'll give it a different name, `m_linear_dc_1`: 


```r
m_linear_dc_1 <- 
  lm(final_grade ~ TimeSpent_std + course_id, data = dat)

tab_model(m_linear_dc_1,
          title = "Table 13.2")
```

<table style="border-collapse:collapse; border:none;">
<caption style="font-weight: bold; text-align:left;">Table 13.2</caption>
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



Using dummy codes is very common - they are used in nearly every case where
you need to fit a model with variables that are factors. We've already seen one benefit of using R functions like `lm()`, or the `lme4::lmer()` function we discuss later. These functions automatically convert character data types into factor data types. 

For example, imagine you include a variable for courses that has values like "mathematics", "science", "english language" (typed like that!), "social studies", and "art" as an argument in `lm()`. `lm()` will automatically dummy-code these for you. You'll just need to decide if you want to use the default reference group or if you should use `fct_revel()` to pick a different one. 

Lastly, there it's worthing noting that there may be some situations where you do not want to dummy code a factor variable. These are situations where you don't want a single factor level to act as a reference group. In such cases, no intercept is estimated. This can be done by passing a -1 as the first value after the tilde, as follows:


```r
# specifying the same linear model as the previous example, but using a "-1" to indicate that there should not be a reference group
m_linear_dc_2 <- 
  lm(final_grade ~ -1 + TimeSpent_std + course_id, data = dat)

tab_model(m_linear_dc_2,
          title = "Table 13.3")
```

<table style="border-collapse:collapse; border:none;">
<caption style="font-weight: bold; text-align:left;">Table 13.3</caption>
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



In the vast majority of cases, you'll want to dummy code your factor variables so you probably won't be using it very often.

### A Deep-Dive into Multilevel Models

Let's discuss multilevel models a little more by exploring some of the nuances of using them with education data. 

*Dummy-coding variables and ease of interpretation* 

Analyzing the effect of multiple levels is a trade off between considering more than one variable and how easy it is to interpret your model's output. A technique like dummy-coding is a very helpful strategy for working with a small number of groups as predictors. In this walkthrough, we estimated the effects of being in one of the five online science courses. Dummy-coding can help us analyze even further by accounting for multiple course sections or classes for each subject. But consider the challenge of interpreting the effect of being a student in a particular class, where each class and section becomes its own line of the model output. It can get complicated interpreting the effects in comparison to the intercept. 

*Multilevel models and the assumption of independent data points* 

Including a group in our model can help us meet the assumption of independent data points. Linear regression models assume that each data point is not correlated with another data point. This is what is meant by the "assumption of independence" or of "independently and identically distributed" (*i.i.d.*) residuals (Field, Miles, & Field, 2012).
A linear regression model that considers students in different sections (i.e., for an introductory life science class, different laboratory sections) as a single sample will assume that the outcome of each of those students is not correlated with the outcome of any other student in their section. This is a tough assumption when you consider that students who are in the same section may perform similarly (because of what the instructor of the section does, when the section happened to be scheduled, or the fact that students in a section helped one another to study) when it comes to the outcome being assessed. Adding a section group to the model helps us meet the assumption of independent data points by considering the effect of being in a particular section. Generally speaking, analysts often have the goal of accounting for the fact that students share a class. This is very different from determining the effect of any one particular class on the outcome.

*Regularization* 

It's helpful to introduce more vocabulary you're likely to see if you explore multilevel modeling more. So far we've learned that multilevel models help us meet the assumption of independent data points by considering groups in the model. Multilevel models do this by estimating the effect of being a student in each group, but with a key distinction from linear models: instead of determining how different the observations in a group are
from those in the reference group, the multilevel model "regularizes" the difference based on how systematically different the groups are. You may also see the the term "shrink" to describe this. The term "shrinkage" is occasionally used because the group-level estimates (e.g., for classes) obtained through multilevel modeling can never be larger than those from a linear regression model. As described earlier, when there are groups included in the model, a regression effectively estimates the effect for each group independent of all of the others.

Through regularization, groups that comprise individuals who are consistently higher or lower than individuals on average are not regularized very much. Their estimated difference may be close to the estimate from a multilevel model. Whereas groups with only a few individuals or lot of variability within individuals, would be regularized a lot. The way that a multilevel model does this "regularizing" is by considering the groups to be samples from a larger population of classes. By considering the effects of groups to be samples from a larger population, the model not only uses information particular to each group, but also information across all of the data. 

*Intra-class correlation coefficient*

Multilevel models are very common in educational research because they help account for the way in which students take the same classes, or even go to the same school (see Raudenbush & Bryk, 2002). Using multilevel models means that the assumption of independence can
be addressed. Their use also means that individual coefficients for classes do
not need to be included (or interpreted, thankfully!), though they are still
included in and accounted for in the model. 

So what's the most useful way to report the importance of groups in a model? The way that information about the groups is reported is usually in the form of the *intra-class correlation coefficient* (ICC), which explains the proportion of variation in the dependent variable that the groups explain. Smaller ICCs (such as ICCs with values of 0.05, representing 5% of the variation in the dependent variable) mean that the groups are not very important; larger ICCs, such as ICCs with values of 0.10 or larger (values as high as 0.50 are not uncommon!) suggest that groups are indeed important. When groups are important, not including them in the model may ignore the assumption of independence. 

We wanted to include this as multilevel models *are* common. Consider how often the data you collect involves students are grouped in classes, or classes grouped in schools. Educational data is complex, and so it is not surprising that multilevel models may be encountered in educational data science analyses, reports, and articles.

### Multilevel Model Analysis

Fortunately, for all of the complicated details, multilevel models are relatively
easy to use in R. We'll need a new package for this next example. One of the most common for
estimating these types of models is {lme4}. We use `lme4::lmer()` very similarly to the `lm()` function, but we pass it an additional argument for the *groups* we want to include in the model. This model is often referred to as a "varying intercepts" multilevel model. The difference between the groups is the effect of being a student in a class: the intercepts between the groups vary.

Now we can fit our multilevel model uisng the `lmer()` function:


```r
m_course <- 
  lmer(final_grade ~ TimeSpent_std + (1|course_id), data = dat)
```

You'll notice something here that we didn't see when we used `lm()`. We use a new term (`(1|course_id)`). We use this new term to model the group (in this case, courses)
in the data. With `lmer()`, these group terms are in parentheses and to the right of the bar. That is what the `|course_id` part means - it is telling `lmer()` that courses are groups in the data that we want to include in the model. The `1` on the left side of the bar tells `lmer()` that we want varying intercepts for each group (1 is used to denote the intercept).

If you're familiar with Bayesian methods, you'll appreciate a connection here (@gelman2006data). Regularizing in a multilevel model takes data across all groups into account when generating estimates for each group. The data for all of the classes can be interpreted as a Bayesian *prior* for the group estimates.

There's more you can do with `lmer()`. For example, you can include different effects for each group in your model output, so each as its own slope. To explore techniques like this and more, we recommend the book by West, Welch, and Galecki [2014], which provides an excellent walkthrough on how to specify varying slopes using `lmer()`. 

## Results

Let's view the results using the `tab_model()` function from {sjPlot} again.


```r
tab_model(m_course,
          title = "Table 13.4")
```

<table style="border-collapse:collapse; border:none;">
<caption style="font-weight: bold; text-align:left;">Table 13.4</caption>
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
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">75.63</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">72.41&nbsp;&ndash;&nbsp;78.84</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">TimeSpent_std</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">9.45</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">7.74&nbsp;&ndash;&nbsp;11.16</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td colspan="4" style="font-weight:bold; text-align:left; padding-top:.8em;">Random Effects</td>
</tr>

<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">&sigma;<sup>2</sup></td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="3">385.33</td>

<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">&tau;<sub>00</sub> <sub>course_id</sub></td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="3">38.65</td>

<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">ICC</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="3">0.09</td>

<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">N <sub>course_id</sub></td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="3">26</td>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm; border-top:1px solid;">Observations</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="3">573</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">Marginal R<sup>2</sup> / Conditional R<sup>2</sup></td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="3">0.170 / 0.246</td>
</tr>

</table>



For `lm()` models, `tab_model()` provides the output, including some fit statistics, coefficients and their standard errors and estimates. There are two things to note about `lmer()` output:

1.  *p*-values are not automatically provided, due to debates in the wider field
    about how to calculate the degrees of freedom for coefficients^[ Run
    `?lme4::pvalues` to see a discussion of the issue and solutions. We
    have found the lmerTest to be helpful as an easy solution, though some of the recommendations available through `?lme4::pvalues` may be preferable because the technique lmerTest implements has some known issues.]

2.  In addition to the coefficients, there are also estimates for how much
    variability there is between the groups.

A common way to understand how much variability is at the group level is to calculate the *intra-class* correlation. This value is the proportion of the variability in the outcome (the *y*-variable) that is accounted for solely by the groups identified in the model. There is a useful function in the {performance} package for doing this.

You can install the {performance} package by typing this code in your console: 


```r
install.packages("performance")
```

After that, try this function: 


```r
icc(m_course)
```

```
## # Intraclass Correlation Coefficient
## 
##      Adjusted ICC: 0.091
##   Conditional ICC: 0.076
```

This shows that nearly 17% of the variability in the percentage of points
students earned can be explained simply by knowing what class they are in.

### Adding Additional Levels

Now let's add some additional levels. The data that we are using is all from one school, and so we cannot estimate a "two-level" model. Imagine, however, that instead of 26 classes, we had student data from 230 classes and that these classes were from 15 schools. We could estimate a two-level, varying intercepts (where there are now two groups
with effects) model similar to the model we estimated above, but with another group added for the school. The model will automatically account for the way that the classes are nested within the schools automatically (Bates, Maechler, Bolker, & Walker, 2015).

We don't have a variable containing the name of different schools. If we did we could fit the model like this, where `school_id` is the variable containing different schools: 


```r
# this model would specify a group effect for both the course and school
m_course_school <- 
  lmer(final_grade ~ TimeSpent + (1|course_id) + (1|school_id), data = dat)
```

Were we to estimate this model (and then use the `icc()` function), we would see
two ICC values representing the proportion of the variation in the dependent
variable explained by the course and the school. Note that as long as the courses are uniquely labelled, it is not necessary to explicitly nest the courses within schools.

The {lme4} package was designed for complex multilevel models, so you can add even more levels, even those with not nested but crossed random effects. For more on advanced multilevel techniques like these see West, Welch, & Galecki, 2015.

## Conclusion

In this walkthrough, the groups in our multilevel model are classes. But, multilevel models can be used for other cases where data is associated with a common group. For example, if students respond to repeated measures (such as quizzes) over time, then the multiple quiz responses for each student are "grouped" within students. In such a case, we'd specify students as the "grouping factor" instead of courses. Moreover, multilevel models can include multiple groups even if the groups are of very different kinds (i.e., if students from multiple
classes responded to multiple quizzes).

We note that the groups in multilevel models do not need to be nested. They can
also be "crossed", as may be the case for data from teachers in different schools who attended different teacher preparation programs. Not every teacher in a school necessarily attended the same teacher preparation program, and graduates from every teacher preparation program are
highly unlikely to all teach in the same school!

Finally, as noted earlier, multilevel models have similarities to the Bayesian
methods which are becoming more common among some R users - and educational data
scientists. There are also references to recommended books on Bayesian methods
in the additional resources chapter.

There is much more that can be done with multilevel models; we have more
recommendations in the [Additional Resources](#c18) chapter.
