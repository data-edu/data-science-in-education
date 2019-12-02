# Walkthrough 7: Title Here

# Introduction 

One of the great features of doing data science with programming is the flexibility of data sources. So far we've analyzed data in CSV files, but that's not the only place data is stored. If we can learn some basic techniques for analyzing text, we increase the number of places we can find information to learn about the student experience. 

When we think about data science in education, our mind tends to go data in spreadsheets. But what can we learn about the student experience from text data? Take a moment to mentally review all the moments in your work day that you generated or consumed text data. In education, we're surrounded by it. We do our lessons in word processor documents, our students submit assignments online, and the school community expresses themselves on public social media platforms. The text we generate can be an authentic reflection of reality in schools, so how might we learn from it?

Even the most basic text analysis techniques will expand your data science toolkit. For example, you can use text analysis to count the number of key words that appear in open ended survey responses. You can analyze word patterns in student responses or message board posts. In this chapter, we'll learn how to count the frequency of words in a dataset and associate those words with common feelings like positivity or joy. 

In this chapter we'll learn by using a dataset of tweets. We encourage you to complete the walkthrough, then reflect on how the skills learned can be applied to other texts, like word processing documents or websites.  

# About Our Text Dataset 
It's useful to learn these techniques from text datasets that are widely available. We hope that when you've completed this walkthrough, you will download more tweet datasets and continue to sharpen your text analysis skills. 

Take a moment to do an online search for "download tweet dataset" and note the abundance of tweet datasets are available. Since there's so much, it's useful to narrow the tweets to a dataset that can help you answer your analytic questions. Hashtags text within a tweet that act as way to categorize content. Here's an example: 

>RT @CKVanPay: I'm trying to recreate some Stata code in R, anyone have a good resource for what certain functions in Stata are doing? #RStats #Stata 

Twitter recognizes any words that start with a "#" as a hashtag. The hashtags "#RStats" and "#Stata" make this tweet conveniently searchable. If Twitter uses search for "#RStats", Twitter returns all the Tweets containing that hashtag.

In this example, we'll be analyzing a dataset of tweets. These tweets have the hashtag [#tidytuesday](https://twitter.com/hashtag/tidytuesday), which returns tweets about the tidytuesday ritual, where folks learning R create and upload data visualizations they made while learning to use tidyverse R packages. 

You can view the dataset here: https://docs.google.com/spreadsheets/d/1PdCTF__SIdycIHx1SV5aZjjDIqUdBjITsPLW5yyxwq4/edit#gid=8743918

# Reading In the Data 

We'll need to get the data into our computer and then into R before we can start analyzing it. For this analysis, we'll be using the `tidyverse` and `here` packages. 


```r
library(tidyverse)
```

```
## ── Attaching packages ────────────────────────────────── tidyverse 1.2.1 ──
```

```
## ✔ ggplot2 3.2.1     ✔ purrr   0.3.3
## ✔ tibble  2.1.3     ✔ dplyr   0.8.3
## ✔ tidyr   1.0.0     ✔ stringr 1.4.0
## ✔ readr   1.3.1     ✔ forcats 0.4.0
```

```
## ── Conflicts ───────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
```

```r
library(here)
```

```
## here() starts at /Users/shortessay/data-science-in-education
```


```r
# URL for walkthrough dataset
url <- "https://docs.google.com/spreadsheets/d/e/2PACX-1vSjwBh9-W3VZgHWWuM2NTsruuN1viqdS7oYXN6Q2Ztu-8-IxFjLtLEWCBoQzvzXcp2ddnwgCj_M3JEZ/pub?gid=400689247&single=true&output=csv"

# Download tweet dataset
download.file(url, destfile = here::here("11-walkthrough-7-data", "tweet-data.csv"))
```

There are other ways to get data for a text analyis. You can go to Google Docs and download it directly. To manually download the file, navigate to the data (here: https://docs.google.com/spreadsheets/d/1PdCTF__SIdycIHx1SV5aZjjDIqUdBjITsPLW5yyxwq4/edit#gid=400689247) and then navigate to the **Archive** tab, and then click *File* -> *Download* -> *Comma-separated values* (or *Microsoft Excel*). If you want to collect data under a different hashtag in the future, you can explore services like [TAGS](https://tags.hawksey.info/) to automate that process.

# Reading the data 

Next, you will need to read the data into R. Depending on how you accessed the data, there are a number of ways to do this.

*If* you downloaded the file directly via R (option 1, above), then you can read the data using the same file name (saved to `file_name`) you used above.

Either type the same file name, in quotation marks (e.g., "my_file_name.csv") within the parentheses of `read_csv()` below (or use `file_name` directly and try to figure out what's happening!):


```r
d <- read_csv("data/tweet-data.csv")
```

```
## Parsed with column specification:
## cols(
##   id_str = col_double(),
##   from_user = col_character(),
##   text = col_character(),
##   created_at = col_character(),
##   time = col_character(),
##   geo_coordinates = col_logical(),
##   user_lang = col_logical(),
##   in_reply_to_user_id_str = col_double(),
##   in_reply_to_screen_name = col_character(),
##   from_user_id_str = col_double(),
##   in_reply_to_status_id_str = col_double(),
##   source = col_character(),
##   profile_image_url = col_character(),
##   user_followers_count = col_double(),
##   user_friends_count = col_double(),
##   user_location = col_character(),
##   status_url = col_character(),
##   entities_str = col_character()
## )
```

```r
# Look at structure of the dataset 
glimpse(d)
```

```
## Observations: 233
## Variables: 18
## $ id_str                    <dbl> 1.186400e+18, 1.186395e+18, 1.186390e+…
## $ from_user                 <chr> "Katelenert", "rebeccamclark87", "Zhon…
## $ text                      <chr> "#aect19 https://t.co/1zt9YaUz4W", "Oh…
## $ created_at                <chr> "Mon Oct 21 21:51:45 +0000 2019", "Mon…
## $ time                      <chr> "21/10/2019 22:51:45", "21/10/2019 22:…
## $ geo_coordinates           <lgl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
## $ user_lang                 <lgl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
## $ in_reply_to_user_id_str   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
## $ in_reply_to_screen_name   <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
## $ from_user_id_str          <dbl> 1243927524, 2786357411, 1664133686, 12…
## $ in_reply_to_status_id_str <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
## $ source                    <chr> "<a href=\"http://twitter.com/download…
## $ profile_image_url         <chr> "http://pbs.twimg.com/profile_images/6…
## $ user_followers_count      <dbl> 232, 54, 83, 1199, 3089, 1618, 3089, 3…
## $ user_friends_count        <dbl> 560, 105, 426, 538, 171, 1205, 171, 17…
## $ user_location             <chr> "Charleston, South Carolina", "Blacksb…
## $ status_url                <chr> "http://twitter.com/Katelenert/statuse…
## $ entities_str              <chr> "{\"hashtags\":[{\"text\":\"aect19\",\…
```

*If* you manually downloaded the file (and saved it to the directory you are working in), then it may be helpful to rename the file. Consider naming the file something easy to understand and to type. Then, read the data by typing the file name in quotation marks (e.g., "my_file_name.csv") within the parentheses of `read_csv()` below. 

Note: another option is to use click the name of the file in your 'Files' window and then to click 'Import Dataset'; it is important to copy the code that that wizard generates into a script so that you can re-run your analyses.

If you haven't already, be sure to type `d` into the console (or to run the chunk above) to see what the data looks like. If something doesn't look right, consider what might have gone wrong (when accessing, renaming, or reading the data).

# Preparing the data for the analysis

Text data can be stored a number of ways. We will focus on a common data structure, a document-term matrix. 

The idea that is essential for understanding a document-term matrix is that it is simply a data frame with every term across every document comprising the columns, and every document being represented with each row. 

We will use the **quanteda** R package to create a document term matrix. To do so, we will use the `tokens()` function, which takes as a first argument the column of a data frame with text. An easy way to do this is via the `pull()` function, which returns just one column from a data frame. Pass to `pull()` the name of your data frame and the name of the column `text`, e.g., `pull(my_data_frame, text)`, directly to the tokens function.


```r
tweets <- d %>% 
    select(id_str, text) %>% 
    # Convert the ID field to the character data type
    mutate(id_str = as.character(id_str))
```


```r
install.packages("tidytext")
```


```r
library(tidytext)

tokens <- tweets %>% 
    unnest_tokens(word, text)
```


```r
data(stop_words)

tokens <- tokens %>%
  anti_join(stop_words)
```

```
## Joining, by = "word"
```

# Counting words 

Though a basic step, assessing the most frequent terms can be powerful. The `topfeatures()` function can be helpful for this; simply pass `my_dfm` as the first argument to it to see the results.


```r
tokens %>% 
    count(word, sort = TRUE)
```

```
## # A tibble: 892 x 2
##    word               n
##    <chr>          <int>
##  1 https            256
##  2 t.co             256
##  3 aect19           234
##  4 rt               108
##  5 aect19inspired    85
##  6 aect              84
##  7 week              32
##  8 vegas             31
##  9 conference        29
## 10 session           29
## # … with 882 more rows
```

Can you change the number of terms that are returned (hint: check `?topfeatures`)? Are the results interpretable? If not, what changes can you make (either through what you pass to `tokens()` or `dfm()`) to improve the output?

# Sentiment analysis


```r
install.packages("textdata")
```

NRC is a dataset was published in a work called Crowdsourcing a Word-Emotion Association Lexicon (Saif M. Mohammad and Peter Turney, 2013). 


```r
get_sentiments("nrc")
```

```
## # A tibble: 13,901 x 2
##    word        sentiment
##    <chr>       <chr>    
##  1 abacus      trust    
##  2 abandon     fear     
##  3 abandon     negative 
##  4 abandon     sadness  
##  5 abandoned   anger    
##  6 abandoned   fear     
##  7 abandoned   negative 
##  8 abandoned   sadness  
##  9 abandonment anger    
## 10 abandonment fear     
## # … with 13,891 more rows
```

## Tweets associated with positive 


```r
nrc_pos <- get_sentiments("nrc") %>% 
  filter(sentiment == "positive")

pos_tweets <- tokens %>%
  inner_join(nrc_pos) %>%
  count(word, sort = TRUE)
```

```
## Joining, by = "word"
```


```r
pos_tweets %>% 
    filter(n >= 10) %>%
    ggplot(., aes(x = reorder(word, -n), y = n)) + 
    geom_bar(stat = "identity") + 
    labs(title = "Count of words associated with positive", 
         subtitle = "Tweets with the hashtag AECT19", 
         x = "", 
         y = "Count")
```

<img src="11-walkthrough-7_files/figure-html/visualize positive-1.png" width="672" />

Note the use of `reorder` when mapping the `word` variable to the x aesthetic. 

## Tweets associated with negative


```r
nrc_neg <- get_sentiments("nrc") %>% 
  filter(sentiment == "negative")

neg_tweets <- tokens %>%
  inner_join(nrc_neg) %>%
  count(word, sort = TRUE)
```

```
## Joining, by = "word"
```


```r
neg_tweets %>% 
    filter(n >= 2) %>%
    ggplot(., aes(x = reorder(word, -n), y = n)) + 
    geom_bar(stat = "identity") + 
    labs(title = "Count of words associated with negative", 
         subtitle = "Tweets with the hashtag AECT19", 
         x = "", 
         y = "Count")
```

<img src="11-walkthrough-7_files/figure-html/visualize negative-1.png" width="672" />

It's important to not draw conclusions on this data alone. The point of exploratory data analysis is to explore and generate hypotheses. 

You can randomly select tweets with positive and negative words to read through and establish context for the visualizations. 

## Random review of tweets 


```r
library(stringr)

# Custom function 
 detect_pos <- function(s) {
  sum(stringr::str_detect(s, fixed(pos_tweets$word, ignore_case = TRUE))) > 0
}
```


```r
tweets_pos <- tweets %>% 
  mutate(pos_words = text %>% map_lgl(detect_pos)) 
```

We'll use `slice`.  


```r
set.seed(369) 

tweets_pos %>% 
  filter(pos_words == TRUE) %>% 
  slice(., sample(1:nrow(.), 10))
```

```
## # A tibble: 10 x 3
##    id_str          text                                           pos_words
##    <chr>           <chr>                                          <lgl>    
##  1 11855320962799… Ready and headed to #aect19 in Las Vegas toda… TRUE     
##  2 11842743774344… Ugh. Just don’t. #aect19 #notinspired https:/… TRUE     
##  3 11851827012943… "Just added a \"Name that Scholar!\" forum to… TRUE     
##  4 11842726905485… RT @tadousay: Y'all! 😍 I've been prepping to … TRUE     
##  5 11863288409827… How do you ensure that your #syllabus is a pr… TRUE     
##  6 11863945099674… Oh look out everyone! I can make cool things … TRUE     
##  7 11863201162894… RT @PaulineMuljana: #aect19 attendees, come a… TRUE     
##  8 11842799251860… #aect19 starts in one week, time to get ready… TRUE     
##  9 11863325581721… #inspiredme #aect19 https://t.co/mFujZEQvpH    TRUE     
## 10 11853651581908… RT @pazureka: So many great #LearnerEngagemen… TRUE
```

# Next steps 

The purpose of this walkthrough is to share code with you so you can practice some basic text analysis techniques. Now it's time to make your learning more meaningful by adapting this code to text-based files you regularly see at work. Here are some ideas: 

 - News articles 
 - Procedure manuals  
 - Open ended responses in surveys  
 
# References 

Silge, J. & Robinson, D. (2017). Text mining with R. O'Reilly Media.  

This dataset was published in Saif M. Mohammad and Peter Turney. (2013), Crowdsourcing a Word-Emotion Association Lexicon. Computational Intelligence, 29(3): 436-465.
