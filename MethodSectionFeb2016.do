version 12
clear all
set more off
capture log close

cd "F:\"
global datadir "F:\BHPS\UKDA-5151-stata8\stata8"
global datadir2 "F:\CNEF-BHPS"
global dir "C:\My Documents\"



 *--------------------------------------------------------------------

 foreach wave in a b c d e f g h i j k l m n o p q r {
 use `wave'hid pid `wave'sex `wave'mastat ///
 `wave'age `wave'qfachi `wave'paygu ///
 `wave'jbft `wave'region `wave'jbsoc ///
 `wave'jbbgy4 `wave'jbsemp `wave'jbstat ///
 `wave'cjsten `wave'jbgold `wave'jbisco ///
 `wave'jbhrs `wave'jbft `wave'qfedhi ///
 `wave'tuin1 `wave'paynty ///
 `wave'jbsize `wave'doim `wave'doiy4 ///
 `wave'jbsat2 `wave'jbsat4 `wave'jbsat6 `wave'jbsat7 /// 
 `wave'jbsat `wave'jbterm* `wave'nchild ///
 `wave'jbsic* `wave'xrwght `wave'xewght `wave'lrwght ///
  `wave'lewght* ///
  using "$datadir/`wave'indresp", clear
 rename `wave'* *
 // deal with wave p
 capture rename id pid
 capture rename `wave'jbterm1 jbterm 
 capture rename `wave'jbsic92 jbsic
 generate wave = index("abcdefghijklmnopqr","`wave'")
 if indexnot("a","`wave'") append using "$dir\DataFile"
 save "$dir\DataFile", replace
 }
 
bysort pid wave: generate TotSpells = _N

gen permanent = 1 if jbterm==1 | jbterm1==1
tab jbterm1 perm,m
tab jbterm perm,m 
replace permanent = 0 if jbterm==2 | jbterm1==2
tab jbterm perman ,m
tab jbterm1 perman ,m

lab var permanent "Job contract is permanenet"
 lab define permanent_label ///
 1 "Permanent" ///
 0 "Temporary", replace
 
 label values permanent permanent_label
 tab permanent

tab jbterm
tab wave
tsset pid wave
tab doiy4
xttrans perman
/*
this section discusses the weights available in the
individual response files. there are a total of four
weights available
lrwght-is the longitudinal response
lewght- is the enumerated longitudinal response
xrwght- is the cross sectional response
xewght- is the enumerated cross sectional response
*/

summ lrwght lewght xrwght xewght
sort pid wave
list pid wave jbsat4 jbsat2 ///
lrwght lewght xrwght xewght if ///
pid==10016848, sepby(pid)



*********************************************************************

**coding variables and dealing with missing values

tab sex
tab sex,nolabel
recode sex (-7=.)(1=0)(2=1) ,gen(female)
tab sex female,missing
**************************************************
lab var female "Dummy variable, respondent female"
 lab define female_label ///
 0 "male" ///
 1 "female"
 label values female female_label
 tab sex female,missing

**************************************************
**************************************************
*******************Merging removes case**************************************************
*******************only merge when comfortable dropping**************************************************
*******************cases etc**************************************************
*********************************************************************
**********************************************************


merge 1:1 pid wave using "$datadir/finaljobhist"
tab wave
tab _merge
keep if _merge==3
tab _merge
drop _merge

mvdecode _all ,mv(-1/-10)

tab Job empchng,m
tab mobility empch,m

tab JobMov
tab JobM jspno

tab JobMove perm,col
tab mobility perm, col
tab wave perm,m

tab wave jbterm,m
summ jbterm jbterm1
tab wave permanen,m
tab mobility perman,row
tab Job perm,col

table JobMo, c(mean cjsten)

table JobMo, c(mean nchild)
table JobMo, c(mean jbsic)
table wave, c(mean jbsic)
table wave, c(mean jbsic92)

table wave, c(mean jbsoc)
tab jbsoc

tab wave female,m
summ age
tab perman
tab wave perm,m


tab female,m
tab qfachi,nolabel
tab qfachi, gen(degree)



tab age
tab JobMove
tab nchild





tab perma
tab jbsize, nolabel
mvdecode jbsize, mv(10 11)
tab jbsize


table Job,c(mean jbsize)
tab jbsoc

encode jbisco, generate(isco)
summ isco
describe isco jbisco
gen recodeocc= real(jbisco)
describe isco jbisco recodeocc
recode recodeocc (0/999=.) (-9/-1=.) ///
(1000/1999=1) ///
(2000/2999=2) ///
(3000/3999=3) ///
(4000/4999=4) ///
(5000/5999=5) ///
(6000/6999=6) ///
(7000/7999=7) ///
(8000/8999=8) ///
(9000/9999=9) ///
,gen(isco10)


tab isco10
lab var isco10 "1 digit occupations"
 lab define isco10_label ///
 1 "managers" ///
 2 "professionals" ///
 3 "technicians and associate professionals" ///
 4 "clerical support workers" ///
 5 "services and sales workers" ///
 6 "skilled agriculture" ///
 7 "craft and related work" ///
 8 "plant and machinery workers" ///
 9 "elmentary work" ///
 , replace
 
 label values isco10 isco10_label
tab isco10,m




display 2329/365
tab jbsoc


tab qfachi



save "$datadir/MethodSection",replace

tab M_event

**************************************************************


use "$datadir/MethodSection", clear
tab Job empch,m
summ paygu
hist paygu
table JobMove, c(mean paygu)

xttab JobMove
xttrans JobMove

summ paygu
table wave, c(mean paygu)
*********************************************************************
tab Job
tab mobility
*****************************************************************************

tab jhstat
tab jbsoc
tab jbsemp
tab jbsize

tab jbsat
tab jbsat2
tab jbsat4


tab Job
xtdescribe


save "$datadir/MethodSection",replace
use "$datadir/MethodSection",clear
sort pid

use x11101LL year m11125 d11102LL m11126 d11101 ///
e11107  e11106 e11105 using ///
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

merge 1:1 pid wave using "$datadir/MethodSection"
tab wave,m
tab _merge,m
sort pid wave
keep if _merge==3
tab _merge
drop _merge

tab wave
tsset pid wave
tab Job empchng,m

table M_eve, c(mean paygu)
mvdecode _all, mv(-9/-1)

*************************************************************
**OUTLINE THE VARIOUS VARIABLES INTO THE NOTE CONTROLS ETC
*********************************************************
summ jbsat jbsat2 jbsat4 paygu jbterm jbterm1 ///
permanent m11126 m11125

summ jspno employed jhstat jhstpy mobility JobMove ///
M_event



tab jbsat,m
tab jbsat,nolabel m
recode jbsat (0=.)
tab jbsat,m
tab jbsat

tab jbsat2
recode jbsat2 (0=.)
tab jbsat2,m

tab jbsat4
recode jbsat4 (0=.)
tab jbsat4,m

summ paygu
table wave , c(mean paygu)

tab m11126, nolabel m
recode m11126 (.m=.)
tab m11126,m


tab m11125,m
recode m11125 (.m=.) (.s=.)
tab m11125,m

***************************************************
drop female
recode d11102LL (1=0) (2=1), gen(female)
tab wave female,m



tab e11106

tab jbsoc
table wave ,c(mean jbsoc)
tab isco10
 
 summ female qfedhi qfachi age nchild permanent ///
 jbsize jbsic* e11106 e11107 isco isco10


xtdescribe
tab Job,m
tab wave Job
sort wave
 
xttab Job

sort pid wave
list pid wave Job if pid==18888569 ///
 , sepby(pid)
*************************************
/*seria quits are coded in this way*/
tab Job 
label list JobMove_label

by pid (wave), sort: gen voluntary_quits = sum(JobMove == 2)
replace voluntary_quits = . if JobMove != 2

tab voluntary Job, m
list pid wave Job voluntary if pid== 10028005, ///
sepby(pid)

tab Job jhsta

tab voluntary

by pid (wave), sort: gen involuntary_quits = sum(JobMove == 3)
replace involuntary_quits = . if JobMove != 3

tab involuntary


list pid wave voluntary involuntary Job ///
employed in 500/900, sepby(pid)

*******************************************
/*mobility paper thoughts*/

/*okay we need a table for all of the variables,
like the one gesthuizen is using.*/

tab M_event, gen(M)

tab M_event M1
tab M_event M2
lab var M2 " Same job, same empolyer"
 lab define M2_label ///
 1 "same job" ///
 , replace
 
 label values M2 M2_label

tab M2

tab M_event M3
lab var M3 "Quit (Voluntary, external)"
 lab define M3_label ///
 1 "Quit" ///
 , replace
 
 label values M3 M3_label

tab M3

tab M_event M4
lab var M4 "Redundancy (Involuntary, external)"
 lab define M4_label ///
 1 "Redundant" ///
 , replace
 
 label values M4 M4_label

tab M_event M6
lab var M6 "Promotion (Voluntary Internal)"
 lab define M6_label ///
 1 "Promotion" ///
 , replace
 
 label values M6 M6_label
 tab M6
 
 tab M_event
 

 
 summ M* jbsat2 jbsat4 jbsat6 female
 
 mvdecode jbsat6, mv(0)
 
 
 summ M* jbsat2 jbsat4 jbsat6 female degree* ///
 age
 
 tab nchild
 
 recode nchild (0=0) (1=1) (2=2) (3/9=3) ,gen(child)
 
 tab child ,gen(child)
 
 tab child child1
lab var child1 "no kids present"
 lab define child1_label ///
 1 "no kids" ///
 , replace
 
 label values child1 child1_label
 tab child1
 
 tab nchild child2
lab var child2 "1 kid present"
 lab define child2_label ///
 1 "1 kid present" ///
 , replace
 
 label values child2 child2_label
 tab child2
 
 tab nchild child3
lab var child3 "2 kids present"
 lab define child3_label ///
 1 "2 kids present" ///
 , replace
 
 label values child3 child3_label
 tab nchild child3
 
 
 tab nchild child4
lab var child4 "3+ kids present"
 lab define child4_label ///
 1 "3+ kids present" ///
 , replace
 
 label values child4 child4_label
 tab nchild child4
 
  summ M* jbsat2 jbsat4 jbsat6 female degree* ///
 age child1 child2 child3 child4 perm
 
 tab e11106 
 mvdecode e11106 , mv(0)
 tab e11106, gen(indust) 
 
 
   summ M2 M3 M4 M6 jbsat2 jbsat4 jbsat6 ///
   female degree* age child1 child2 ///
   child3 child4 perm indust*
   
   tab M_even M6,nola
   
tab JobMove
   

   
  summ M2 M3 M4 M6 jbsat2 jbsat4 jbsat6 ///
   female degree* age child1 child2 ///
   child3 child4 perm indust*
    tab M_event M2

   
 tab M_event M2
 tab M_eve
 
 sort pid wave
 
 tab jbgold,nolabel
 
 recode jbgold (1 8 9 =1) (2 3 4 5 6 10 = 0) ///
 (7 11 = .) ,gen(skill)
 
 lab var skill "skill level of occupational class"
 lab define skill_label ///
 1 "skilled" ///
 2 "unskilled" ///
 , replace
 
 label values skill skill_label
 tab skill
 
 

 tab jbgold skill
 tab perm skill,col
 
 save "$datadir/MethodSection",replace

tab JobMove
tab mobility
