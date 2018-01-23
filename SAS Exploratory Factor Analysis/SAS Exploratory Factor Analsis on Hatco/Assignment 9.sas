*;
*;
* HATCO - Principal Components Analysis;
*;
    ods graphics on;
*;
options ls=80 ps=50 nodate pageno=1;
*;
ods all close;
ods pdf file = "C:\Users\YASH\Desktop\Semester 1\BIA 652\SAS Assignment\Assignment 9\Yash's Code\Assignment 9 HATCO_Factor_Analysis.pdf";
*;
* Input HATCO ;
*;
Data HATCO;
Infile 'C:\Users\YASH\Desktop\Semester 1\BIA 652\SAS Assignment\Assignment 9\Hatco Data\HATCO_X1-X7_Tabs.txt' DLM = '09'X TRUNCOVER;
Input X1 X2 X3 X4 X5 X6 X7 ;
*;
Data HATCO;
	Set HATCO (Keep = X1 X2 X3 X4 X5 X6 X7);
	Label X1 = 'X1 - Delivery Speed'
	      X2 = 'X2 - Price Level'
          X3 = 'X3 - Price Flexibility'
          X4 = 'X4 - Manufactures Image'
          X5 = 'X5 - Service'
          X6 = 'X6 - Salesforces Image'
          X7 = 'X7 - Product Quality';
*;
Proc Print Data = HATCO;
*;
* Principal Components Analysis - All Variables;
*;
Proc Princomp Data = HATCO Plots = ALL;
    Var X1 X2 X3 X4 X5 X6 X7;
*;
*;
************ All Variables - Method=Principal Rotation: None and Varimax ****************;
*;
Proc Factor Data = HATCO Method = Principal Rotate = None NFactors = 5 Simple MSA Plots = Scree MINEIGEN = 0
Reorder;
Var X1 X2 X3 X4 X5 X6 X7;

*;
* Exploratory Factor Analysis Rotate=Varimax All Variables ;
*;
Proc Factor Data = HATCO Method = Principal Rotate = Varimax NFactors = 5 Print Score Simple MSA Plots = Scree MINEIGEN = 0
Reorder;
    Var X1 X2 X3 X4 X5 X6 X7;

*;
************ Exploratory Factor Analysis Rotate=NONE X7 Deleted ; ****************;
*;
Proc Factor Data = HATCO Method = Principal Rotate = None NFactors = 4 Simple MSA Plots = Scree MINEIGEN = 0
Reorder;
Var X1 X2 X3 X4 X5 X6;

*;
* Exploratory Factor Analysis Rotate=Varimax X7 Deleted ;
*;
Proc Factor Data = HATCO Method = Principal Rotate = Varimax NFactors = 4 Print Score Simple MSA Plots = Scree MINEIGEN = 0
Reorder;
    Var X1 X2 X3 X4 X5 X6;

*;
************ Exploratory Factor Analysis Rotate=NONE X7 & X3 Deleted ; ****************;
*;
Proc Factor Data = HATCO Method = Principal Rotate = None NFactors = 3 Simple MSA Plots = Scree MINEIGEN = 0
Reorder;
Var X1 X2 X4 X5 X6;

*;
* Exploratory Factor Analysis Rotate=Varimax X7 & X3 Deleted ;
*;
Proc Factor Data = HATCO Method = Principal Rotate = Varimax NFactors = 3 Print Score Simple MSA Plots = Scree MINEIGEN = 0
Reorder;
    Var X1 X2 X4 X5 X6;

Run;
ods pdf close;
Quit;
