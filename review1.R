library(readstata13)
library(tidyverse)
library(forcats)
library(plm)

# Read Stata data into R
mydata <- read.dta13("C:/Users/Ivan/Desktop/dir/papers/try1/tempdataspot/methodsection.dta") 

View(mydata)

mydata <- mydata %>% 
  filter(wave>9,
         jbstat=='employed',
         !is.na(M_event)) %>% 
  select(sex, jbsize, jbhrs, contains('jbsat'),
         pid, wave, age, qfedhi, qfachi, paygu, jbisco,
         jhstat, jhstpy, mobility, JobMove, M_event, 
         isco10, nchild, contains('jbterm')) %>% 
  group_by(pid) %>%
  filter(n() > 7) %>% 
  arrange(pid,wave) %>% 
  tbl_df() %>% 
  mutate(perm = case_when(jbterm1=='permanent job' | jbterm==0 ~ 'permanent',
                          jbterm1=='not permanent job'| jbterm==1 | jbterm==2 ~ 'temp'),
         age_sq= age^2,
         jbsize = fct_collapse(jbsize,
                               '<100' = c("1 - 2", "3 - 9", "10 - 24",
                                          '25 - 49', '50 - 99'),
                               '100-500' = c("100 - 199", "200 - 499"),
                               '500+' = c("500 - 999", "1000 or more")),
         nchild = fct_collapse(factor(nchild),
                               'none' = '0',
                               '1' = '1',
                               '2' = '2',
                               '3+'= c('3', '4', '5')))

mydata %>% 
  count(nchild)

table(mydata$perm)
table(mydata$jbsize)

mydata %>% 
  count(M_event)


mydata %>% 
  count(jbsize)

mydata %>% 
  count(wave)


##m1
mydata<- pdata.frame(mydata, index=c("pid","wave"), drop.index=FALSE, row.names=TRUE)

m1<- plm(jbsat~factor(M_event)+age+age_sq+
      perm+factor(jbsize)+nchild+
      factor(isco10)+factor(wave)
          , data = mydata, model = "within")

summary(m1)

m2<- plm(log10(paygu)~factor(M_event)+jbhrs+age+age_sq+
           perm+factor(jbsize)+nchild+
           factor(isco10)+factor(wave), 
         data = mydata, model = "within")

summary(m2)
