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

xtdescribe
xtsum ln_gross


summ i.M_eve ///
 z_* jbhrs paygu ln_* i.sex  ///
 i.agecat i.child i.permanen i.jbsize1  ///
 i.industry i.isco10 i.wave ///
 growth unemp, separator(0) ///
  fvwrap(1) fvwrapon(width) 

  ********satisfaction with work*************
   xtreg z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth, vce(robust) fe 
 
 outreg2 using UKpanel2.doc,  dec(2) ///
 replace ///
 title (Subjective satisfaction (Fixed Effects)) ///
ctitle(Satisfaction with work, linear z-scores) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
  firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for general job satisfaction in each model (except for the model estimating satisfaction with work) ///
 and macro variables like the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)
 
 tab educ if e(sample)
 tab M_event if e(sample)
 
 ****satisfaction with pay**
   xtreg z_paysat z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth, vce(robust) fe 
 
  outreg2 using UKpanel2.doc,  dec(2) ///
 append ///
 title (Subjective satisfaction (Fixed Effects)) ///
ctitle(Satisfaction with pay, linear z-scores) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
 firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for general job satisfaction in each model (except for the model estimating satisfaction with work) ///
 and macro variables like the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)
 
 tab M_event if e(sample)
 
 *satisfaction with security***
   xtreg z_securit z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth, vce(robust) fe
 
   outreg2 using UKpanel2.doc,  dec(2) ///
 append ///
 title (Subjective satisfaction (Fixed Effects)) ///
ctitle(Satisfaction with security, linear z-scores) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
 firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for general job satisfaction in each model (except for the model estimating satisfaction with work) ///
 and macro variables like the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)
 
 tab M_event if e(sample)
 
 **satisfaction with time**
 xtreg z_time z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth, vce(robust) fe
 
    outreg2 using UKpanel2.doc,  dec(2) ///
 append ///
 title (Subjective satisfaction (Fixed Effects)) ///
ctitle(Satisfaction with time, linear z-scores) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
 firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for general job satisfaction in each model (except for the model estimating satisfaction with work) ///
 and macro variables like the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)

tab M_event if e(sample)
 
    *********************************************************************

	
	 xtreg ln_gross i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth, vce(robust) fe
 
     outreg2 using UKpanel_obje.doc,  dec(2) ///
 replace ///
 title (Objective outcomes (Fixed Effects)) ///
ctitle(Log Gross monthly pay) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
 firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)
 
	 xtreg health i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth, vce(robust) fe
 
      outreg2 using UKpanel_obje.doc,  dec(2) ///
 append ///
 title (Objective outcomes (Fixed Effects)) ///
ctitle(Subjective health) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
 firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)
 
 
	 xtreg jbhrs i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth, vce(robust) fe
 
 
      outreg2 using UKpanel_obje.doc,  dec(2) ///
 append ///
 title (Objective outcomes (Fixed Effects)) ///
ctitle(Number of hours worked) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
 firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)
 
 
 
 ******************differences between workers****************************************
 **gender**
 	 xtreg z_worksat i.M_ i.agecat ib1.perm  ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if sex==1, vce(robust) fe
 
 
      outreg2 using UK_gender_sub.doc,  dec(2) ///
 replace ///
 title (Objective outcomes) ///
ctitle(Male: z-score work sat) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
  firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)
 
 	 xtreg z_worksat i.M_ i.agecat ib1.perm  ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if sex==2, vce(robust) fe
 
   outreg2 using UK_gender_sub.doc,  dec(2) ///
 append ///
 title (Objective outcomes) ///
ctitle(Female: z-score work sat) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
 firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)

 	 xtreg z_pay z_worksat i.M_ i.agecat ib1.perm  ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if sex==1, vce(robust) fe

    outreg2 using UK_gender_sub.doc,  dec(2) ///
 append ///
 title (Objective outcomes) ///
ctitle(Male: z-score pay sat) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
 firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)

 	 xtreg z_pay z_worksat i.M_ i.agecat ib1.perm  ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if sex==2, vce(robust) fe
 
     outreg2 using UK_gender_sub.doc,  dec(2) ///
 append ///
 title (Objective outcomes) ///
ctitle(Female: z-score pay sat) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
 firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)

 *gender part 2
 
  xtreg z_security z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if sex==1, vce(robust) fe
 
     outreg2 using UK_gender2_sub.doc,  dec(2) ///
 replace ///
 title (Objective outcomes) ///
ctitle(Male: z-score secure sat) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
 firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)
 
 xtreg z_security z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if sex==2, vce(robust) fe
 
     outreg2 using UK_gender2_sub.doc,  dec(2) ///
 append ///
 title (Objective outcomes) ///
ctitle(Female: z-score secure sat) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
 firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)

xtreg z_time z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if sex==1, vce(robust) fe
 
     outreg2 using UK_gender2_sub.doc,  dec(2) ///
 append ///
 title (Objective outcomes) ///
ctitle(Female: z-score time sat) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
 firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)

xtreg z_time z_worksat i.M_ i.agecat ib1.perm  ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if sex==2, vce(robust) fe
 
   outreg2 using UK_gender2_sub.doc,  dec(2) ///
 append ///
 title (Objective outcomes) ///
ctitle(Female: z-score time sat) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
 firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)
 
 ***************************************************
xtreg ln_gross z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if sex==1, vce(robust) fe
 
   outreg2 using UK_gender_obj.doc,  dec(2) ///
 replace ///
 title (Objective outcomes) ///
ctitle(Male: Log gross monthly wage) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
  firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)

 
xtreg ln_gross z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if sex==2, vce(robust) fe
 
    outreg2 using UK_gender_obj.doc,  dec(2) ///
 append ///
 title (Objective outcomes) ///
ctitle(Female: Log gross monthly wage) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
 firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)

xtreg health z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if sex==1, vce(robust) fe
 
    outreg2 using UK_gender_obj.doc,  dec(2) ///
 append ///
 title (Objective outcomes) ///
ctitle(Male: Subjective health) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
 firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)

xtreg health z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if sex==2, vce(robust) fe
 
    outreg2 using UK_gender_obj.doc,  dec(2) ///
 append ///
 title (Objective outcomes) ///
ctitle(Female: Subjective health) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
 firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)

xtreg jbhrs z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if sex==1, vce(robust) fe
 
    outreg2 using UK_gender_obj.doc,  dec(2) ///
 append ///
 title (Objective outcomes) ///
ctitle(Male: weekly work hours) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
 firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)

xtreg jbhrs z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if sex==2, vce(robust) fe
 
     outreg2 using UK_gender_obj.doc,  dec(2) ///
 append ///
 title (Objective outcomes) ///
ctitle(Female: weekly work hours) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
 firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)


 
 ****education
 
 xtreg z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if educ==3, vce(robust) fe
 
   outreg2 using UK_educ_obj.doc,  dec(2) ///
 replace ///
 title (Objective outcomes) ///
ctitle(basic education lvl: satisfaction with work) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)

 xtreg z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if educ==2, vce(robust) fe
 
   outreg2 using UK_educ_obj.doc,  dec(2) ///
 append ///
 title (Objective outcomes) ///
ctitle(secondary education lvl: satisfaction with work) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
 firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)

xtreg z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if educ==1, vce(robust) fe
 
   outreg2 using UK_educ_obj.doc,  dec(2) ///
 append ///
 title (Objective outcomes) ///
ctitle(third lvl education: satisfaction with work) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)

xtreg z_pay z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if educ==3, vce(robust) fe
 
    outreg2 using UK_educ_obj.doc,  dec(2) ///
 append ///
 title (Objective outcomes) ///
ctitle(basic lvl education: satisfaction with pay) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)
 
 xtreg z_pay z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if educ==2, vce(robust) fe
 
    outreg2 using UK_educ_obj.doc,  dec(2) ///
 append ///
 title (Objective outcomes) ///
ctitle(secondary lvl education: satisfaction with pay) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)

 xtreg z_pay z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if educ==1, vce(robust) fe
 
     outreg2 using UK_educ_obj.doc,  dec(2) ///
 append ///
 title (Objective outcomes) ///
ctitle(third lvl education: satisfaction with pay) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)

 
 xtreg z_security z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if educ==3, vce(robust) fe
 
   outreg2 using UK_educ2_obj.doc,  dec(2) ///
 replace ///
 title (Objective outcomes) ///
ctitle(basic education lvl: satisfaction with security) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)

 xtreg z_security z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if educ==2, vce(robust) fe
 
   outreg2 using UK_educ2_obj.doc,  dec(2) ///
 append ///
 title (Objective outcomes) ///
ctitle(secondary education lvl: satisfaction with security) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
 firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)

xtreg z_security z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if educ==1, vce(robust) fe
 
   outreg2 using UK_educ2_obj.doc,  dec(2) ///
 append ///
 title (Objective outcomes) ///
ctitle(third lvl education: satisfaction with security) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)

xtreg z_time z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if educ==3, vce(robust) fe
 
    outreg2 using UK_educ2_obj.doc,  dec(2) ///
 append ///
 title (Objective outcomes) ///
ctitle(basic lvl education: satisfaction with time) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)
 
 xtreg z_time z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if educ==2, vce(robust) fe
 
    outreg2 using UK_educ2_obj.doc,  dec(2) ///
 append ///
 title (Objective outcomes) ///
ctitle(secondary lvl education: satisfaction with time) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)

 xtreg z_time z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if educ==1, vce(robust) fe
 
     outreg2 using UK_educ2_obj.doc,  dec(2) ///
 append ///
 title (Objective outcomes) ///
ctitle(third lvl education: satisfaction with pay) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)



 
 
 
 
 ***obj
 xtreg ln_gross z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if educ==3, vce(robust) fe
 
   outreg2 using UK_educ_obj.doc,  dec(2) ///
 replace ///
 title (Objective outcomes) ///
ctitle(basic education lvl: log og gross monthly wage) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)

 xtreg ln_gross z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if educ==2, vce(robust) fe
 
   outreg2 using UK_educ_obj.doc,  dec(2) ///
 append ///
 title (Objective outcomes) ///
ctitle(secondary education lvl: log og gross monthly wage) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)

xtreg ln_gross z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if educ==1, vce(robust) fe
 
   outreg2 using UK_educ_obj.doc,  dec(2) ///
 append ///
 title (Objective outcomes) ///
ctitle(third lvl education: log og gross monthly wage) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)

xtreg health z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if educ==3, vce(robust) fe
 
    outreg2 using UK_educ_obj.doc,  dec(2) ///
 append ///
 title (Objective outcomes) ///
ctitle(basic lvl education: health) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)
 
 xtreg health z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if educ==2, vce(robust) fe
 
    outreg2 using UK_educ_obj.doc,  dec(2) ///
 append ///
 title (Objective outcomes) ///
ctitle(secondary lvl education: health) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)

 xtreg health z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if educ==1, vce(robust) fe
 
     outreg2 using UK_educ_obj.doc,  dec(2) ///
 append ///
 title (Objective outcomes) ///
ctitle(third lvl education: health) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)


************gender differences in objective outcomes are weird***********
 
  xtreg ln_gross z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if sex==2, vce(robust) fe
 
   xtreg ln_gross z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 jbhrs ///
 unemp growth if sex==1, vce(robust) fe
 
 ***the premium gained by women can be explained fully by working hours***************************
 
 
 
 
 ***********time **************************
 
  xtreg jbhrs z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if educ==3, vce(robust) fe
 
     outreg2 using UK_educ_obj2.doc,  dec(2) ///
 replace ///
 title (Objective outcomes) ///
ctitle(basic lvl education: weekly working hours) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)

 xtreg jbhrs z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if educ==2, vce(robust) fe
 
      outreg2 using UK_educ_obj2.doc,  dec(2) ///
 append ///
 title (Objective outcomes) ///
ctitle(secondary lvl education: weekly working hours) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)

 xtreg jbhrs z_worksat i.M_ i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if educ==1, vce(robust) fe
 
    outreg2 using UK_educ_obj2.doc,  dec(2) ///
 append ///
 title (Objective outcomes) ///
ctitle(third lvl education: weekly working hours) ///
 long ///
 keep(i.M_e) ///
addnote(The models control for age/ contract/ ///
firm size/ whether the respondent has children ///
 the size of the firm the industry and survey wave. ///
 I also control for two macro variables/ the unemployment rate and the rate of ///
 economic growth. I list these estimates in the appendix.) ///
addtext(Wave, 10-18, Weights, Clustered SE)

**************************

  xtreg health z_worksat i.Job i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 ///
 unemp growth if educ==1, vce(robust) fe
 
 
  xtreg ln_gross z_worksat i.Job i.agecat ib1.perm ///
  ib3.jbsize1 i.wave i.child ///
 ib9.industry i.isco10 jbhrs ///
 unemp growth if educ==1, vce(robust) fe

