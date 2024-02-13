```{r}
CS1_ss <- dplyr::filter(CS1,
                        !is.na(Q1MaincellgroupRow1),
                        opdata_username != "_49147_1",
                        opdata_username != "_93993_1",
                        opdata_username != "@X@user.pk_string@X@",
                        opdata_username != "_80624_1",
                        opdata_CourseID != "@X@course.course_id@X@",
                        opdata_username != "") # must revisit

ps12 <- dplyr::arrange(CS1_ss, opdata_username, opdata_CourseID, StartDate)

ps12$Q1MaincellgroupRow4_rc <- car::recode(ps12$Q1MaincellgroupRow4, "1=5; 2=4; 5=1; 4=2")
ps12$Q1MaincellgroupRow7_rc <- car::recode(ps12$Q1MaincellgroupRow7, "1=5; 2=4; 5=1; 4=2")

# Int: 1, 4, 5, 8, 10
# UV: 2, 6, 9
# PC: 3, 7

ps12 <- ps12 %>%
    mutate(q1 = Q1MaincellgroupRow1,
           q2 = Q1MaincellgroupRow2,
           q3 = Q1MaincellgroupRow3,
           q4 = Q1MaincellgroupRow4_rc,
           q5 = Q1MaincellgroupRow5,
           q6 = Q1MaincellgroupRow6,
           q7 = Q1MaincellgroupRow7_rc,
           q8 = Q1MaincellgroupRow8,
           q9 = Q1MaincellgroupRow9,
           q10 = Q1MaincellgroupRow10)

ps12$int <- (ps12$Q1MaincellgroupRow1 + ps12$Q1MaincellgroupRow4_rc + ps12$Q1MaincellgroupRow8 + ps12$Q1MaincellgroupRow10+ ps12$Q1MaincellgroupRow5) / 5
ps12$uv <- (ps12$Q1MaincellgroupRow2 + ps12$Q1MaincellgroupRow6+ ps12$Q1MaincellgroupRow9) / 3
ps12$percomp <- (ps12$Q1MaincellgroupRow3 + ps12$Q1MaincellgroupRow7_rc) / 2
ps12$tv <- (ps12$Q1MaincellgroupRow1 + ps12$Q1MaincellgroupRow8 + ps12$Q1MaincellgroupRow10+ ps12$Q1MaincellgroupRow5 + ps12$Q1MaincellgroupRow2 + ps12$Q1MaincellgroupRow6+ ps12$Q1MaincellgroupRow9) / 7

x <- str_split(ps12$opdata_CourseID, "-")

ps12_f <- mutate(ps12,
                 subject = map_chr(x, ~ .[1]),
                 semester = map_chr(x, ~ .[2]),
                 section = map_chr(x, ~ .[3]))

ps12_f$date <- ymd_hm(ps12_f$CompletedDate, tz = "America/Detroit")

ps12_f <- select(ps12_f,
                 student_ID = opdata_username,
                 course_ID = opdata_CourseID,
                 subject, semester, section,
                 int, uv, percomp, tv,
                 q1:q10,
                 date)

ps12_f <- mutate(ps12_f, student_ID = str_sub(student_ID, start = 2L, end = -3L))
ps12_f <- arrange(ps12_f, student_ID, date)

ps12_f <- ps12_f %>% distinct(student_ID, .keep_all=T)

# f <- here::here("data", "online-science-motivation", "raw", "CS2.csv")
# CS2 <- read_csv(f) # this is the pre-survey for the Fall, 2015 and Spring, 2016 semesters

CS2$Q1MaincellgroupRow4_rc <- car::recode(CS2$Q1MaincellgroupRow4, "1=5; 2=4; 5=1; 4=2")
CS2$Q1MaincellgroupRow7_rc <- car::recode(CS2$Q1MaincellgroupRow7, "1=5; 2=4; 5=1; 4=2")

CS2$post_int <- (CS2$Q1MaincellgroupRow1 + CS2$Q1MaincellgroupRow8 + CS2$Q1MaincellgroupRow10+ CS2$Q1MaincellgroupRow5) / 4
CS2$post_uv <- (CS2$Q1MaincellgroupRow2 + CS2$Q1MaincellgroupRow6+ CS2$Q1MaincellgroupRow9) / 3 # dropped 7 (is this supposed to be dropped 4?)

CS2$post_tv <- (CS2$Q1MaincellgroupRow1 + CS2$Q1MaincellgroupRow8 + CS2$Q1MaincellgroupRow10+ CS2$Q1MaincellgroupRow5 + CS2$Q1MaincellgroupRow2 + CS2$Q1MaincellgroupRow6+ CS2$Q1MaincellgroupRow9) / 7

CS2$post_percomp <- (CS2$Q1MaincellgroupRow3 + CS2$Q1MaincellgroupRow7_rc) / 2
CS2$date <- lubridate::ymd_hm(CS2$CompletedDate, tz = "America/Detroit")
CS2 <- arrange(CS2, date)

CS2 <- CS2 %>%
    mutate(student_ID = str_sub(opdata_username, start = 2L, end = -3L)) %>%
    select(student_ID, contains("post"), date)

CS2 <- CS2[complete.cases(CS2), ]

CS2 <- dplyr::filter(CS2,
                     student_ID != "49147",
                     student_ID != "93993",
                     student_ID != "80624",
                     student_ID != "@X@user.pk_string@X@",
                     student_ID != "@X@course.course_id@X@",
                     student_ID != "")
CS2 <- arrange(CS2, student_ID, date)
CS2 <- distinct(CS2, student_ID, .keep_all = T)

ps12_f <- left_join(ps12_f, CS2, by = "student_ID")
```

# 2. Pre-processing (for semester 3)

```{r}
# f <- here::here("data", "online-science-motivation", "raw", "CS_1_7_13_17.xls")
#
# ps3 <- read_excel(f)

ps3$Q1MaincellgroupRow31_rc <- car::recode(ps3$Q1MaincellgroupRow31, "1=5; 2=4; 5=1; 4=2")
ps3$Q1MaincellgroupRow61_rc <- car::recode(ps3$Q1MaincellgroupRow61, "1=5; 2=4; 5=1; 4=2")

# ps3$int <- (ps3$Q1MaincellgroupRow01 + ps3$Q1MaincellgroupRow71 + ps3$Q1MaincellgroupRow91+ ps3$Q1MaincellgroupRow41) / 4
# ps3$uv <- (ps3$Q1MaincellgroupRow11 + ps3$Q1MaincellgroupRow51+ ps3$Q1MaincellgroupRow81) / 3 # dropped 7
# ps3$percomp <- (ps3$Q1MaincellgroupRow21 + ps3$Q1MaincellgroupRow61_rc) / 2

# Int: 1, 4, 5, 8, 10
# UV: 2, 6, 9
# PC: 3, 7

ps3 <- ps3 %>%
    mutate(int = composite_mean_maker(ps3, Q1MaincellgroupRow01, Q1MaincellgroupRow31_rc, Q1MaincellgroupRow41, Q1MaincellgroupRow71, Q1MaincellgroupRow91),
           uv = composite_mean_maker(ps3, Q1MaincellgroupRow11, Q1MaincellgroupRow51, Q1MaincellgroupRow81),
           percomp = composite_mean_maker(ps3, Q1MaincellgroupRow21, Q1MaincellgroupRow61_rc),
           tv = composite_mean_maker(ps3, Q1MaincellgroupRow01, Q1MaincellgroupRow31_rc, Q1MaincellgroupRow41, Q1MaincellgroupRow71, Q1MaincellgroupRow91,Q1MaincellgroupRow11, Q1MaincellgroupRow51, Q1MaincellgroupRow81),
           q1 = Q1MaincellgroupRow01,
           q2 = Q1MaincellgroupRow11,
           q3 = Q1MaincellgroupRow21,
           q4 = Q1MaincellgroupRow31_rc,
           q5 = Q1MaincellgroupRow41,
           q6 = Q1MaincellgroupRow51,
           q7 = Q1MaincellgroupRow61_rc,
           q8 = Q1MaincellgroupRow71,
           q9 = Q1MaincellgroupRow81,
           q10 = Q1MaincellgroupRow91
    ) %>%
    filter(opdata_CourseID != "@X@course.course_id@X@") %>%
    separate(opdata_CourseID, c("subject", "semester", "section"), sep = "-", remove = F)

ps3$date <- ymd_hm(ps3$CompletedDate, tz = "America/Detroit")

ps3_f <- select(ps3,
                student_ID = opdata_username,
                course_ID = opdata_CourseID,
                subject, semester, section,
                int, uv, percomp, tv,
                q1:q10,
                date)

ps3_f <- ps3_f %>% arrange(student_ID, date) %>% distinct(student_ID, .keep_all = T)

# f <- here::here("data", "online-science-motivation", "raw", "CS_2_7_13_17.xls")
# df2 <- read_excel(f)

df2$post_int <- (df2$Q2MaincellgroupRow01 + df2$Q2MaincellgroupRow71 + df2$Q2MaincellgroupRow91 + df2$Q2MaincellgroupRow41) / 4
df2$post_uv <- (df2$Q2MaincellgroupRow11 + df2$Q2MaincellgroupRow51+ df2$Q2MaincellgroupRow81) / 3 # dropped 7
df2$post_percomp <- (df2$Q2MaincellgroupRow21)
df2$post_tv <- (df2$Q2MaincellgroupRow01 + df2$Q2MaincellgroupRow71 + df2$Q2MaincellgroupRow91 + df2$Q2MaincellgroupRow41 + df2$Q2MaincellgroupRow11 + df2$Q2MaincellgroupRow51+ df2$Q2MaincellgroupRow81) / 7

df2 <- mutate(df2, date = lubridate::mdy_hm(CompletedDate, tz = "America/Detroit"))

df2 <- arrange(df2, date)

df2 <- select(df2, student_ID = opdata_username, contains("post"), date)
df2 <- distinct(df2)
df2 <- select(df2, -date)

pd3_f <- left_join(ps3_f, df2, by = "student_ID")
ps3_f <- mutate(ps3_f,
                student_ID = str_sub(student_ID, start = 2, end = -3))

```

# 3. Merging and processing merged data

```{r, eval = T}
ps12s <- dplyr::select(ps12_f, student_ID, course_ID, subject, semester, section, int, uv, percomp, tv, q1:q10)
ps3s <- dplyr::select(ps3_f, course_ID, subject, semester, section, int, uv, percomp, tv, q1:q10)

x <- bind_rows(ps12s, ps3s)
x <- as_tibble(x)

d <- bind_rows(ps12_f, ps3_f)

# treatment vs. control for sems 1 and 2
# https://docs.google.com/document/d/1g52pl-0JyEO26bFEJ9aE295dL7oZSOU1wrVXvVbd2lg/edit

d <- mutate(d,
            intervention_dummy = case_when(
                # Fall 15
                course_ID == "AnPhA-S116-01" ~ 1,
                course_ID == "AnPhA-S116-02" ~ 0,
                course_ID == "BioA-S116-01" ~ 1,
                course_ID == "BioA-T116-01" ~ 0,
                course_ID == "FrScA-S116-01" ~ 1,
                course_ID == "FrScA-S116-02" ~ 0,
                course_ID == "FrScA-S116-03" ~ 1,
                course_ID == "FrScA-S116-04" ~ 0,
                course_ID == "FrScA-T116-01" ~ 0,
                course_ID == "OcnA-S116-01" ~ 1,
                course_ID == "OcnA-S116-01" ~ 0,
                course_ID == "OcnA-S116-03" ~ 1,
                course_ID == "OcnA-T116-01" ~ 0,
                course_ID == "PhysA-S116-01" ~ 1,
                course_ID == "PhysA-T116-01" ~ 0,
                
                # Spring 16
                course_ID == "AnPhA-S216-01" ~ 0,
                course_ID == "AnPhA-S216-02" ~ 1,
                course_ID == "BioA-S216-01" ~ 0,
                course_ID == "FrScA-S216-01" ~ 0,
                course_ID == "FrScA-S216-02" ~ 1,
                course_ID == "FrScA-S216-03" ~ 0,
                course_ID == "FrScA-S216-04" ~ 1,
                course_ID == "OcnA-S216-01" ~ 0,
                course_ID == "OcnA-S216-02" ~ 1,
                course_ID == "PhysA-S216-01" ~ 0,
                
                # Spring 17
                course_ID == "AnPhA-S217-01" ~ 1,
                course_ID == "AnPhA-S217-01" ~ 0,
                course_ID == "Bio-S217-01" ~ 1,
                course_ID == "FrScA-S217-01" ~ 1,
                course_ID == "FrScA-S217-02" ~ 0,
                course_ID == "FrScA-S217-02." ~ 0,
                course_ID == "FrScA-S217-03" ~ 1,
                course_ID == "OcnA-S217-01" ~ 0,
                course_ID == "OcnA-S217-02" ~ 1,
                course_ID == "OcnA-S217-03" ~ 1,
                course_ID == "PhysA-S217-01" ~ 0,
                TRUE ~ 0
            ))

d <- rename(d, pre_int = int, pre_uv = uv, pre_percomp = percomp, pre_tv = tv)
d <- select(d, -date.y, -date.x)
```

# 4. Processing all gradebook data

```{r}
# f <- here::here("data", "online-science-motivation", "raw", "RR_S3.csv")
#
# x <- read_csv(r)
x <- select(x, course_ID = Course_ID, student_ID = CU_Pk1, Item_Position:last_access_date)
x <- rename(x, Grade_Category = Grade_Catagory)

RR_Course_Data <- select(RR_Course_Data, course_ID = CourseSectionOrigID, student_ID = Bb_UserPK, Gradebook_Item:last_access_date)

xx <- bind_rows(RR_Course_Data, x)
# write_csv(RR_Course_Data, "s12_gradebook_data.csv")
```

# 5. Merging self-report and gradebook data (not run yet)

```{r, eval = F}
d$student_ID <- as.character(d$student_ID)
xx$student_ID <- as.character(xx$student_ID)
df <- left_join(d, xx, by = "student_ID")
```

# Processing trace data

```{r}
library(readxl)
# f <- here::here("data", "online-science-motivation", "raw", "RR_Minutes.csv")
# ts_12 <- read_csv(f)
#
# f <- here::here("data", "online-science-motivation", "raw", "RR_Course_Data.csv")
# td_12 <- read_csv(f)
#
# f <- here::here("data", "online-science-motivation", "raw", "Ranelluci Study Data Pull Request.xlsx")
# td_3 <- read_excel(f)

td_12 <- td_12 %>%
    select(student_ID = Bb_UserPK, course_ID = CourseSectionOrigID,
           gender = Gender, enrollment_reason = EnrollmentReason,
           enrollment_status = EnrollmentStatus,
           final_grade = FinalGradeCEMS) %>%
    distinct()

ts_12 <- ts_12 %>%
    select(student_ID = Bb_UserPK,
           course_ID = CourseSectionOrigID,
           time_spent = TimeSpent)

td_12 <- left_join(td_12, ts_12)

td_3 <- td_3 %>%
    select(student_ID = CEMS_Bb_UserPK,
           course_ID = Section_ID,
           gender = Gender,
           enrollment_reason = EnrollmentReason,
           enrollment_status = EnrollmentStatus,
           final_grade = Final_Grade,
           time_spent = `Sum of time spent in course`) %>%
    mutate(final_grade = as.numeric(final_grade))

trace_data <- bind_rows(td_12, td_3)
```

# Merging trace data with other data

```{r}
d$student_ID <- as.integer(d$student_ID)
d <- left_join(d, trace_data)
dd <- select(d, student_ID:pre_tv, post_int:post_percomp, enrollment_reason, enrollment_status, final_grade, time_spent)
write_csv(dd, "online-science-data.csv")
```

# 6. Pre-post analysis (not included here in this doc)

# 7. Other analyses

```{r, proc-vars}
d$ts_60 <- d$time_spent / 60
d$male_dummy <- ifelse(d$gender == "M", 1, 0)
d <- mutate(d,
            final_grade_s = scale(final_grade))

d <- filter(d,
            enrollment_status != "Dropped" & enrollment_status != "Withdrawn")
```

### Looking at data

```{r}
d
```

### Correlation table

```{r}
d %>%
    # distinct(student_ID, .keep_all=T) %>%
    select(pre_int, pre_uv, pre_percomp, ts_60, final_grade) %>%
    corrr::correlate() %>%
    corrr::shave() %>%
    corrr::fashion()

```

### Latent variable models

Model with time spent

```{r}
m <- '
# measurement models
pre_int =~ q2 + q6 + q9
pre_pc =~ q3 + q7
# regressions
ts_60 ~ a*pre_int + pre_pc
final_grade ~ b*ts_60 + c*pre_int + pre_pc
# indirect effect (a*b)
ab := a*b
# total effect
total := c + (a*b)
'

out3 <- sem(m, data = d)
summary(out3, standardized = T, fit.measures = T)
```