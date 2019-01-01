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
mydata <- read.dta13("C:/Users/Ivan/Desktop/dir/data/bhps/chapterUK.dta") 

mydata$permanent <- factor(mydata$permanent)
mydata$isco10 <- factor(mydata$isco10)
mydata$e11106 <- factor(mydata$e11106)
mydata$M_event <-   factor(mydata$M_event)


mydata <- tbl_df(mydata) %>% 
  select(pid, wave, M_event,
         jbsize, jbhrs, 
         jbsat, jbsat2, jbsat4, jbsat6, 
         jbsat7, age, nchild, paygu, permanent,
         isco10, e11106) %>%
  rename(indust = e11106) %>% 
  mutate(jbsize = fct_collapse(jbsize,
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
                     "Same employer, other" = '7'),
         age_sq = age^2)


mydata


mydata %>%
  count(jbsize)


mydata %>% 
  count(wave)



# summary stats ----------------------------------------------------------- 
t1 <-   table(mydata$M_event)

# 2-Way Frequency Table 

#mytable <- table(A,B) # A will be rows, B will be columns 
#mytable # print table 

#margin.table(mytable, 1) # A frequencies (summed over B) 
#margin.table(mytable, 2) # B frequencies (summed over A)

prop.table(t1) # cell percentages
prop.table(t1, 1) # row percentages 
prop.table(t1, 2) # column percentages

## build the summary table

str(mydata)

mydata %>%
  summarise(n=n(), 
            mean_sat = mean(jbsat2, na.rm = TRUE),
            sd_sat = sd(jbsat2, na.rm=TRUE),
            min_sat = min(jbsat2,na.rm=TRUE),
            max_sat = max(jbsat2, na.rm = TRUE))

mydata %>%
  summarise(n=n(), 
            mean_sat = mean(jbsat7, na.rm = TRUE),
            sd_sat = sd(jbsat7, na.rm=TRUE),
            min_sat = min(jbsat7,na.rm=TRUE),
            max_sat = max(jbsat7, na.rm = TRUE))


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

summary(mydata)

sd(mydata$jbsat2, na.rm = TRUE)
sd(mydata$jbsat6, na.rm = TRUE)
sd(mydata$jbsat7, na.rm = TRUE)

prop.table(table(mydata$nchild))
prop.table(table(mydata$permanent))
prop.table(table(mydata$jbsize))
prop.table(table(mydata$isco10))
prop.table(table(mydata$indust))



summary(mydata$indust)

1214+247 +500 +65+5048 +1445 +4004+1870 + 1768 +13785

# set up dframe -----------------------------------------------------------

mydata<- pdata.frame(mydata, index=c("pid","wave"), drop.index=FALSE, row.names=TRUE)

mydata


# hausman -----------------------------------------------------------------

## fixed or random


fixed<- plm(jbsat6~M_event+age+age_sq+
              permanent+jbsize+nchild+
              factor(isco10)+wave, 
            data = mydata, 
            model = "within")

summary(fixed, round=2)

random<- plm(jbsat6~M_event+age+age_sq+
               permanent+jbsize+nchild+
               factor(isco10)+wave, 
             data = mydata, 
             model = "random")


summary(random)

phtest(fixed, random)


# subjective models -------------------------------------------------------

m1 <- plm(jbsat6~M_event+age+age_sq+
            permanent+jbsize+nchild+
            isco10+ indust + wave, 
          data = mydata, 
          model = "within")


summary(m1, digits = 3)


tidy_m1<- tidy(m1) %>% 
  mutate(signif = stars.pval(p.value))

 
glance(m1)

write.csv(tidy_m1, "results/tidy_m1.csv")

m2 <- plm(jbsat2~M_event+age+age_sq+
            permanent+jbsize+nchild+
            isco10+ indust + wave, 
          data = mydata, 
          model = "within")


summary(m2)

tidy_m2<- tidy(m2) %>% 
  mutate(signif = stars.pval(p.value))


glance(m2)

write.csv(tidy_m2, "results/tidy_m2.csv")

m3 <- plm(jbsat7~M_event+age+age_sq+
            permanent+jbsize+nchild+
            isco10+ indust + wave, 
          data = mydata, 
          model = "within")
summary(m3)

tidy_m3<- tidy(m3) %>% 
  mutate(signif = stars.pval(p.value))


glance(m3)

write.csv(tidy_m3, "results/tidy_m3.csv")



## objective models

m4 <- plm(log(paygu)~M_event+age+age_sq+
            permanent+jbsize+nchild+
            isco10+ indust + wave, 
          data = mydata, 
          model = "within")
summary(m4)

tidy_m4<- tidy(m4) %>% 
  mutate(signif = stars.pval(p.value))


glance(m4)

write.csv(tidy_m4, "results/tidy_m4.csv")

m5 <- plm(jbhrs ~M_event+age+age_sq+
            permanent+jbsize+nchild+
            isco10+ indust + wave, 
          data = mydata, 
          model = "within")
summary(m5)

tidy_m5<- tidy(m5) %>% 
  mutate(signif = stars.pval(p.value))


glance(m5)

write.csv(tidy_m5, "results/tidy_m5.csv")

m6 <- plm(log(paygu)~M_event+jbhrs+age+age_sq+
            permanent+jbsize+nchild+
            isco10+ indust + wave, 
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

m6
cont <-multcomp::glht(m6, linfct = M_event[2] - M_event[4] = 0)
summary(cont) ## estimate, standard error, z-statistic and p-value
confint(cont) ## confidence interval




# dataviz bit -------------------------------------------------------------

mydata$pay_log <- log(mydata$paygu)
mydata$pay_diff_log <- diff(mydata$pay_log, k=1)

ggplot(mydata, aes(y=pay_diff_log,
                   x=lag(M_event)))+
  geom_jitter(aes(colour=M_event),
              alpha=0.3)+
  geom_hline(yintercept=0, linetype='dashed')+
  coord_flip()+
  labs(title= 'Difference in pay is highly varied, \neven within mobility types',
       subtitle='Voluntary mobility mostly leads to positive change in pay, \nbut so do other types of mobility',
       caption= 'Source: BHPS, own calculations. \nPlot: @privlko',
       x= '',
       y= 'First difference in log of monthly pay')+
  guides(colour=FALSE)

ggsave('difference_pay.jpg')






# wage model --------------------------------------------------------------

m6 <- plm(log(paygu)~M_event+ jbhrs+age+age_sq+
            permanent+jbsize+nchild+
            isco10+indust+wave, 
          data = mydata, 
          model = "within")
summary(m6)
