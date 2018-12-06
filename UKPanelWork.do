version 12
clear all
set more off
capture log close

cd "F:\"
global datadir "F:\BHPS\UKDA-5151-stata8\stata8"
global datadir2 "F:\CNEF-BHPS"
global dir "C:\My Documents\"
global tables "C:\Users\Administrator.admin-PC2\Desktop\Thesis pieces"




 use "$datadir/MethodSection",clear
 
   
   xtset pid wave
   xtdescribe
 
 summ jbsat2 jbsat4 jbsat6 jbsat7
 describe jbsat2 jbsat4 jbsat6 jbsat7

 
 tab jbsat2 
 tab mobility jspno,m
 recode jbsize (1/5=1) (6/7=2) (8/9=3), gen(jbsize1)
 gen ljbsat2= L.jbsat2
 gen ljbsat4= L.jbsat4
 gen ljbsat6= L.jbsat6
 gen ljbsat7= L.jbsat7
 
mvdecode jbsat*, mv(0) 
mvdecode ljbsat*, mv(0)

 recode qfedhi (1=1) (2=2) ///
 (3/5=3) (6=4) (7=5) (8/13=6) ///
 ,gen(qualification)



**generate the unemployment rate

recode doiy4 (1992= 7.5 ) ///
 (1993= 9.3) ///
 (1994= 10.4) ///
 (1995= 8.7) ///
 (1996= 8.2) ///
 (1997= 7.3) ///
 (1998= 6.2) ///
 (1999= 6) ///
 (2000= 5.7) ///
 (2001= 5.1) ///
 (2002= 5.1) ///
 (2003= 4.9) ///
 (2004= 4.8) ///
 (2005= 4.7) ///
 (2006= 5.1) ///
 (2007= 5.5) ///
 (2008= 5.1) ///
 (2009=6.7) ///
 ,gen(unemployment)
 
 recode doiy4 (1992= 0.45 ) ///
 (1993= 2.65) ///
 (1994= 4.02) ///
 (1995= 2.53) ///
 (1996= 2.67) ///
 (1997= 2.55) ///
 (1998= 3.51) ///
 (1999= 3.15) ///
 (2000= 3.77) ///
 (2001= 2.66) ///
 (2002= 2.45) ///
 (2003= 4.3) ///
 (2004= 2.45) ///
 (2005= 2.81) ///
 (2006= 3.04) ///
 (2007= 2.56) ///
 (2008= -0.33) ///
 (2009= -4.31) ///
 ,gen(growth)
 
  

summ  jbsat* i.skill i.qual ///
i.sex age i.child ///
i.perm i.jbsize1 i.e11106 unemployment ///
growth , separator(0) ///
  fvwrap(100) fvwrapon(width) format
 
 
 
 **************z-scores************************
sort pid wave
list pid wave jbsat2 in 1/20, sepby(pid)

egen z_paysat = std(jbsat2)
list pid wave jbsat2 z in 1/20, sepby(pid)

egen z_securitysat = std(jbsat4)
list pid wave jbsat2 jbsat4 z* in 1/20, sepby(pid)


egen z_worksat = std(jbsat6)
list pid wave jbsat2 jbsat6 z* in 1/20, sepby(pid)

egen z_timesat = std(jbsat7)
list pid wave jbsat2 jbsat6 jbsat7 ///
 z* in 1/20, sepby(pid)
 



summ z*
sort pid wave
save "$datadir/chapterUK",replace
xtdescribe

 ********income****************************************
 
 use x11101LL year i11101 i11103 using ///
   "$datadir2/bequiv_long", clear
   
rename x11101LL pid
sort pid
gen wave=year
tab wave
recode wave (1991=1) (1992=2) (1993=3) (1994=4) ///
(1995=5) (1996=6) (1997=7) (1998=8) (1999=9) ///
(2000=10) (2001=11) (2002=12) (2003=13) (2004=14) ///
(2005=15) (2006=16) (2007=17) (2008=18)

 tab wave
 sort pid wave
   merge 1:1 pid wave using "$datadir/chapterUK"
   
   tab wave
   list z* wave in 1/200
   tab _merge
   keep if _merge==3
   drop _merge
   
   list pid z_* in 1/200, sepby(pid)
   xtdescribe
   *********************************************
  
 
xtdescribe
tab wave
keep if wave > 10

xtdescribe

bysort pid: keep if _N > 6
xtdescribe

tab jbsat2
tab M_eve

 
  recode age(15/30=1) (31/45=2) (46/65=3) (65/200=4) ///
 , gen(agecat)
 
 tab agecat
 

 
 save "$datadir/chapterUK",replace
 

 
 ***base idea with linear variables.
 xtreg jbsat2 i.M_ ///
 i.perm i.skill i.quali ///
 i.agecat i.child ///
 i.jbsize1 i.isco10  ///
 i.wave jbsat unemp growth ,fe
 
 outreg2 using UKpanel2.doc,  dec(2) ///
 replace ///
 title (Subjective satisfaction (Fixed Effects)) ///
ctitle(Linear satisfaction with pay 1-7) ///
 long ///
 keep(i.M_e i.catage i.wave ) ///
addnote(The models control for ///
 education age whether the respondent has children ///
 the size of the firm the industry and a factor variable ///
 for each wave. I also control for general job satisfaction ///
 and macro variables like the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 11-18, Weights, none)
 
 parmest, format(estimate min95 max95) ///
 saving("$tables/112")
 
 margins, at(M_e=(1/7)) 
 marginsplot, horiz
 
 
 gen diff = D.jbsat2
recode diff (0=.)
tab diff
 tab M_eve if diff!=.
 drop diff
 
 **BASE IDEA SECURITY
 gen diff = D.jbsat4
recode diff (0=.)
tab diff
 tab M_eve if diff!=.
 
  xtreg jbsat4 i.M_ ///
 i.perm i.skill i.quali ///
 i.catage i.child ///
 i.jbsize1 i.e11106  ///
 i.wave jbsat unemp growth ,fe
 
  outreg2 using UKpanel2.doc,  dec(2) ///
 append ///
 title (Subjective satisfaction (Fixed Effects)) ///
ctitle(Linear satisfaction with security 1-7) ///
 long ///
 keep(i.M_e i.catage i.wave ) ///
addnote(The models control for ///
 education age whether the respondent has children ///
 the size of the firm the industry and a factor variable ///
 for each wave. I also control for general job satisfaction ///
 and macro variables like the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 11-18, Weights, none)
 
 
 margins, at(M_e=(1/7)) 
 marginsplot, horiz
 tab jbsat4

 **BASE IDEA work
 
 gen diff = D.jbsat6
recode diff (0=.)
tab diff
 tab M_eve if diff!=.
 
   xtreg jbsat6 i.M_ ///
 i.perm i.skill i.quali ///
 i.catage i.child ///
 i.jbsize1 i.e11106  ///
 i.wave jbsat unemp growth ,fe
 
   outreg2 using UKpanel2.doc,  dec(2) ///
 append ///
 title (Subjective satisfaction (Fixed Effects)) ///
ctitle(Linear satisfaction with work 1-7) ///
 long ///
 keep(i.M_e i.catage i.wave ) ///
addnote(The models control for ///
 education age whether the respondent has children ///
 the size of the firm the industry and a factor variable ///
 for each wave. I also control for general job satisfaction ///
 and macro variables like the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 11-18, Weights, none)
 
 
margins, at(M_e=(1/7))
 marginsplot,horiz
 
 
 **BASE IDEA Hours
 
 gen diff = D.jbsat7
recode diff (0=.)
tab diff
 tab M_eve if diff!=.
 
   xtreg jbsat7 i.M_ ///
 i.perm i.skill i.quali ///
 i.catage i.child ///
 i.jbsize1 i.e11106  ///
 i.wave jbsat unemp growth ,fe
 
    outreg2 using UKpanel2.doc,  dec(2) ///
 append ///
 title (Subjective satisfaction (Fixed Effects)) ///
ctitle(Linear satisfaction with hours 1-7) ///
 long ///
 keep(i.M_e i.catage i.wave ) ///
addnote(The models control for ///
 education age whether the respondent has children ///
 the size of the firm the industry and a factor variable ///
 for each wave. I also control for general job satisfaction ///
 and macro variables like the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 11-18, Weights, none)
 
 
 tab jbsat7
 margins, at(M_e=(1/7))
 marginsplot,horiz
 
 
 **gender differences
 xtreg jbsat2 i.sex##i.M_ ///
 i.perm i.skill i.quali ///
 i.catage i.child ///
 i.jbsize1 i.e11106  ///
 i.wave jbsat unemp growth ,fe
 
    outreg2 using UKpanel3.doc,  dec(2) ///
 replace ///
 title (Subjective satisfaction and Gender (Fixed Effects)) ///
ctitle(Linear satisfaction with pay 1-7) ///
 long ///
 keep(i.sex##i.M_ i.wave ) ///
addnote(The models control for ///
 education age whether the respondent has children ///
 the size of the firm the industry and a factor variable ///
 for each wave. I also control for general job satisfaction ///
 and macro variables like the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 11-18, Weights, none)

xtreg jbsat4 i.sex##i.M_ ///
 i.perm i.skill i.quali ///
 i.catage i.child ///
 i.jbsize1 i.e11106  ///
 i.wave jbsat unemp growth ,fe
 
   outreg2 using UKpanel3.doc,  dec(2) ///
 append ///
 title (Subjective satisfaction and Gender (Fixed Effects)) ///
ctitle(Linear satisfaction with security 1-7) ///
 long ///
 keep(i.sex##i.M_ i.wave ) ///
addnote(The models control for ///
 education age whether the respondent has children ///
 the size of the firm the industry and a factor variable ///
 for each wave. I also control for general job satisfaction ///
 and macro variables like the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 11-18, Weights, none)

xtreg jbsat6 i.sex##i.M_ ///
 i.perm i.skill i.quali ///
 i.catage i.child ///
 i.jbsize1 i.e11106  ///
 i.wave jbsat unemp growth ,fe
 
   outreg2 using UKpanel3.doc,  dec(2) ///
 append ///
 title (Subjective satisfaction and Gender (Fixed Effects)) ///
ctitle(Linear satisfaction with work 1-7) ///
 long ///
 keep(i.sex##i.M_ i.wave ) ///
addnote(The models control for ///
 education age whether the respondent has children ///
 the size of the firm the industry and a factor variable ///
 for each wave. I also control for general job satisfaction ///
 and macro variables like the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 11-18, Weights, none)

xtreg jbsat7 i.sex##i.M_ ///
 i.perm i.skill i.quali ///
 i.catage i.child ///
 i.jbsize1 i.e11106  ///
 i.wave jbsat unemp growth ,fe
 
  outreg2 using UKpanel3.doc,  dec(2) ///
 append ///
 title (Subjective satisfaction and Gender (Fixed Effects)) ///
ctitle(Linear satisfaction with hours 1-7) ///
 long ///
 keep(i.sex##i.M_ i.wave ) ///
addnote(The models control for ///
 education age whether the respondent has children ///
 the size of the firm the industry and a factor variable ///
 for each wave. I also control for general job satisfaction ///
 and macro variables like the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 11-18, Weights, none)


 
 
 
 **skill differeneces
 
  xtreg jbsat2 i.skill##i.M_ ///
 i.perm i.quali ///
 i.catage i.child ///
 i.jbsize1 i.e11106  ///
 i.wave jbsat unemp growth ,fe
 
    outreg2 using UKpanel4.doc,  dec(2) ///
 replace ///
 title (Subjective satisfaction and Skill (Fixed Effects)) ///
ctitle(Linear satisfaction with pay 1-7) ///
 long ///
 keep(i.skill##i.M_ i.wave ) ///
addnote(The models control for ///
 education age whether the respondent has children ///
 the size of the firm the industry and a factor variable ///
 for each wave. I also control for general job satisfaction ///
 and macro variables like the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 11-18, Weights, none)

xtreg jbsat4 i.skill##i.M_ ///
 i.perm i.quali ///
 i.catage i.child ///
 i.jbsize1 i.e11106  ///
 i.wave jbsat unemp growth ,fe
 
   outreg2 using UKpanel4.doc,  dec(2) ///
 append ///
 title (Subjective satisfaction and Skill (Fixed Effects)) ///
ctitle(Linear satisfaction with security 1-7) ///
 long ///
 keep(i.skill##i.M_ i.wave ) ///
addnote(The models control for ///
 education age whether the respondent has children ///
 the size of the firm the industry and a factor variable ///
 for each wave. I also control for general job satisfaction ///
 and macro variables like the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 11-18, Weights, none)

xtreg jbsat6 i.skill##i.M_ ///
 i.perm i.quali ///
 i.catage i.child ///
 i.jbsize1 i.e11106  ///
 i.wave jbsat unemp growth ,fe
 
   outreg2 using UKpanel4.doc,  dec(2) ///
 append ///
 title (Subjective satisfaction and Skill (Fixed Effects)) ///
ctitle(Linear satisfaction with work 1-7) ///
 long ///
 keep(i.skill##i.M_ i.wave ) ///
addnote(The models control for ///
 education age whether the respondent has children ///
 the size of the firm the industry and a factor variable ///
 for each wave. I also control for general job satisfaction ///
 and macro variables like the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 11-18, Weights, none)

xtreg jbsat7 i.skill##i.M_ ///
 i.perm i.quali ///
 i.catage i.child ///
 i.jbsize1 i.e11106  ///
 i.wave jbsat unemp growth ,fe
 
  outreg2 using UKpanel4.doc,  dec(2) ///
 append ///
 title (Subjective satisfaction and Skill (Fixed Effects)) ///
ctitle(Linear satisfaction with hours 1-7) ///
 long ///
 keep(i.skill##i.M_ i.wave ) ///
addnote(The models control for ///
 education age whether the respondent has children ///
 the size of the firm the industry and a factor variable ///
 for each wave. I also control for general job satisfaction ///
 and macro variables like the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 11-18, Weights, none)


 
 
 **contract differences
 
 xtreg jbsat2 i.skill i.perm##i.M_ ///
  i.quali ///
 i.catage i.child ///
 i.jbsize1 i.e11106  ///
 i.wave jbsat unemp growth ,fe
 
    outreg2 using UKpanel5.doc,  dec(2) ///
 replace ///
 title (Subjective satisfaction and Contract (Fixed Effects)) ///
ctitle(Linear satisfaction with pay 1-7) ///
 long ///
 keep(i.perm##i.M_ i.wave ) ///
addnote(The models control for ///
 education age whether the respondent has children ///
 the size of the firm the industry and a factor variable ///
 for each wave. I also control for general job satisfaction ///
 and macro variables like the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 11-18, Weights, none)

xtreg jbsat4 i.skill i.perm##i.M_ ///
  i.quali ///
 i.catage i.child ///
 i.jbsize1 i.e11106  ///
 i.wave jbsat unemp growth ,fe
 
    outreg2 using UKpanel5.doc,  dec(2) ///
 append ///
 title (Subjective satisfaction and Contract (Fixed Effects)) ///
ctitle(Linear satisfaction with security 1-7) ///
 long ///
 keep(i.perm##i.M_ i.wave ) ///
addnote(The models control for ///
 education age whether the respondent has children ///
 the size of the firm the industry and a factor variable ///
 for each wave. I also control for general job satisfaction ///
 and macro variables like the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 11-18, Weights, none)

xtreg jbsat6 i.skill i.perm##i.M_ ///
  i.quali ///
 i.catage i.child ///
 i.jbsize1 i.e11106  ///
 i.wave jbsat unemp growth ,fe
 
      outreg2 using UKpanel5.doc,  dec(2) ///
 append ///
 title (Subjective satisfaction and Contract (Fixed Effects)) ///
ctitle(Linear satisfaction with work 1-7) ///
 long ///
 keep(i.perm##i.M_ i.wave ) ///
addnote(The models control for ///
 education age whether the respondent has children ///
 the size of the firm the industry and a factor variable ///
 for each wave. I also control for general job satisfaction ///
 and macro variables like the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 11-18, Weights, none)

xtreg jbsat7 i.skill i.perm##i.M_ ///
  i.quali ///
 i.catage i.child ///
 i.jbsize1 i.e11106  ///
 i.wave jbsat unemp growth ,fe
 
     outreg2 using UKpanel5.doc,  dec(2) ///
 append ///
 title (Subjective satisfaction and Contract (Fixed Effects)) ///
ctitle(Linear satisfaction with hours 1-7) ///
 long ///
 keep(i.perm##i.M_ i.wave ) ///
addnote(The models control for ///
 education age whether the respondent has children ///
 the size of the firm the industry and a factor variable ///
 for each wave. I also control for general job satisfaction ///
 and macro variables like the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 11-18, Weights, none)

 
 
**base idea w/ categorical variables

recode jbsat2 jbsat4 jbsat6 jbsat7 (1/3=1) (4=2) (5/7=3)

  
  recode pay3 (1=1) (0=2), gen(tag)
  
  tab tag
  gen tag2= L.tag*10
  tab tag2
  gen tag3= tag+tag2
  tab tag3
 tab M_event if tag3==21
 
*sataisfaction with pay

xtlogit pay3 i.M_  ///
 i.quali i.catage i.child ///
 i.jbsize1 i.e11106  ///
 i.wave jbsat,fe nolog 
 xtlogit , or

 outreg2 using UKpanel.doc,  dec(2) ///
 replace ///
 title (Subjective satisfaction (Fixed Effects)) ///
ctitle(Binary satisfaction with pay) ///
 long ///
 keep(i.M_e i.catage i.catage) ///
addnote(The models control for ///
 education age whether the respondent has children ///
 the size of the firm the industry and a factor variable ///
 for each wave. These estimates can be found in the appendix.) ///
addtext(Wave, 11-18, Weights, none)

******************************************************
**satisfaction with security


tab jbsat4
xttrans jbsat4
tab jbsat4, gen(secure)

tab jbsat4 secure3

xtlogit secure3 i.M_  ///
 i.quali i.catage i.child ///
 i.jbsize1 i.e11106  ///
 i.wave jbsat,fe nolog 
 xtlogit, or
 
 outreg2 using UKpanel.doc,  dec(2) ///
 append ///
 title (Subjective satisfaction (Fixed Effects)) ///
ctitle(Binary satisfaction with security) ///
 long ///
 keep(i.M_e i.catage i.catage) ///
addnote(The models control for ///
 education age whether the respondent has children ///
 the size of the firm the industry and a factor variable ///
 for each wave. These estimates can be found in the appendix.) ///
addtext(Wave, 11-18, Weights, none)

********************************************************************
***satisfaction with work



tab jbsat6
xttrans jbsat6
tab jbsat6, gen(work)

tab jbsat6 work3

xtlogit work3 i.M_  ///
 i.quali i.catage i.child ///
 i.jbsize1 i.e11106  ///
 i.wave jbsat,fe nolog 
 xtlogit, or
 
 outreg2 using UKpanel.doc,  dec(2) ///
 append ///
 title (Subjective satisfaction (Fixed Effects)) ///
ctitle(Binary satisfaction with work) ///
 long ///
 keep(i.M_e i.catage) ///
addnote(The models control for ///
 education age whether the respondent has children ///
 the size of the firm the industry and a factor variable ///
 for each wave. These estimates can be found in the appendix.) ///
addtext(Wave, 11-18, Weights, none)


********************************************************************
***satisfaction with hours

tab jbsat7
xttrans jbsat7
tab jbsat7, gen(hours)

tab jbsat7 hours3

xtlogit hours3 i.M_  ///
 i.quali i.catage i.child ///
 i.jbsize1 i.e11106  ///
 i.wave jbsat,fe nolog 
 xtlogit, or
 
 outreg2 using UKpanel.doc,  dec(2) ///
 append ///
 title (Subjective satisfaction (Fixed Effects)) ///
ctitle(Binary satisfaction with hours) ///
 long ///
 keep(i.M_e i.catage) ///
addnote(The models control for ///
 education age whether the respondent has children ///
 the size of the firm the industry and a factor variable ///
 for each wave. These estimates can be found in the appendix.) ///
addtext(Wave, 11-18, Weights, none)



xttrans cat


 
 
 margins catage, at(M_eve=(1 2 5) wave=(12)) /// 
 atmeans
marginsplot, horizon

tab age

 tab catage


 
 **drop "sex"
 xtlogit pay3 i.M_ i.skill i.perm ///
 i.qfedhi c.age##c.age i.child ///
 i.jbsize i.e11106 unemployment growth ///
 i.wave,fe nolog
 
 margins, at(M_eve=(1/7) skill=(1) permanent=(1) /// 
child=(1) jbsize=(3) e11106=(9)) atmeans
marginsplot, horizon
 
 **interact with "sex"
 
  xtlogit pay3 i.sex##i.M_ i.skill i.perm ///
 ib3.qfedhi c.age##c.age i.child ///
 i.jbsize ib9.e11106 unemployment growth ///
 i.wave,fe nolog
 
  margins sex, at(M_eve=(1/7) permanent=(1) /// 
child=(1) jbsize=(3)) atmeans
marginsplot, horizon

  xtlogit pay3 i.skill##i.M_ i.perm ///
 i.qfedhi c.age##c.age i.child ///
 i.jbsize unemployment growth ///
 i.wave,fe nolog
 
 margins skill, at(M_eve=(1/7) permanent=(1) /// 
child=(1) jbsize=(3)) atmeans
marginsplot, horizon
 
 ***********************************************8
 **************************************************
 **************************************************
 *******DATA WRINKLE*******************************
 **************************************************
 **************VOICE*******************************
 
 bys pid: gen nyear=[_N]
tab nyear
 keep if nyear==K

 ***base idea with linear variables.
 xtreg jbsat2 i.tuin i.Job ///
 i.perm i.skill i.quali ///
 i.catage i.child ///
 i.jbsize1 i.e11106  ///
 i.wave jbsat unemp growth ,fe
 
 
 tab M_event if e(sample)
 
 xtdescribe
 
 
 tab tuin
 
 xtreg jbsat2 i.tuin i.Job ///
 i.perm i.skill i.quali ///
 i.catage i.child ///
 i.jbsize1 i.e11106  ///
 i.wave jbsat unemp growth ,fe
 
 
   outreg2 using UKpanel_UNION.doc,  dec(2) ///
 replace ///
 title (Subjective satisfaction (Fixed Effects)) ///
ctitle(Linear satisfaction with pay 1-7) ///
 long ///
 keep(i.tuin i.Job i.wave) ///
addnote(The models also control for ///
 contract skill education age whether the respondent ///
 has children ///
 the size of the firm the industry and a factor variable ///
 for each wave. I also control for general job satisfaction ///
 and macro variables like the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 11-18, Weights, none)


 xtreg jbsat4 i.tuin i.Job ///
 i.perm i.skill i.quali ///
 i.catage i.child ///
 i.jbsize1 i.e11106  ///
 i.wave jbsat unemp growth ,fe
 
 
   outreg2 using UKpanel_UNION.doc,  dec(2) ///
 append ///
 title (Subjective satisfaction (Fixed Effects)) ///
ctitle(Linear satisfaction with security 1-7) ///
 long ///
 keep(i.tuin i.Job i.wave) ///
addnote(The models also control for ///
 contract skill education age whether the respondent ///
 has children ///
 the size of the firm the industry and a factor variable ///
 for each wave. I also control for general job satisfaction ///
 and macro variables like the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 11-18, Weights, none)

xtreg jbsat6 i.tuin i.Job ///
 i.perm i.skill i.quali ///
 i.catage i.child ///
 i.jbsize1 i.e11106  ///
 i.wave jbsat unemp growth ,fe
 
 
   outreg2 using UKpanel_UNION.doc,  dec(2) ///
 append ///
 title (Subjective satisfaction (Fixed Effects)) ///
ctitle(Linear satisfaction with work 1-7) ///
 long ///
 keep(i.tuin i.Job i.wave) ///
addnote(The models also control for ///
 contract skill education age whether the respondent ///
 has children ///
 the size of the firm the industry and a factor variable ///
 for each wave. I also control for general job satisfaction ///
 and macro variables like the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 11-18, Weights, none)

xtreg jbsat7 i.tuin i.Job ///
 i.perm i.skill i.quali ///
 i.catage i.child ///
 i.jbsize1 i.e11106  ///
 i.wave jbsat unemp growth ,fe
 
   outreg2 using UKpanel_UNION.doc,  dec(2) ///
 append ///
 title (Subjective satisfaction (Fixed Effects)) ///
ctitle(Linear satisfaction with hours 1-7) ///
 long ///
 keep(i.tuin i.Job i.wave) ///
addnote(The models also control for ///
 contract skill education age whether the respondent ///
 has children ///
 the size of the firm the industry and a factor variable ///
 for each wave. I also control for general job satisfaction ///
 and macro variables like the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 11-18, Weights, none)


xtreg jbsat2 i.tuin##i.Job ///
 i.perm i.skill i.quali ///
 i.catage i.child ///
 i.jbsize1 i.e11106  ///
 i.wave jbsat unemp growth ,fe
 
