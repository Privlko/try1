library(readstata13)
library(dplyr)
library(readr)
library(tidyverse)
library(forcats)
library(plm)
library(broom)
library(gtools)

# some labels

# Read Stata data into R
mydata <- read.dta13("C:/Users/Ivan/Desktop/dir/papers/try1/tempdataspot/methodsection.dta") 


View(mydata)

mydata$M_event <-   factor(mydata$M_event)

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
                               '3+'= c('3', '4', '5')),
         M_event = fct_recode(M_event,
                              "Same job, same employer" = '1',
                              "Changed employer, voluntary" = '2',
                              "Changed employer, involuntary" = '3' , 
                              "Changed employer, other" = '4', 
                              "Same employer, voluntary" = '5', 
                              "Same employer, involuntary" = '6',
                              "Same employer, other" = '7'))

mydata$perm <-   factor(mydata$perm)
mydata$wave <-   factor(mydata$wave)


mydata %>% 
  count(M_event)

mydata %>% 
  count(nchild)

mydata %>% 
  count(perm)


mydata %>% 
  count(jbsize)

mydata %>% 
  count(wave)

write_csv(mydata, 'C:/Users/Ivan/Desktop/dir/data/bhps/mydata.csv')

##set up the frame
mydata<- pdata.frame(mydata, index=c("pid","wave"), drop.index=FALSE, row.names=TRUE)


## fixed or random


fixed<- plm(jbsat6~M_event+age+age_sq+
      perm+jbsize+nchild+
      factor(isco10)+wave, 
      data = mydata, 
      model = "within")

summary(fixed, digits=2)

random<- plm(jbsat6~M_event+age+age_sq+
              perm+jbsize+nchild+
              factor(isco10)+wave, 
            data = mydata, 
            model = "random")


summary(random)

phtest(fixed, random)

##hausman wage

fixed<- plm(log(paygu)~M_event+age+age_sq+
              perm+jbsize+nchild+
              factor(isco10)+wave, 
            data = mydata, 
            model = "within")

summary(fixed)

random<- plm(log(paygu)~M_event+age+age_sq+
               perm+jbsize+nchild+
               factor(isco10)+wave, 
             data = mydata, 
             model = "random")


summary(random)

phtest(fixed, random)
fixed$coefficients


## build the summary table

str(mydata)
with(mydata, table(M_event, sex))
mean_sd(mydata$paygu, denote_sd = "paren")


 mydata %>% 
  summarise( m1= mean(M_event))
prop.table(table(mydata$M_event))
 

mydata %>%
  summarise(n=n(), 
            mean_sat = mean(jbsat6, na.rm = TRUE),
            sd_sat = sd(jbsat6, na.rm=TRUE),
            min_sat = min(jbsat6,na.rm=TRUE),
            max_sat = max(jbsat6, na.rm = TRUE))

mydata %>%
  summarise(n=n(), 
            mean_sat = mean(jbhrs, na.rm = TRUE),
            sd_sat = sd(jbhrs, na.rm=TRUE),
            min_sat = min(jbhrs,na.rm=TRUE),
            max_sat = max(jbhrs, na.rm = TRUE))

mydata %>%
  summarise(n=n(), 
            mean_sat = mean(paygu, na.rm = TRUE),
            sd_sat = sd(paygu, na.rm=TRUE),
            min_sat = min(paygu,na.rm=TRUE),
            max_sat = max(paygu, na.rm = TRUE))

mydata %>%
  summarise(n=n(), 
            mean_sat = mean(log(paygu), na.rm = TRUE),
            sd_sat = sd(log(paygu), na.rm=TRUE),
            min_sat = min(log(paygu),na.rm=TRUE),
            max_sat = max(log(paygu), na.rm = TRUE))

mydata %>%
  summarise(n=n(), 
            mean_sat = mean(age, na.rm = TRUE),
            sd_sat = sd(age, na.rm=TRUE),
            min_sat = min(age,na.rm=TRUE),
            max_sat = max(age, na.rm = TRUE))

summary(mydata$jbsat2)

sd(mydata$jbsat2, na.rm = TRUE)
sd(mydata$jbsat6, na.rm = TRUE)
sd(mydata$jbsat7, na.rm = TRUE)


## subjective models

m1 <- plm(jbsat6~M_event+age+age_sq+
              perm+jbsize+nchild+
              factor(isco10)+wave, 
            data = mydata, 
            model = "within")


summ(m1, digits = 3)

tidy_m1<- tidy(m1) %>% 
  mutate(signif = stars.pval(p.value))


glance(m1)

write.csv(tidy_m1, "results/tidy_m1.csv")

m2 <- plm(jbsat2~M_event+age+age_sq+
            perm+jbsize+nchild+
            factor(isco10)+wave, 
          data = mydata, 
          model = "within")
summary(m2)

tidy_m2<- tidy(m2) %>% 
  mutate(signif = stars.pval(p.value))


glance(m2)

write.csv(tidy_m2, "results/tidy_m2.csv")

m3 <- plm(jbsat7~M_event+age+age_sq+
            perm+jbsize+nchild+
            factor(isco10)+wave, 
          data = mydata, 
          model = "within")
summary(m3)

tidy_m3<- tidy(m3) %>% 
  mutate(signif = stars.pval(p.value))


glance(m3)

write.csv(tidy_m3, "results/tidy_m3.csv")



## objective models

m4 <- plm(log(paygu)~M_event+age+age_sq+
            perm+jbsize+nchild+
            factor(isco10)+wave, 
          data = mydata, 
          model = "within")
summary(m4)

tidy_m4<- tidy(m4) %>% 
  mutate(signif = stars.pval(p.value))


glance(m4)

write.csv(tidy_m4, "results/tidy_m4.csv")

m5 <- plm(jbhrs ~M_event+age+age_sq+
            perm+jbsize+nchild+
            factor(isco10)+wave, 
          data = mydata, 
          model = "within")
summary(m5)

tidy_m5<- tidy(m5) %>% 
  mutate(signif = stars.pval(p.value))


glance(m5)

write.csv(tidy_m5, "results/tidy_m5.csv")

m6 <- plm(log(paygu)~M_event+ jbhrs+age+age_sq+
            perm+jbsize+nchild+
            factor(isco10)+wave, 
          data = mydata, 
          model = "within")
summary(m6)

tidy_m6<- tidy(m6) %>% 
  mutate(signif = stars.pval(p.value))


glance(m6)

write.csv(tidy_m6, "results/tidy_m6.csv")

tidy_m6$estimate <- round(tidy_m6$estimate,3)
tidy_m6$p.value <- round(tidy_m6$p.value,3)
tidy_m6


##testing two estimates
??multcomp
m6
cont <-multcomp::glht(m6, linfct = M_event[2] - M_event[4] = 0)
summary(cont) ## estimate, standard error, z-statistic and p-value
confint(cont) ## confidence interval










multcomp::glht()
##some ideas about hypothesis testing
?glht
??linearHypothesis


linearHypothesis(mod, c("disp = hp", "disp = drat", "disp = drat:wt" ))