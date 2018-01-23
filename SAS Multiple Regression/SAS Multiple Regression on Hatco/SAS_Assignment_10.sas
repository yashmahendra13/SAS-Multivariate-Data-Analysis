*;
*;
* HATCO - Multiple Regression;
*;
    ods graphics on;
*;
options ls=80 ps=50 nodate pageno=1;
*;
ods all close;
ods pdf file = "C:\Users\YASH\Desktop\Semester 1\BIA 652\SAS Assignment\Assignment 10\Yash's Code\Assignment 10 HATCO_Factor_Analysis.pdf";
*;
* Input HATCO ;
*;
Data HATCO;
Infile 'C:\Users\YASH\Desktop\Semester 1\BIA 652\SAS Assignment\Assignment 10\Hatco Data\HATCO_X1-X14_Tabs.txt' DLM = '09'X TRUNCOVER;
Input X1 X2 X3 X4 X5 X6 X7 X8 X9 ;
*;
Data HATCO;
	Set HATCO (Keep = X1 X2 X3 X4 X5 X6 X7 X8 X9);
	Label X1 = 'X1 - Delivery Speed'
	      X2 = 'X2 - Price Level'
          X3 = 'X3 - Price Flexibility'
          X4 = 'X4 - Manufactures Image'
          X5 = 'X5 - Service'
          X6 = 'X6 - Salesforces Image'
          X7 = 'X7 - Product Quality'
		  X8 = 'X8 - Size of firm'
          X9 = 'X9 - Usage level'		 
;
*;
Proc Print Data = HATCO;
*;
*;
* Correlation Matrix - All Variables;
*;
Proc Corr Data = HATCO;
    Var X1 X2 X3 X4 X5 X6 X7 X8 X9;
*;

*;
* Regression Analysis - X9 = X5;
* Fit and Analyze the best single independent (simple) regression analysis;
*;
Proc Reg Data = HATCO plots(unpack);
	Model X9 = X5 / STB Influence P R VIF Tol;
	Plot NQQ.*R. NPP.*R.; * NQQ.*R and NPP.*R request specific separate Normal Quantile and Normal Probability Plots;
*;
	* Regression Analysis - General Model X9 = X1 X2 X3 X4 X5 X6 X7;
*;
Proc Reg Data = HATCO plots(unpack);
	Model X9 = X1 X2 X3 X4 X5 X6 X7 / STB Influence P R VIF Tol;
	Plot NQQ.*R. NPP.*R.;
*;
*;
*	Perform a Stepwise Regression Analysis to select the best subset model using Alpha = 0.05;
*;
Proc Reg Data = HATCO Corr Simple plots(unpack);
	Model X9 = X1 X2 X3 X4 X5 X6 X7 / Selection=Stepwise SLEntry=0.05 STB Influence P R VIF Tol;
	Plot NQQ.*R. NPP.*R.;
*;
*;
*;
*	Perform a Full Model (Confirmatory) Regression Analysis using Alpha = 0.05
*;
Proc Reg Data = HATCO Corr Simple plots(unpack);
	Model X9 = X3 X5 X6 / Selection=Stepwise SLEntry=0.05 STB Influence P R VIF Tol;
	Plot NQQ.*R. NPP.*R.;
*;
*;
*	Using the best subset from the Stepwise Regression Analysis now include variable X8 (Firm Size) 
	and analyze its effect and the new resultant model;
*;
Proc Reg Data = HATCO Corr Simple plots(unpack);
	Model X9 = X3 X5 X6 X8 / Selection=Stepwise SLEntry=0.05 STB Influence P R VIF Tol;
	Plot NQQ.*R. NPP.*R.;
*;
Run;
ods pdf close;
Quit;

