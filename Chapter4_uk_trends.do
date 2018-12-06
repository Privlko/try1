version 12
clear all
set more off
capture log close

cd "F:\"
global datadir "F:\BHPS\UKDA-5151-stata8\stata8"
global datadir2 "F:\CNEF-BHPS"
global dir "C:\My Documents\"
global tables "C:\Users\Administrator.admin-PC2\Desktop\Thesis pieces"






use "$datadir/chapter4_trends_uk",replace

tab health
tab m11126

xtsum m11126

xttab perm
