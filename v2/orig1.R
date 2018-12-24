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


# set up dframe -----------------------------------------------------------

mydata<- pdata.frame(mydata, index=c("pid","wave"), drop.index=FALSE, row.names=TRUE)


# wage model --------------------------------------------------------------

m6 <- plm(log(paygu)~M_event+ jbhrs+age+age_sq+
            permanent+jbsize+nchild+
            isco10+indust+wave, 
          data = mydata, 
          model = "within")
summary(m6)
