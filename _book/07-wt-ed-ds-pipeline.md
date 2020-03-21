
# Walkthrough 1: The Education Data Science Pipeline With Online Science Class Data {#c07}



## Introduction to the walkthroughs

This chapter is the first of eight walkthroughs included in the book. In it, 
we present *one approach* to analyzing a specific dataset; in this case, the approach
is what we call the education data science pipeline using data from a number of 
online science classes. While the walkthroughs are very different, the structure 
(and section headings) will be consistent throughout the walkthroughs. For example,
every walkthrough will begin with a vocabulary section, followed by an introduction 
to the dataset (and the question or problem) explored in the walkthrough. 

## Vocabulary

- item
- joins
- keys
- log-trace data
- pass
- reverse scale
- regression
- survey
- tibble
- vectorize

## Chapter Overview

In this walkthrough, we explore some of the key steps that are a
part of many data science in education projects. In particular, we explore how
to process and prepare data: what is sometimes referred to as data wrangling. To
do so, we rely heavily on a set of tools that we use throughout *all* of the
walkthroughs, those associated with the tidyverse, the set of
packages for data manipulation, exploration, and visualization using the design
philosophy of 'tidy' data [@wickham2019]. For more information, see the Foundational Skills chapters or https://www.tidyverse.org/.

The tidyverse is predicated on the concept of tidy data [@wickham2014]. Tidy
data has a specific structure: each variable is a column, each observation is a
row, and each type of observational unit is a table. We'll discuss both the
tidyverse and tidy data much more throughout the book.

### Background

The online science classes from which the data used in this walkthrough was obtained
were designed and taught by instructors through a statewide online course provider
designed to supplement (and not replace) students' enrollment in their local school. For
example, students may choose to enroll in an online physics class because one
was not offered at their school. The data were originally collected for a research study, 
which involved a number of different data sources which were explored to
understand students' motivation, or their reasons for taking the course. The 
datasets included:

1.  A self-report survey for three distinct but related aspects of students'
    motivation
2.  Log-trace data, such as data output from the learning management system
3.  Discussion board data (not used in this walkthrough)
4.  Achievement-related (i.e., final grade) data

Our *purpose* for this walkthrough is to begin to understand what explains
students' performance in these online courses. The *problem* we are facing is a 
very common one when it comes to data science in education: the data are complex 
and in need of further processing before we can get to answering questions (or 
running analyses).

To understand students' performance, we will focus on a variable that was available 
through the learning management system used for the courses on the amount of time
students' spent on the course. We will also explore how different (science) 
subjects as well as being in a particular class may help to explain student performance.

First, these different data sources will be described in terms of how they were
provided by the school.

### Data Sources

#### Data Source \#1: Self-Report Survey about Students' Motivation

The first data source is a self-report survey. This was data collected before
the start of the course via self-report survey. The survey included 10 items,
each corresponding to one of three *measures*: interest, utility
value, and perceived competence:

1.  I think this course is an interesting subject. (Interest)
2.  What I am learning in this class is relevant to my life. (Utility value)
3.  I consider this topic to be one of my best subjects. (Perceived competence)
4.  I am not interested in this course. (Interest - reverse coded)
5.  I think I will like learning about this topic. (Interest)
6.  I think what we are studying in this course is useful for me to know.
    (Utility value)
7.  I don’t feel comfortable when it comes to answering questions in this area.
    (Perceived competence)
8.  I think this subject is interesting. (Interest)
9.  I find the content of this course to be personally meaningful. (Utility
    value)
10. I’ve always wanted to learn more about this subject. (Interest)

### Data Source \#2: Log-Trace Data

*Log-trace data* is data generated from our interactions with digital
technologies, such as archived data from social media postings (see
[Chapter 11](#c11) and [Chapter 12](#c12)). In education, an increasingly common
source of log-trace data is that generated from interactions with learning
management systems and other digital tools [@siemens2012]. The data for this
walk-through is a *summary of* log-trace data, namely, the number of minutes
students spent on the course. While this data is rich, you can imagine
even more complex sources of log-trace data (e.g. time stamps associated with
when students started and stopped accessing the course!).

### Data Source \#3: Achievement-Related and Gradebook Data

This is a common source of data: one associated with graded assignments
students completed. In this walkthrough, we just examine students' final grade.

### Data Source \#4: Discussion Board Data

Discussion board data is both rich and unstructured, in that it is primarily in
the form of written text. We also collected discussion board data for this project.

### Methods

In this walkthrough, we will concentrate on the different joins available in the {dplyr} package. We will also start exploring how to run linear models in R.

## Load Packages

This analysis uses R packages, which are collections of R code that help users
code more efficiently, as you will recall from [Chapter 1](#c1). We load
these packages with the function `library()`. In particular, the packages we'll
use will help us organize the structure of the data, work with
dates in the data using {lubridate} [@R-lubridate], create formatted 
tables using {apaTables} [@R-apaTables] and {sjPlot} [@R-sjPlot], and navigate file directories using {here} [@R-here].


```r
library(readxl)
library(tidyverse)
library(lubridate)
library(here)
library(dataedu)
library(apaTables)
library(sjPlot)
```

## Import Data

This code chunk loads the log-trace data from the {dataedu} package. Note that we assign a dataset to an object three times, once for each of the three log-trace
datasets. We assign each of the datasets a name using `<-`.


```r
# Gradebook and log-trace data for F15 and S16 semesters
course_data <- dataedu::course_data

# Pre-survey for the F15 and S16 semesters

pre_survey <- dataedu::pre_survey

# Log-trace data for F15 and S16 semesters - this is for time spent

course_minutes <- dataedu::course_minutes
```

## View Data

Now that we've successfully loaded all three log-trace datasets, we can visually inspect the data by typing the names that we assigned to each dataset.


```r
pre_survey
```

```
#> # A tibble: 1,102 x 12
#>    opdata_username opdata_CourseID Q1Maincellgroup… Q1Maincellgroup…
#>    <chr>           <chr>                      <dbl>            <dbl>
#>  1 _80624_1        FrScA-S116-01                  4                4
#>  2 _80623_1        BioA-S116-01                   4                4
#>  3 _82588_1        OcnA-S116-03                  NA               NA
#>  4 _80623_1        AnPhA-S116-01                  4                3
#>  5 _80624_1        AnPhA-S116-01                 NA               NA
#>  6 _80624_1        AnPhA-S116-02                  4                2
#>  7 _80624_1        AnPhA-T116-01                 NA               NA
#>  8 _80624_1        BioA-S116-01                   5                3
#>  9 _80624_1        BioA-T116-01                  NA               NA
#> 10 _80624_1        PhysA-S116-01                  4                4
#> # … with 1,092 more rows, and 8 more variables: Q1MaincellgroupRow3 <dbl>,
#> #   Q1MaincellgroupRow4 <dbl>, Q1MaincellgroupRow5 <dbl>,
#> #   Q1MaincellgroupRow6 <dbl>, Q1MaincellgroupRow7 <dbl>,
#> #   Q1MaincellgroupRow8 <dbl>, Q1MaincellgroupRow9 <dbl>,
#> #   Q1MaincellgroupRow10 <dbl>
```

```r
course_data
```

```
#> # A tibble: 29,711 x 8
#>    CourseSectionOr… Bb_UserPK Gradebook_Item Grade_Category FinalGradeCEMS
#>    <chr>                <dbl> <chr>          <chr>                   <dbl>
#>  1 AnPhA-S116-01        60186 POINTS EARNED… <NA>                     86.3
#>  2 AnPhA-S116-01        60186 WORK ATTEMPTED <NA>                     86.3
#>  3 AnPhA-S116-01        60186 0.1: Message … <NA>                     86.3
#>  4 AnPhA-S116-01        60186 0.2: Intro As… Hw                       86.3
#>  5 AnPhA-S116-01        60186 0.3: Intro As… Hw                       86.3
#>  6 AnPhA-S116-01        60186 1.1: Quiz      Qz                       86.3
#>  7 AnPhA-S116-01        60186 1.2: Quiz      Qz                       86.3
#>  8 AnPhA-S116-01        60186 1.3: Create a… Hw                       86.3
#>  9 AnPhA-S116-01        60186 1.3: Create a… Hw                       86.3
#> 10 AnPhA-S116-01        60186 1.4: Negative… Hw                       86.3
#> # … with 29,701 more rows, and 3 more variables: Points_Possible <dbl>,
#> #   Points_Earned <dbl>, Gender <chr>
```

```r
course_minutes
```

```
#> # A tibble: 598 x 3
#>    Bb_UserPK CourseSectionOrigID TimeSpent
#>        <dbl> <chr>                   <dbl>
#>  1     44638 OcnA-S116-01            1383.
#>  2     54346 OcnA-S116-01            1191.
#>  3     57981 OcnA-S116-01            3343.
#>  4     66740 OcnA-S116-01             965.
#>  5     67920 OcnA-S116-01            4095.
#>  6     85355 OcnA-S116-01             595.
#>  7     85644 OcnA-S116-01            1632.
#>  8     86349 OcnA-S116-01            1601.
#>  9     86460 OcnA-S116-01            1891.
#> 10     87970 OcnA-S116-01            3123.
#> # … with 588 more rows
```

## Process Data

Often, survey data needs to be processed in order to be (most) useful. Here, we
process the self-report items into three scales for 1) interest, 2) self-efficacy,
and 3) utility value. We do this by:

- Renaming the question variables to something more manageable
- Reversing the response scales on questions 4 and 7
- Categorizing each question into a measure
- Computing the mean of each measure

Let's take these steps in order:

1.  Rename the question columns to something much simpler:


```r
pre_survey  <-
  pre_survey  %>%
  # Rename the qustions something easier to work with because R is case sensitive
  # and working with variable names in mix case is prone to error
  rename(
    q1 = Q1MaincellgroupRow1,
    q2 = Q1MaincellgroupRow2,
    q3 = Q1MaincellgroupRow3,
    q4 = Q1MaincellgroupRow4,
    q5 = Q1MaincellgroupRow5,
    q6 = Q1MaincellgroupRow6,
    q7 = Q1MaincellgroupRow7,
    q8 = Q1MaincellgroupRow8,
    q9 = Q1MaincellgroupRow9,
    q10 = Q1MaincellgroupRow10
  ) %>%
  # Convert all question responses to numeric
  mutate_at(vars(q1:q10), list( ~ as.numeric(.)))
```

Let's take a moment to discuss the {dplyr} function `mutate_at()`. `mutate_at()` is a version of `mutate()`, which changes the values in an existing column or creates new columns. It's useful in education datasets because you'll often need to transform your data before analyzing it. Try this example, where we create a new `total_students` column by adding the number of `male` students and `female` students: 


```r
# Dataset of students
df <- tibble(
  male = 5, 
  female = 5
)

df %>% mutate(total_students = male + female)
```

```
#> # A tibble: 1 x 3
#>    male female total_students
#>   <dbl>  <dbl>          <dbl>
#> 1     5      5             10
```

`mutate_at()` is a special version of `mutate()`, which conveniently changes the values of multiple columns. In our dataset `pre_survey`, we let `mutate()` know we want to change the variables `q1` through `q10`. We do this with the argument `vars(q1:q10)`

2.  Next we'll reverse the scale of the survey responses on questions 4 and 7 so
the responses for all questions can be interpreted in the same way. Rather
than write a lot of code once to reverse the scales for question 4 then
writing it again to reverse the scales on question 7, we'll build a function
that does that job for us. Then we'll use the same function for question 4
and question 7. This will result in much less code, plus it will make it
easier for us to change in the future.

We'll use `case_when()` in our function to reverse the scale of the item responses. `case_when()` is useful when you need to replace the values in a column with other values based on some criteria. Education datasets use a lot of codes to describe demographics, like numerical codes for disability categories, race groups, or proficiency in a test. When you work with codes like this, you'll often want to change the codes to values that are easier to understand. For a example, a consultant analyzing how students did on state testing might use `case_when()` to replace proficiency codes like 1, 2, or 3 to more descriptive words like "below proficiency", "proficient", or "advanced". 
	
`case_when()` lets you vectorize the rules you want to use to change values in a column. When a sequence of criteria is vectorized, R will evaluate a value in a column against each criteria in your `case_when()` sequence. `case_when()` is helpful because it does this without complicated loops. By using code that is compact and readable once you understand how all the arguments work. 

The left hand side of each `case_when()` argument will be a formula that returns either a `TRUE` or a `FALSE`. In the function below we'll use logical operators in the left hand side of the formula like this: `question == 1 ~ 5`. Here are some other logical operators you can use in the future: 

 - `>`: greater than 
 - `<`: lesser than 
 - `>=`: greater than or equal to 
 - `<=`: lesser than or equal to 
 - `==`: equal to 
 - `!=`: not equal to 
 - `!`: not 
 - `&`: and 
 - `|`: or 

Let's make this all concrete and use it here in our function that reverses the scale of the survey responses:


```r
# This part of the code is where we write the function:
# Function for reversing scales 
reverse_scale <- function(question) {
  # Reverses the response scales for consistency
  #   Args:
  #     question: survey question
  #   Returns: a numeric converted response
  # Note: even though 3 is not transformed, case_when expects a match for all
  # possible conditions, so it's best practice to label each possible input
  # and use TRUE ~ as the final statement returning NA for unexpected inputs
  x <- case_when(
    question == 1 ~ 5,
    question == 2 ~ 4,
    question == 4 ~ 2,
    question == 5 ~ 1,
    question == 3 ~ 3,
    TRUE ~ NA_real_
  )
  x
}

# And here's where we use that function to reverse the scales
# Reverse scale for questions 4 and 7
pre_survey <-
  pre_survey %>%
  mutate(q4 = reverse_scale(q4),
         q7 = reverse_scale(q7))
```

3. We'll accomplish the last two steps in one chunk of code. First we'll create a column called `measure` and we'll fill that column with one of three question categories:

- `int`: interest
- `uv`: utility value
- `pc`: self efficacy

After that we'll find the mean response of each category using `mean()` function.


```r
# Add measure variable 
measure_mean <-
  pre_survey %>%
  # Gather questions and responses
  pivot_longer(cols = q1:q10,
               names_to = "question",
               values_to = "response") %>%
  # Here's where we make the column of question categories
  mutate(
    measure = case_when(
      question %in% c("q1", "q4", "q5", "q8", "q10") ~ "int",
      question %in% c("q2", "q6", "q9") ~ "uv",
      question %in% c("q3", "q7") ~ "pc",
      TRUE ~ NA_character_
    )
  ) %>%
  group_by(measure) %>%
  # Here's where we compute the mean of the responses
  summarise(
    # Mean response for each measure
    mean_response = mean(response, na.rm = TRUE),
    # Percent of each measure that had NAs in the response field
    percent_NA = mean(is.na(response))
    )

measure_mean
```

```
#> # A tibble: 3 x 3
#>   measure mean_response percent_NA
#>   <chr>           <dbl>      <dbl>
#> 1 int              4.25      0.178
#> 2 pc               3.65      0.178
#> 3 uv               3.74      0.178
```

### Processing the Course Data

We also can process the course data in order to create new variables which we can use in analyses. 
Information about the course subject, semester, and section are stored in a single column, `CourseSectionOrigID`. If we give each of these their own columns, we'll have more opportunities to analyze them as their own variables. We'll use a function called `separate()` to do this. 
This pulls out the subject, semester, and section from the course ID so we can use them later on. 


```r
# split course section into components
course_data <- 
  course_data %>%
  # Give course subject, semester, and section their own columns
  separate(
    col = CourseSectionOrigID,
    into = c("subject", "semester", "section"),
    sep = "-",
    remove = FALSE
  )
```

### Joining the Data

To join the course data and pre-survey data, we need to create similar *keys*.
In other words, our goal here is to have one variable that matches across both
datasets, so that we can merge the datasets on the basis of that variable.

For these data, both have variables for the course and the student, though they
have different names in each. Our first goal will be to rename two variables in
each of our datasets so that they will match. One variable will correspond to
the course, and the other will correspond to the student. We are not changing
anything in the data itself at this step - instead, we are just cleaning it up
so that we can look at the data all in one place.

Let's start with the pre-survey data. We will rename `RespondentID` and `opdata_CourseID` to be `student_id` and `course_id`, respectively.


```r
pre_survey <-
  pre_survey %>%
  rename(student_id = opdata_username,
         course_id = opdata_CourseID)

pre_survey
```

```
#> # A tibble: 1,102 x 12
#>    student_id course_id    q1    q2    q3    q4    q5    q6    q7    q8    q9
#>    <chr>      <chr>     <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1 _80624_1   FrScA-S1…     4     4     4     5     5     4     5     5     5
#>  2 _80623_1   BioA-S11…     4     4     3     4     4     4     4     3     4
#>  3 _82588_1   OcnA-S11…    NA    NA    NA    NA    NA    NA    NA    NA    NA
#>  4 _80623_1   AnPhA-S1…     4     3     3     4     3     3     3     4     2
#>  5 _80624_1   AnPhA-S1…    NA    NA    NA    NA    NA    NA    NA    NA    NA
#>  6 _80624_1   AnPhA-S1…     4     2     2     4     4     4     5     4     4
#>  7 _80624_1   AnPhA-T1…    NA    NA    NA    NA    NA    NA    NA    NA    NA
#>  8 _80624_1   BioA-S11…     5     3     3     5     5     4     5     5     3
#>  9 _80624_1   BioA-T11…    NA    NA    NA    NA    NA    NA    NA    NA    NA
#> 10 _80624_1   PhysA-S1…     4     4     3     4     4     4     4     4     3
#> # … with 1,092 more rows, and 1 more variable: q10 <dbl>
```

Looks better now!

In addition to needing to be renamed, the `student_id` variable had an issue - the variable has some additional characters before and after *the actual ID* that we will need to be able to join this data with the other data sources we have. Why does this variable have these additional characters? We are not sure! Sometimes, educational data from different systems (used for different purposes) may have additional "meta"-data added on. In any event, here is what the variables look like before and processing:


```r
head(pre_survey$student_id)
```

```
#> [1] "_80624_1" "_80623_1" "_82588_1" "_80623_1" "_80624_1" "_80624_1"
```

What we need is the five characters in between the underscore symbols - these: `_`.

One way to do this is to use the `str_sub()` function from the {stringr} package. You can specify the indices of the variables you want the string to *start* and *end* with. Here, for example, is how we can start with the second character, skipping the first underscore in the process.


```r
str_sub("_80624_1", start = 2)
```

```
#> [1] "80624_1"
```

We can do the same with the last few characters:


```r
str_sub("_80624_1", end = -3)
```

```
#> [1] "_80624"
```

Putting the pieces together, the following should return what we want:


```r
str_sub("_80624_1", start = 2, end = -3)
```

```
#> [1] "80624"
```

We can apply this to our data using `mutate()`. We convert the string into a number using `as.numeric()` at the same time, so the data can be joined to the other, numeric `student_id` variables (in the other data sets):


```r
pre_survey <- pre_survey %>% 
  mutate(student_id = as.numeric(str_sub(student_id, start = 2, end = -3)))
```

Let's proceed to the course data. Our goal is to rename two variables that
correspond to the course and the student so that we can match with the other
variables we just created for the pre-survey data.


```r
course_data <-
  course_data %>%
  rename(student_id = Bb_UserPK,
         course_id = CourseSectionOrigID)
```

Now that we have two variables that are consistent across both datasets - we
have called them `course_id` and `student_id` - we can join them using the
{dplyr} function, `left_join()`.

Let's save our joined data as a new object called `dat`.


```r
dat <-
  left_join(course_data, pre_survey,
            by = c("student_id", "course_id"))
dat
```

```
#> # A tibble: 40,348 x 21
#>    course_id subject semester section student_id Gradebook_Item Grade_Category
#>    <chr>     <chr>   <chr>    <chr>        <dbl> <chr>          <chr>         
#>  1 AnPhA-S1… AnPhA   S116     01           60186 POINTS EARNED… <NA>          
#>  2 AnPhA-S1… AnPhA   S116     01           60186 WORK ATTEMPTED <NA>          
#>  3 AnPhA-S1… AnPhA   S116     01           60186 0.1: Message … <NA>          
#>  4 AnPhA-S1… AnPhA   S116     01           60186 0.2: Intro As… Hw            
#>  5 AnPhA-S1… AnPhA   S116     01           60186 0.3: Intro As… Hw            
#>  6 AnPhA-S1… AnPhA   S116     01           60186 1.1: Quiz      Qz            
#>  7 AnPhA-S1… AnPhA   S116     01           60186 1.2: Quiz      Qz            
#>  8 AnPhA-S1… AnPhA   S116     01           60186 1.3: Create a… Hw            
#>  9 AnPhA-S1… AnPhA   S116     01           60186 1.3: Create a… Hw            
#> 10 AnPhA-S1… AnPhA   S116     01           60186 1.4: Negative… Hw            
#> # … with 40,338 more rows, and 14 more variables: FinalGradeCEMS <dbl>,
#> #   Points_Possible <dbl>, Points_Earned <dbl>, Gender <chr>, q1 <dbl>,
#> #   q2 <dbl>, q3 <dbl>, q4 <dbl>, q5 <dbl>, q6 <dbl>, q7 <dbl>, q8 <dbl>,
#> #   q9 <dbl>, q10 <dbl>
```

`left_join()` is named based on the 'direction' that the data is being joined. Note the order of the data frames passed to our "left" join. Left joins retain all of the rows in the data
frame on the "left", and joins every matching row in the right data frame to it.

Let's hone in on how this code is structured. After `left_join()`, we see `course_data` and then
`pre_survey`. In this case, `course_data` is the "left" data frame (passed as
the *first* argument), while `pre_survey` is the "right" data frame (passed as
the *second* argument). So, in the above, what
happens? You can run the code yourself to check.

What our aim - and what should happen - is that all of the rows in
`course_data` are retained in our new data frame, `dat`, with matching rows of
`pre_survey` joined to it. An important note is that there are
not multiple matching rows of `pre_survey`; otherwise, you would end up with
more rows in `dat` than expected. There is a lot packed into this one function. Joins are, however, extremely powerful - and common - in
many data analysis processing pipelines, both in education and in any field. Think of
all of the times you have data in more than one data frame, and want them to be
in a single data frame! As a result, we think that joins are well worth
investing the time to be able to use.

With education (and other) data, `left_join()` is helpful for carrying out
most tasks related to joining datasets. However, there are functions for other
types of joins. They may be less important than `left_join()` but are still worth
mentioning (note that for all of these, the "left" data frame is
always the first argument, and the "right" data frame is always the second):

#### `semi_join()`

`semi_join()`: joins and retains all of the *matching* rows in the "left" and "right" data frame; it is useful when you are only interested in keeping the rows (or cases/observations) that are able to be joined. 
`semi_join()` will not create duplicate rows of the left data frame, even when it finds multiple matches on the right data frame. It will also keep only the columns from the left data frame. 

For example, the following returns only the rows that are present in both
`course_data` and `pre_survey`:


```r
dat_semi <- 
  semi_join(course_data,
            pre_survey,
            by = c("student_id", "course_id"))

dat_semi
```

```
#> # A tibble: 28,655 x 11
#>    course_id subject semester section student_id Gradebook_Item Grade_Category
#>    <chr>     <chr>   <chr>    <chr>        <dbl> <chr>          <chr>         
#>  1 AnPhA-S1… AnPhA   S116     01           60186 POINTS EARNED… <NA>          
#>  2 AnPhA-S1… AnPhA   S116     01           60186 WORK ATTEMPTED <NA>          
#>  3 AnPhA-S1… AnPhA   S116     01           60186 0.1: Message … <NA>          
#>  4 AnPhA-S1… AnPhA   S116     01           60186 0.2: Intro As… Hw            
#>  5 AnPhA-S1… AnPhA   S116     01           60186 0.3: Intro As… Hw            
#>  6 AnPhA-S1… AnPhA   S116     01           60186 1.1: Quiz      Qz            
#>  7 AnPhA-S1… AnPhA   S116     01           60186 1.2: Quiz      Qz            
#>  8 AnPhA-S1… AnPhA   S116     01           60186 1.3: Create a… Hw            
#>  9 AnPhA-S1… AnPhA   S116     01           60186 1.3: Create a… Hw            
#> 10 AnPhA-S1… AnPhA   S116     01           60186 1.4: Negative… Hw            
#> # … with 28,645 more rows, and 4 more variables: FinalGradeCEMS <dbl>,
#> #   Points_Possible <dbl>, Points_Earned <dbl>, Gender <chr>
```

#### `anti_join()`

`anti_join()`: *removes* all of the rows in the "left" data frame that can be
joined with those in the "right" data frame.


```r
dat_anti <-
  anti_join(course_data,
            pre_survey,
            by = c("student_id", "course_id"))

dat_anti
```

```
#> # A tibble: 1,056 x 11
#>    course_id subject semester section student_id Gradebook_Item Grade_Category
#>    <chr>     <chr>   <chr>    <chr>        <dbl> <chr>          <chr>         
#>  1 AnPhA-S1… AnPhA   S116     01           85865 POINTS EARNED… <NA>          
#>  2 AnPhA-S1… AnPhA   S116     01           85865 WORK ATTEMPTED <NA>          
#>  3 AnPhA-S1… AnPhA   S116     01           85865 0.1: Message … <NA>          
#>  4 AnPhA-S1… AnPhA   S116     01           85865 0.2: Intro As… Hw            
#>  5 AnPhA-S1… AnPhA   S116     01           85865 0.3: Intro As… Hw            
#>  6 AnPhA-S1… AnPhA   S116     01           85865 1.1: Quiz      Qz            
#>  7 AnPhA-S1… AnPhA   S116     01           85865 1.2: Quiz      Qz            
#>  8 AnPhA-S1… AnPhA   S116     01           85865 1.3: Create a… Hw            
#>  9 AnPhA-S1… AnPhA   S116     01           85865 1.3: Create a… Hw            
#> 10 AnPhA-S1… AnPhA   S116     01           85865 1.4: Negative… Hw            
#> # … with 1,046 more rows, and 4 more variables: FinalGradeCEMS <dbl>,
#> #   Points_Possible <dbl>, Points_Earned <dbl>, Gender <chr>
```

#### `right_join()`

`right_join()`: perhaps the least helpful of the three, `right_join()` works the
same as `left_join()`, but by retaining all of the rows in the "right" data
frame, and joining matching rows in the "left" data frame (so, the opposite of
`left_join()`).


```r
dat_right <-
  right_join(course_data,
             pre_survey,
             by = c("student_id", "course_id"))

dat_right
```

```
#> # A tibble: 39,593 x 21
#>    course_id subject semester section student_id Gradebook_Item Grade_Category
#>    <chr>     <chr>   <chr>    <chr>        <dbl> <chr>          <chr>         
#>  1 FrScA-S1… <NA>    <NA>     <NA>         80624 <NA>           <NA>          
#>  2 BioA-S11… <NA>    <NA>     <NA>         80623 <NA>           <NA>          
#>  3 OcnA-S11… <NA>    <NA>     <NA>         82588 <NA>           <NA>          
#>  4 AnPhA-S1… <NA>    <NA>     <NA>         80623 <NA>           <NA>          
#>  5 AnPhA-S1… <NA>    <NA>     <NA>         80624 <NA>           <NA>          
#>  6 AnPhA-S1… <NA>    <NA>     <NA>         80624 <NA>           <NA>          
#>  7 AnPhA-T1… <NA>    <NA>     <NA>         80624 <NA>           <NA>          
#>  8 BioA-S11… <NA>    <NA>     <NA>         80624 <NA>           <NA>          
#>  9 BioA-T11… <NA>    <NA>     <NA>         80624 <NA>           <NA>          
#> 10 PhysA-S1… <NA>    <NA>     <NA>         80624 <NA>           <NA>          
#> # … with 39,583 more rows, and 14 more variables: FinalGradeCEMS <dbl>,
#> #   Points_Possible <dbl>, Points_Earned <dbl>, Gender <chr>, q1 <dbl>,
#> #   q2 <dbl>, q3 <dbl>, q4 <dbl>, q5 <dbl>, q6 <dbl>, q7 <dbl>, q8 <dbl>,
#> #   q9 <dbl>, q10 <dbl>
```

If we wanted this to return exactly the same output as `left_join()` (and so to
create a data frame that is identical to the `dat` data frame above), we could
simply switch the order of the two data frames to be the opposite of those used
for the `left_join()` above:


```r
dat_right <-
  semi_join(pre_survey,
            course_data,
            by = c("student_id", "course_id"))

dat_right
```

```
#> # A tibble: 801 x 12
#>    student_id course_id    q1    q2    q3    q4    q5    q6    q7    q8    q9
#>         <dbl> <chr>     <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1      85791 FrScA-S1…     3     3     3     3     4     3     3     3     2
#>  2      87010 FrScA-S1…     5     3     3     5     4     4     3     5     2
#>  3      87027 FrScA-S1…     5     5     4     4     4     5     4     5     4
#>  4      85649 FrScA-S1…    NA    NA    NA    NA    NA    NA    NA    NA    NA
#>  5      86216 BioA-S11…     5     3     4     4     5     4     3     5     4
#>  6      68476 OcnA-S11…     4     4     2     2     3     4     4     4     4
#>  7      68476 OcnA-S11…     4     4     4     4     4     4     4     4     4
#>  8      87866 FrScA-T1…     5     4     3     5     4     4     3     3     3
#>  9      64930 FrScA-T1…     4     3     3     4     4     4     3     4     4
#> 10      86280 FrScA-S1…     4     3     2     4     4     4     4     4     3
#> # … with 791 more rows, and 1 more variable: q10 <dbl>
```

Just one more data frame to merge:


```r
course_minutes <-
  course_minutes %>%
  rename(student_id = Bb_UserPK,
         course_id = CourseSectionOrigID)

course_minutes <-
  course_minutes %>%
  # Change the data type for student_id in course_minutes so we can match to 
  # student_id in dat
  mutate(student_id = as.integer(student_id))

dat <- 
  dat %>% 
  left_join(course_minutes, 
            by = c("student_id", "course_id"))
```

Note that they're now combined, even though the course data has many more rows:
The pre\_survey data has been joined for each student by course combination.

We have a pretty large data frame! Let's take a quick look.


```r
dat
```

```
#> # A tibble: 40,348 x 22
#>    course_id subject semester section student_id Gradebook_Item Grade_Category
#>    <chr>     <chr>   <chr>    <chr>        <dbl> <chr>          <chr>         
#>  1 AnPhA-S1… AnPhA   S116     01           60186 POINTS EARNED… <NA>          
#>  2 AnPhA-S1… AnPhA   S116     01           60186 WORK ATTEMPTED <NA>          
#>  3 AnPhA-S1… AnPhA   S116     01           60186 0.1: Message … <NA>          
#>  4 AnPhA-S1… AnPhA   S116     01           60186 0.2: Intro As… Hw            
#>  5 AnPhA-S1… AnPhA   S116     01           60186 0.3: Intro As… Hw            
#>  6 AnPhA-S1… AnPhA   S116     01           60186 1.1: Quiz      Qz            
#>  7 AnPhA-S1… AnPhA   S116     01           60186 1.2: Quiz      Qz            
#>  8 AnPhA-S1… AnPhA   S116     01           60186 1.3: Create a… Hw            
#>  9 AnPhA-S1… AnPhA   S116     01           60186 1.3: Create a… Hw            
#> 10 AnPhA-S1… AnPhA   S116     01           60186 1.4: Negative… Hw            
#> # … with 40,338 more rows, and 15 more variables: FinalGradeCEMS <dbl>,
#> #   Points_Possible <dbl>, Points_Earned <dbl>, Gender <chr>, q1 <dbl>,
#> #   q2 <dbl>, q3 <dbl>, q4 <dbl>, q5 <dbl>, q6 <dbl>, q7 <dbl>, q8 <dbl>,
#> #   q9 <dbl>, q10 <dbl>, TimeSpent <dbl>
```

It looks like we have 40348 observations from 30 variables.

There is one last step to take. If we were interested in a fine-grained analysis of
how students performed (according to the teacher) on different assignments (see
the `Gradebook_Item` column), we would keep all rows of the data. But,
our goal (for now) is more modest: to calculate the percentage of points
students earned as a measure of their final grade (noting that the teacher may
have assigned a different grade - or weighted their grades in ways not reflected
through the points).


```r
dat <-
  dat %>%
  group_by(student_id, course_id) %>%
  mutate(Points_Earned = as.integer(Points_Earned)) %>%
  summarize(
    total_points_possible = sum(Points_Possible, na.rm = TRUE),
    total_points_earned = sum(Points_Earned, na.rm = TRUE)
  ) %>%
  mutate(percentage_earned = total_points_earned / total_points_possible) %>%
  ungroup() %>%
  # note that we join this back to the original data frame to retain all of the variables
  left_join(dat)
```

```
#> Joining, by = c("student_id", "course_id")
```

### Finding Distinct Cases at the Student-Level

This last step calculated a new column for the percentage of points each
student earned. That value is the same for the same student (an easy way we
would potentially use to check this is `View()`, i.e., `View(dat)`).
But, because we are not carrying out a finer-grained analysis using the
`Gradebook_Item`, the duplicate rows are not necessary. We only want variables
at the student-level (and not at the level of different gradebook items). We can
do this using the `distinct()` function. This function takes the name of the
data frame and the name of the variables used to determine what counts as a
unique case.

Imagine having a bucket of Halloween candy that has 100 pieces of candy. You know that these 100 pieces are really just a bunch of duplicate pieces from a relatively short list of candy brands. `distinct()` takes that bucket of 100 pieces and returns a bucket containing only one of each distinct piece.
Another thing to note about `distinct()` is that it will only
return the variable(s) (we note that you can pass more than one variable to
`distinct()`) you used to determine uniqueness, *unless* you include the
argument `.keep_all = TRUE`. For the sake of making it very easy to view the
output, we omit this argument (only for now).

Were we to run `distinct(dat, Gradebook_Item)`, what do you think would be
returned?


```r
distinct(dat, Gradebook_Item)
```

```
#> # A tibble: 222 x 1
#>    Gradebook_Item                                             
#>    <chr>                                                      
#>  1 POINTS EARNED & TOTAL COURSE POINTS                        
#>  2 WORK ATTEMPTED                                             
#>  3 0-1.1: Intro Assignment - Send a Message to Your Instructor
#>  4 0-1.2: Intro Assignment - DB #1                            
#>  5 0-1.3: Intro Assignment - Submitting Files                 
#>  6 1-1.1: Lesson 1-1 Graphic Organizer                        
#>  7 1-2.1: Explore a Career Assignment                         
#>  8 1-2.2: Explore a Career DB #2                              
#>  9 PROGRESS CHECK 1 @ 02-18-16                                
#> 10 1-2.3: Lesson 1-2 Graphic Organizer                        
#> # … with 212 more rows
```

What is every distinct gradebook item is what is returned. You might be
wondering (as we were) whether some gradebook items have the same values across
courses; we can return the unique *combination* of courses and gradebook items
by simply adding another variable to `distinct()`:


```r
distinct(dat, course_id, Gradebook_Item)
```

```
#> # A tibble: 1,269 x 2
#>    course_id     Gradebook_Item                                             
#>    <chr>         <chr>                                                      
#>  1 FrScA-S216-02 POINTS EARNED & TOTAL COURSE POINTS                        
#>  2 FrScA-S216-02 WORK ATTEMPTED                                             
#>  3 FrScA-S216-02 0-1.1: Intro Assignment - Send a Message to Your Instructor
#>  4 FrScA-S216-02 0-1.2: Intro Assignment - DB #1                            
#>  5 FrScA-S216-02 0-1.3: Intro Assignment - Submitting Files                 
#>  6 FrScA-S216-02 1-1.1: Lesson 1-1 Graphic Organizer                        
#>  7 FrScA-S216-02 1-2.1: Explore a Career Assignment                         
#>  8 FrScA-S216-02 1-2.2: Explore a Career DB #2                              
#>  9 FrScA-S216-02 PROGRESS CHECK 1 @ 02-18-16                                
#> 10 FrScA-S216-02 1-2.3: Lesson 1-2 Graphic Organizer                        
#> # … with 1,259 more rows
```

It looks like *a lot* of gradebook items were repeated - likely across the
different sections of the same course (we would be curious to hear what you find
if you investigate this!).

Let's use what we just did, but to find the unique values at the student-level.
Thus, instead of exploring unique gradebook items, we will explore unique
students (still accounting for the course, as students could enroll in more than
one course.) This time, we will add the `keep_all = TRUE` argument.


```r
dat <-
  distinct(dat, course_id, student_id, .keep_all = TRUE)
```

This is a much smaller data frame - with one row for each student in the course
(instead of the 29,701 rows which we would be interested in were we analyzing
this data at the level of specific students' grades for specific gradebook
items). Now that our data are ready to go, we can start to ask some questions of
the data,

## Analysis

In this section, we focus on some initial analyses in the form of visualizations and some models. We expand on these in [Chapter 13](#c13). Before we start visualizing relationships between variables in our survey dataset, let's introduce {ggplot2}, a visualization package we'll be using in our walkthroughs. 

### About \{ggplot2\}

{ggplot2} is a package we’ll be using a lot for graphing our education datasets. {ggplot2} is designed to build graphs layer by layer, where each layer is a building block for your graph. Making graphs in layers is useful because we can think of building up our graphs in separate parts–the data comes first, then the x- and y-axis, then other components like text labels and graph shapes. When something goes wrong and your ggplot2 code returns an error, you can learn about what’s happening by removing one layer at a time and running it again until the code works properly. Once you know which line is causing the problem, you can focus on fixing it. 

The first two lines of most {ggplot2} code look similar in most graphs. The first line tells R which dataset to graph and which columns the x-axis and y-axis will represent. The second line tells R which shape to use when drawing the graph. You can tell R which shape to use in your graphs with a family of {ggplot2} functions that start with `geom_`. {ggplot2} has many graph shapes you can use, including points, bars, lines, and boxplots.  Here’s a {ggplot2} example using a dataset of school mean test scores to graph a bar chart:


```r
# make dataset
students <- 
  tibble(
    school_id = c("a", "b", "c"), 
    mean_score = c(10, 20, 30)
  )

# tell R which dataset to plot and which columns the x-axis and y-axis will represent
ggplot(data = students, aes(x = school_id, y = mean_score)) + 
  # draw the plot
  geom_bar(stat = "identity",
           fill = dataedu_colors("darkblue")) +
  theme_dataedu()
```

<div class="figure" style="text-align: center">
<img src="figures/unnamed-chunk-27-1.png" alt="Example Plot" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-27)Example Plot</p>
</div>

The `data` argument in the first line tells R we’ll be using the dataset called `students`. The `aes` argument tells R we’ll be using values from the `school_id` column for the x-axis and values from the `mean_score` column for the y-axis. In the second line, the `geom_bar` function tells R we’ll drawing the graph using the bar chart format.  Each line of ggplot code is connected by a `+` at the end to tell R the next line of code is an additional ggplot layer to add. 

### The Relationship between Time Spent on Course and Percentage of Points Earned

One thing we might be wondering is how time spent on course is related to
students' final grade.


```r
dat %>%
  # aes() tells ggplot2 what variables to map to what feature of a plot
  # Here we map variables to the x- and y-axis
  ggplot(aes(x = TimeSpent, y = percentage_earned)) + 
  # Creates a point with x- and y-axis coordinates specified above
  geom_point(color = dataedu_colors("green")) + 
  theme_dataedu() +
  xlab("Time Spent") +
  ylab("Percentage Earned")
```

<div class="figure" style="text-align: center">
<img src="figures/unnamed-chunk-28-1.png" alt="Percentage Earned vs. Time Spent" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-28)Percentage Earned vs. Time Spent</p>
</div>

There appears to be *some* relationship. What if we added a line of best fit - a linear model?


```r
dat %>%
  ggplot(aes(x = TimeSpent, y = percentage_earned)) +
    geom_point(color = dataedu_colors("green")) + # same as above
  # this adds a line of best fit
  # method = "lm" tells ggplot2 to fit the line using linear regression
  geom_smooth(method = "lm") +
  theme_dataedu() +
  xlab("Time Spent") +
  ylab("Percentage Earned")
```

<div class="figure" style="text-align: center">
<img src="figures/unnamed-chunk-29-1.png" alt="Adding a Line of Best Fit" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-29)Adding a Line of Best Fit</p>
</div>

So, it appears that the more time students spent on the course, the more points
they earned.

### Linear Model (Regression)

We can find out exactly what the relationship is using a linear model. We also
discuss linear models in [Chapter 10](#c10).

Let's use this technique to model the relationship between the time spent on the
course and the percentage of points earned. Here, we predict
`percentage_earned`, or the percentage of the total points that are possible for
a student to earn. Percentage earned is the dependent, or *y*-variable,
and so we enter it first, after the `lm()` command and before the tilde (`~`)
symbol. To the right of the tilde is one independent variable, `TimeSpent`, or
the time that students spent on the course. We also pass, or provide, the data frame, `dat`.
At this point, we're ready to run the model. Let's run this line of code and
save the results to an object - we chose `m_linear`, but any name will work, as
well as the `summary()` function on the output.


```r
m_linear <-
  lm(percentage_earned ~ TimeSpent, data = dat)
```

Another way that we can generate table output is with a function from the
{sjPlot} package, `tab_model()`.


```r
tab_model(m_linear)
```

<table style="border-collapse:collapse; border:none;">
<tr>
<th style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm;  text-align:left; ">&nbsp;</th>
<th colspan="3" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">percentage earned</th>
</tr>
<tr>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  text-align:left; ">Predictors</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">Estimates</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">CI</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">p</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">(Intercept)</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.76</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.75&nbsp;&ndash;&nbsp;0.77</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">TimeSpent</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-0.00</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-0.00&nbsp;&ndash;&nbsp;0.00</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.364</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm; border-top:1px solid;">Observations</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="3">598</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">R<sup>2</sup> / R<sup>2</sup> adjusted</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="3">0.001 / -0.000</td>
</tr>

</table>

This will work well for R Markdown documents (or simply to interpret the model in
R). If you want to save the model for use in a Word document, the
[{apaTables}](https://cran.r-project.org/web/packages/apaTables/vignettes/apaTables.html) (https[]()://cran.r-project.org/web/packages/apaTables/vignettes/apaTables.html)
package may be helpful. To do so, just pass the name of the regression model,
like we did with `tab_model()`. Then, you can save the output to a Word
document, simply by adding a `filename` argument:


```r
apa.reg.table(m_linear, filename = "regression-table-output.doc")
```

You might be wondering what else the {apaTables} package does. We encourage you to
read more about the package here:
<https://cran.r-project.org/web/packages/apaTables/index.html>. The vignette is
especially helpful. One function that may be useful for writing manuscripts is
the following function for creating correlation tables; the function takes, as
an input, a data frame with the variables for which you wish to calculate
correlations. 

Before we proceed to the next code chunk, let's talk about some functions we'll
be using a lot in this book. `filter()`, `group_by()`, and `summarize()` are functions
in the {dplyr} package that you will see a lot in upcoming chapters.

  - `filter()` removes rows from the dataset that don't match a criteria. Use it
    for tasks like only keeping records for students in the fifth grade
  - `group_by()` groups records together so you can perform operations on those
    groups instead of on the entire dataset. Use it for tasks like getting the
    mean test score of each school instead of a whole school district
  - `summarize()` and `summarise()` reduce your dataset down to a summary statistic.
    Use it for tasks like turning a dataset of student test scores into a dataset
    of grade levels and their mean test score

So let's use these {dplyr} functions on our survey analysis. We will create the
same measures (based on the survey items) that we used earlier to understand how
they relate to one another:


```r
survey_responses <-
  pre_survey %>%
  # Gather questions and responses
  pivot_longer(cols = q1:q10,
               names_to = "question",
               values_to = "response") %>%
  mutate(
    # Here's where we make the column of question categories
    measure = case_when(
      question %in% c("q1", "q4", "q5", "q8", "q10") ~ "int",
      question %in% c("q2", "q6", "q9") ~ "uv",
      question %in% c("q3", "q7") ~ "pc",
      TRUE ~ NA_character_
    )
  ) %>%
  group_by(student_id, measure) %>%
  # Here's where we compute the mean of the responses
  summarize(
    # Mean response for each measure
    mean_response = mean(response, na.rm = TRUE)
    ) %>%
  filter(!is.na(mean_response)) %>%
  pivot_wider(names_from = measure, 
              values_from = mean_response)

survey_responses
```

```
#> # A tibble: 515 x 4
#> # Groups:   student_id [515]
#>    student_id   int    pc    uv
#>         <dbl> <dbl> <dbl> <dbl>
#>  1      43146  5     4.5   4.33
#>  2      44638  4.2   3.5   4   
#>  3      47448  5     4     3.67
#>  4      47979  5     3.5   5   
#>  5      48797  3.8   3.5   3.5 
#>  6      49147  4.25  3.73  3.71
#>  7      51943  4.6   4     4   
#>  8      52326  5     3.5   5   
#>  9      52446  3     3     3.33
#> 10      53248  4     3     3.33
#> # … with 505 more rows
```

Now that we've prepared the survey responses, we can use the `apa.cor.table()` function:


```r
survey_responses %>% 
  apa.cor.table()
```

```
#> 
#> 
#> Means, standard deviations, and correlations with confidence intervals
#>  
#> 
#>   Variable      M        SD       1           2          3         
#>   1. student_id 85966.07 10809.12                                  
#>                                                                    
#>   2. int        4.22     0.59     .00                              
#>                                   [-.08, .09]                      
#>                                                                    
#>   3. pc         3.60     0.64     .04         .59**                
#>                                   [-.05, .13] [.53, .64]           
#>                                                                    
#>   4. uv         3.71     0.71     .02         .57**      .50**     
#>                                   [-.06, .11] [.51, .62] [.43, .56]
#>                                                                    
#> 
#> Note. M and SD are used to represent mean and standard deviation, respectively.
#> Values in square brackets indicate the 95% confidence interval.
#> The confidence interval is a plausible range of population correlations 
#> that could have caused the sample correlation (Cumming, 2014).
#> * indicates p < .05. ** indicates p < .01.
#> 
```

The time spent variable is on a very large scale (minutes); what if we transform
it to represent the number of hours that students spent on the course? Let's use
the `mutate()` function we used earlier. We'll end the variable name in
`_hours`, to represent what this variable means.


```r
# creating a new variable for the amount of time spent in hours
dat <- 
  dat %>% 
  mutate(TimeSpent_hours = TimeSpent / 60)

# the same linear model as above, but with the TimeSpent variable in hours
m_linear_1 <- 
  lm(percentage_earned ~ TimeSpent_hours, data = dat)

# viewing the output of the linear model
tab_model(m_linear_1)
```

<table style="border-collapse:collapse; border:none;">
<tr>
<th style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm;  text-align:left; ">&nbsp;</th>
<th colspan="3" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">percentage earned</th>
</tr>
<tr>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  text-align:left; ">Predictors</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">Estimates</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">CI</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">p</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">(Intercept)</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.76</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.75&nbsp;&ndash;&nbsp;0.77</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">TimeSpent_hours</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-0.00</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-0.00&nbsp;&ndash;&nbsp;0.00</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.364</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm; border-top:1px solid;">Observations</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="3">598</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">R<sup>2</sup> / R<sup>2</sup> adjusted</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="3">0.001 / -0.000</td>
</tr>

</table>

The scale still does not seem quite right. What if we standardized the variable
to have a mean of zero and a standard deviation of one?


```r
# this is to standardize the TimeSpent variable to have a mean of zero and a standard deviation of 1
dat <- 
  dat %>% 
  mutate(TimeSpent_std = scale(TimeSpent))

# the same linear model as above, but with the TimeSpent variable standardized
m_linear_2 <- 
  lm(percentage_earned ~ TimeSpent_std, data = dat)

# viewing the output of the linear model
tab_model(m_linear_2)
```

<table style="border-collapse:collapse; border:none;">
<tr>
<th style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm;  text-align:left; ">&nbsp;</th>
<th colspan="3" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">percentage earned</th>
</tr>
<tr>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  text-align:left; ">Predictors</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">Estimates</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">CI</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">p</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">(Intercept)</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.76</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.75&nbsp;&ndash;&nbsp;0.77</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">TimeSpent_std</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-0.00</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-0.01&nbsp;&ndash;&nbsp;0.00</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.364</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm; border-top:1px solid;">Observations</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="3">598</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">R<sup>2</sup> / R<sup>2</sup> adjusted</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="3">0.001 / -0.000</td>
</tr>

</table>

That seems to make more sense. However, there is a different interpretation
now for the time spent variable: for every one standard deviation increase in
the amount of time spent on the course, the percentage of points a student earns
increases by .11, or 11 percentage points.

## Results

Let's extend our regression model and consider the following to be the final
model in this sequence of models: What other variables may matter? Perhaps there
are differences based on the subject of the course. We can add subject as a
variable easily, as follows:


```r
# a linear model with the subject added 
# independent variables, such as TimeSpent_std and subject, can simply be separated with a plus symbol:
m_linear_3 <- 
  lm(percentage_earned ~ TimeSpent_std + subject, data = dat)
```

We can use `tab_model()` once again to view the results:


```r
tab_model(m_linear_3)
```

<table style="border-collapse:collapse; border:none;">
<tr>
<th style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm;  text-align:left; ">&nbsp;</th>
<th colspan="3" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">percentage earned</th>
</tr>
<tr>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  text-align:left; ">Predictors</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">Estimates</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">CI</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">p</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">(Intercept)</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.75</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.74&nbsp;&ndash;&nbsp;0.77</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">TimeSpent_std</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-0.00</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-0.01&nbsp;&ndash;&nbsp;0.00</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.346</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">subject [BioA]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-0.00</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-0.03&nbsp;&ndash;&nbsp;0.03</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.872</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">subject [FrScA]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.00</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-0.02&nbsp;&ndash;&nbsp;0.02</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.766</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">subject [OcnA]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.02</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-0.00&nbsp;&ndash;&nbsp;0.04</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.094</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">subject [PhysA]</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.00</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-0.03&nbsp;&ndash;&nbsp;0.03</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.900</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm; border-top:1px solid;">Observations</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="3">598</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">R<sup>2</sup> / R<sup>2</sup> adjusted</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="3">0.008 / -0.001</td>
</tr>

</table>

It looks like subject `FrSc` - forensic science - and subject `Ocn` -
oceanography - are associated with a higher percentage of points earned,
overall. This indicates that students in those two classes earned higher grades
than students in other science classes in this dataset.

## Conclusion

In this walkthrough, we focused on taking unprocessed, or raw data, and loading,
viewing, and then processing it through a series of steps. The result was a data
set which we could use to create visualizations and a simple (but powerful!)
model, a linear model, also known as a regression model. We found that the time
that students spent on the course was positively (and statistically
significantly) related to students' final grades, and that there appeared to be
differences by subject. While we focused on using this model in a traditional,
explanatory sense, it could also (potentially) be used for predictive analytics, in that
knowing how long students spent on the course and what subject their course is
could be used to estimate what that students' final grade might be. We focus on uses of predictive models further in [Chapter 14](#c14).

In the follow-up to this walkthrough (see [Chapter 13](#c13)), we will
focus on visualizing and then modeling the data using an advanced methodological
technique, multi-level models, using the data we prepared as a part of this data
processing pipeline used in this chapter.


