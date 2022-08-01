# Walkthrough 5: text analysis with social media data {#c11}

**Abstract**

This chapter explores tidying, transforming, visualizing, and analyzing text data. Data scientists in education are surrounded by text-based data sources like word processing documents, emails, and survey responses. Data scientists in education can expand their opportunities to learn about the student experience by adding text mining and natural language processing to their toolkit. Using Twitter data, this chapter shows the reader practical tools for text analysis, including preparing text data, counting and visualizing words, and doing sentiment analysis. The chapter uses Tweets from #tidytuesday, an R learning community, to put these techniques in an education context. Data science tools in this chapter include transforming text into data frames, filtering datasets for keywords, running sentiment analysis and algorithms, and visualizing data.


## Topics emphasized

- Tidying data 
- Transforming data
- Visualizing data

## Functions introduced

- `sample_n()`
- `set.seed()`
- `tidytext::unnest_tokens()`
- `nrc::get_sentiments()`
- `tidytext::inner_join()`

## Functions introduced in the appendix

- `readr::read_delim()`
- `rtweet::lookup_statuses()`

## Vocabulary 

- RDS files 
- Text analysis
- Stop words
- Tokenize 

## Chapter overview

The ability to work with many kinds of datasets is one of the great features of doing data science with programming. So far we've analyzed data in `.csv` files, but that's not the only way data is stored. If we can learn some basic techniques for analyzing text, we increase the number of places we can find information to learn about the student experience.

In this chapter, we focus on analyzing textual data from Twitter. We focus on this particular data *source* because we think it is relevant to a number of educational topics and questions, including how newcomers learn to visualize data. In addition, Twitter data is complex and includes not only information about who posted a tweet (and when---and a great deal of additional information (see [@R-rtweet])), but also the text of the tweet. This makes it especially well-suited for exploring the uses of text analysis, which is broadly part of a group of techniques involving the analysis of text as data---Natural Language Processing (often abbreviated NLP) [@hirschberg2015].

We note that while we focused on #tidytuesday because we think it exemplifies the new kinds of learning-related data that a data science toolkit allows an analyst to try to understand, we also chose this because it is straightforward to access data from Twitter, and - due to the presence of an interactive Shiny application - because it is particularly easy to access data on #tidytuesday. While this chapter dives deeply into the analysis of the *text* of tweets, [Appendix B](#c20b) elaborates on a number of techniques for accessing data from Twitter - including data from #tidytuesday - and [Chapter 12](#c12) explores the nature of the interactions that take place between individuals through #tidytuesday.

### Background 

When we think about data science in education, our minds tends to go data stored in spreadsheets. But what can we learn about the student experience from text data? Take a moment to mentally review all the moments in your work day that you generated or consumed text data. In education, we're surrounded by it. We do our lessons in word processor documents, our students submit assignments online, and the school community expresses themselves on public social media platforms. The text we generate can be an authentic reflection of reality in schools, so how might we learn from it?

Even the most basic text analysis techniques will expand your data science toolkit. For example, you can use text analysis to count the number of key words that appear in open ended survey responses. You can analyze word patterns in student responses or message board posts. 

Analyzing a collection of text is different from analyzing large numerical datasets because words don't have agreed upon values the way numbers do. The number 2 will always be more than 1 and less than 3. The word "fantastic," on the other hand, has multiple ambiguous levels of degree depending on interpretation and context. 

Using text analysis can help to broadly estimate what is happening in the text. When paired with observations, interviews, and close review of the text, this approach can help education staff learn from text data. In this chapter, we'll learn how to count the frequency of words in a dataset and associate those words with common feelings like positivity or joy. 

We'll show these techniques using a dataset of tweets. We encourage you to complete the walkthrough, then reflect on how the skills learned can be applied to other texts, like word processing documents or websites.  

### Data Source

It's useful to learn text analysis techniques from datasets that are available for download. Take a moment to do an online search for "download tweet dataset" and note the abundance of Twitter datasets available. Since there's so much, it's useful to narrow the tweets to only those that help you answer your analytic questions. Hashtags are text within a tweet that act as a way to categorize content. Here's an example: 

>RT \@CKVanPay: I'm trying to recreate some Stata code in R, anyone have a good resource for what certain functions in Stata are doing? #RStats #Stata 

Twitter recognizes any words that start with a "#" as a hashtag. The hashtags "#RStats" and "#Stata" make this tweet conveniently searchable. If Twitter uses search for "#RStats", Twitter returns all the Tweets containing that hashtag.

In this example, we'll be analyzing a dataset of tweets that have the hashtag #tidytuesday (https://twitter.com/hashtag/tidytuesday). #tidytuesday is a community sparked by the work of one of the *Data Science in Education Using R* co-authors, Jesse Mostipak, who created the (related) #r4ds community from which #tidytuesday was created. #tidytuesday is a weekly data visualization challenge. A great place to see examples from past #tidytuesday challenges is an interactive Shiny application (https://github.com/nsgrantham/tidytuesdayrocks). 

The #tidytuesday hashtag (search Twitter for the hashtag, or see the results here: http://bit.ly/tidytuesday-search) returns tweets about the weekly TidyTuesday practice, where folks learning R create and tweet data visualizations they made while learning to use tidyverse R packages. 

### Methods 

In this walkthrough, we'll be learning how to count words in a text dataset. We'll also use a technique called sentiment analysis to count and visualize the appearance of words that have a positive association. Lastly, we'll learn how to get more context by selecting random rows of tweets for closer reading.

## Load Packages 

For this analysis, we'll be using the {tidyverse}, {here}, and {dataedu} packages. We will also use the {tidytext} package for working with textual data [@R-tidytext]. As it has not been used previously in the book, you may need to install the {tidytext} package (and - if you haven't just yet - the other packages), first. 
For instructions on and an overview about installing packages, see the [Packages section](#c06p) of the [Foundational Skills](#c06) chapter. 

Let's load our packages before moving on to import the data: 


```r
library(tidyverse)
library(here)
library(dataedu)
library(tidytext)
```

## Import Data

Let's start by getting the data into our environment so we can start analyzing it. In [Chapter 12](#c12) and in [Appendix B](#c20b), we describe how we accessed this data through Twitter's Application Programming Interface, or API (and how you can access data from Twitter on other hashtags or terms, too). 

We've included the raw dataset of TidyTuesday tweets in the {dataedu} package. You can see the dataset by typing `tt_tweets`. Let's start by assigning the name `raw_tweets` to this dataset:


```r
raw_tweets <- dataedu::tt_tweets
```

## View Data 

Let's return to our `raw_tweets` dataset. Run `glimpse(raw_tweets)` and notice the number of variables in this dataset. It's good practice to use functions like `glimpse()` or `str()` to look at the data type of each variable. For this walkthrough, we won't need all 90 variables so let's clean the dataset and keep only the ones we want. 

## Process Data

In this section we'll select the columns we need for our analysis and we'll transform the dataset so each row represents a word. After that, our dataset will be ready for exploring. 

First, let's use `select()` to pick the two columns we'll need: `status_id` and `text`. `status_id` will help us associate interesting words with a particular tweet and `text` will give us the text from that tweet. We'll also change `status_id` to the character data type since it's meant to label tweets and doesn't actually represent a numerical value. 


```r
tweets <-
  raw_tweets %>%
  #filter for English tweets
  filter(lang == "en") %>%
  select(status_id, text) %>%
  # Convert the ID field to the character data type
  mutate(status_id = as.character(status_id))
```

Now the dataset has a column to identify each tweet and a column that shows the text that users tweeted. But each row has the entire tweet in the `text` variable, which makes it hard to analyze. If we kept our dataset like this, we'd need to use functions on each row to do something like count the number of times the word "good" appears. We can count words more efficiently if each row represented a single word. Splitting sentences in a row into single words in a row is called "tokenizing." In their book *Text Mining With R*, @silge2017text describe tokens this way: 

>A token is a meaningful unit of text, such as a word, that we are interested in using for analysis, and tokenization is the process of splitting text into tokens. This one-token-per-row structure is in contrast to the ways text is often stored in current analyses, perhaps as strings or in a document-term matrix.

Let's use `unnest_tokens()` from the {tidytext} package to take our dataset of tweets and transform it into a dataset of words. 


```r
tokens <- 
  tweets %>%
  unnest_tokens(output = word, input = text)

tokens 
```

```
## # A tibble: 131,232 × 2
##    status_id           word       
##    <chr>               <chr>      
##  1 1163154266065735680 first      
##  2 1163154266065735680 tidytuesday
##  3 1163154266065735680 submission 
##  4 1163154266065735680 roman      
##  5 1163154266065735680 emperors   
##  6 1163154266065735680 and        
##  7 1163154266065735680 their      
##  8 1163154266065735680 rise       
##  9 1163154266065735680 to         
## 10 1163154266065735680 power      
## # … with 131,222 more rows
```

We use `output = word` to tell `unnest_tokens()` that we want our column of tokens to be called `word`. We use `input = text` to tell `unnest_tokens()` to tokenize the tweets in the `text` column of our `tweets` dataset. The result is a new dataset where each row has a single word in the `word` column and a unique ID in the `status_id` column that tells us which tweet the word appears in. 

Notice that our `tokens` dataset has many more rows than our `tweets` dataset. This tells us a lot about how `unnest_tokens()` works. In the `tweets` dataset, each row has an entire tweet and its unique ID. Since that unique ID is assigned to the entire tweet, each unique ID only appears once in the dataset. When we used `unnest_tokens()` put each word on its own row, we broke each tweet into many words. This created additional rows in the dataset. And since each word in a single tweet shares the same ID for that tweet, an ID now appears multiple times in our new dataset. 

We're almost ready to start analyzing the dataset! There's one more step we'll take--removing common words that don't help us learn about what people are tweeting about. Words like "the" or "a" are in a category of words called "stop words". Stop words serve a function in verbal communication, but don't tell us much on their own. As a result, they clutter our dataset of useful words and make it harder to manage the volume of words we want to analyze. The {tidytext} package includes a dataset called `stop_words` that we'll use to remove rows containing stop words. We'll use `anti_join`() on our `tokens` dataset and the `stop_words` dataset to keep only rows that have words *not* appearing in the `stop_words` dataset. 


```r
data(stop_words)

tokens <-
  tokens %>%
  anti_join(stop_words, by = "word")
```

Why does this work? Let's look closer. `inner_join()` matches the observations in one dataset to another by a specified common variable. Any rows that don't have a match get dropped from the resulting dataset. `anti_join()` does the same thing as `inner_join()` except it drops matching rows and keeps the rows that *don't* match. This is convenient for our analysis because we want to remove rows from `tokens` that contain words in the `stop_words` dataset. When we call `anti_join()`, we're left with rows that *don't* match words in the `stop_words` dataset. These remaining words are the ones we'll be analyzing.

One final note before we start counting words: Remember when we first tokenized our dataset and we passed `unnest_tokens()` the argument `output = word`? We conveniently chose `word` as our column name because it matches the column name `word` in the `stop_words` dataset. This makes our call to `anti_join()` simpler because `anti_join()` knows to look for the column named `word` in each dataset. 

## Analysis: Counting Words 

Now it's time to start exploring our newly cleaned dataset of tweets. Computing the frequency of each word and seeing which words showed up the most often is a good start. We can pipe `tokens` to the `count` function to do this: 


```r
tokens %>% 
    count(word, sort = TRUE) 
```

```
## # A tibble: 15,334 × 2
##    word            n
##    <chr>       <int>
##  1 t.co         5432
##  2 https        5406
##  3 tidytuesday  4316
##  4 rstats       1748
##  5 data         1105
##  6 code          988
##  7 week          868
##  8 r4ds          675
##  9 dataviz       607
## 10 time          494
## # … with 15,324 more rows
```

We pass `count()` the argument `sort = TRUE` to sort the `n` variable from the highest value to the lowest value. This makes it easy to see the most frequently occurring words at the top. Not surprisingly, "tidytuesday" was the third most frequent word in this dataset. 

We may want to explore further by showing the frequency of words as a percent of the whole dataset. Calculating percentages like this is useful in a lot of education scenarios because it helps us make comparisons across different sized groups. For example, you may want to calculate what percentage of students in each classroom receive special education services. 

In our tweets dataset, we'll be calculating the count of words as a percentage of all tweets. We can do that by using `mutate()` to add a column called `percent`. `percent` will divide `n` by `sum(n)`, which is the total number of words. Finally, will multiply the result by 100.


```r
tokens %>%
  count(word, sort = TRUE) %>%
  # n as a percent of total words
  mutate(percent = n / sum(n) * 100)
```

```
## # A tibble: 15,334 × 3
##    word            n percent
##    <chr>       <int>   <dbl>
##  1 t.co         5432   7.39 
##  2 https        5406   7.36 
##  3 tidytuesday  4316   5.87 
##  4 rstats       1748   2.38 
##  5 data         1105   1.50 
##  6 code          988   1.34 
##  7 week          868   1.18 
##  8 r4ds          675   0.919
##  9 dataviz       607   0.826
## 10 time          494   0.672
## # … with 15,324 more rows
```

Even at 4316 appearances in our dataset, "tidytuesday" represents only about 6 percent of the total words in our dataset. This makes sense when you consider our dataset contains 15335 unique words. 

## Analysis: Sentiment Analysis

Now that we have a sense of the most frequently appearing words, it's time to explore some questions in our tweets dataset. Let's imagine that we're education consultants trying to learn about the community surrounding the TidyTuesday data visualization ritual. We know from the first part of our analysis that the token "dataviz" (a short name for data visualization) appeared frequently relative to other words, so maybe we can explore that further. A good start would be to see how the appearance of that token in a tweet is associated with other positive words. 

We'll need to use a technique called sentiment analysis to get at the "positivity" of words in these tweets. Sentiment analysis tries to evaluate words for their emotional association. If we analyze words by the emotions they convey, we can start to explore patterns in large text datasets like our `tokens` data. 

Earlier we used `anti_join()` to remove stop words in our dataset. We're going to do something similar here to reduce our `tokens` dataset to only words that have a positive association. We'll use a dataset called the NRC Word-Emotion Association Lexicon to help us identify words with a positive association. This dataset was published in a work called Crowdsourcing a Word-Emotion Association Lexicon [@mohammad2013]

We need to install a package called {textdata} to make sure we have the NRC Word-Emotion Association Lexicon dataset available to us. Note that you only need to have this package installed. You do not need to load it with the `library(textdata)` command. 

If you don't already have it, let's install {textdata}: 


```r
install.packages("textdata")
```

To explore this dataset more, we'll use a {tidytext} function called `get_sentiments()` to view some words and their associated sentiment. If this is your first time using the NRC Word-Emotion Association Lexicon, you'll be prompted to download the NRC lexicon. Respond "yes" to the prompt and the NRC lexicon will download. Note that you'll only have to do this the first time you use the NRC lexicon. 































