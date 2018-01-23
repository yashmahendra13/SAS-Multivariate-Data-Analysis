*;
*;
    ods graphics on;
*;
* MANOVA Model 1: X19 X20 X21 = X5;
*;
options ls=80 ps=50 nodate pageno=1;
*;
* Input HBAT200 ;
*;
Data HBAT200;
Infile 'C:\Documents and Settings\Thomas F Brantle\My Documents\Stevens_2006\Stevens_Teaching\BIA_652_Multivariate_2013_Summer I\Class_11_Chapter 7\HBAT200_Tabs.txt' DLM = '09'X TRUNCOVER;
Input ID X1 X2 X3 X4 X5 X6 X7 X8 X9 X10 X11 X12 X13 X14 X15 X16 X17 X18 X19 X20 X21 X22 X23;
*;
Data HBAT200;
	Set HBAT200 (Keep = X5 X19 X20 X21);
	Label X5 = 'X5 - Distribution System'
          X19 = 'X19 - Satisfaction'
		  X20 = 'X20 - Likely to Recommend'
		  X21 = 'X21 - Likely to Purchase';
*;
Proc Print Data = HBAT200;
*;
* Exploratory Data Analysis - Means ;
*;
*  X19 - Satisfaction;
*;
Proc Means Data = HBAT200;
    Var X19 X20 X21;
*;
Proc Sort Data = HBAT200;
    By X5;
*;
Proc Means Data = HBAT200;
    Var X19 X20 X21;
	By X5;
	ID X5;
*;
* Exploratory Data Analysis - Univariate ;
*;
*  X19 - Satisfaction;
*;
Proc Univariate Data = HBAT200 Normal Plot;
    Var X19 X20 X21;
*;
Proc Sort Data = HBAT200;
    By X5;
*;
Proc Univariate Data = HBAT200 Normal Plot;
    Var X19 X20 X21;
	By X5;
	ID X5;
*;
* GLM MANOVA Analysis ;
*;
Proc GLM Data = HBAT200;
    Class X5;
	Model X19 X20 X21 = X5;
	Means X5 / Scheffe Tukey LSD SNK Duncan;
	Means X5 / Hovtest = Levene Hovtest = bf Hovtest = Bartlett;
	Means X5;
	Manova H = X5 / MStat = Exact;
*;
*;
Run;
Quit;
