# What is a Data Scientist in Education? {#c03}

You can think of a data scientist as someone who combines three skills to do data analysis: programming, statistics, and content knowledge [@conway2010data]. Though if you Google "what is a data scientist," you won't find a simple answer.

If we substitute "education experience" for "content knowledge", we start to imagine what skills a data scientist in education has. Even then, there's still a lot more to talk about when we try to describe what someone in this role does on a day-to-day basis.

Not having a consistent definition of what a data scientist in education does makes it hard to share with others in specific terms. In this chapter we'll try and define what being a data scientist in education means by sharing some of the roles folks occupy in this line of work. We'll also share some of the common day-to-day activities a data scientist in education does. 

## Data Roles in Education 

We learned from talking with data scientists in the education field that their roles and specializations can be very different from each other. Hearing about all the different ways that people contribute to education organizations was inspiring and eye opening. It inspired hope and excitement that people have niche skills and passions can find ways to add value to their organization's data culture. Here are some of the roles and specializations data scientists in education might take on. 

### Building Systems That Get Data to the Right People 

School staff and leadership can’t make data-informed decisions unless they have good data. Data scientists in education who specialize in data engineering and data warehousing build systems that organize data in one place, keep the data secure to protect the information of students and staff, and distribute datasets to the folks who need it. In this area of data science, you might also find folks who specialize in data governance, which are policies used to keep data collection, documentation, security, and communication to a high standard. 

### Measuring the Impact of Our Work on the Student Experience 

Education systems that continually strive to improve the way they serve students value the scientific evaluation of their work’s impact. Measuring the impact of instructional interventions is so important for allocating time, money, and attention to ways to improve education systems. Data scientists who specialize in measuring impact know how to use statistical techniques to isolate the effect of an intervention and estimate its value. For example, an education system may choose to work with their data analysts to quantify gains in student attendance that result from a new intervention aimed at chronic absenteeism. 

### Looking for Patterns in Student Data 

Now more than ever, students and school staff are generating data as they go about their day learning and teaching. Online quizzes generate quiz data. Student systems collect attendance, discipline, behavior, and native language data. Online individualized education program (IEP) systems house information about students with disabilities. Statewide testing assessments are scored, stored in a database, and reported back to families. Much of this data gets reported to the state education agency (SEA) for processing and publishing online as a part of an accountability system. 

School systems that learn to explore this data as its generated get a lot of value from it. The patterns they identify inform where they put their time, money, and attention. Data analysts are experts at systematically exploring these data and finding useful ways to compare data across different categories. This technique, called exploratory data analysis, is used to generate plausible hypotheses about relationships between variables in the data. These hypotheses can be tested and become the material educational organizations use to learn about what’s happening with their students. For example, one way for school systems to strive for equity in student outcomes is to constantly explore any differences in outcomes among student subgroups. 

### Improving How We Use Statistical Models in Education 

When we spoke with data scientists in education during the research phase of this book, we learned about the way they use tried and true methods for analysis in schools. But we also learned that they are innovators. They take techniques that are commonly found in other industries like business, and explore how these techniques can improve the state of analytics in education. In particular, the data scientists that we spoke with talked about going beyond exploratory data analysis and introducing more advanced techniques like inferential statistics and predictive modeling to the data culture of schools. This work is not only about improving how well we do our current practices, but also exploring our curiosities about how we might apply new techniques to the task of improving the learning experience of our students. 

## Common Activities of Data Scientists 

Now let's explore what a data scientist in education can expect to do on a typical day at the office. In this section we'll preview some common activities data scientists do daily. Later in the book we'll learn and practice these techniques and more. 

### Processing Data 

Processing data, or cleaning data, is the act of taking data in its raw form and preparing it for analysis. When you start a data analysis, the data you have is in the same state it was in when it was generated and stored. It very often isn’t designed to support the specific analysis that that you’re tasked with doing. 

Here are some examples of common things you’ll need to do to prepare your data: 

The variable names have to be reworked so they’re convenient to reference in your code. It’s common for raw datasets to have generic variable names that don’t describe the values in that dataset’s column. These variable names should be changed into something that intuitively represents the values in that column. There are also format-related problems with variables: things like spaces between words, lengthy variable names, or symbols in the variables names can cause inconvenience in your code or make it hard to keep track of the steps in a complicated analysis. 

Datasets also have to be filtered to the subset that you're interested in analyzing. It’s possible that the dataset you’re given contains a larger group of students than you need for your project. For example, a principal at a school site may give you a dataset of every student and the number of days they’ve missed this school year. Now imagine she asks you to do an analysis of attendance patterns in first, second, and third graders. One step you’ll need to take before you start the analysis is filtering the dataset so that it only contains first, second, and third graders. 

Sometimes you’ll need to do computations to get the summary figures your stakeholders are asking for. Imagine that the director of curriculum and instruction asks you to report the percentage of students that have scored in the proficient range on a statewide assessment. Now imagine that the datasets you're given is a list of students, the school they attend, and their test score. To produce the requested report, you'll need to convert the number of students who scored above a threshold on the test to the percentage of students who met that threshold at each school. 

### Doing Analysis 

This is the part of our workflow that most people associate with data science. Analysis is when you apply statistics techniques to identify the underlying structure of the dataset. This means that you are making educated guesses about the real life conditions that generated the dataset.

We realize this may be the first time you’ve heard data analysis described this way. We choose to describe it this way because in the end, data analysis in education is about understanding what the data tells us about the student experience. If we can understand the underlying structure of a dataset, we can improve our understanding of the students who’s actions generated the numbers. 

Let’s look at a concrete examples of this. Imagine that you are an education consultant and your client is a school district superintendent. The superintendent has asked you to evaluate the impact of a new teacher coaching initiative the school district has been using for a year. After preparing a dataset that contains teachers, the number of hours they’ve spent in coaching sessions, and the change in quiz scores, you set out to explore and fit a statistical model. Your initial visualization of the dataset suggests there might be a linear relationship between the number of hours spent in coaching and a positive change in quiz scores. 

Using a statistical model to analyze this dataset is one way of understanding the underlying structure of the dataset. Specifically, a statistical model can help estimate how much the hours a teacher spent in coaching sessions influences the change in test scores, and how much some other factor (even random chance!) accounts for the change. Data scientists in education are fundamentally interested in the people who generated the numbers. In this case, that’s the students who took the quizzes and the teachers who participated in the coaching sessions. If you can analyze the dataset and understand its underlying structure, you might learn more about what’s happening with the student experience. 

### Sharing Results

One lesson we’ve learned from our daily practice is that each step in a data analysis is its own step with its own audience. When that audience changes, the way you create output must also change. So far we’ve discussed processing data and analyzing data. At these stages, the audiences for your output are usually you, other data scientists, or stakeholders who are in a position to give feedback about the process so far. But when you’ve sorted through your findings and have selected conclusions you want to share,  the audience shifts to a wider group of people. Now you’re tasked with communicating with leadership, staff, parents, the community, or some combination. 

Your thought process and techniques for sharing with a wider audience are different from the ones you use when processing and analyzing data. This third activity includes developing visualizations that clearly communicate a finding, writing narratives that give context and story to your analysis, and developing presentations that spark conversations about the student experience. 

## Who We Are and What We Do

We've talked about the roles of data scientists in education and the daily tasks they can be expected to do. Now let's talk about how who data scientists in education are. 

In some fields the relationship between what you do today and how you got there is prescribed. If you want to help people by performing cardiac surgery, you have to go to medical school first. If you want to hear trials in court, you have to go to law school first. To prepare for this book, we talked to lots of folks who do data analysis in the education field. We found that there’s quite a bit of variety in how people work with data in education. There’s also variety in the journey that people took to arrive at their education data science role. 

We see this as good news for folks who want to start working with data in education in a more formalized way. You don’t need a Ph.D. to do this kind of work, though many people we talked to did. You don’t need to be an expert in statistical modeling, though many people we talked to were. We talked to people who are consultants that came to the education field. We also talked to teachers and administrators who became consultants. We talked to folks who are the lone data scientist in their education organizations and we talked to folks who are part of an analytics team. 

Even our own paths toward doing data science in education are very different. Here's a little about us and how we practice data science: 

*Leading Office Culture Toward a Data-Driven Approach*

Jesse, a director at an education non-profit in Texas, is setting up a database to house student achievement data. This project requires a number of data science skills we'll discuss in chapter five, including cleaning data into a consistent format. Once the data is prepared, Jesse builds dashboards to help her teammates explore the data.

But not all of Jesse's work can be found in a how-to manual for data scientists. She manages a team and serves as the de facto project manager for IT initiatives. And given her expertise and experience in data science, she's leading the charge towards a more data-driven approach within the organization.

*Helping School Districts Plan to Meet Their Goals*

Ryan, a special education administrator in California, uses data science to reproduce the state department of education's special education compliance metrics, then uses the results to build an early warning system for compliance based on local datasets. In this case, Ryan uses foundational data science skills like data cleaning, visualization, and modeling to help school districts monitor and meet their compliance requirements. 

*Doing and Empowering Research On Data Scientists in Education*

Joshua, Assistant Professor of STEM Education at University of Tennessee in Knoxville, researches how students do data science and helps teachers teach the next generation of data-informed citizens. He makes this work possible by building R packages - self-contained groups of data tools - that he and other researchers use to analyze datasets efficiently. 

*Supporting Student Success with Data*

Emily, a dental education administrator in Wisconsin, guides faculty members on best practices in assessing student learning. Like Jesse, Emily works on merging multiple data sources together to get a better understanding of the educational experience. For example, she merges practice national board exam scores with actual national board performance data. Later, Emily conducts statistical analyses to help identify a practice national board score threshold at which students are ready to sign up for the real national board exam. All this is possible because of R!

*Placing Schools and Districts in Context*

Isabella, a data analyst at a large philanthropy, uses publicly available aggregate data to understand what schools and districts look like, how they've changed over time, and other contextual information needed to better understand the field of education. These datasets are often in messy formats (or, PDFs!), and sometimes data from the same agency are organized in a slightly different way every year. Using R allows the downloading and cleaning process to be reproducible when new data comes in. The code clearly shows the decision rules made to make the aggregate data useful in models or visualizations. Packages and projects allow the entire process to be shared and reused across the analytics team.

These are examples of how one might apply statistics and programming to create new knowledge in the education field. But that's as far as we can go when looking for commonalities in their day-to-day work. We hope this book is part of a movement to develop common norms and expectations for how it all works together as the relationship between data science and education grows. 

Because this relationship is still young, it is important that the people growing data science in education understand the culture and unique challenges in their education job. After all, the defining feature that will differentiate data science in education from data science in general will be doing data science that meets the unique needs of students, staff, and administration in education.

As you progress through this book, we hope you begin to understand where your particular data interests and passions are. There is more variety in educational backgrounds and in the daily work of education data analysis than one might think. You can bring your own unique background and interests to this field. We hope this book will help you combine your unique experiences with some new learning so you can create a practice that improves the education experience of students using your unique gifts. 
