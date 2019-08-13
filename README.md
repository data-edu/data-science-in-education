# Data Science in Education

* [How to Contribute](#Contributing)

## The Aims of This Book

School districts, government agencies, and education businesses are generating data at a dizzying pace and serving it to teachers, administrators, and education consultants in a mind-boggling variety of formats. Educators and educational data practitioners who want to use data to improve the educational outcomes of students often have a clear idea of the questions they want to ask of their data, but they are left to analyze data as it is presented to them, often times using high-cost proprietary systems. Educational data rarely comes in a “ready-to-analyze” format, so educators and educational data practitioners who are eager to leverage data to promote student success often feel very little connection between the analytic questions they have and the numbers on their laptop. But some educational data practitioners are adopting the tools of data science, including open source projects like R, to make better use of the data deluge. When data science meets education, the numbers previously confined to websites and PDF reports are set free. Teachers, administrators, and consultants apply programming and statistics to prepare data, transform it, visualize it, and analyze it to answer questions that are as unique as are their roles in education.

Data science represents the intersection of domain-level expertise, statistics, and computer programming, applied to data as a means to answer research questions and solve problems. Making sense of data requires, among other things, collaboration, data processing (i.e., wrangling or munging), visualization, and communication of both processes and results in transparent and reproducible ways. Our book focuses on *data science in education*, which we define as using data science techniques like preparing, exploring, visualizing, and modeling data, in order to support schooling at all levels. Our book advances the larger conversation about data science by introducing the idea that the application of data science in a specific field–in this case, education–requires an exploration of unique challenges and the development of unique language. We feel that discussing data science using scenarios that are familiar to education professionals at all levels of education more effectively addresses the needs of those professionals–data analysts and others–who work in that field. This concept of *data science in education* is separate from data science education, which seeks to teach the broader techniques of data science while not necessarily teaching the unique application of those techniques in any particular industry. Educators have different needs than data science enthusiasts who aim to self-teach using *data science education materials*. As educational technology transforms both the administrative and student-facing sides of education, it will become increasingly important for education professionals - not just people hired to analyze data - to be able to understand and respond to the data they gather. Our book empowers educators from elementary school to higher education to transform the educational data they are immersed in into actionable insights, in order to help them better serve the students and institutions for whom they work. It could be used as a main textbook in a graduate data science in education course. Alternatively, it could be used as a supplementary textbook for individuals looking to expand their professional toolkit and become more proficient in data science techniques. 

By the end of this book the reader will understand:

* The diversity of data analysis skills and applications in the education field 
* The unique challenges that come with analyzing education data
* That good data analysis has a basic workflow and how they might implement such a workflow
* The wonderful opportunity we have to shape the usefulness of data science in our education jobs

And, the reader will be able to:

* Reflect and determine what their role is as a data analyst within their role as an educator
* Identify and apply solutions to education data’s unique challenges, such as cleaning datasets and working with private student data 
* Apply a basic analytic workflow through practice with education datasets
* Be thoughtful, empathetic, and effective when introducing data science techniques in their education jobs

1. Introduction: Who Are Data Scientists in Education? 

    - The Challenge of Data Science in Education 
    - Meeting the Challenge

2. How to Use This Book 

    - Read the Book Cover to Cover
    - Pick a Chapter That is Useful for Your Level of Experience and Start There*
    - Read Through the Walkthroughs and Run the Code
    - Mention of why we're using the Tidyverse
    - Mention of the benefits of keeping R up-to-date, learning to deal with functions that are no longer supported, and proactively writing code so it is easier to update in response to new versions

3. What is Data Science in Education?

    - Example #1: Leading Office Culture Toward a Data-Driven Approach
    - Example #2: Helping School Districts Plan to Meet Their Goals
    - Example #3: Doing and Empowering Research On Data Scientists in Education

4. Unique Challenges

    - Challenges common to doing data science in any domain 
    - Lack of Processes and Procedures 
    - Few Guidelines From Research and Evaluation
    - Limited Training and Educational Opportunities 
    - The Complex and Messy Nature of Educational Data
    - Ethical and Legal Concerns
    - Analytic Challenges

5. Foundational Skills: Track One (Getting Started)

    - Downloading R and RStudio
    - Check That It Worked
    - Help, I'm Completely New to Using R / RStudio!
    - Creating Projects
    - Packages
    - Installing and Loading Packages
    - Running Functions from Packages

6. Foundational Skills: Track Two (Welcome to the Tidyverse)

    - Loading Data from Various Sources
    - Saving Files
    - Processing Data
    - Communicating / Sharing Results With R Markdown
    - Configuring R Studio
    - Getting Data Into and Out of R

7. Walkthrough #1: Analyzing Gradebook Data Using the Data Science Framework

8. Walkthrough #2: Understanding Student Motivation to Learn Using Multi-Level Modeling

9. Walkthrough #3: Understanding Online Course Motivation with Machine Learning

10. Walkthrough #4: Creating Network Graphs of Simulated Data

    - Add a discussion of use cases for network analysis to our existing social media example

11. Walkthrough #5: Exploring Nationally- and Internationally-Representative Data

12. Walkthrough #6: Looking at Longitudinal Data

13. Solutions for Adapting Data Science Techniques in Education

    - Matching your analytic strengths to the data needs of your organization 
    - The change process
    - Understanding the culture of your organization
    - Building a network
    - To code or not to code
    - A practical guide to introducing new analytic techniques

14. Teaching Data Science

    - A Pedagogical Framework for Data Science Education

15. Resources

    - Books
    - Websites and Web-based Resources
    - Courses and Communities

16. Learning More

    - Work in the Open
    - Welcoming Others
    - Asking For and Receiving Help
    - Adopting a Growth Mindset


# Contributing

- Check the [planning](/planning/) folder for process- and outline-related information.

- This project started in the #dataedu [Slack channel](https://dataedu.slack.com/) - please get in touch to join!

**Git Issue Labels** 

To help contributors participate, we're using labels so folks who are new to the repo can identify tasks to participate in. If you're working on an issue, it helps us if you assign the issue to yourself so we know who to reach if we want to collaborate. The labels are: 

`test code`: Need help running the file locally and reporting back if everything worked. If it didn't, it helps us if we have a description of what went wrong. 

`discussion`: Sometimes we need help talking through a topic to help us make a good design choice for our readers.

`help wanted`: Need help getting code to run or writing a section. We'll make sure the problem we're trying to work out is clearly stated in the issue comments. 

`writing`: New content needed. At least one author will be assigned to `writing` issues, but we welcome collaboration! Feel free to message the author on Slack or in the issue comments to coordinate.