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
***********************************************

***********converting pay to 2008 dollars***********
 gen gross_dollars = paygu * 0.507 //as of Jan 2008
list paygu gross_dollars in 20/40
gen log_dollars = ln(gross_dollars)
**************************************************

  xtreg log_dollars i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth, vce(robust) fe 
 
 outreg2 using "$paperdir/CommitedStayers.doc",  dec(2) ///
 append ///
 title (Fixed Effects Estimates) ///
ctitle(UK Gross Wages (Log)) ///
 long ///
 keep(i.M_e) label(proper) ///
addnote("The models above control for age, contract, whether the respondent has children, the size of the firm, the industry, occupation, and survey wave. It also controls for two macro variables, the unemployment rate and the rate of economic growth. The full model is listed in the appendix.") ///
addtext(Years, 2000-2008, Weights, Clustered SE)

  xtreg log_dollars i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth jbhrs, vce(robust) fe 
 
 outreg2 using "$paperdir/CommitedStayers.doc",  dec(2) ///
 append ///
 title (Fixed Effects Estimates) ///
ctitle(UK Gross Wages (Log) Controling for Hours) ///
 long ///
 keep(i.M_e) label(proper) ///
addnote("The models above control for age, contract, whether the respondent has children, the size of the firm, the industry, occupation, and survey wave. It also controls for two macro variables, the unemployment rate and the rate of economic growth. The full model is listed in the appendix.") ///
addtext(Years, 2000-2008, Weights, Clustered SE)
