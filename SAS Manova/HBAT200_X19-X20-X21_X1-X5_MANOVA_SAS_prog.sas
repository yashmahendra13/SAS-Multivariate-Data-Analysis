*;
*;
    ods graphics on;
*;
* MANOVA Model 2: X19 X20 X21 = X1 X5 X1*X5;
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
	Set HBAT200 (Keep = X1 X5 X19 X20 X21);
	Label X1 = 'X1 - Customer Type'
          X5 = 'X5 - Distribution System'
		  X19 = 'X19 - Satisfaction'
		  X20 = 'X20 - Likely to Recommend'
		  X21 = 'X21 - Likely to Purchase';
*;
Proc Print Data = HBAT200;
*;
* GLM MANOVA Analysis ;
*;
Proc GLM Data = HBAT200;
    Class X1 X5;
	Model X19 X20 X21 = X1 X5 X1*X5;
	Means X1 X5 X1*X5;
	Manova H = X1 X5 X1*X5 / MStat = Exact;
*;
*;
Run;
Quit;
