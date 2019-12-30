# Introducing Data Science Tools To Your Education Job

## Introduction 

The purpose of this section is to explore the reality of what it is like to take new found data science skills into your work place with the challenge of finding practical ways to use your skills, encouraging your coworkers to be better users of data, and develop analytic routines that are individualized to the needs of your organization. Whether you are helping an education institution as a consultant, an administrator leading teachers at a school, or a university department chair, there are things you can do to transform what you've learned in the abstract into more concrete learning objectives in the context of your education work place. We'll discuss this topic using two areas of focus: bringing your organization the gift of speed and scale, and the importance of connecting well with others. We'll close this chapter by discussing some of the ways that K-12 teachers in particular might engage a work culture that is bringing on data science as a problem-solving tool. 

## The Gift of Speed and Scale

The power of doing data a analysis with a programming language like R comes from two improvements over tools like Excel and Google Sheets. These improvements are 1. a massive boost in the speed of your work and 2. a massive boost in the size of the size of the datasets you analyze. Here are some approaches to introducing data science to your education workplace that focus on making the most of these increases in speed and scale. 

### Working With Data Faster

Data analysts who have have an efficient analytic process understand their clients' questions and participate by rapidly cycling through analysis and discussion. They quickly accumulate skill and experience because their routines facilitate many cycles of data analysis. Roger Peng and Elizabeth Matsui discuss epicycles of analysis in their book [The Art of Data Science](https://bookdown.org/rdpeng/artofdatascience/epicycles-of-analysis.html). In their book [R for Data Science](https://r4ds.had.co.nz/explore-intro.html), Garrett Grolemund and Hadley Wickham demonstrate a routine for data exploration. When the problem space is not clearly defined, as is often the case with education data analysis questions, the path to get from the initial question to analysis itself is full of detours and distractions. Having a routine that points you to the next immediate analytic step gets the analyst started quickly, and many quick starts results in a lot of data analyzed.

But speed gives us more than just an accelerated flow of experience or the thrill of rapidly getting to the bottom of a teacher's data inquiry. It fuels the creativity required to understand problems in education and the imaginative solutions required to address them. Analyzing data quickly keeps the analytic momentum going at the speed needed to indulge organic exploration of the problem. Imagine an education consultant working with a school district to help them measure the effect of a new intervention on how well their students are learning math. During this process the superintendent presents the idea of comparing quiz scores at the schools in the district. The speed at which the consultant offers answers is important for the purposes of keeping the analytic conversation going. 

When a consultant quickly answers a teacher's analytic question about their students' latest batch of quiz scores, the collaborative analytic process feels more like a fast-paced inspiring conversation with a teammate instead of sluggish correspondence between two people on opposite ends of the country. We've all experienced situations where a question like "Is this batch of quiz scores meaningfully different from the ones my students had six months ago?" took so long to answer that the question itself is unimportant by the time the answer arrives! 

Users of data science techniques in education have wonderful opportunities to contribute in situations like this because speedy answers can be the very thing that sparks more important analytic questions. In our example of the education consultant presented with a superintendent's curiosity about quiz score results, it is not too hard to imagine many other great questions resulting from the initial answers: 

 - How big was the effect of the new intervention, if any? 
 - Do we see similar effects across student subgroups, especially the subgroups we are trying to help the most? 
 - Do we see similar effects across grade levels? 

The trick here is to use statistics, programming, and knowledge about education to raise and answer the right questions quickly so the process feels like a conversation. When there's too much time between analytic questions and their answers, educators lose the momentum required to follow the logical and exploratory path towards understanding the needs of their students. 

#### Example: Preparing quiz data to compute average scores


```r
# TODO: Add an intervention column to make this example feel more connected to the anecdote 
```

Let's take our example of the education consultant tasked with computing the average quiz scores. Imagine the school district uses an online quiz system and each teacher's quiz export looks like this:


```r
library(tidyverse)
```

```
## ── Attaching packages ──────────────
```

```
## ✓ ggplot2 3.2.1     ✓ purrr   0.3.3
## ✓ tibble  2.1.3     ✓ dplyr   0.8.3
## ✓ tidyr   1.0.0     ✓ stringr 1.4.0
## ✓ readr   1.3.1     ✓ forcats 0.4.0
```

```
## ── Conflicts ───────────────────────
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
set.seed(45)

quizzes_1 <- tibble(
    teacher_id = 1, 
    student_id = c(1:3), 
    quiz_1 = sample(c(0:100), 3, replace = TRUE), 
    quiz_2 = sample(c(0:100), 3, replace = TRUE), 
    quiz_3 = sample(c(0:100), 3, replace = TRUE)
)

quizzes_1
```

```
## # A tibble: 3 x 5
##   teacher_id student_id quiz_1 quiz_2 quiz_3
##        <dbl>      <int>  <int>  <int>  <int>
## 1          1          1     36     95     82
## 2          1          2     74     38     10
## 3          1          3     45     57     63
```

Tools like Excel and Google Sheets can help you compute statistics like mean scores for each quiz or mean scores for each student fairly quickly, but what if you'd like to do that for five teachers using the exact same method? First, let's tidy the data. This will prepare our data nicely to compute any number of summary statistics or plot results. Using `gather` to separate the quiz number and its score for each student will get us a long way: 


```r
quizzes_1 %>% 
    gather(quiz_number, score, -c(teacher_id, student_id))
```

```
## # A tibble: 9 x 4
##   teacher_id student_id quiz_number score
##        <dbl>      <int> <chr>       <int>
## 1          1          1 quiz_1         36
## 2          1          2 quiz_1         74
## 3          1          3 quiz_1         45
## 4          1          1 quiz_2         95
## 5          1          2 quiz_2         38
## 6          1          3 quiz_2         57
## 7          1          1 quiz_3         82
## 8          1          2 quiz_3         10
## 9          1          3 quiz_3         63
```

Note now that in the first version of this dataset, each individual row represented a unique combination of teacher and student. After using `gather`, each row is now a unique combination of teacher, student, and quiz number. This is often talked about as changing a dataset from "wide" to "narrow" because of the change in the width of the dataset. The benefit to this change is that we can compute summary statistics by grouping values in any of the new columns. For example, here is how we would compute the mean quiz score for each student:


```r
quizzes_1 %>% 
    gather(quiz_number, score, -c(teacher_id, student_id)) %>% 
    group_by(student_id) %>% 
    summarise(quiz_mean = mean(score))
```

```
## # A tibble: 3 x 2
##   student_id quiz_mean
##        <int>     <dbl>
## 1          1      71  
## 2          2      40.7
## 3          3      55
```

Again, for one dataset this computation is fairly straight forward and can be done with a number of software tools. But what if the education consultant in our example wants to do this repeatedly for twenty five teacher quiz exports? Let's look at one way we can do this fairly quickly using R. We'll start by creating two additional datasets as an example. To make things feel authentic, we'll also add a column to show if the students participated in a new intervention. 


```r
# Add intervention column to first dataset 
quizzes_1 <- quizzes_1 %>% 
    mutate(intervention = sample(c(0, 1), 3, replace = TRUE))

# Second imaginary dataset
quizzes_2 <- tibble(
    teacher_id = 2, 
    student_id = c(4:6), 
    quiz_1 = sample(c(0:100), 3, replace = TRUE), 
    quiz_2 = sample(c(0:100), 3, replace = TRUE), 
    quiz_3 = sample(c(0:100), 3, replace = TRUE), 
    intervention = sample(c(0, 1), 3, replace = TRUE)
)

# Third imaginary dataset
quizzes_3 <- tibble(
    teacher_id = 3, 
    student_id = c(7:9), 
    quiz_1 = sample(c(0:100), 3, replace = TRUE), 
    quiz_2 = sample(c(0:100), 3, replace = TRUE), 
    quiz_3 = sample(c(0:100), 3, replace = TRUE), 
    intervention = sample(c(0, 1), 3, replace = TRUE)
)
```

The method we'll use to compute the mean quiz score for each student is to: 

1. Combine all the datasets into one big dataset: Use `bind_rows` to combine all three quiz exports into one dataset. Remember, this can be done because each teacher's export uses the same imaginary online quiz system and export feature and thus use the same number of columns and variable names 

1. Reuse the code from the first dataset on the new bigger dataset: Paste the code we used in the first example into the script so it cleans and computes the mean on the combined dataset 

1. Compute the mean of each student: Now that the data is arranged so that each row is a unique combination of teacher, student, quiz number, and intervention status, we can compute the mean quiz score for each student. 


```r
# Use `bind_rows` to combine the three quiz exports into one big dataset
all_quizzes <- bind_rows(quizzes_1, quizzes_2, quizzes_3) 
```

Note there are now nine rows, one for each student in our dataset of three teacher quiz exports: 


```r
all_quizzes
```

```
## # A tibble: 9 x 6
##   teacher_id student_id quiz_1 quiz_2 quiz_3 intervention
##        <dbl>      <int>  <int>  <int>  <int>        <dbl>
## 1          1          1     36     95     82            0
## 2          1          2     74     38     10            1
## 3          1          3     45     57     63            0
## 4          2          4     92     27     15            0
## 5          2          5     37     80     99            1
## 6          2          6     67     52     99            1
## 7          3          7     60     78     13            0
## 8          3          8     29      1     89            0
## 9          3          9     93     52     25            1
```

We'll combine the cleaning and computation of the mean steps neatly into one this chunk of code:


```r
# Reuse the code from the first dataset on the new bigger dataset
all_quizzes %>% 
    gather(quiz_number, score, -c(teacher_id, student_id, intervention)) %>% 
    # Compute the mean of each student
    group_by(student_id, intervention ) %>% 
    summarise(quiz_mean = mean(score))
```

```
## # A tibble: 9 x 3
## # Groups:   student_id [9]
##   student_id intervention quiz_mean
##        <int>        <dbl>     <dbl>
## 1          1            0      71  
## 2          2            1      40.7
## 3          3            0      55  
## 4          4            0      44.7
## 5          5            1      72  
## 6          6            1      72.7
## 7          7            0      50.3
## 8          8            0      39.7
## 9          9            1      56.7
```

Note here that our imaginary education consultant from the example is thinking ahead by including the `intervention` column. By doing so she's opened the possibility of collaboratively exploring any possible differences in the scores between the students who had the intervention and the students who did not when she reviews and discusses these results with the school staff. Adding these types of details ahead of time is one way to build conversation starters into your collaborations. It is also a way to get faster at responding to curiosities by anticipating useful questions from your clients. 

The difference in time it takes to do this on three quiz exports using R versus non-programming tools is perhaps not significant. But the speed of computing means across larger volumes of data--say thirty quiz exports--is truly useful to an education consultant looking to help many educators. 

*Summary* 

While getting fast at answering analytic questions is not a silver bullet (but really, what is?), it does have a chain effect often leads to creative solutions. It works something like this: 

 1. Answering analytic questions faster helps more people
 1. Helping more people creates opportunities for more data science practice 
 1. Helping more people also helps educate those same people about the solutions data science tools can offer 
 1. Lots of practice combined with a common understanding of the value of data science tools in the education workplace nurtures confidence 
 1. Confidence leads to the courage required to experiment with interesting solutions for designing the best solutions for students 

Here are more ways to get faster at answering analytic questions: 

 - Recognize when you are using similar chunks of code to do repetitive operations. Store that code in an accessible place and reuse it 
 - Keep a notebook of the questions teachers and administrators ask to help you develop an instinct for common patterns of questions. Write your code to anticipate these questions 
 - Learn to use functions and packages like `purrr` to work on many datasets at once 
 - Install a prototyping habit by getting comfortable with quickly producing rough first drafts of your analysis. Your audience can give valuable feedback early and feel like you are quickly on the path to developing useful answers to their questions

### Working With More Data

Improving outcomes in education is about learning, obviously for the students, but just as importantly for the people teaching the students. The more data is available to examine, the more school staff learn about what is working for their students. Using R to prepare and analyze data so it is repeatable and easy to share increases the amount of data you can work with on an order of magnitude compared to tools like Google Sheets. 

When cleaning and analyzing data is laborious, people tend to generate less data. This can be a problem because less data means less context for the data you do have. Without context, it is difficult to conduct one of the primary cognitive tasks of data analysis: making comparisons. 
For example, imagine a teacher whose students have an average quiz score of 75 percent. This information is helpful to the teacher because it shows her how close she is to some pre-determined average quiz score goal, say 95 percent. But that data alone doesn't tell the teacher how unusual that class average is. For that, you need context. Say that line of code used to compute this teacher's class average quiz score was applied to every classroom and she learned that the school average for the same quiz was 77 percent. From this information the teacher learns that her class average is not very different from everyone else's. This is more information than just the knowledge that her class's average was less than her pre-determined goal of 95 percent. 

This is where using R for data analysis enters the conversation. Working with data past a certain size, say 10,000 rows, is difficult because you have to interact with each row through the graphical user interface. Instead, you can work with larger datasets like using programming languages like R to issue complex instructions for acting on the data rather than using a mouse and keyboard to act on what you can see on the screen. 

#### Example: Replacing Many Student Names With Numerical IDs

Say, for example, an elementary school administrator wants to replace each student name in a classroom dataset with a unique numerical ID. Doing this in a spreadsheet using good old fashioned data entry is fairly straightforward. Doing this for a whole school's worth of classrooms though, demands a different approach. Rather than hand enter a unique id into a spreadsheet, the administrator can write an R script that executes the following steps: 

 1. Use `read_csv` to store every classroom's student list into the computer's memory
 1. Use `bind_rows` to combine the separate lists into one long list 
 1. Use `mutate` to replace student names with a randomized and unique numerical ID 
 1. Use `split` to separate the data into classrooms again 
 1. Use `purrr` and `write_csv` to create and rename individual spreadsheets to send back to teachers 

With some initial investment into thoughtful coding on the front end of this problem, the admininistrator now has a script she can use repeatedly in the future when she needs to do this task again.


```r
# TODO: More examples of differences in scale 
```

##  Other Ways to Reimagine the Scale of Your Work

### Reflect on your current scale, then push to the next level

When you've been using the same data analysis tools and routines for a long time, it's easy to forget to reflect on how you work. The analytic questions we ask, the datasets we use, and the scale of the analytic questions become automatic because for the most part they've delivered results. When you introduce data science techniques and R into your education analysis workflow, you also introduce an opportunity to ask yourself: How can I put this analytic question in context by analyzing on a larger scale? 

When an education client or coworker asks for help answering an analytic question, consider the following: 

 1. At what level is this question about, student, classroom, school, district, regional, state, or federal? 
 1. What can we learn by answering the analytic question at the current level, but also at the next level of scale up?

If a teacher asks you to analyze the attendance pattern of one student, see what you learn by comparing to the the attendance pattern of the whole classroom or the whole school. If a superintendent of a school district asks you to analyze the behavior referrals of a school, analyze the behavior referrals of every school in the district. One of the many benefits of using programming languages like R to analyze data is that once you write code for one dataset, it can be used with many datasets with a relatively small amount of additional work. 

### Look for lots of similarly structured data 

Train your eyes to be alert to repositories that contain many datasets that have the exact same structure, then design ways to act on all those datasets at once. Data systems in education generate standardized data tables all the time. It's one of the side effects of automation. Software developers design data systems to automatically generate many datasets for many people. The result is many datasets that contain different data, but all have the same number of columns and the same column names. This uniformity creates the perfect condition for R scripts to automatically act on these datasets in a way that is predictable and repeatable. Imagine a student information system that exports a list of students, their teacher, their grade level, and the number of school days attended to date. School administrator's that have a weekly routine of exporting this data and storing it in a folder on their laptop will generate many uniformly structured datasets. When you train your eyes to see this as an opportunity to act on a lot of data at once, you will find an abundance of chances to transform data on a large scale so school staff can freely explore and ask questions aimed at improving the student experience. 

### Cleaning data

Folks who work in education want to look at data about their students with tools like Excel, but the data is frequently not ready for analysis. You can empower these folks to explore data and ask more questions by being alert to opportunities to prepare lots of data for analysis. Offer to clean a dataset! Then do it again and do it fast. When you get into this habit, you not only train your data cleaning skills but you also train your education client's expectations for how quickly you can prepare data for them. 

## Solving Problems Together 

Steven Spielberg said, "When I was a kid, there was no collaboration; it's you with a camera bossing your friend around. But as an adult, filmmaking is all about appreciating the talents of the people you surround yourself with and knowing you could never have made any of these films by yourself" [@nytimes2011].

Data science techniques are a powerful addition to an educational organization's problem-solving capacity. But  when you're the only person who codes or fits statistical models, it's easy to forget that the best solutions magically arrive when many perspectives come crashing together. Here are some things to think about as you challenge yourself to introduce data science to your education workplace in a lasting and meaningful way. 

### Data Science in Education and Empathy 

One definition of empathy is seeing things as others do, which points to a barrier to our mission of discovering ways to use our data science skills to improve the experience of learners--it is all too easy to assume that our coworkers will be inspired by possibilities of data science as you are. In 1990 Elizabeth Newton, then a Stanford University graduate, asked research subjects to "tap" out well-known songs with their fingers and estimate how many people would recognize the songs [@newton1991, @hbr2006]. She found that they overestimated every time! When we know a subject well, we tend to forget the experience of not knowing that subject. So how do we make use of this knowledge? 

First, listen carefully to your coworkers as they work with data. As you listen, aim to understand the thinking process they use when making sense of reports, tables, and graphs. This will help you understand the problems and solutions they gravitate towards. 

Second, ask them if you can "borrow the problem" for a bit. "Borrowing a problem" is not solving it for them, it's using a little data science magic to get them unstuck so they can continue solving the problem the way they want to. If they're struggling to make a scatter plot from their pivot table data, offer to help by cleaning and summarizing the dataset before they try again. 

Third, if your first attempt at borrowing the problem didn't help, make an effort to learn more. Doing data science together is a conversation, so ask them how it went after you cleaned the dataset. Then listen, understand, and try again. After many rounds of this process, you may find your coworkers willing to try new methods for advancing their goals. 

A workplace going from not using data science to using data science regularly is a process that takes longer than you think. Responses to new ideas might include excitement and inspiration, but they might just as likely include resistance and fear. Changing the way an organization works requires new skills which often take years to learn. But here we are talking about one part of this change that is easily missed: listening to people and the system and using empathy to determine the unique place in your education organization that your data science skills will help students the most. Introducing data science techniques to your system is as much about having good people skills and empathy as it is about learning how to code and fit models. 

Data scientists and non-data scientists in education are similar in this regard--they both get excited and inspired by solving meaningful problems for their students. Once we recognize that that is the unifying goal, the exploration of how we do that with a diversity of expertise and tools begins. When we use empathy to connect with our coworkers about the common problems we are solving, we open the door to all kinds of solutions. Data science in education becomes a tool for a student-centered common cause, not an end in and of itself. 

Here are some reflection questions and exercise to use to inspire connection in your education workplace. Practice these questions both as personal reflections and also as questions you ask your coworkers: 

 1. What does data analysis in our organiztion look like today? 
 1. How do I wish data analysis will look like in the future?
 1. What is the hardest challenge I face in building my vision of student learning?
 1. What is one story about a rewarding experience I had with a student? 

### Create a Daily Practice Commitment That Answers Someone Else's Question

In his book Feck Perfuction, designer @victore2019 writes "Success goes to those who keep moving, to those who can practice, make mistakes, fail, and still progress. It all adds up. Like exercise for muscles, the more you learn, the more you develop, and the stronger your skills become" (p. 31). Doing data science is a skill and like all skills, repetition and mistakes are their fuel for learning. But what happens if you are the first person to do data science in your education workplace? When you have no data science mentors, analytics routines, or examples of past practice, it can feel aimless to say the least. The antidote to that aimlessness is daily practice. 

Commit to writing code everyday. Even the the simplest three line scripts have a way of adding to your growing programming instincts. Train your ears to be radars for data projects that are usually done in a spreadsheet, then take them on and do them i R. Need the average amount of time a student with disabilities spends in speech and language sessions? Try it in R. Need to rename the columns in a student quiz dataset? Try it in R. The principal is hand assembling twelve classroom attendance sheets into one dataset? You get the picture. 

Now along the path of data science daily practice you may discover that your non-data science coworkers start kindly declining your offers for help. In my experience there is nothing mean happening here, but rather this is a response to imagining what it's like to do what you are offering to do using the more commonly found spreadsheet applications. As your programming and statistics skills progress, some of the tasks you offer to help with will be the kind that, if done in a spreadsheet app, are overwhelmingly difficult and time intensive. So in environments where programming is not used for data analysis, declining your offers of help are more perceived acts of kindness to you and probably not statements about the usefulness of your work. As frustrating as these situations might be, they are necessary experiences as an organization learns just how available speed and scale of data analysis are when you use programming as a tool. In fact, these are opportunities you should seize because they serve both as daily practice and as demonstrations of the speed and scale programming for data analysis provides. 

### Build Your Network 

It is widely accepted that participating in personal and professional networks is important for survival, thriving, and innovation. The path to connecting to a data science in education network is apparent if your education workplace has an analytics department, but it will take a little more thought if you are the lone data scientist. When looking for allies that will inspire and teach you, the mind immediately searches for other programmers and statisticians and to be sure, these are relationships that will help you and the organization grow in its analytic approach. 

What the authors argue here is that data science in eduation is not just about bringing programming and statistics, but in the broader view is about evolving the whole approach to analytics. When viewed that way, members of a network broaden beyond just programmers and statisticians. It grows to include administrators and staff who are endlessly curious about the lives of students, graduate students fascinated with unique research methodologies, and designers who create interesting approaches to measurement. 

Networks for growing data science in education are not limited to the workplace. There are plenty of online and in real life chances to participate in a network that are just as rewarding as the networks you participate in during regular work hours. Here are a few to check out: 

 - Communities on Twitter like #RLadies and #rstats 
 - Local coding communities 
 - Conferences like rstudio::conf and useR! 
 - Online forums like RStudio Community 

## For K-12 Teachers 

We've used almost all of this chapter to explore what to think about and what to do to help you bring your data science skills to your education workplace. So far the discussion has been from the data scientist's point of view, but what if you are one of the many who have an interest in analytics but very little interest in programming and statistics? Teachers in elementary and high schools are faced with a mind boggling amount of student data. A study by the @dataqualitycampaign2018 estimated that "95 percent of teachers use a combination of academic data (test scores, graduation rates, etc.) and nonacademic data (attendance, classroom, behavior, etc.) to understand their students' performance". 57 percent of the teachers in the study said a lack of time was a barrier to using the data they have. Data literacy is also increasingly important within teacher preparation programs [@mandinach2013].

Yet the majority of teachers aren't interested in learning a programming language and statistical methods as a way to get better at analytics, and both time and professional development with respect to working with data are necessary [@datnow2015]. After all, most teachers chose their profession because they love teaching, not because they enjoy cleaning datasets and evaluating statistical model output. But to leave them out feels like a glaring ommission in a field where perhaps the most important shared value is the effective teaching of students. 

If you do happen to be an elementary or high school teacher who wants use programming and statistics to improve how you use data, you will find the approaches in this book useful. But if you are not that person, there is still much to explore that will lead to a rewarding experience as you grow your analytic skill. This book lacks the scope to explore this topic thoroughly, but there are many ways to improve how you use data without requiring a programming language or deep knowledge of statistics. 

For example, you can explore what is perhaps the most important element of starting a data analysis: asking the correct question. Chapter three of @peng2015's book, *The Art of Data Science* provides a useful process for getting better at asking data questions. 

Given how often data is served to us through data visualizations, it is important to learn the best ways to create and consume these visualizations. Chapter one of @healy2019's book *Data Visualization: A Practical Introduction*, explores this topic using excellent examples and writing. 

For practical applications of a data-informed approach, *Learning to Improve: How America's Schools Can Get Better at Getting Better* by @bryk2015 offers a thorough explanation of the improvement science process. The book is filled with examples of how data is used to understand problems and trial solutions. 

The final recommendation for elementary and secondary teachers wanting to get better at analysis is this: find, and partner with, someone who can help you answer the questions you have about how to serve your students better. You have the professional experience to come up with the right ideas and the curiosity to see what these ideas look like in the classroom. Inviting someone who can collaborate with you and help you measure the success of your ideas can be a rewarding partnership for you and your students. 
