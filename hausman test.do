**hausman test 

version 12
clear all
set more off
capture log close



***germany
cd "e:\"
global datadir "e:\SOEP\SOEPlongSTARTINGPOINT"
use "$datadir/chapter_trends_germany", clear

xtdescribe

gen weekly = e11101/52
tab weekly
summ weekly
recode age(17/30=1) (31/45=2) (46/65=3) (65/200=4) ///
 , gen(agecat)

   gen gross_log= ln(grossmonth)
 gen net_log= ln(netmonth)

 summ gross_log
   bysort pid (syear): replace w11103=w11103[8]
rename m11125 health
 

********satisfaction with work*******
  xtreg z_worksat i.M_ , fe 
 
 
 estimates store fixed
 
  xtreg z_worksat i.M_ , re 
 
 estimates store random
 
 hausman fixed random
 
 ******************pay**********************
   xtreg gross_log i.M_, fe 
 
 estimates store delogwagefe
 
 
   xtreg gross_log i.M_ , re 
 
 
 estimates store delogwagere
 
 hausman delogwagefe delogwagere
 
 ****************UK*****************
 
 version 12
clear all
set more off
capture log close

cd "e:\"
global datadir "E:\BHPS\UKDA-5151-stata8\stata8"
global datadir2 "E:\CNEF-BHPS"
global dir "C:\My Documents\"
global tables "C:\Users\Administrator.admin-PC2\Desktop\Thesis pieces"

use "$datadir/chapter4_trends_uk",clear

xtreg z_worksat i.M_ , fe 

estimates store satfe

xtreg z_worksat i.M_ , re 

estimates store satre

hausman satfe satre

******************************************

xtreg ln_gross i.M_ , fe 

estimates store payfe

xtreg z_worksat i.M_ ,re 

estimates store payre

hausman payfe payre



 

 
 
