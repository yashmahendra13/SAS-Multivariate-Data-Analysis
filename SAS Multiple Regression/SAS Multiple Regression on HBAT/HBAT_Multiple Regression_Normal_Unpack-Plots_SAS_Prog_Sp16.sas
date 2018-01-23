*;
*;
* HBAT - Multiple Regression Analysis;
*;
    ods graphics on;
*;
options ls=80 ps=50 nodate pageno=1;
*;
* Input HBAT ;
*;
Data HBAT;
Infile 'N:\BIA652C_Multivariate Data Analysis_Spring 2016\Class_09_Chap 4\HBAT_tabs.txt' DLM = '09'X TRUNCOVER;
Input ID X1 X2 X3 X4 X5 X6 X7 X8 X9 X10 X11 X12 X13 X14 X15 X16 X17 X18 X19 X20 X21 X22 X23;
*;
Data HBAT;
	Set HBAT (Keep = ID X3 X6 X7 X8 X9 X10 X11 X12 X13 X14 X15 X16 X17 X18 X19);
	Label ID = 'ID - Identification Number'
		  X3 = 'X3 - Firm Size'
		  X6 = 'X6 - Product Quality'
	      X7 = 'X7 - E-Commerce'
          X8 = 'X8 - Technical Support'
          X9 = 'X9 - Complaint Resolution'
          X10 = 'X10 - Advertizing'
          X11 = 'X11 - Product Line'
          X12 = 'X12 - Salesforce Image'
          X13 = 'X13 - Competitive Pricing'
          X14 = 'X14 - Warranty & Claims'
          X15 = 'X15 - New Products'
          X16 = 'X16 - Order & Billing'
          X17 = 'X17 - Price Flexibility'
          X18 = 'X18 - Delivery Speed'
          X19 = 'X19 - Satisfaction';
*;
Proc Print Data = HBAT;
*;
*;
* Correlation Matrix - All Variables;
*;
Proc Corr Data = HBAT;
    Var X6 X7 X8 X9 X10 X11 X12 X13 X14 X15 X16 X17 X18 X19;
*;
*;
* Regression Analysis - X19 = X9;
*;
Proc Reg Data = HBAT plots(unpack);
	Model X19 = X9 / STB Influence P R VIF Tol;
	Plot NQQ.*R. NPP.*R.; * NQQ.*R and NPP.*R request specific separate Normal Quantile and Normal Probability Plots;
*;
*;
Proc Reg Data = HBAT Corr Simple plots(unpack);
	Model X19 = X6 X7 X8 X9 X10 X11 X12 X13 X14 X15 X16 X17 X18 / Selection=Stepwise SLEntry=0.05 STB Influence P R VIF Tol;
	Plot NQQ.*R. NPP.*R.;
*;
*;
Proc Reg Data = HBAT Corr Simple plots(unpack);
	Model X19 = X6 X7 X9 X11 X12 / STB Influence P R VIF Tol;
	Plot NQQ.*R. NPP.*R.;
*;
*;
Proc Reg Data = HBAT Corr Simple plots(unpack);
	Model X19 = X6 X7 X8 X9 X10 X11 X12 X13 X14 X15 X16 X17 X18 / STB Influence P R VIF Tol;
	Plot NQQ.*R. NPP.*R.;
*;
*;
Proc Reg Data = HBAT Corr Simple plots(unpack);
	Model X19 = X3 X6 X7 X9 X11 X12 / STB Influence P R VIF Tol;
	Plot NQQ.*R. NPP.*R.;
*;
*;
*	ods graphics off;
*;
*;
Run;
Quit;
