***chpater 3 do-file for the BHPS

version 12
 clear all
set more off
 capture log close

cd "F:\"
global datadir "F:\BHPS\UKDA-5151-stata8\stata8"
global dir "C:\Users\Administrator.admin-PC2\Desktop\BHPS"
global dir3 "C:\Users\Administrator.admin-PC2\Desktop\UnderstandingSociety"
global datadir2 "F:\CNEF-BHPS"


use "$datadir/MethodSection",clear

summ xrwght
summ perman skill Job mobility
tab mobility
tab Job empch,m
xttab mobility

tab mobility ,gen(mob1)
rename mob11 SameJob
rename mob12 ChangeJobKeptFirm
rename mob13 ChangedFirm

table wave [pw=xrwght], ///
 c(mean Same mean ChangeJob mean Changed) ///
 format(%9.2f)  cellwidth(20)
 
 tab wave mobility,row
 tab wave jhstat
 
 table sex, c(mean Same mean  ///
 ChangeJob mean Changed) ///
 format(%9.3f)  cellwidth(20)
 
 table wave [pw=xrwght] if sex==2, ///
 c(mean Same mean ChangeJob mean Changed) ///
 format(%9.2f)  cellwidth(20) 
 
  table wave [pw=xrwght] if sex==1, ///
 c(mean Same mean ChangeJob mean Changed) ///
 format(%9.2f)  cellwidth(20) 
 
 
  table permanent  [pw=xrwght] , ///
  c(N Same mean Same mean  ///
 ChangeJob mean Changed) ///
 format(%9.3f)  cellwidth(20)
 
 table wave  [pw=xrwght] if permanent==0, ///
  c(N Same mean Same mean  ///
 ChangeJob mean Changed) ///
 format(%9.3f)  cellwidth(20)
 
 
  table wave  [pw=xrwght] if permanent==1, ///
  c(N Same mean Same mean  ///
 ChangeJob mean Changed) ///
 format(%9.3f)  cellwidth(20)
 
 tab skill
 lab define skill_label ///
 1 "skilled" ///
 0 "unskilled", replace
 
 label values skill skill_label
 
  table skill [pw=xrwght], c(mean Same mean  ///
 ChangeJob mean Changed) ///
 format(%9.3f)  cellwidth(20)
 
  table wave [pw=xrwght] if skill==1, c(mean Same mean  ///
 ChangeJob mean Changed) ///
 format(%9.3f)  cellwidth(20)
 
   table wave [pw=xrwght] if skill==0, c(mean Same mean  ///
 ChangeJob mean Changed) ///
 format(%9.3f)  cellwidth(20)
 
 tab JobMove
tab JobMove, gen(vol)
rename vol1 nochange
rename vol2 voluntarymove
rename vol3 involuntarymove
rename vol4 othermove

xttab JobMove

table wave [pw=xrwght], ///
c(mean nochange mean voluntarymove   ///
 mean involuntarymove mean othermove) ///
 format(%9.3f)  cellwidth(13)
 
 table sex [pw=xrwght], c(mean nochange ///
 mean voluntarymove   ///
 mean involuntarymove mean othermove) ///
 format(%9.3f)  cellwidth(12)
 
 table wave [pw=xrwght] if sex==2, ///
c(mean nochange mean voluntarymove   ///
 mean involuntarymove mean othermove) ///
 format(%9.3f)  cellwidth(13)
 
  table wave [pw=xrwght] if sex==1, ///
c(mean nochange mean voluntarymove   ///
 mean involuntarymove mean othermove) ///
 format(%9.3f)  cellwidth(13)
 
   table permanent [pw=xrwght], ///
c(mean nochange mean voluntarymove   ///
 mean involuntarymove mean othermove) ///
 format(%9.3f)  cellwidth(13)

  table wave [pw=xrwght]if permanent == 0, ///
c( mean nochange mean voluntarymove   ///
 mean involuntarymove mean othermove) ///
 format(%9.3f)  cellwidth(13)
 
   table wave [pw=xrwght]if permanent == 1, ///
c( mean nochange mean voluntarymove   ///
 mean involuntarymove mean othermove) ///
 format(%9.3f)  cellwidth(13)

 table skill [pw=xrwght], ///
c(mean nochange mean voluntarymove   ///
 mean involuntarymove mean othermove) ///
 format(%9.3f)  cellwidth(13)
 
 table wave [pw=xrwght]if skill == 0, ///
c( mean nochange mean voluntarymove   ///
 mean involuntarymove mean othermove) ///
 format(%9.3f)  cellwidth(13)
 
  table wave [pw=xrwght]if skill == 1, ///
c( mean nochange mean voluntarymove   ///
 mean involuntarymove mean othermove) ///
 format(%9.3f)  cellwidth(13)
