# Walkthrough 3: Using School-Level Aggregate Data to Illuminate Educational Inequities {#c09}

## Topics Emphasized

- Importing data
- Tidying data 
- Transforming data
- Visualizing data

## Functions Introduced

- `dplyr::mutate_at() `
- `readRDS()`
- `purrr::map` and `purrr::map_df()`
- `purrr::set_names()`
- `dplyr::slice()`

## Vocabulary

* aggregate data
* disaggregated data
* data frame
* Free/Reduced Price Lunch (FRPL)
* histogram
* lists
* subgroup
* trim
* weighted average

## Chapter Overview

Data scientists working in education don't always have access to student level
data, so knowing how to model aggregate datasets is very valuable. This chapter explores what aggregate data is, and how to access, clean, and explore it. It is a "companion" to the 
following chapter, [Chapter 10](#c10), which also explores aggregate data, but does so with an emphasis on longitudinal analyses, or analyses that involve data at more than one time point.

### Background

A common situation encountered when searching for education data, particularly
by analysts who are not directly working with schools or districts, is the
prevalence of publicly available, *aggregate* data. Aggregate data refers to
numerical information (or non-numerical information, such as the names of districts or schools) that has the following characteristics:

1.  collected from multiple sources and/or on multiple measures, variables, or
    individuals and
2.  compiled into data summaries or summary reports, typically for the purposes
    of public reporting or statistical analysis [@greatschools2014]

Examples of publicly available aggregate data include school-level graduation
rates, state test proficiency scores by grade and subject, or mean survey
responses. In this walkthrough, we explore the role of aggregate data, with a
focus on educational equity.

Aggregate data is essential both for accountability purposes and for providing
useful information about schools and districts to those who are monitoring them.
For example, district administrators might aggregate row-level (also known as
individual-level or student-level) enrollment reports over time. This allows
them to see how many students enroll in each school, in the district overall,
and any grade-level variation. Depending on their state, the district
administrator might submit these aggregate data to their state education agency (SEA)
for reporting purposes. These datasets might be posted on the state's department
of education website for anyone to download and use.

Federal and international education datasets provide additional information. In the US, some federal datasets aim to
consolidate important metrics from all states. This can be useful because
each state has its own repository of data and to go through each state website to
download a particular metric is a significant effort. The federal government
also funds assessments and surveys which are disseminated to the public.
However, federal datasets often have more stringent data requirements than
the states, so the datasets may be less usable.

For data scientists in education, these reports and datasets can be analyzed to
answer questions related to their field of interest. However, doing so is not always straightforward.
Publicly available, aggregate datasets are large and often suppressed to protect privacy.
Sometimes they are already a couple of years old by the time they're released.
Because of their coarseness, they can be difficult to interpret and use.
Generally, aggregate data is used to surface broader trends and
patterns in education as opposed to diagnosing underlying issues or making
causal statements. It is very important that we consider the limitations of
aggregate data *first* before analyzing it.

Analysis of aggregate data can help us identify patterns that may not have
previously been known. When we have gained new insight, we can create research
questions, craft hypotheses around our findings, and make recommendations on how
to improve for the future.

We want to take time to explore aggregate data since it's so common
in education but can also be challenging to meaningfully used. This chapter and the [following chapter](#c10) provide two different examples of
cleaning an aggregate dataset and of using aggregate
datasets to compare student experiences. In this chapter, we'll focus on
educational equity by identifying and comparing patterns in student demographic groups. In the next chapter, we'll compare student counts longitudinally (or over time) in different states.

**What is the Difference Between Aggregate and Student-Level Data?**

Let's dig a little deeper into the differences between aggregate and
student-level data. Publicly available data - like the data we'll use in this
walkthrough - is a summary of student-level data. That means that student-level
data is totaled to protect the identities of students before making the data
publicly available. We can use R to demonstrate this concept.

Here are rows in a student-level dataset:


```r
library(tidyverse)

# Create student-level data 
tibble(
  student = letters[1:10],
  school = rep(letters[11:15], 2),
  test_score = sample(0:100, 10, replace = TRUE)
)
```

```
## # A tibble: 10 x 3
##    student school test_score
##    <chr>   <chr>       <int>
##  1 a       k              96
##  2 b       l              36
##  3 c       m               4
##  4 d       n              76
##  5 e       o              51
##  6 f       k              83
##  7 g       l              37
##  8 h       m              63
##  9 i       n               8
## 10 j       o              19
```

Aggregate data totals up a variable - the variable `test_score` in this case - to
"hide" the student-level information. The rows of the resulting dataset
represent a group. The group in our example is the `school` variable:


```r
tibble(
  student = letters[1:10],
  school = rep(letters[11:15], 2),
  test_score = sample(0:100, 10, replace = TRUE)
) %>%
  # Aggregate by school
  group_by(school) %>%
  summarize(mean_score = mean(test_score))
```

```
## # A tibble: 5 x 2
##   school mean_score
## * <chr>       <dbl>
## 1 k            54  
## 2 l            51.5
## 3 m            24  
## 4 n            44.5
## 5 o            37
```

Notice here that this dataset no longer identifies individual students.

**Disaggregating Aggregated Data**

Aggregated data can tell us many things, but in order for us to better examine
subgroups (groups that share similar characteristics), we must have data *disaggregated* by the
subgroups we hope to analyze. This data is still aggregated from row-level data
but provides information on smaller components than the grand total
[@disaggregate]. Common disaggregations for students include gender,
race/ethnicity, socioeconomic status, English learner designation, and whether
they are served under the Individuals with Disabilities Education Act (IDEA) [@subgroup].

**Disaggregating Data and Equity**

Disaggregated data is essential to monitor equity in educational resources and
outcomes. If only aggregate data is provided, we are unable to distinguish how
different groups of students are doing and what support they need. With
disaggregated data, we can identify where solutions are needed to solve
disparities in opportunity, resources, and treatment.

It is important to define what equity means to your team so you know whether you
are meeting your equity goals.

## Data Sources

There are many publicly available aggregate datasets related to education. On the
international level, perhaps the most well-known is PISA:

  - [Programme for International Student Assessment
    (PISA)](http://www.oecd.org/pisa/) (http[]()://www.oecd.org/pisa/), which
    measures 15-year-old school pupils' scholastic performance on mathematics,
    science, and reading.

On the federal level, well-known examples include:

  - [Civil Rights Data Collection
    (CRDC)](https://www2.ed.gov/about/offices/list/ocr/data.html)
    (https[]()://www2.ed.gov/about/offices/list/ocr/data.html), which reports
    many different variables on educational program and services disaggregated
    by race/ethnicity, sex, limited English proficiency, and disability. These
    data are school-level.

  - [Common Core of Data (CCD)](https://nces.ed.gov/ccd/)
    (https[]()://www2.ed.gov/about/offices/list/ocr/data.html), which is the
    U.S. Department of Education's primary database on public elementary and
    secondary education.

  - [EdFacts](https://www2.ed.gov/about/inits/ed/edfacts/data-files/index.html)
    (https[]()://www2.ed.gov/about/inits/ed/edfacts/data-files/index.html),
    which includes state assessments and adjusted cohort graduation rates. These
    data are school- and district-level.

  - [Integrated Postsecondary Education Data System
    (IPEDS)](https://nces.ed.gov/ipeds/) (https[]()://nces.ed.gov/ipeds/), which
    is the U.S. Department of Education's primary database on postsecondary
    education.

  - [National Assessment for Educational Progress (NAEP)
    Data](https://nces.ed.gov/nationsreportcard/researchcenter/datatools.aspx)
    (https[]()://nces.ed.gov/nationsreportcard/researchcenter/datatools.aspx),
    which is an assessment of educational progress in the United States. Often called the
    "nation's report card," the NAEP reading and mathematics assessments are
    administered to a representative sample of fourth- and eighth-grade students
    in each state every two years.

At the state and district levels, two examples include:

  - [California Department of Education](https://www.cde.ca.gov/ds/)
    (https[]()://www.cde.ca.gov/ds/), which is the state department of education
    website. It includes both downloadable CSV files and "Data Quest", which
    lets you query the data online.

  - [Minneapolis Public Schools](https://mpls.k12.mn.us/reports_and_data)
    (https[]()://mpls.k12.mn.us/reports\_and\_data), which is a district-level
    website with datasets beyond those listed in the state website.

**Selecting Data**

For the purposes of this walkthrough, we will be looking at a particular school
district's data; in the next, we will "zoom out" to look across states in the United States.

The district we focus on here reports their student demographics in a robust,
complete way. Not only do they report the percentage of students in a subgroup,
but they also include the number of students in each subgroup. This allows a
deep look into their individual school demographics. Their reporting of the
composition of their schools provides an excellent opportunity to explore
inequities in a system.

### Methods

In this chapter, we will walk through how running analyses on data from a single district can help education data practitioners *to understand and describe the landscape
of needs and opportunities* present there. As opposed to causal
analyses, which aim to assess the root cause of an phenomenon or the effects of
an intervention, we use descriptive analysis on an aggregate dataset to find out whether
there *is* a phenomenon present, *what* it is, and *what* may be worth trying to address through future
supports, reforms, or interventions [@descriptive].

## Load Packages

As usual, we begin our code by calling the packages we will use. If you have not installed any of these packages yet, see the [Packages section](#c06p) of the [Foundational Skills](#c06) chapter). Load the libraries, as they must be loaded each time we start a new project.


```r
library(tidyverse)
library(here)
library(janitor)
library(dataedu)
```

ROpenSci created the [{tabulizer}](https://github.com/ropensci/tabulizer)
(https[]()://github.com/ropensci/tabulizer) package [@R-tabulizer] which provides R bindings to
the Tabula java library, which can be used to computationally extract tables
from PDF documents. {rJava} [@R-rJava] is a required package to load {tabulizer}.
Unfortunately, installing {rJava} can be very tedious. 

If you find yourself unable to install {rJava}, or would like to go straight to the data processing, you can skip the steps requiring {tabulizer}. We provide the raw and processed data in the {dataedu} package below.


```r
library(tabulizer)
```

## Import Data

We have three options of getting the data:

1. We can use {tabulizer}, which pulls the PDF data into lists using `extract_tables()`.
2. We can get the data from the book's [Github repository ](https://github.com/data-edu/data-science-in-education/tree/master/data/agg_data)(https[]()://github.com/data-edu/data-science-in-education/tree/master/data/agg_data). If you set up the folders in your working directory in the same way they are in the book, where there's a folder called `data`, then a folder called `agg_data` inside of `data`, then the file `race_pdf.Rds` in `agg_data`, then you can run the code below and load the data using `here()`. Otherwise, you will have to change the file path inside of `here()` to match where the data is stored on your working directory.
3. Finally, you can get the data from the {dataedu} package.


```r
# Get data using {tabulizer}
race_pdf <-
  extract_tables("https://studentaccounting.mpls.k12.mn.us/uploads/mps_fall2018_racial_ethnic_by_school_by_grade.pdf")

# Get data from book repository
# The code below assumes you have set up folders data and agg_data within your working directory
race_pdf <-
  readRDS(here("data", "agg_data", "race_pdf.Rds"))

# Get data using {dataedu}
race_pdf <-
  dataedu::race_pdf
```

We then transform the list to a data frame by first making the matrix version of the PDF's into a tibble by using `map(as_tibble())`. Then, we use the `map_df()` function then turns these tibbles into a single data frame. The `slice()` inside of `map_df()` removes unnecessary rows from the tibbles. Finally, we create readable column names using `set_names()` (otherwise, they look like `...1`, `...2`, etc.).


```r
race_df <-
  race_pdf %>%
  # Turn each page into a tibble
  map(~ as_tibble(.x, .name_repair = "unique")) %>% 
  # Make data frame and remove unnecessary rows
  map_df(~ slice(.,-1:-2)) %>%
  # Use descriptive column names
  set_names(
    c(
      "school_group",
      "school_name",
      "grade",
      "na_num", # Native American number of students
      "na_pct", # Native American percentage of students
      "aa_num", # African American number of students
      "aa_pct", # African American percentage
      "as_num", # Asian number of students
      "as_pct", # Asian percentage
      "hi_num", # Hispanic number of students
      "hi_pct", # Hispanic percentage
      "wh_num", # White number of students
      "wh_pct", # White percentage
      "pi_pct", # Pacific Islander percentage
      "blank_col",
      "tot" # Total number of students (from the Race PDF)
    )
  )
```

For the Race/Ethnicity table, we want the totals for each district school as we
won't be looking at grade-level variation. When analyzing the PDF, we see the
school totals have "Total" in `school_name`.

We clean up this dataset by:

1.  Removing unnecessary or blank columns using `select()`. Negative selections
    means those columns will be removed.
2.  Removing all Grand Total rows (otherwise they'll show up in our data when
    we just want district-level data) using `filter()`. We keep schools that
    have "Total" in the name but remove any rows that are Grand Total.
3.  Then we trim white space from strings using `trimws()`.
4.  The data in the `percentage` columns are provided with a percentage sign. This means `percentage` was read in as a character. We will have to remove all of the non-numeric characters to be able to do math with these columns (for example, to add them together). Also, we want to divide the numbers by 100 so they are in decimal format.

Let's break this line down: `mutate_at(vars(contains("pct")), list( ~ as.numeric(str_replace(., "%", "")) / 100))`. We are telling `mutate_at()` to:

* Select the columns whose names contain the string "pct" by using `vars(contains("pct"))`.
* For the rows in those columns, replace the character "%" with blanks "" by using `str_replace(., "%", "")`.
* After doing that, make those rows numeric by using `as.numeric()`.
* Then, divide those numbers by 100 using `/100`.


```r
race_df2 <-
  race_df %>%
  # Remove unnecessary columns
  select(-school_group, -grade, -pi_pct, -blank_col) %>%
  # Filter to get grade-level numbers
  filter(str_detect(school_name, "Total"),
         school_name != "Grand Total") %>%
  # Clean up school names
  mutate(school_name = str_replace(school_name, "Total", "")) %>%
  # Remove white space
  mutate_if(is.character, trimws) %>%
  # Turn percentage columns into numeric and decimal format
  mutate_at(vars(contains("pct")), list( ~ as.numeric(str_replace(., "%", "")) / 100))
```

Now, we will import the Free Reduced Price Lunch (FRPL) PDF's.

FRPL stands for Free/Reduced Price Lunch and is often used as a proxy for poverty [@frpl]. Students from a household with an income up to 185 percent of the poverty threshold are eligible for free or reduced price lunch. (Sidenote: definitions are very important for disaggregated data. FRPL is used because it’s ubiquitous but there is debate as to whether it actually reflects the level of poverty among students.)


```r
# Get data using {tabulizer}
frpl_pdf <-
  extract_tables("https://studentaccounting.mpls.k12.mn.us/uploads/fall_2018_meal_eligiblity_official.pdf")

# Get data from book repository
frpl_pdf <-
  readRDS(here("data", "agg_data", "frpl_pdf.Rds"))

# Get data using {dataedu}
frpl_pdf <-
  dataedu::frpl_pdf
```

Similar to the Race/Ethnicity PDF, we take the PDF matrix output, turn it into tibbles, then create a single data frame. There are rows that we don't need from each page, which we remove using `slice()`. Then, we create column names that can be easily understood.


```r
frpl_df <-
  frpl_pdf %>%
  # Turn each page into a tibble
  map(~ as_tibble(.x, .name_repair = "unique")) %>% 
  # Make data frame and remove unnecessary rows
  map_df( ~ slice(.,-1)) %>%
  # Use descriptive column names
  set_names(
    c(
      "school_name",
      "not_eligible_num", # Number of non-eligible students,
      "reduce_num", # Number of students receiving reduced price lunch
      "free_num",   # Number of students receiving free lunch
      "frpl_num",  # Total number of students (from the FRPL PDF)
      "frpl_pct" # Free/reduced price lunch percentage
    )
  )
```

To clean the dataset up further, we remove the rows that are blank. When looking at the PDF, we
notice that there are aggregations inserted into the table that are not
district-level. For example, the report includes `ELM K_08`, presumably to
aggregate FRPL numbers up to the K-8 level. Although this is useful data, we
don't need it for this district-level analysis. There are different ways we can
remove these rows but we will just filter them out by using `!` before the variable name.


```r
frpl_df2 <-
  frpl_df %>%
  filter(
    # Remove blanks
    school_name != "",
    # Filter out the rows in this list
    !school_name %in% c(
      "ELM K_08",
      "Mid Schl",
      "High Schl",
      "Alt HS",
      "Spec Ed Total",
      "Cont Alt Total",
      "Hospital Sites Total",
      "Dist Total"
    )
  ) %>%
  # Turn percentage columns into numeric and decimal format
  mutate(frpl_pct = as.numeric(str_replace(frpl_pct, "%", "")) / 100)
```

Because we want to look at race/ethnicity data in conjunction with free/reduced
price lunch percentage, we join the two datasets by the name of the school. We want our student counts and percentages to be numeric, so apply `as.numeric` to multiple columns using `mutate_at()`.


```r
# create full dataset, joined by school name
joined_df <-
  left_join(race_df2, frpl_df2, by = c("school_name")) %>%
  mutate_at(2:17, as.numeric)
```

**Did you notice?** The total number of students from the Race/Ethnicity table does **not** match the total number of students from the FRPL table, even though they're referring to the same districts in the same year. Why? Perhaps the two datasets were created by different people, who used different rules when aggregating the dataset. Perhaps the counts were taken at different times of the year, and students may have moved around in the meantime. We don't know but it does require us to make strategic decisions about which data we consider the 'truth' for our analysis.

Now we move on to the fun part of creating new columns based on the merged
dataset using `mutate()`.

1.  We want to calculate, for each race, the number of students in 'high
    poverty' schools. This is defined by NCES as schools that are over 75% FRPL
    [@ncesfrpl]. When a school is over 75% FRPL, we count the number of students
    for that particular race under the variable `[racename]_povnum`.
2.  The {janitor} package has a handy `adorn_totals()` function that sums
    columns for you. This is important because we want a weighted average of
    students in each category, so we need the total number of students in each
    group.
3.  We create the weighted average of the percentage of each race by dividing
    the number of students by race by the total number of students.
4.  To get FRPL percentage for all schools, we have to recalculate `frpl_pct` (otherwise, it would not be a weighted average).
5.  To calculate the percentage of students by race who are in high poverty
    schools, we must divide the number of students in high poverty schools by
    the total number of students in that race.


```r
district_merged_df <-
  joined_df %>%
  # Calculate high poverty numbers
  mutate(
    hi_povnum = case_when(frpl_pct > .75 ~ hi_num),
    aa_povnum = case_when(frpl_pct > .75 ~ aa_num),
    wh_povnum = case_when(frpl_pct > .75 ~ wh_num),
    as_povnum = case_when(frpl_pct > .75 ~ as_num),
    na_povnum = case_when(frpl_pct > .75 ~ na_num)
  ) %>%
  adorn_totals() %>%
  # Create percentage by demographic
  mutate(
    na_pct = na_num / tot,
    aa_pct = aa_num / tot,
    as_pct = as_num / tot,
    hi_pct = hi_num / tot,
    wh_pct = wh_num / tot,
    frpl_pct = (free_num + reduce_num) / frpl_num,
    # Create percentage by demographic and poverty
    hi_povsch = hi_povnum / hi_num[which(school_name == "Total")],
    aa_povsch = aa_povnum / aa_num[which(school_name == "Total")],
    as_povsch = as_povnum / as_num[which(school_name == "Total")],
    wh_povsch = wh_povnum / wh_num[which(school_name == "Total")],
    na_povsch = na_povnum / na_num[which(school_name == "Total")]
  )
```

To facilitate the creation of plots later on, we also put this data in tidy format using `pivot_longer()`.


```r
district_tidy_df <-
  district_merged_df %>%
  pivot_longer(
    cols = -matches("school_name"),
    names_to = "category",
    values_to = "value"
  )
```

Running the code above, particularly the download of the PDFs, takes a lot of
time. We've saved copies of the merged and tidy data in the book's Github repository and {dataedu}. To access them, you can run the code below.


```r
# If reading in from book repository
district_tidy_df <-
  read_csv(here("data", "agg_data", "district_tidy_df.csv"))

district_merged_df <-
  read_csv(here("data", "agg_data", "district_merged_df.csv"))

# If using the {dataedu} package
district_tidy_df <- dataedu::district_tidy_df

district_merged_df <- dataedu::district_merged_df
```

## View Data

### Discovering Distributions

What do the racial demographics in this district look like? A barplot
can quickly visualize the different proportion of subgroups.


```r
district_tidy_df %>%
  # Filter for Total rows, since we want district-level information
  filter(school_name == "Total",
         str_detect(category, "pct"),
         category != "frpl_pct") %>%
  # Reordering x-axis so bars appear by descending value
  ggplot(aes(x = reorder(category, -value), y = value)) +
  geom_bar(stat = "identity", aes(fill = category)) +
  labs(title = "Percentage of Population by Subgroup",
       x = "Subgroup",
       y = "Percentage of Population") +
  # Make labels more readable
  scale_x_discrete(
    labels = c(
      "aa_pct" = "Black",
      "wh_pct" = "White",
      "hi_pct" = "Hispanic",
      "as_pct" = "Asian",
      "na_pct" = "Native Am."
    )
  ) +
  # Makes labels present as percentages
  scale_y_continuous(labels = scales::percent) + 
  scale_fill_dataedu() +
  theme_dataedu() +
  theme(legend.position = "none")
```

![(\#fig:fig9-1)Percentage of Population by Subgroup](09-wt-aggregate-data_files/figure-docx/fig9-1-1.png){width=100%}

When we look at these data, the district looks very diverse. Almost **40% of
students are Black** and around **36% are White**. Note that this matches the percentages provided in the original PDF's. This shows our calculations above were accurate. Hooray!

`frpl_pct` is the percentage of the students in the district that are eligible for FRPL.


```r
district_tidy_df %>%
  filter(category == "frpl_pct",
         school_name == "Total")
```

```
## # A tibble: 1 x 3
##   school_name category value
##   <chr>       <chr>    <dbl>
## 1 Total       frpl_pct 0.569
```

**56.9% of the students are eligible for FRPL**, compared to the U.S. average
of 52.1% [@avgfrpl]. This also matches the PDF's. Great!

Now, we dig deeper to see if there is more to the story.

### Analyzing Spread

Another view of the data is visualizing the distribution of students with
different demographics across schools. Here is a histogram for the percentage of
White students within the schools for which we have data.


```r
district_merged_df %>%
  # Remove district totals
  filter(school_name != "Total") %>%
  # X-axis will be the percentage of White students within schools
  ggplot(aes(x = wh_pct)) +
  geom_histogram(breaks = seq(0, 1, by = .1),
                 fill = dataedu_colors("darkblue"))  +
  labs(title = "Count of Schools by White Population",
       x = "White Percentage",
       y = "Count") +
  scale_x_continuous(labels = scales::percent) + 
  theme(legend.position = "none") +
  theme_dataedu()
```

![(\#fig:fig9-2)Count of Schools by White Population](09-wt-aggregate-data_files/figure-docx/fig9-2-1.png){width=100%}

**26 of the 74 (35%) of schools have between 0-10% White students.** This
implies that even though the school district may be diverse, the demographics
are not evenly distributed across the schools. More than half of schools enroll
fewer than 30% of White students even though White students make up 35% of the
district student population.

The school race demographics are not representative of the district populations
but does that hold for socioeconomic status as well?

## Analysis

### Creating Categories

High-poverty schools are defined as public schools where more than 75% of the
students are eligible for FRPL. According to NCES, 24% of public school students
attended high-poverty schools [@ncesfrpl]. However, different subgroups are
overrepresented and underrepresented within the high poverty schools. Is this
the case for this district?


```r
district_tidy_df %>%
  filter(school_name == "Total",
         str_detect(category, "povsch")) %>%
  ggplot(aes(x = reorder(category,-value), y = value)) +
  geom_bar(stat = "identity", aes(fill = factor(category))) +
  labs(title = "Distribution of Subgroups in High Poverty Schools",
       x = "Subgroup",
       y = "Percentage in High Poverty Schools") +
  scale_x_discrete(
    labels = c(
      "aa_povsch" = "Black",
      "wh_povsch" = "White",
      "hi_povsch" = "Hispanic",
      "as_povsch" = "Asian",
      "na_povsch" = "Native Am."
    )
  ) +
  scale_y_continuous(labels = scales::percent) +
  scale_fill_dataedu() +
  theme_dataedu() +
  theme(legend.position = "none")
```

![(\#fig:fig9-3)Distribution of Subgroups in High Poverty Schools](09-wt-aggregate-data_files/figure-docx/fig9-3-1.png){width=100%}

**8% of White students** attend high poverty schools, compared to **43% of Black
students, 39% of Hispanic students, 28% of Asian students, and 45% of Native
American students**. We can conclude that non-White students are disproportionally
attending high poverty schools.

### Reveal Relationships

Let’s explore what happens when we correlate race and FRPL percentage by school.


```r
district_merged_df %>%
  filter(school_name != "Total") %>%
  ggplot(aes(x = wh_pct, y = frpl_pct)) +
  geom_point(color = dataedu_colors("green")) +
  labs(title = "FRPL Percentage vs. White Percentage",
       x = "White Percentage",
       y = "FRPL Percentage") +
  scale_y_continuous(labels = scales::percent) +
  scale_x_continuous(labels = scales::percent) +
  theme_dataedu() +
  theme(legend.position = "none")
```

![(\#fig:fig9-4)FRPL Percentage vs. White Percentage](09-wt-aggregate-data_files/figure-docx/fig9-4-1.png){width=100%}

Similar to the result in Creating Categories, there is a strong negative correlation between FRPL
percentage and the percentage of White students in a school. That is, high
poverty schools appear to have a lower percentage of White students and low poverty
schools have a higher percentage of White students.

## Results

Because of the disaggregated data this district provides, we can go deeper than
the average of demographics across the district and see what it looks like on
the school level. These distinct but closely related views demonstrate that:

1. There exists a distribution of
race/ethnicity within schools that are not representative of the district.
2. Students of color are overrepresented in high poverty schools.
3. There is a negative relationship between the percentage of White students in a
school and the percentage of students eligible for FRPL.

## Conclusion

This analysis, like all analyses, does not occur in a vacuum.  According to the Urban Institute, the disproportionate percentage of students of color attending high poverty schools "is a defining feature of almost all
Midwestern and northeastern metropolitan school systems" [@urbanpov]. Among other
issues, "high poverty schools tend to lack the educational resources - like highly
qualified and experienced teachers, low student-teacher ratios, college
prerequisite and advanced placement courses, and extracurricular
activities - available in low-poverty schools." This has a huge impact on these
students and their futures.

In addition, research shows that racial and socioeconomic diversity in schools
can provide students with a range of cognitive and social benefits. Therefore,
the deep segregation that exists in the district can have adverse effects on
students.

As a data scientist in education, we can use these data to showcase the inequity in a system and suggest interventions
for what we can do to improve the situation in the district. In addition, we can
advocate for more datasets such as these, which allow us to dig deep. In the next chapter, we discuss
aggregate data further, focusing on how we can use them to understand changes over time.
