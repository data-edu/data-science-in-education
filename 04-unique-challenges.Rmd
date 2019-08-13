Because data science in the school setting is a relatively new phenomena, it's understandable that school staff may be wary of how data is collected and analyzed. It's common for school staff to question how data is used, particularly if the data is used to describe staff and student performance. School systems that want to evolve their data analysis processes into something practical and meaningful to student progress will need to do the difficult work of addressing these worries. 

# A Reproducible Approach

One way to do this is to build analytic processes that are open about what data is collected, how it is collected, how it is analyzed, and how it is considered alongside other data when used in decision-making conversations. This can be achieved through a number of activities, including regular conversations about analytic methods, written reports describing data collection, and receiving input about analytic goals from staff members. 

One such process for achieiving openess in data collection and analysis is called reproducible research. The concept of [Reproducible work]("https://en.wikipedia.org/wiki/Reproducibility#Reproducible_research") is the idea that a completed analysis should come with all the necessary materials, including a description of methodology and programming code, needed for someone else to run the analysis and achieve the same results. If school staff are apprehensive about how school data is collected and used, it follows that a more transparent method for using data could go some way towards putting school staff--the consumers of school data--at ease. 

# A Self-Driven Analytic Approach 

An organization should encourage their staff to do their own data analyses primarily for the purpose of testing their own hypotheses about student learning in their classrooms and to directly guide decisions about how they deliver instruction. There are at least two benefits to this approach. First, staff begin to realize the value of doing data analysis as an ongoing inquiry into their outcomes, instead of a special event once a year ahead of school board presentations. Second--and more important for the idea of reducing apprehension around data analysis in schools--school staff begin to demystify data analysis as a process. When school staff collect and analyze their own data, they know exactly how it is collected and exactly how it is analyzed. The long-term effect of this self-driven analytic approach might be more openess to analysis, whether it is self-driven or conducted by the school district.

Building and establishing data governance that advocates for an open and transparent analytic process is difficult and long-term work, but the result will be less apprehension about how data is used and more channels for school staff to participate in the analysis. Here are more practical steps a school district can take towards building a more open approach to analysis: 

 - Make technical write-ups available so interested parties can learn more about how data was collected and analyzed 
 - Make datasets available to staff within the organization, to the extent that privacy laws and policies allow 
 - Establish an expectation that analysts present their work in a way that is accessible to many levels of data experience 
 - Hold regular forums to discuss how the organization collects and uses data

# Unique challenges

Educational data science is a new domain. It presents opportunities, like those discussed in the [previous chapter](#03-ds-role.Rmd), but also some challenges. These challenges vary a lot: We consider doing data science in education to include not only access, processing, and modeling data, but also social and cultural factors, like the training and support that educational data scientists have available to them. These challenges, then, range from the very general (and common to *all* domains in which data science is carried out) to very particular to educational data science. These are discussed in the remainder of this chapter.

## Challenges common to doing data science in any domain 

One challenge for educational data scientists is common to data scientists in other domains: Combining content knowledge, programming, and statistics to solve problems is a fairly new idea. In particular, the amount of data now available means that programming is often not only helpful, but necessary, for stakeholders to use data in education. Programming is powerful, but challenging; many of us in education do not have prior experience with it. Despite this challenge and the difficulty of writing the first few lines of code, there is good evidence, and many examples, that even those of us without prior programming experience can learn. 

## Lack of processes and procedures 

Other challenges are more about the process and practice of doing educational data science. Education is a field that is rich with data: survey, assessment, written, and policy and evaluation data, just for a few examples. Nevertheless, sometimes, there is a lack of processes and procedures in place for school districts and those working in them to share data with each other in order to build knowledge and context. Moreover, in academic and research settings, there are not often structures in place to facilitate the analysis of data and sharing of results. 
 
## Few guidelines from research and evaluation

While there is a body of past research on *students*' work with data (see Lee & Wilkerson, 2018, for a review), there is limited information from case- or design-based research on how others--teachers, administrators, and data scientists--use data in their work. In other words, we do not have a good idea for what best practices in our field are. This challenge is reflected in part in the variability in the roles of those who work with data. Many districts employ data analysts and research associates; some are now advertising and hiring for data scientist positions. 

## Limited training and educational opportunities for educational data science

Educational data science is new. At the present time, there are limited opportunities for those working in education to build their capabilities in educational data science (though this is changing to an extent; see Anderson and colleagues' work to create an educational data science certificate program at the University of Oregon and Bakers' educational data mining Massive Open Online Course offered through Coursera). 

Many educational data scientists have been trained in fields other than statistics, business analytics, or research. Moreover, the training in terms of particular tools and approaches that educational data scientists are highly varied. 
    
## The complex and messy nature of educational data

Another challenge concerns the particular nature of educational data. Educational data are often hierarchical, in that data at multiple "levels" is collected. These levels include classrooms, schools, districts, states, and countries - quite the hierarchy! In addition to the hierarchical nature of educational data, by their nature, these data often require linking with other data, such as data that provides context at each of the aforementioned levels. For example, when data is collected on students at the school level, it is often important to know about the training of the teachers in the school; data at the district level needs to be interpreted in the context of the funding provided by the community in terms of per-pupil spending and other, for example. A final aspect concerns the *type* of data collected. Often, educational data is numeric, but just as often, it is not: It involves characteristics of students, teachers, and other individuals that are categorical; open-ended responses that are strings; or even recordings that consist of audio and video data. All of these present challenges to the educational data scientist. 
    
## Ethical and legal concerns

Related to the complex and messy nature of educational data is its confidential nature. At the K-12 level, most data requires protections because of its human subjects focus, particularly because the data is about a protected population, youth. A closely related issue concerns the aims of education. Those working in education often seek to improve it and often work to do so with a scarcity of school and community resources. These ethical, legal, and even values-related concerns may become amplified as the role of data in education increases. They should be carefully considered and emphasized from the outset by those involved in educational data science.

## Analytic challenges

Due to the challenging nature of educational data, analyzing educational data is hard, too. The data is often not ready to be used: It may be in a format that is difficult to open without specialized software or it may need to be "cleaned" before it is usable. Closely related to the ethical and legal challenges, educational data scientists should be conscious of potential racial and gender biases in school models, and challenge not reinforce them. Because of the different *types* of data, the educational data scientist must often use a variety of analytic approaches, such as multi-level models, models for longitudinal data, or even models and analytic approaches for text data. 
