# How to Use this Book {#c02}

We've heard it from fellow data scientists and experienced it many times -
learning a programming language is hard. Learning a programming language, like
learning a foreign language, is not just about mastering vocabulary. It's also
about learning norms, the language's underlying structure, and the metaphors
that hold the whole thing together.

The beginning of the learning journey is particularly challenging because it
feels slow. If you have experience as an educator or consultant, you already
have efficient solutions you use in your day-to-day work. Introducing code to
your workflow slows you down at first because you won't be as fast as you are
with your favorite spreadsheet software. But learning how to analyze data using
R is like investing in your own personal infrastructure--it takes time while
you're building the initial skills, but the investment pays off when you start
solving complex problems faster and at scale. One person we spoke with shared
this story about their learning journey:

> "The first six months were hard. I knew how quickly I could do a pivot table
> in Excel. It took longer in R because I had to go through the syntax and take
> the book out. I forced myself to do it though. In the long-term, I'd be a
> better data scientist. I'm so glad I thought that way, but it was hard the
> first few months."

Our message is this: learning R for your education job is doable, challenging,
and rewarding all at once. We wrote this book for you because we do this work
every day. We're not writing as education data science masters. We're writing as
people who learned R and data science *after* we chose education. And like you,
learning to use R and data science to improve the lives of students is our daily
practice. Join us in enjoying all that comes with that--both the challenge of
learning and the joy of solving problems in creative ways.

## Different Strokes for Different Data Scientists in Education

It's tough to define data science in education because people are educated in
all kinds of settings and in all kinds of age groups. Education organizations
require different roles to make it work, which creates different kinds of data
science uses. A teacher's approach to data analysis is different from an
administrator's or an operations manager.

We also know that learning data science and R is not in the typical job
description. Most readers of this book are educators working with data and
looking to expand their tools. You might even be an educator who **doesn't**
work with data, but who's discovered a love for learning about the lives of
students through data. Either way, learning data science and R is probalby not
in your job description.

Does this describe your situation? You've got a full work schedule and
challenging demands in the name of improving the student experience. Your busy
workday doesn't include regular professional development time or self-driven
learning. You also have a life outside of work, including family, hobbies, and
relaxation. We struggle with this ourselves, so we've designed this book to be
used in lots of different ways. The important part in learning this materials is
to establish a routine that allows you to engage and practice the content every
day, even if for a few minutes at a time. That will make the content ever
present in your mind and will help you shift your mindset so you start seeing
even more opportunities for practice.

We want all readers to have a rewarding experience and so we believe there
should be different ways to use this book. Here are some of those ways:

### Read the Book Cover to Cover (and How to Keep Going)

We wrote this book assuming you're at the start of your journey learning R and
using data science in your education job. The book takes you from installing R
to practicing more advanced data science skills like text analysis.

If you've never written a line of R code, we welcome you to the community! We
wrote this book for you. Consider reading the book cover to cover and doing all
the analysis walkthroughs. Remember that you'll get more from a few minutes of
practice every day than you will from long hours of practice every once in
awhile. Typing code everyday, even if it doesn't always run, is a daily practice
that invites learning and a-ha moments. We know how easy it is to avoid coding
when it doesn't feel successful, so we've designed the book to deliver frequent
small wins to keep the momentum going. But even then, we all eventually hit a
wall in our learning. When that happens, take a break and then come back and
keep coding. When daily coding becomes a habit, so does the learning.

If you get stuck in an advanced chapter and you need a break, try reviewing an
earlier chapter. You'll be surprised at how much you learn from reviewing old
material with the benefit of new experience. That kind of back-to-basics
attitude is sometimes what we need to get a fresh perspective on new challenges.

### Pick a Chapter of Interest and Start There

We interviewed R users in education as research for this book. We chose people
with different levels of experience in R, the education field, and statistics.
We asked each interviewee to rate their level of experience on a scale from 1
to 5, with 1 being no experience and 5 being very experienced. You can try this
now--take a moment to rate your level of experience in:

  - Using R
  - Education as a field
  - Statistics

If you rated yourself as a 1 in Using R, we recommend reading the book from
beginning to end as part of a daily practice. If you rated yourself higher than
a 1, consider reviewing the table of contents and skimming across all the
chapters first. If a particular chapters call to you, feel free to start your
daily practice there. Eventually, we do hope you choose to experience the whole
book even if you start somewhere in the middle.

For example, you might be working through a specific use case in your education
job--analyzing student quiz scores, evaluating a school program, introducing a
data science technique to your teammates, or designing data dashboards for
example. If this describes your situation, feel free to find a section in the
book that inspires you or shows you techniques that apply to your project.


```r
# LEFT OFF December 2, 2019 
```

### Read Through the Walkthroughs and Run the Code

If you're experienced in data analysis using R, you may be interested in
starting with the walkthroughs. Each walkthrough is designed to demonstrate
basic analytic routines using datasets that look familiar to educators.

In this approach, we suggest readers be intentional about what they want to
learn from the walkthroughs. For example, readers may seek out examples of
aggregated datasets, exploratory data analysis, the {ggplot2} package, or the
`gather()` function. Read the walkthrough and run the code in your R console as
you go. After you successfully run the code, experiment with the functions and
techniques you learned by changing the code and seeing new results (or new error
messages!). After running the code in the walkthroughs, reflect on how what you
learned can be applied to the datasets, problems, and analytic routines in your
education work.

One last note on this approach to the book: we believe that doing data science
in R is, at its heart, an endeavor aimed at improving the student experience.
This endeavor involves complex problems and collaboration. Be sure to read other
areas of the book that give context to why and how we do this work. Chapter
Twelve in particular explores ways to introduce these skills to your education
job and invite others into analytic activities. The skills taught in the
walkthroughs are only one part of doing data science in education using R.

## A Note on Statistics

It's been said that data science is the intersection between content expertise,
programming, and statistics. You'll want to grow all three of these as you learn
more about using data science in your education job. Your education knowledge
will lead you to the right problems, your statistics skills will bring rigor to
your analysis, and your programming skills will scale your analysis to reach
more people.

What happens when we remove one of these pieces? Consider a data scientist
working in education who is an expert programmer and statistician but has not
learned about the real life conditions that generate education data. She might
make analysis decisions that ignore the nuances in the data. Or consider a data
scientist who is an expert statistician and an education veteran, but has not
learned to code. She will find it difficult to scale her analysis and have the
largest possible influence on improving the student experience. And finally,
consider a data scientist who is an expert programmer and an education veteran.
She can only scale surface level analysis and might miss chances to draw causal
relationships or predict student outcomes.

In this book we will spend a lot of time learning R by way of recognizable
education data examples. But doing a deep dive into statistics and how to use
them responsibly is better covered by books dedicated solely to the topic. It's
hard to understate how important this part of the learning is on the lives of
students and educators. One education data scientist we spoke to said this about
the difference between building a model for an online retailer and building a
model in education:

> "It’s ok if I get shown 1000 brooms but if I got my model wrong and we close a
> school that will change someone else’s world."

We want this book to be your go-to R reference as you start integrating data
science tools into your education job. Our aim is to help you learn R by
teaching it in two contexts: data science techniques and workaday education
datasets. We'll demonstrate statistics techniques like hypothesis testing and
model building and how to run these operations in R. But the explanations stop
short of a complete discussion about the statistics themselves.

We wrote within these boundaries because we believe that the technical and
ethical use of statistics techniques deserve their own space. We hope that
you'll take a satisfying leap forward in your learning by successfully using R
to run the models and experiencing the model interpretations in our
walkthroughs. We encourage you to explore other excellent books like Navarro's *Learning Statistics With R* (https://learningstatisticswithr.com/) as you learn the required nuances of
applying statistical techniques to scenarios outside our walkthroughs.

## What This Book Is Not About

While we wrote *Data Science in Education Using R* to be a wide-ranging introduction
to the topic, there is a great deal that this book is not about. Some of these topics 
are those that we would like to have been able to include but did not because they did 
not fit our intention (providing a solid foundation in doing data science in education). 
We chose to not include others because, frankly, excellent resources already exist. We
detail some of what we had to not include in the book here.

<!-- Note - may edit this if we add some brief content on using git as an individual analyst, perhaps our niche -->

- git/GitHub: Using git and GitHub are parts of the educational data scientists workflow; 
however, these can be a challenge to us (and are not needed to get started). Moreover, an
outstanding introduction to their use exists in @bryan2020 freely-available *Happy git with R* (https://happygitwithr.com/).

- Building R packages: If you are carrying out the same analyses many times, it may be helpful to create your own package, such as the roomba (for tidying complex, nested lists) and tidyLPA (for carrying out Latent Profile Analysis) packages that authors of this book created. However, building an R package is not the focus of this book, and Wickham has made the helpful - and freely-available - R packages (http://r-pkgs.had.co.nz/) book.

- Advanced statistical methodologies: As noted above, there are other excellent books for learning 
statistics; while we do discuss statistical methods (including some that can be considered to be advanced), this is not, primarily, a statistics text, and we especially do not consider this to be an advanced statistical methods book; one that we think is excellent as an advanced text from a machine learning perspective is @james2013 *Introduction to Statistical Learning*.

- Creating a website (or book): While this book is created using the bookdown package (for creating a book through R), and many of us have created our personal websites using the blogdown R package (for cerating a website through R), this book does not describe how to do these; there are excellent, freely available books (see @xie2019blogdown's *Blogdown* (https://bookdown.org/yihui/blogdown/) and @xie2019bookdown' *Bookdown* (https://bookdown.org/yihui/bookdown/)).

## Contributing to the Book

We designed this book to be useful and practical for our readers in education
and by doing so almost certainly left out much. We did this to create a
reference that is not intimidating to new users and indeed creates frequent
small wins while learning to use R.

But how do we expand the work as data science in education itself expands? We
wrote this book in the open on GitHub so that community members can help us
evolve the work. We hope that as the book evolves it grows to reflect the
changing needs of data scientists in education.

We want this to be the book new data scientists in education have with them as
they grow their craft. To do that, it's important to us that the stories and
examples in the book are based on **your** stories and examples. And so we've
built ways for you to share with us. Here's how you can can contribute:

  - Submit a pull request to our GitHub repository that describes
    a data science problem that is unique to the education setting
  - Submit a pull request to share a solution for the problems discussed in the
    book to the education setting
  - Share an anonymized dataset
