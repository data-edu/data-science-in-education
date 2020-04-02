# Walkthrough 6: Exploring Relationships Using Social Network Analysis With Social Media Data {#c12}

## Vocabulary

- Application Programming Interface (API)
- edgelist
- edge
- influence model
- regex
- selection model
- social network analysis
- sociogram
- vertex

## Chapter Overview

This chapter builds on [Walkthrough 5/Chapter 11]](#c11), where we worked with #tidytuesday data. In the previous chapter we focused on using text analysis to understand the *content* of tweets. In this, we chapter focus on the *interactions* between #tidytuesday participants using social network analysis techniques. And like the previous chapter, we're including a technical appendix to introduce some ideas for further exploration. This chapter's technical appendix introduces two social network processes, selection and influence. 

### Background

There are a few reasons to be interested in social media. For example, if you work in a school district, you may want to know who is interacting with the content you share. If you are a researcher, you may want to investigate what teachers, administrators, and others do through state-based hashtags (e.g., @rosenberg2016). Social media-based data also provides new contexts for learning to take place, like in professional learning networks [@trust2016]. 

In the past, if a teacher wanted advice about how to plan a unit or to design a lesson, they would turn to a trusted peer in their building or district [@spillane2012]. Today they are as likely to turn to someone in a social media network. Social media interactions like the ones tagged with the #tidytuesday hashtag are increasingly common in education. Using data science tools to learn from these interactions is valuable for improving the student experience. 

### Packages, Data Sources and Import, and Methods

In this chapter, we access data using the {rtweet} package [@kearney2016]. Through {rtweet} and a Twitter account, it is easy to access data from Twitter. We will load the {tidyverse} and {rtweet} packages to get started. 

We will also load other packages that we will be using in this analysis, including two packages related to social network analysis [@R-tidygraph, @R-ggraph] as well as one that will help us to use not-anonymized names in a savvy way [@R-randomNames].


```r
library(tidyverse)
library(rtweet)
library(dataedu)
library(randomNames)
library(tidygraph)
library(ggraph)
```

Here is an example of searching the most recent 1,000 tweets which include the hashtag #rstats. When you run this code, you will be prompted to authenticate your access via Twitter. 


```r
rstats_tweets <- 
  search_tweets("#rstats")
```

As described in [the previous chapter](#c11), you can easily change the search term to other hashtags terms. For example, to search for #tidytuesday tweets, we can replace #rstats with #tidytuesday: 


```r
tidytuesday_tweets <- 
  search_tweets("#tidytuesday")
```

## View Data

We can see that there are *many* rows for the data:


```r
nrow(tt_tweets)
```

```
## [1] 4418
```

## Process Data

Network data requires some processing before it can be used in subsequent analyses. The network dataset needs a way to identify each participant's role in the interaction. We need to answer questions like: Did someone reach out to another for help? Was someone contacted by another for help? We can process the data by creating an "edgelist". An edgelist is a dataset where each row is a unique interaction between two parties. 

An edgelist looks like the following, where the `sender` (sometimes called the "nominator") column identifies who is initiating the interaction and the `receiver` (sometimes called the "nominee") column identifies who is receiving the interaction:




```
## # A tibble: 12 x 2
##    sender                     receiver              
##    <chr>                      <chr>                 
##  1 al-Sawaya, Nabeeha         Nuno Villanueva, Angie
##  2 Tewolde, Jernayiah         Cloud, Desiree        
##  3 Tewolde, Jernayiah         Chase, Timothy        
##  4 Castillo-Halvorssen, Scott Cloud, Desiree        
##  5 Castillo-Halvorssen, Scott Nuno Villanueva, Angie
##  6 Castillo-Halvorssen, Scott Mattie, Logan         
##  7 Vigil, Tiffany             Chase, Timothy        
##  8 Vigil, Tiffany             Martel, Alondra       
##  9 Vigil, Tiffany             Mattie, Logan         
## 10 Proctor, Tina              al-Imam, Samraa       
## 11 Ewald, Audrey              Chase, Timothy        
## 12 Ewald, Audrey              al-Imam, Samraa
```

In this edgelist, the `sender` column might identify someone who nominates another  (the receiver) as someone they go to for help. The sender might also identify someone who interacts with the receiver in other ways, like "liking" or "mentioning" their tweets. In the following steps, we will work to create an edgelist from the data from #tidytuesday on Twitter.

### Extracting Mentions

Let's extract the mentions. There is a lot going on in the code below; let's break it down line-by-line, starting with `mutate()`:

- `mutate(all_mentions = str_extract_all(text, regex))`: this line uses a regex, or regular expression, to identify all of the usernames in the tweet (*note*: the regex comes from from [this Stack Overflow page](https://stackoverflow.com/questions/18164839/get-twitter-username-with-regex-in-r) (https[]()://stackoverflow.com/questions/18164839/get-twitter-username-with-regex-in-r))
- `unnest(all_mentions)` this line uses a {tidyr} function, `unnest()` to move every mention to its own line, while keeping all of the other information the same (see more about `unnest()` here: [https://tidyr.tidyverse.org/reference/unnest.html](https://tidyr.tidyverse.org/reference/unnest.html))).

Now let's use these functions to extract the mentions from the dataset. Here's how all the code looks in action: 


```r
regex <- "@([A-Za-z]+[A-Za-z0-9_]+)(?![A-Za-z0-9_]*\\.)"

tt_tweets <-
  tt_tweets %>%
  # Use regular expression to identify all the usernames in a tweet
  mutate(all_mentions = str_extract_all(text, regex)) %>%
  unnest(all_mentions)
```

Let's put these into their own data frame, called `mentions`.


```r
mentions <-
  tt_tweets %>%
  mutate(all_mentions = str_trim(all_mentions)) %>%
  select(sender = screen_name, all_mentions)
```

### Putting the Edgelist Together

Recall that an edgelist is a data structure that has columns for the "sender" and "receiver" of interactions. Someone "sends" the mention to someone who is mentioned, who can be considered to "receive" it. To make the edgelist, we'll need to clean it up a little by removing the "@" symbol. Let's look at our data as it is now.


```r
mentions
```

```
## # A tibble: 2,447 x 2
##    sender  all_mentions    
##    <chr>   <chr>           
##  1 cizzart @eldestapeweb   
##  2 cizzart @INDECArgentina 
##  3 cizzart @ENACOMArgentina
##  4 cizzart @tribunalelecmns
##  5 cizzart @CamaraElectoral
##  6 cizzart @INDECArgentina 
##  7 cizzart @tribunalelecmns
##  8 cizzart @CamaraElectoral
##  9 cizzart @AgroMnes       
## 10 cizzart @AgroindustriaAR
## # … with 2,437 more rows
```

Let's remove that "@" symbol from the columns we created and save the results to a new tibble, `edgelist`.


```r
edgelist <- 
  mentions %>% 
  # remove "@" from all_mentions column
  mutate(all_mentions = str_sub(all_mentions, start = 2)) %>% 
  # rename all_mentions to receiver
  select(sender, receiver = all_mentions)
```

## Analysis and Results

Now that we have our edgelist, let's plot the network. We'll use the {tidygraph} and {ggraph} packages to visualize the data.

### Plotting the Network

Large networks like this one can be hard to work with because of their size. We can get around that problem by only include some individuals. Let's explore how many interactions each individual in the network sent by using `count()`: 


```r
interactions_sent <- edgelist %>% 
  # this counts how many times each sender appears in the data frame, effectively counting how many interactions each individual sent 
  count(sender) %>% 
  # arranges the data frame in descending order of the number of interactions sent
  arrange(desc(n))

interactions_sent
```

```
## # A tibble: 618 x 2
##    sender            n
##    <chr>         <int>
##  1 thomas_mock     347
##  2 R4DScommunity    78
##  3 WireMonkey       52
##  4 CedScherer       41
##  5 allison_horst    37
##  6 mjhendrickson    34
##  7 kigtembu         27
##  8 WeAreRLadies     25
##  9 PBecciu          23
## 10 sil_aarts        23
## # … with 608 more rows
```

618 senders of interactions is a lot! What if we focused on only those who sent more than one interaction?


```r
interactions_sent <- 
  interactions_sent %>% 
  filter(n > 1)
```

That leaves us with only 349, which will be much easier to work with. 

We now need to filter the edgelist to only include these 349 individuals. The following code uses the `filter()` function combined with the `%in%` operator to do this:


```r
edgelist <- edgelist %>% 
  # the first of the two lines below filters to include only senders in the interactions_sent data frame
  # the second line does the same, for receivers
  filter(sender %in% interactions_sent$sender,
         receiver %in% interactions_sent$sender)
```

We'll use the `as_tbl_graph()` function, which identifies the first column as the "sender" and the second as the "receiver." Let's look at the object it creates: 


```r
g <- 
  as_tbl_graph(edgelist)

g
```

```
## # A tbl_graph: 267 nodes and 975 edges
## #
## # A directed multigraph with 7 components
## #
## # Node Data: 267 x 1 (active)
##   name           
##   <chr>          
## 1 dgwinfred      
## 2 datawookie     
## 3 jvaghela4      
## 4 FournierJohanie
## 5 JonTheGeek     
## 6 jakekaupp      
## # … with 261 more rows
## #
## # Edge Data: 975 x 2
##    from    to
##   <int> <int>
## 1     1    32
## 2     1    36
## 3     2   120
## # … with 972 more rows
```

We can see that the network now has 267 individuals, all of which sent more than one interaction.

Next, we'll use the `ggraph()` function:


```r
g %>%
  # we chose the kk layout as it created a graph which was easy-to-interpret, but others are available; see ?ggraph
  ggraph(layout = "kk") +
  # this adds the points to the graph
  geom_node_point() +
  # this adds the links, or the edges; alpha = .2 makes it so that the lines are partially transparent
  geom_edge_link(alpha = .2) +
  # this last line of code adds a ggplot2 theme suitable for network graphs
  theme_graph()
```

<div class="figure" style="text-align: center">
<img src="12-wt-social-network-analysis_files/figure-html/fig12-1-1.png" alt="Network Graph" width="672" />
<p class="caption">(\#fig:fig12-1)Network Graph</p>
</div>

Finally, let's size the points based on a measure of centrality. A common way to do this is to measure how influential an individual may be based on the interactions observed.




```r
g %>% 
  # this calculates the centrality of each individual using the built-in centrality_authority() function
  mutate(centrality = centrality_authority()) %>% 
  ggraph(layout = "kk") + 
  geom_node_point(aes(size = centrality, color = centrality)) +
  # this line colors the points based upon their centrality
  scale_color_continuous(guide = 'legend') + 
  geom_edge_link(alpha = .2) +
  theme_graph()
```

<div class="figure" style="text-align: center">
<img src="12-wt-social-network-analysis_files/figure-html/fig12-2-1.png" alt="Network Graph with Centrality" width="672" />
<p class="caption">(\#fig:fig12-2)Network Graph with Centrality</p>
</div>

There is much more you can do with {ggraph} (and {tidygraph}); check out the {ggraph} tutorial here: [https://ggraph.data-imaginist.com/](https://ggraph.data-imaginist.com/)

## Conclusion

In this chapter, we used social media data from the #tidytuesday hashtag to prepare and visualize social network data. This is a powerful technique that can reveal who is interacting with whom in some cases can suggest why.

Behind these visualizations there are also statistical models and methods that help to further understand relationships in a network.

One way to consider these models and methods is by considering selection and influence, two *processes* at play in our relationships. These two processes are commonly the focus of statistical analyses of networks. Selection and influence do not interact independently: they affect each other reciprocally (Xu, Frank, & Penuel, 2018). Let's define these two processes:

- *Selection*: the process of choosing relationships
- *Influence*: the process of how our social relationships affect behavior

While these are processes are complex, it is possible to study them using data about people's relationships and behavior. Happily, the use of these methods has expanded along with R. In fact, long-standing R packages have become some of the best tools for studying social networks. Additionally, while there are many nuances to studying selection and influence, these are models that can be carried out with relatively simple modeling techniques like linear regression. We describe these in the *Technical Appendix* for this chapter, as they do not use the tidytuesday dataset and are likely to be of interest to readers after mastering the preperation and visualization of network data.

## Technical Appendix: Influence and Selection Models

After getting familiar with using edgelists and visualizations, a good next step is learning about selection and influence. Let's look at some examples: 

### An Example of Influence

First, let's look at an example of influence. To do so, let's create three different data frames. These will include: 

- An edgelist data frame that contains the *nominator* and *nominee* for a relationship. For example, if Stefanie says that José is her friend, then Stefanie is the nominator and José the nominee. Dataframes like this can also contain an optional variable indicating the weight, or strength, of their relation 
- Data frames indicating the values of some behavior - an outcome - at two different time points

In this example, we'll create example data we can use to explore questions about influence. 

Let's take a look at our three datasets: 

 - `data1`: an edgelist that contains a nominator, nominee, and strength of the relation 
 - `data2`: a dataset that contains the nominee and the values of some behavior at the first time point  
 - `data3`: a dataset that contains a nominator and the value of some behavior at the second time point 

Note that we will find each nominators' outcome at time 2 later on. Here's how we can make these example datasets: 


```r
data1 <-
  data.frame(
    nominator = c(2, 1, 3, 1, 2, 6, 3, 5, 6, 4, 3, 4),
    nominee = c(1, 2, 2, 3, 3, 3, 4, 4, 4, 5, 6, 6),
    relate = c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
  )

data2 <-
  data.frame(nominee = c(1, 2, 3, 4, 5, 6),
             yvar1 = c(2.4, 2.6, 1.1, -0.5, -3, -1))

data3 <-
  data.frame(nominator = c(1, 2, 3, 4, 5, 6),
             yvar2 = c(2, 2, 1, -0.5, -2, -0.5))
```

### Joining the Data
  
Next, we'll join the data into one data frame. This step can be time-consuming for large network datasets, but it's important for the visualizations and analysis that follow. The more time you can invest into preparing the data properly, the more confidence you'll have that your resulting analysis is based on a deeper understanding of the data. 


```r
data <-
  left_join(data1, data2, by = "nominee")

data <-
  data %>% 
  # this makes merging later easier
  mutate(nominee = as.character(nominee)) 

# calculate indegree in tempdata and merge with data
tempdata <- data.frame(table(data$nominee))

tempdata <-
  tempdata %>%
  rename(
    # rename the column "Var1" to "nominee" 
    "nominee" = "Var1", 
    # rename the column "Freq" to "indegree"
    "indegree" = "Freq"
    ) %>% 
  # makes nominee a character data type, instead of a factor, which can cause problems
  mutate(nominee = as.character(nominee))

data <- 
  left_join(data, tempdata, by = "nominee")
```

**Calculating an Exposure Term**

Next we'll create an exposure term. This is the key step that makes this linear regression model special. The idea is that the exposure term "captures" how your interactions with someone over the first and second time points impact an outcome. The model describes a *change* in this otucome because it takes the first and second time points into account.


```r
# Calculating exposure
data <-
  data %>% 
  mutate(exposure = relate * yvar1)

# Calculating mean exposure
mean_exposure <-
  data %>%
  group_by(nominator) %>%
  summarize(exposure_mean = mean(exposure))
```

The data frame `mean_exposure` contains the mean of the outcome (in this case, `yvar1`) for all of the individuals the nominator had a relation with.

Let's process the data more so we can add the variables `exposure_mean`, `yvar1`, and `yvar2`.


```r
data2 <-
  data2 %>% 
  # rename nominee as nominator to merge these
  rename("nominator" = "nominee") 

final_data <-
  left_join(mean_exposure, data2, by = "nominator")

final_data <- 
  # data3 already has nominator, so no need to change
  left_join(final_data, data3, by = "nominator") 
```

**Regression (Linear Model)**

Calculating the exposure term is the most distinctive and important step in carrying out influence models. Now, we can use a linear model to find out how much relations - as captured by the influence term - affect some outcome.


```r
model1 <-
  lm(yvar2 ~ yvar1 + exposure_mean, data = final_data)

summary(model1)
```

```
## 
## Call:
## lm(formula = yvar2 ~ yvar1 + exposure_mean, data = final_data)
## 
## Residuals:
##       1       2       3       4       5       6 
##  0.0295 -0.0932  0.0943 -0.0273 -0.0255  0.0222 
## 
## Coefficients:
##               Estimate Std. Error t value Pr(>|t|)    
## (Intercept)     0.1161     0.0345    3.37    0.043 *  
## yvar1           0.6760     0.0241   28.09  9.9e-05 ***
## exposure_mean   0.1254     0.0361    3.47    0.040 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.0823 on 3 degrees of freedom
## Multiple R-squared:  0.998,	Adjusted R-squared:  0.997 
## F-statistic:  945 on 2 and 3 DF,  p-value: 6.31e-05
```

So, the influence model is used to study a key process for social network analysis. It's useful because it's one way you can quantify *the network effect*. This is a metric that's not always considered in education, but we hope to see  more of it (Frank, 2009). It also helps that it can be done wiht a relatively straight forward regression model. 

### An Example of Selection

Let's look at selection models next. Information from selection models can be useful to a wide audeince--administrators, teachers, and students--because it describes how members of a network choose who to interact with. Here, we briefly describe a few possible approaches for using a selection model to learn more about a social network.

In the last section we use da linear regression model. In this example we'll use a logistic regression model. Logistic regressions model outcomes that are either a 0 or a 1. Thus, the most straightforward way to use a selection model is to use a logistic regression where all of the relations (note the `relate` variable in `data1` above) are indicated with a 1. 

But, here is the important and challenging step: all of the *possible relations* between members of a network are indicated with a 0 in an edgelist. Recall that an edgelist is the preferred data structure for carrying out this analysis. This step requires that we prepare the data by lengthening and widening it.

Once all of the relations are given a value of either a 1 or a 0, then a  logistic regression can be used. Imagine that we are interested in whether individuals from the *same* group are more or less likely to interact than those from different groups. To answer this question, one could create a new variable called `same` and then fit the model using code like this:


```r
m_selection <- 
  glm(relate ~ 1 + same, data = edgelist1)
```

While this is a straightforward way to carry out a selection model, there are some limitations. First, it doesn't account for the amount of nominations an individual sends. Not considering this may mean other effects, like the one associated with being from the *same* group, are not accurate. Some R packages aim to address this by considering other variables like relationship weights. Here are some examples: 

 - The {amen} [@R-amen] package can be used for data that is not only 1ss and 0s - like a logistic regression - but also data that is normally distributed  
 - The Exponential Random Graph Model, or {ergm} R package, makes it easy to use these kinds of selection models. {ergm} [@R-ergm] is itself a part of a powerful and often-used collection of packages for social network analysis, {statnet} [@R-statnet] 
 
These packages are examples of the richness R packages can bring to using social network analysis models and methods. As developments in social network analysis methods continue, more cutting-edge techniques and R packages will be available.
