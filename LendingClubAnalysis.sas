data loans;
	infile '/home/u42930892/Stat 448/loansub.csv' dlm=' ,' firstobs=2 dsd;
	input loan_amnt 
          funded_amnt 
          term :$20.
          int_rate 
          installments
          grade :$20.
          homeownership :$20.
          annualinc 
          loan_status :$20.
          purpose :$20. ;
run; 

/* tabulation of loan amount means, standard deviations, and counts by loan grade */
proc tabulate data=loans;
  class grade;
  var loan_amnt;
  table grade,
        loan_amnt*(mean std n);  
run;

/* tabulation of loan amount means, standard deviations, and counts by homeownership type */
proc tabulate data=loans;
  class homeownership;
  var loan_amnt;
  table homeownership,
        loan_amnt*(mean std n);  
run;

/* tabulation of loan amount means, standard deviations, and counts by loan purpose */
proc tabulate data=loans;
  class purpose;
  var loan_amnt;
  table purpose,
        loan_amnt*(mean std n);  
run;

/* tabulation of loan amount means, standard deviations, and counts by loan term */
proc tabulate data=loans;
  class term;
  var loan_amnt;
  table term,
        loan_amnt*(mean std n);  
run;

/* one-way ANOVA with only grade main effect */
proc anova data=loans;
	class grade;
	model loan_amnt = grade;
run;

/* one-way ANOVA with only homeownership main effect */
proc anova data=loans;
	class homeownership;
	model loan_amnt = homeownership;
run;

/* one-way ANOVA with only purpose main effect */
proc anova data=loans;
	class purpose;
	model loan_amnt = purpose;
run;

/* one-way ANOVA with only term main effect */
proc anova data=loans;
	class term;
	model loan_amnt = term;
run;

/* 2-way ANOVA testing all combinations */
proc glm data=loans;
	class grade homeownership;
	model loan_amnt = grade homeownership;
run;

proc glm data=loans;
	class grade purpose;
	model loan_amnt = grade purpose;
run;

proc glm data=loans;
	class grade term;
	model loan_amnt = grade term;
run;

proc glm data=loans;
	class homeownership purpose;
	model loan_amnt = homeownership purpose;
run;

proc glm data=loans;
	class homeownership term;
	model loan_amnt = homeownership term;
run;

proc glm data=loans;
	class purpose term;
	model loan_amnt = purpose term;
run;

/* 4-way ANOVA, testing different orders */
proc glm data=loans;
	class grade homeownership purpose term;
	model loan_amnt = grade homeownership purpose term/ss1 ss3;
run;
proc glm data=loans;
	class grade homeownership purpose term;
	model loan_amnt = homeownership purpose term grade/ss1 ss3;
run;
proc glm data=loans;
	class grade homeownership purpose term;
	model loan_amnt = purpose homeownership grade term/ss1 ss3;
run;
proc glm data=loans;
	class grade homeownership purpose term;
	model loan_amnt = term grade purpose homeownership/ss1 ss3;
run;

/* 4-way ANOVA w/ lsmeans */
proc glm data=loans;
	class grade homeownership purpose term;
	model loan_amnt = grade homeownership purpose term;
	lsmeans grade/pdiff=all cl;
	lsmeans homeownership/pdiff=all cl;
	lsmeans purpose/pdiff=all cl;
	lsmeans term/pdiff=all cl;
run;


