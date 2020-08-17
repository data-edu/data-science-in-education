# What Does Data Science in Education Look Like? {#c03}

You can think of a data scientist as someone who combines three skills to do data analysis: programming, statistics, and content knowledge [@conway2010data]. However, if you Google "what is a data scientist",   you won't find a simple answer. In reality, "data scientist" is not a clear description of a single job function: it is much like saying you are a "business person". Data science as a field describes a wide array of job functions: some data scientists work on database architecture, while others focus on data analysis and interpretation. Moreover, data science describes a wide variety of job skills.

Some of the time, for instance, data science in education refers to the application of data science methods, while other times it refers to data science as a context for teaching and learning [@rosenberg2020mdsc]. In the former case, data science in education is seen more as a set of techniques for making sense from data about teaching, learning, and educational systems; in the latter, it is seen more as a content area, like science or mathematics education. Our emphasis in this book is *primarily* (although, not exclusively) on the former case---applying data science methods to ask and answer questions and identify and solve problems related to education.

This wide variety can make it difficult to know what data science in education really is, and how one could start to learn how to do it. Despite the heterogeneity in roles and capabilities involved, in this chapter, we'll provide a working definition of data science in education by sharing some of the roles that professionals occupy in this line of work. We'll also share some common day-to-day tasks for a data scientist in education. Last, we'll provide a definition of the process of doing data science, one that we use to help categorize the aspects emphasized in each of the walkthroughs included later in the book.

## Data Roles in Education 

We learned from talking with data scientists in the education field that their roles and specializations can be very different from each other. People working in education have specialized skills and passions that allow them to add value to their organizations' data culture. Here are some of the roles and specializations data scientists in education might take on.

### Building Systems That Get Data to the Right People 

School staff and leadership can’t make data-informed decisions unless they have good data. Data scientists in education who specialize in data engineering and data warehousing build systems that organize data in one place. They also keep the data secure to protect the information of students and staff, and they distribute datasets to the people who need it. In this area of data science, you might also find people who specialize in data governance: the creation and maintenance of policies used to keep data collection, documentation, security, and communication to a high standard. 

### Measuring the Impact of Our Work on the Student Experience 

Scientific evaluation can help measure the impact of student-centered policies and instructional interventions. Such measurements are important because they inform the allocation of time, money, and attention to future improvements to education systems. Data scientists who specialize in measuring impact know how to use statistical techniques to isolate the effect of an intervention and estimate its value. For example, an education system may choose to work with their data analysts to quantify gains in student attendance that result from a new intervention aimed at chronic absenteeism. 

### Looking for Patterns in Student Data 

Now more than ever, students and school staff are generating data as they go about their day learning and teaching. Online quizzes generate quiz data. Student systems collect data about attendance, discipline, behavior, and native language. Online individualized education program (IEP) systems house information about students with disabilities. State-wide testing assessments are scored, stored in a database, and reported to families. Much of this data gets reported to the state education agency (SEA) for processing and publishing online as a part of an accountability system. 

School systems that learn to use this data as it is generated get a lot of value from it. Data analysts are experts at systematically analyzing this data and finding useful ways to compare it across different categories. This technique, called "exploratory data analysis", is used to generate plausible hypotheses about relationships between variables in the data. These hypotheses can help generate material educational organizations use to create data-driven institutional changes for their students. For example, one way for school systems to support efforts towards equity in student outcomes is to frequently examine any differences in outcomes among student subgroups.

### Improving How We Use Statistical Models in Education 

There are many tried and true methods for data analysis in schools; even so, there is plenty of room for innovation. Data scientists in education take techniques that are commonly found in other industries, like business, and explore how they can improve the state of analytics in education. In particular, the data scientists we spoke to talked about going beyond exploratory data analysis by introducing more advanced techniques like inferential statistics and predictive modeling to the data culture of the schools where they work. This work is not only about improving how well schools implement their current practices, but is also about exploring how we might apply new techniques improve the learning experience of our students. 

## Defining The Process of Data Science

While there is not wholesale agreement on the process of what doing data science entails, there
are some aspects that most data scientists agree upon.

For example, @peng2015's representation of the process emphasizes its cyclical, iterative nature (and the critical importance of starting with a question), and includes data exploration and model building as steps of the process. @grolemund2018's depiction emphasizes the specific, technical steps involved with doing data science; in addition to including modeling, it highlights the importance of preparing and transforming data so that it can be used in the analyses that follow these steps. In this book, we use their depiction to define the process of doing data science.

These are:

1. **Importing data:** Accessing data from a number of sources (including Excel and Comma Separate Value [CSV] files, databases, and Application Programming Interfaces [or APIs]), which is then---typically---stored in a data frame in R.
2. **Tidying data:** Storing data in a "tidy" form [@wickham2014], which may involve pivoting data from "long" to "wide" form and joining or combining two or more data frames in order to facilitate data visualization or modeling.
3. **Transforming data:** Selecting and naming columns and filtering, recoding incomplete cases of data, and calculating summary statistics based on other variables in a dataset.
4. **Visualizing data:** Creating visualizations to understand data and to present output from analyses.
5. **Modeling data:** Using statistical models, from simple to complex, to understand trends and patterns in the data.
6. **Communicating results:** Sharing the results of the analysis through visualizations, the output from models, or other products related to what you learned from the data.

In @grolemund2018's depiction, steps three, four, and five are grouped together as "understanding data": we can see how transforming, visualizing, and modeling data are each different ways to make sense of the trends and patterns among variables in a dataset.

Later, in the first walkthrough chapter ([Chapter 7])(#c07), we'll introduce these six steps in the context of describing the areas of emphasis for the walkthrough; we then use these in the remaining walkthroughs to do the same. While we use these aspects to categorize the topics emphasized in the walkthroughs, we do not think that these are necessarily the *only* important aspects of doing data science. Nevertheless, particularly given our use of many R packages and techniques that work well with tidy data (see "tidying data" above; @wickham2019), we think these aspects satisfactorily describe the process of doing data science for us to use them for our purposes.

## Common Activities of Data Scientists 

Now let's explore the tasks and techniques a data scientist in education uses on a daily basis. 

We'll learn and practice these and other similar techniques later in the book; for now, we introduce the common activities.

### Processing (Preparing and Tidying) Data 

Processing data, or cleaning data, is the act of taking data in its raw form and preparing it for analysis. It begins with *importing data*, which is often followed by *transforming* (e.g., selecting and renaming variables, or filtering or recoding incomplete cases) and *tidying* (e.g., joining or pivoting) data in order to facilitate data visualization or modeling.

When you start a data analysis, the data you have is in the same state as when it was generated and stored. Often, it isn’t designed to support the specific analysis that that you’re tasked with performing. 

Here are some examples of common things you’ll need to do to prepare your data: 

The variable names have to be reworked so they’re convenient to reference in your code. It’s common for raw datasets to have generic variable names that don’t describe the values in that dataset’s column. For example, a dataset indicating students' grades at various points in the semester might have variable names that are just the date of the measurement. In this case, the variable name doesn't fully describe the data captured in the column: it just captures the date of the measurement of that data. These variable names should be changed into something that intuitively represents the values in that column. There are also format-related problems with variables. Things like spaces between words, lengthy variable names, or symbols in the variable names can be inconvenient or make it hard to keep track of the steps in a complicated analysis. 

Datasets also have to be filtered to the subset that you're interested in analyzing. It’s possible that the dataset you’re given contains a larger group of students than you need for your project. For example, a principal at a school site may give you a dataset of every student and the number of days they’ve missed this school year. Now imagine she asks you to do an analysis of attendance patterns in first, second, and third graders. Before you start the analysis, you would need to filter the dataset so that it only contains data for first, second, and third graders. 

Sometimes, your stakeholders will ask you to generate summary figures. Imagine that the director of curriculum and instruction asks you to report the percentage of students at each school that have scored in the "proficient" range on a state-wide assessment. The datasets you're given are (1) a list of students, (2) a list of the schools they attend, and (3) a list of their test scores. To produce the requested report, you'll need to merge these lists so that all the data for each student is in one place: student, school, and test score. Next, you'll need to identify the number of students who scored above the "proficient" threshold on the test at each school. Finally, you'll be able to calculate the percentage of students who met that threshold at each school. 

### Doing Analysis (Exploring, Visualizing, and Modeling Data) 

This is the part of our workflow that most people associate with data science. Analysis is the application of techniques to identify the nature and underlying structure of the dataset, or the relationships among the variables in it. This means that you are making educated guesses about the real life conditions that generated the dataset. This process involves a number of steps, including *visualizing data* and *modeling data* (with techniques that range from the relatively simple to the highly complex).

We realize this may be the first time you’ve heard data analysis described this way. We choose to describe it this way because, in the end, data analysis in education is about understanding what the data tells us about the student experience. If we can understand the underlying structure of a dataset, we can improve our understanding of the students whose academic behaviors generated the numbers. 

Let’s look at a concrete example. Imagine that you are an education consultant and your client is a school district superintendent. The superintendent has asked you to evaluate the impact of a teacher coaching initiative the school district has been using for a year. After processing a dataset that contains teachers, the number of hours they spent in coaching sessions, and the change in student quiz scores, you set out to analyze the data and fit a statistical model. Your initial visualization of the dataset---a line graph of the relationship between hours the teachers spent in coaching and the quiz scores of their students---suggests there might be a linear relationship: the more hours a teacher spent in coaching, the higher that teacher's students score on quizzes. While this relationship might seem intuitive, you can't draw a definitive conclusion just from the visualization, because it *doesn't* tell you whether the relationship between those two variables is meaningful.

Using a statistical model to analyze this dataset can help estimate how much of the change in test scores can be explained by the hours a teacher spent in coaching sessions, and how much can be explained by some other factor (even random chance!). In this example, an alternative explanation for the results is that more conscientious and passionate teachers seek out additional hours of coaching. The data visualization might accurately reflect a relationship between effective teaching style and quiz scores, but that's not enough to conclude that the coaching program is the cause; it's just that more effective teachers are more likely to attend more hours of coaching. 

As you can see, when we try to describe human behavior, things tend to get complicated quickly. Data scientists in education are fundamentally interested in the people who generated the numbers, and understanding the circumstances in which data is being collected is critical to performing good analysis. 

### Sharing Results

So far, we’ve discussed processing data and analyzing data. At these stages, the audiences for your output are usually you, other data scientists, or stakeholders who are in a position to give feedback about the process so far. But when you’ve sorted through your findings and have selected conclusions you want to share, your audience becomes much wider. Now you’re tasked with *communicating* your findings with leadership, staff, parents, the community, or some combination of those audiences. 

The strategy and techniques for sharing with a wider audience are different from the ones you use when processing and analyzing data. Sharing your results includes developing visualizations that clearly communicate a finding, writing narratives that give context and story to your analysis, and developing presentations that spark conversations about the student experience. 

## Who We Are and What We Do

In some fields, there is a clear path you must follow to do a specific job: if you want to be perform cardiac surgery, you have to go to medical school; if you want to hear trials in court, you have to go to law school first. That's not always true for data analysis. To prepare for this book, we talked to lots of folks who do data analysis in the education field. We found that there’s quite a bit of variety in both how people work with data in education and how those people arrived at their education data science roles. 

This is good news for people who want to start working with data in education in a more formalized way. You don’t need a Ph.D. to do this kind of work, though some people we talked to had pursued graduate education. You don't need to be an expert in statistical modeling, though some people had a statistics background. We talked to consultants who moved to the education field. We also talked to teachers and administrators who became consultants. We talked to people who are the lone data scientist in their education organizations and we talked to people who are part of an analytics team. 

You might not think of yourself as a data scientist because your job title doesn't include those words. However, we believe data science is more about the things that you do than the title on your business card. Our own paths toward doing data science in education are very different. Here's a little about us and how we practice data science: 

*Leading Office Culture Toward a Data-Driven Approach*

Jesse, a director at an education nonprofit in Texas, is setting up a database to house student achievement data. This project requires a number of data science skills, which we'll discuss in Chapter 5, including processing data into a consistent format. Once the data is prepared, Jesse builds dashboards to help her teammates explore the data.

However, not all of Jesse's work can be found in a how-to manual for data scientists. She manages a team and serves as the de facto project manager for IT initiatives. Given her expertise and experience in data science, she's also leading the charge towards a more data-driven approach within the organization.

*Helping School Districts Plan to Meet Their Goals*

Ryan, a special education administrator in California, uses data science to reproduce the state department of education's special education compliance metrics. Then, he uses the results to build an early warning system for compliance based on local datasets. In this case, Ryan uses foundational data science skills like data processing, visualization, and modeling to help school districts monitor and meet their compliance requirements. 

*Doing and Empowering Research On Data Scientists in Education*

Joshua, an Assistant Professor of STEM Education at University of Tennessee in Knoxville, researches how students do data science and helps teachers teach the next generation of data-informed citizens. He uses R and develops R packages---self-contained groups of functions---that facilitate efficient data analysis for researchers. 

*Supporting Student Success with Data*

Emily, a dental education administrator in Wisconsin, guides faculty members on best practices in assessing student learning. Like Jesse, Emily works on merging multiple data sources to get a better understanding of the educational experience. For example, she merges practice national board exam scores with actual national board performance data. Later, Emily conducts statistical analyses to help identify the practice score threshold at which students are ready to sign up for the real exam. All this is possible because of R!

*Placing Schools and Districts in Context*

Isabella, a data analyst at a large philanthropic organization, uses publicly available aggregated data to analyze the demographics of schools and districts, how they've changed over time, and other contextual information needed to better understand the field of education. These datasets are often in messy formats (even PDFs!), and sometimes, data from the same agency are organized in a slightly different way every year. Using R allows the downloading and cleaning process to be reproducible when new data comes in. The code clearly shows the decisions made to make aggregated data useful in models or visualizations. Packages and projects allow the entire process to be shared and reused across the analytics team.

## Next Steps for Data Science in Education

As you saw above, there are a variety of ways to apply statistics and programming techniques to support educators and students and to create new knowledge in the education field. We hope this book is part of a movement to develop the norms and expectations for the field as the relationship between data science and education grows. 

Because data science in education is still a young field, it is important that the people growing the field understand the unique culture and challenges in their education job. After all, the feature that will differentiate data science in education from data science in general is the ability to meet the unique needs of students, staff, and administration.

As you progress through this book, we hope you begin to understand where your particular data interests and passions lie. There is more variety in educational backgrounds and in the daily work of education data analysis than one might think. We hope this book will help you combine your unique experiences and talents with new learning in order to create a practice that improves the  experience of students, teachers, and the realm of education as a whole. 
