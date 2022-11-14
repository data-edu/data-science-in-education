# Teaching Data Science {#c16}

## Chapter Overview

This book is focused on the application of data science to education. In other
words, this book focuses on how to apply data science to questions of teaching,
learning, and educational systems. The previous chapters have addressed this
topic through narrative and walkthroughs for common questions (or problems) and
the types of data encountered in education. In this way, much of the book has
focused on *applying data science methods*. However, for a book on data science
in education, it is important to not only discuss the application of
data science methods, but also to consider what we know about *how to teach
data science*. In recognition of these dual meanings of data science in
education, we've referred to the application of data science methods as 
"data science *in* education\*, and the teaching and
learning of data science as "data science \*for" education
[@rosenberg2020mdsc].

Naturally, educators who do data science are positioned well to try to 
teach others how to do data science. In addition, we expect readers of this book - many of whom will
also be involved in education - will be interested in teaching others about data science.

This chapter is organized around three topics:

1.  The pedagogical principles this book is based upon
2.  Strategies for teaching data science
3.  General strategies related to teaching and learning

## The Pedagogical Principles This Book is Based Upon

As the authors of a book about data science in education - and readers of books
that taught us about data science - we considered what would make it effective
for our readers when we set out to write it. The result of this process was a
pedagogical framework that consists of four principles: problem-based learning,
differentiation, building mental models, and working in the open. We consider each of these in turn.

### Problem-based learning

Problem-based learning (PBL) is a method of instruction that asks learners
to apply their skills and knowledge to solve a real-world challenge. 
We applied this principle to the design of this book by including
walkthroughs for common data science and education questions.
This is especially important in data science because we do not
have all of the right answers in this text. Moreover, there is not one right
statistical model or algorithm, technique to write code, or piece software and
set of tools to utilize.

Thus, the text features walkthroughs that reflect the types of challenges that
educational data scientists may encounter in the course of their work. All of
the data (as well as the code) is available, and readers may choose to
approach the analysis of the data used in each walkthrough differently.
Moreover, the walkthroughs are structured in such a way that readers return to
some of the analytic challenges, but with different aims, over the course of the
book: [Walkthrough 1/Chapter 7](#c07), [Walkthrough 7/Chapter 13](#c13), and
[Walkthrough 8/Chapter 14](#c14) all use the same dataset on online science
learning, but Walkthrough 7 expands Walkthrough 1 by its focus on modeling the
effects of courses, and Walkthrough 8 takes a *predictive*, rather than
explanatory, goal, through the use of machine learning. Other challenges, such
as processing and preparing data, are introduced in the first walkthrough and -
reflective of their importance and ubiquity - returned to in each of the subsequent 
chapters.

### Differentiation

Differentiation is a method for providing multiple pathways for learners to
engage with, understand, and ultimately apply new content and new skills. To
differentiate this text, we first created personas of the common groups of readers 
we expected to read this book (see @wilson2009 for an example of this
approach).

The objective was to write in a way that helped readers see themselves in the scenarios. 
The personas were a way to imagine our audience and guide who we interviewed to 
prepare for the writing. The interviews equipped us to go beyond what we 
imagined the needs of our readers were and to include their voices in the way 
we presented the content.

We then aimed to differentiate the book by recognizing and providing background
knowledge (either explicitly or through references to other resources) and
recommendations for where to begin based on prior expertise. We also provided
screenshots--particularly in [Chapter 5/Getting Started with R and
RStudio](#c05) and [Chapter 6/Foundational Skills](#c06)--that are annotated and
reflective of the content in the text to help show readers how to use what they 
are reading about.

Lastly, we considered inclusivity and accessibility when differentiating this book. 
For inclusivity, we considered who makes up the audience for this text and how a 
broader view of who participates in data science informs the types of challenges, 
topics, and data that we included. and accessibility (technically, in terms of how a wide audience of readers
is able to access and use the book, as well how the
content is written based on the unique assets that those in education bring)
along with how we differentiate the book.

### Working in the Open

We started writing this book in the open, on GitHub. This allowed us to share
the book as it developed. Writing the book in the open also allowed others from
the wider educational data science and data science community to contribute.
These contributions included writing sections of the book in which contributors
had specific expertise, asking clarifying questions, and, even creating a logo
for the book which informed our choice of a color palette. We decided to write
this book in the open after witnessing the success of other books on data
science (such as @wickham2019advr *Advanced R* (<https://adv-r.hadley.nz/>)
book.

## Building Mental Models

In the foundational skills chapter, [Chapter 6](#c06), we introduced the 
*foundational skills framework*. The purpose of this framework was to emphasize 
four core concepts (projects, functions, packages, and data) that are relevant to and used in nearly all data science projects. 
We chose to introduce this *general* framework before walkthroughs, which introduce *specific* techniques, 
in part to help readers to build a "mental model" of data science: an understanding of 
how data science tools and techniques at a level deeper than particular functions or individual lines of code (see @krist2019's framework for 
the development of *mental models* and this type of deeper understanding). Understanding both how R works as a programming language (what R code is) 
and how R and RStudio work as software programs can make it easier to troubleshoot the 
(inevitable!) issues and identify possible solutions in the course of working on educational data science projects.

### Universal Design

In our original proposal for this book (see @dsieurproposal), we noted that
Universal Design [@mctighe2019upgrade; @wiggins2005understanding] was a part
of our pedagogical framework. As we worked toward completing the book, we
recognized that we did not fully meet the aims we had laid out. Here is what we
wrote in the proposal:

> Universal Design is a series of principles which guide the creation of spaces
> that are inclusive and accessible to individuals from all walks of life
> regardless of age, size, ability, or disability. While traditionally applied
> to physical spaces, we have extended these principles to the creation of a
> data science text in such a way that the text and accompanying materials will
> be designed for individuals from all walks of life, regardless of educational
> level, background, ability, or disability. Many of the seven guiding
> principles of Universal Design are readily transferable to the creation of a
> text, such as equitable use, flexibility in use (aided in large part through
> differentiation), simple and intuitive use, perceptible information, and
> tolerance for error.

While we did not adequately address these in the book, they remain important to
us, and we hope to address them in a future edition of the book.

## Strategies for Teaching Data Science

You may be interested in teaching others data science. You may be doing this
informally (such as by teaching a colleague in your school
district or organization), in a formal environment (such as a class on data
science for educational data scientists or analysts), or in some setting
in-between (such as a workshop). There is some research
on teaching data science, as well as practical advice from experienced
instructors, that can inform these efforts.

### Provide a Home Base for Learners to Access Resources (and to Learn More)

Learning strategies, along with other important factors (such as
learners' motivations and having a supportive atmosphere), can make a difference 
for learners. Especially when it comes to learning to do
data science, there are many tools and resources to keep track of, such as:

  - How to download and install R
  - How to download and install R Studio
  - How to install packages
  - How to access resources related to the workshop or course (or simply other
    resources you wish to share)
  - How to contact the instructor
  - How to get help and learn more

Having a "home base," where you can remind learners to look first for
resources, can help to lower some of learners' demands in terms of remembering
how these tools and resources can be accessed. One way to do this is through a
personal website. Another is through GitHub pages. For some organizations, a
proprietary learning management system - such as Desire2Learn, Blackboard,
Moodle, or Canvas - can be helpful (especially if your learners are accustomed
to using them).

### When it Comes to Writing Code, Think Early and Often

It is important to get learners to start writing code early and often. It can be
tempting to teach classes or workshops that front-load content about data
science and using R. While this information is important, it can
mean that those you are teaching do not have the chance to do the things
they want to do, including installing R (and R Studio) and beginning to run
analyses. Because of this, we recommend starting with strategies that lower the
barrier to writing code for learners. Ways to do this include:

  - Using R Studio Cloud
  - Providing an R Markdown document for learners to work through
  - Providing a data set and ideas for how to begin exploring it

While these strategies are especially helpful for courses or workshops, they can
be translated to teaching and learning R in tutoring (or "one-on-one")
opportunities for learners. In these cases, being able to work through and
modify an existing analysis (perhaps in R Studio Cloud) is a way to quickly
begin running analyses - and to use the analysis as a template for analyses
associated with other projects. Also, having a data set associated with a
project or analysis - and a real need to analyze it using R - can be an
outstanding way for an individual to learn to use R.

### Don't Touch That Keyboard!

Resist helping learners to the point of hindering their learning. @wilson2009
writes about the way in which those teaching others about R - or to program, in
general - can find it easier to correct errors in learners' work. But, by fixing
errors, you may cause learners to feel that they are not capable of carrying out all
of the steps needed in an analysis on their own.

This strategy relates to a broader issue, as well: issues that have to do with
writing code that runs correctly (e.g., with the correct capitalization
and syntax) can be minor to those with experience programming but can be major
barriers to using R independently for those new to it. For example,
becoming comfortable with where arguments to functions belong and how to
separate them, how to use brackets in functions or loops, and when it is
necessary to use an assignment operator can be *completely new* to beginners.
Doing these steps for learners may hinder their capability later when they may
have fewer resources available to help them than when you are teaching them.
Consider taking the additional time needed to help learners navigate
minor issues and errors in their code: it can pay off in increased motivation on
their part in the long-term.

### Anticipate Issues (and Sacrifice Accuracy for Clarity)

Don't worry about being perfectly accurate early on, especially if doing so
would lead to learners who are less interested in the topic you are teaching.
Especially in cases for which additional details may not be helpful to beginning
learners, it can be valuable to not only anticipate these questions, but to have
responses or answers that provide more clarity, rather than confusion.

For example, there are complicated issues at the heart of why data that is
built-in to packages or to R (such as the iris dataset) appear in the
environment after they are first used in an R session (see the section on
"promises" in @wickham2019advr). Similarly, there are complicated issues that
pertain to how functions are evaluated that can explain why it is important to
provide the name of packages installed via `install.packages()` (whereas the
names of arguments to other functions, such as `dplyr::select()` do not need to
be quoted).

### Start Lessons or Activities With Visualizing Data

There are examples from data science books @grolemund2018 and past research
(e.g., @lehrer2015) that suggest that starting with visualizing data can be
beneficial in terms of learners' ability to work with data. @grolemund2018 write
that they begin their book, *Data Science Using R*, with a chapter on
visualization, because doing so allows learners to create something they
can share immediately, whereas tasks such as loading data can be rife with
issues and do not immediately give learners a product they can
share. @lehrer2007 show how providing students with an opportunity to invent
statistics by displaying the data in new ways led to productive critique
among fifth- and sixth-grade students and their teacher.

### Consider Representation and Inclusion in the Data and Examples You Use

One way to think about data is that it is objective and free of decisions about
what to value or prioritize. Another is to consider data as a process that is
value-laden, from deciding what question to ask (and what data to collect) to
interpreting findings with attention to how others will make sense of them
(e.g., @oneill2016's *Weapons of Math Destruction*, and @lehrer2007's
description of data modeling). From this broader view, choosing representative
data is a choice, like others, that teachers can make. For example, instructors
can choose data that directs attention to issues--equity-related issues in
education, for example--that she or he believes would be valuable for students
to analyze.

It is important to consider and question what data is collected and why, even with variables that we consider to be objective. For example, some variables are constructed to be dichotomous (e.g. gender) or categorical (e.g. race), but the data that is collected is based on decisions by the observer and may not be inherently objective. 

This broader consideration of data is also important when it comes to which data is used for teaching
and learning. For example, if a dataset only includes names of individuals from a
majority racial or ethnic group, some learners may perceive the content being taught 
to be designed for others. While we may think that such issues are better left up 
to those we are teaching to decide on themselves, setting the precedent in classes, 
courses, and other contexts in which data science is taught can be important for 
how learners collect and use data in the future.

### Draw on Other Resources

We touched on a few strategies for teaching data science. There are others that go more into depth on this topic from different
perspectives, such as the following:

  - [GAISE
    Guidelines](https://www.amstat.org/asa/education/Guidelines-for-Assessment-and-Instruction-in-Statistics-Education-Reports.aspx) (https[]()://www.amstat.org/asa/education/Guidelines-for-Assessment-and-Instruction-in-Statistics-Education-Reports.aspx):
    guidelines for teaching statistics
  - [Data Science for
    Undergraduates](https://www.nap.edu/catalog/25104/data-science-for-undergraduates-opportunities-and-options) ((https[]()://www.nap.edu/catalog/25104/data-science-for-undergraduates-opportunities-and-options)):
    a report on undergraduate data science education
  - [R Studio Education](https://education.rstudio.com/) (https[]()://education.rstudio.com/)

There are also a number of data science-related curricula (for the K-12 level)
which may be helpful:

  - [Bootstrap Data Science](https://www.bootstrapworld.org/blog/index.shtml)(https[]()://www.bootstrapworld.org/blog/index.shtml)
  - [Exploring CS, unit 5](http://www.exploringcs.org/curriculum) (http[]()://www.exploringcs.org/curriculum)
  - [Chromebook Data Science](http://jhudatascience.org/chromebookdatascience/) (http[]()://jhudatascience.org/chromebookdatascience/)
  - [Oceans of Data Institute
    Curricula](http://oceansofdata.org/our-work/ocean-tracks-high-school-learning-modules) (http[]()://oceansofdata.org/our-work/ocean-tracks-high-school-learning-modules)

Last, there are also books that emphasize the importance--for teachers--of
understanding their students--every student. These books include
@paris2017culturally and @kozol2012savage and will likely be valuable for teachers of data science who wish to understand and honor the diversity of their
students. @moore2017guide and @emdin2016 may be helpful for data science
educators who aim to be aware and intentional about teaching students from
backgrounds other than their own.

## General Strategies Related to Teaching and Learning

The National Academy of Science commissioned a report, *How People Learn*
[@nrc2000], that aimed to summarize research on teaching and learning from educational psychology
and the learning sciences. In 2018, the report was
updated in *How People Learn II* [@nrc2018] with a new emphasis on the
social and cultural aspects of teaching and learning. Both reports include general strategies 
that may be helpful to those teaching data science.

In addition to these reports, there are some books that are more
practical, including @hattie2012visible, @lemov2015teach, and
@bambrick2010driven. These may provide some answers to questions of how to teach
data science and how to mitigate some of the anxiety that teachers may feel. 

Below, we highlight some general teaching and learning strategies
with an emphasis on strategies applicable to teaching and learning data science. These general strategies
are more conceptual than those described in the last section, and are likely more
useful as starting points for further research or reflection, instead of as specific techniques that can be brought to the next
workshop, class, or peer-to-peer teaching session.

### Teaching and Learning are Complex

One principle from *How People Learn II* is that learning is not just about what 
learners know or think, but is also about the developmental, cultural, contextual, 
and historical factors each individual brings to the table. In short, learning is complex. 
This is an asset to teachers, because learners often bring resources that can
serve as a starting point for their learning trajectory in data science.
Individual distinctions also mean that educators need to consider factors beyond 
what learners know, such as their prior educational experiences and what resources
and other individuals they have access to at work and at home.

### Learners Learn Many Different Things (Consciously and Unconsciously)

The authors of *How People Learn II* point out that individuals learn in response 
to different challenges and circumstances, including those in formal learning environments, such as
workshops or classes. This learning also happens at a different rate for each individual. 
This principle implies a strategy that involves supporting
learners doing data science, however and whenever they learn it. This means that
it is both okay - and even to be expected - that learners may learn more
from a problem they try to solve on their own, than from a workshop
or class (or even a degree!). This also suggests that learners may learn things
that we do not anticipate.

### Meta-cognition is Important (Even Though it Sounds More Sophisticated Than it is!)

Educators and educational researchers often talk about meta-cognition, or
thinking (and ideas) about thinking, as if it is something only very
sophisticated learners do. In reality, it is much more commonplace, as
people (and learners) are thinking about what they are learning and doing
regularly. Instructors can support meta-cognition by asking their students 
to consider what they learned and what they would like to learn more about. 
Exit tickets can be a great way to do this, but a brief period in-class would also work.
Another strategy is to help learners recognize when it is important to ask for help.
Often in data science, the right question to the right person (or community) 
can save hours of work.

### Learning Strategies Matter

While teachers are responsible for designing learning opportunities, learners
also play an important role in their own learning! According to the authors of
*How People Learn II*, learning strategies matter, including those that help students
retrieve, summarize, and explain what they have learned to themselves and others (see @nrc2018 for an elaboration on these).

Teaching strategies, such as how content is spaced and sequenced, also help learners.
@dirksen2015's *Design for How People Learn* presents these strategies, based largely on instructional
design research, that may be helpful to those teaching data science.

What is most important for teachers of data science is less the specific strategies,
and more the commitment to teaching their students how to learn.

## Summary

Data science educators do not need to reinvent the wheel when it comes to teaching about data science. Insights from other, related educational domains (such as statistics education and computer science education) may prove helpful to those seeking to teach data science to others, whether in a one-on-one setting, a workshop, or through a formal class. In this chapter, we sought to describe both the pedagogical principles for this book and some 
strategies for teaching data science. As scholarship and practice where it comes to teaching and learning data science continues to develop, we hope that those teaching (and producing scholarship about) teaching data science not only draw upon the findings of those in other domains, but carve out a domain of their own - one with findings that may have implications for how statistics, computer science, or even subject matters such as science and mathematics are learned.
