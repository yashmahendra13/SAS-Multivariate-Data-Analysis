*;
*;
* HBAT - Logistic Regression Analysis;
*;
*;
    ods graphics on;
*;
options ls=80 ps=50 nodate pageno=1;
*;
Title 'Chapter 6 Logistic Regression Example';
*;
* Input HBAT ;
*;
Data HBAT;
Infile 'C:\Documents and Settings\Thomas F Brantle\My Documents\Stevens_2006\Stevens_Teaching\BIA_652_Multivariate_2014_Spring\Class_09 Chapter 5-6\HBAT_Split60.txt' DLM = '09'X TRUNCOVER;
Input ID Split60 X1 X2 X3 X4 X5 X6 X7 X8 X9 X10 X11 X12 X13 X14 X15 X16 X17 X18 X19 X20 X21 X22 X23;
*;
Data HBAT;
	Set HBAT (Keep = ID Split60 X4 X6 X7 X8 X9 X10 X11 X12 X13 X14 X15 X16 X17 X18);
	Label ID = 'ID - Identification Number'
		  Split60 = 'Split60'
		  X4 = 'X4 - Region'
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
          X18 = 'X18 - Delivery Speed';
*;
* Create HBAT Split 60 (Original/Initial) and Split 40 (Validation/Holdout) Datasets ;
*;
Data HBAT60;
	Set HBAT;
	If Split60 = 0;
*;
Data HBAT40;
	Set HBAT;
	If Split60 = 1;
*;
Proc Print Data = HBAT60;
*;
Proc Print Data = HBAT40;
*;
*;
* Stepwise Logistic Regression Analysis - X4 = X6 X7 X8 X9 X10 X11 X12 X13 X14 X15 X16 X17 X18;
*;
* EVENT=’category’ | keyword
*        specifies the event category for the binary response model.
*;
* SELECTION = option specifies the method used to select the explanatory variables in the model. 
*             STEPWISE requests stepwise selection;
*;
* SLENTRY = option specifies the significance level for entry into the model
* SLSTAY = option specifies the significance level for staying in the model
*;
* DETAILS option produces detailed printout at each step of the model-building process
*;
* LACKFIT requests Hosmer and Lemeshow goodness-of-fit test
*;
* RSQUARE displays generalized R^2
*;
* CTABLE option requests the printing of a classification table for the final model produced by the procedure.
*;
* PPROB = option specifies possibly multiple cutpoints used to classify observations for the CTABLE option.
*         The values must be between 0 and 1. If the PPROB= option is not specified, the
*         default is to print the classification for a range of probabilities from the smallest estimated
*         probability (rounded below to the nearest .02) to the highest estimated probability (rounded above
*         to the nearest .02) with 0.02 increments. Note that the PPROB= option has no effect unless the
*         CTABLE option is also specified.
*;
*;
Proc Logistic Data = HBAT60;
	Model X4(event='0') = X6 X7 X8 X9 X10 X11 X12 X13 X14 X15 X16 X17 X18 
						/ Selection=Stepwise SLEntry=0.05 SLStay=0.05 Details 
							LackFit RSquare CTable PProb =(0 to 1 by .10);
*;
* Final Resultant Model and Output Model;
*;
Proc Logistic Data = HBAT60 OutModel=Logistic60;
	Model X4(event='0') = X13 X17
						/ LackFit RSquare CTable PProb =(0.40 to 0.60 by .01);
*;
* Original Split60 Logistic Model Fitted to Split40 validation Data;
*;
Proc Logistic InModel=Logistic60;
	Score Data = HBAT60 (Keep = X4 X13 X17) Out = HBAT60Score;
*;
* Proc Freq Crosstabulations Original and Holdout Validation Datasets;
*;
Proc Print Data = HBAT60Score;
Proc Freq Data = HBAT60Score;
	Table F_X4 * I_X4;
*;
Proc Logistic InModel=Logistic60;
	Score Data = HBAT40 (Keep = X4 X13 X17) Out = HBAT40Score;
Proc Print Data = HBAT40Score;
Proc Freq Data = HBAT40Score;
	Table F_X4 * I_X4;
*;
*;
*	ods graphics off;
*;
*;
Run;
Quit;
