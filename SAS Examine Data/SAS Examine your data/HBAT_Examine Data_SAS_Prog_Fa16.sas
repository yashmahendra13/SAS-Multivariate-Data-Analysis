*;
*;
* HBAT - Examining Your Data PROC Univariate;
*;
    ods graphics on;
*;
options ls=80 ps=50 nodate pageno=1;
*;
* Input HBAT ;
*;
Data HBAT;
Infile 'N:\BIA652D_Multivariate Data Analytics_2016_Fall\Class_04_Chap 2\HBAT_tabs.txt' DLM = '09'X TRUNCOVER;
Input ID X1 X2 X3 X4 X5 X6 X7 X8 X9 X10 X11 X12 X13 X14 X15 X16 X17 X18 X19 X20 X21 X22 X23;
*;
Data HBAT;
	Set HBAT (Keep = X1 X2 X3 X4 X5 X6 X7 X8 X9 X10 X11 X12 X13 X14 X15 X16 X17 X18 X19 X20 X21 X22);
	Label X1 = 'X1 - Customer Type'
	      X2 = 'X2 - Industry Type'
          X3 = 'X3 - Firm Size'
          X4 = 'X4 - Region'
          X5 = 'X5 - Distribution System'
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
		  X19 = 'X19 - Customer Satisfaction'
          X20 = 'X20 - Likelihood of Recommending HBAT'
          X21 = 'X21 - Likelihood of Future Purchases from HBAT'
          X22 = 'X22 - Percentage of Purchases from HBAT';
*;
Proc Print Data = HBAT;
*;
* Proc Univariate - All Metric Variables X6 - X22;
*;
*   Only Var X6 X7 Illustrated ;
*;
Proc Univariate Data = HBAT Normal Plot;
*    Var X6 X7 X8 X9 X10 X11 X12 X13 X14 X15 X16 X17 X18 X19 X20 X21 X22;
     Var X6 X7;
*;
*;
* Proc Univariate - By Nonmetric Variables X1-X5 for All Metric Variables X6 - X22;
*;
*   Only Var X6 By X1 Illustrated ;
*;
Proc Sort Data = HBAT;
    By X1;
*;
Proc Univariate Data = HBAT Normal Plot;
    Var X6;
	By X1;
	ID X1;
*;
*   Only Var X7 By X1 Illustrated ;
*;
Proc Sort Data = HBAT;
    By X1;
*;
Proc Univariate Data = HBAT Normal Plot;
    Var X7;
	By X1;
	ID X1;
*;
*;
*;
* GLM ANOVA Analysis ;
*;
*   Only Var X6 By X1 Illustrated ;
*;
Proc GLM Data = HBAT;
    Class X1;
	Model X6 = X1;
	Means X1;
	Means X1 / hovtest = levene hovtest = bf hovtest = bartlett;
*;
*;
*   Only Var X7 By X1 Illustrated ;
*;
Proc GLM Data = HBAT;
    Class X1;
	Model X7 = X1;
	Means X1;
	Means X1 / hovtest = levene hovtest = bf hovtest = bartlett;
*;
*;
*;
*	ods graphics off;
*;
*;
Run;
Quit;
