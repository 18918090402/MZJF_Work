libname junfang BASE "F:\WORKSPACE\RISK\chenjunfang";
data _null_;
call symput('day',put(date()-1,yymmddn8.));
run;
proc sql noprint;
select
max(ym_file) into: latest_ym
from junfang.loan_prem4plus;
quit;
data loan_ht;
set junfang.loan_prem4plus;
where product in ("白领包","应届贷" ,"社保贷" ,"其他大额贷" ,"消费贷" ,"学历贷" ,"本科包","名校贷应急包","专科包") and ym_disbursed ge 201701;
amt_term=disbursed_amt*term;
if ym_file= &latest_ym.;/*筛选出当月静态表，每月修改*/
run;
%macro contract (ds= , time_level=);
proc tabulate data=&ds  out=loan_ht_1(drop=_TYPE_ _PAGE_ _TABLE_ );
class  product_title product  &time_level. ;
var help  amt_term  disbursed_amt ;
tables (product_title='' product =''  all)*(help  amt_term  disbursed_amt disbursed_amt*mean),&time_level.;
run;
data loan_ht_2;
retain cate product_title product
help_Sum
term_avg
disbursed_amt_sum
disbursed_amt_mean;
set loan_ht_1;
cate=compress(product_title||product);
if cate="" then cate="all";
term_avg=amt_term_Sum/disbursed_amt_sum;	
run;
proc sort data= loan_ht_2 nodupkey ;
by 
cate
&time_level.
help_Sum
term_avg
disbursed_amt_sum
disbursed_amt_mean
;
run;
proc transpose data= loan_ht_2(drop=amt_term_sum)   out=loan_ht_3;
by  cate  ;
id  &time_level. ;
/*var   ;*/
run;
%mend;
/*导出表格*/
%contract (ds=loan_ht , time_level=month);
%macro output(Table_List);
%let condition=0;
%let i=1;
%do %until(&condition=1);
	%let F=%scan(&Table_List,&i,' ');
	%let TableName&i=&F;
	%if &F= %then %let condition=1;
	%let N=%eval(&i-1);%put N=&N;
	%let i=%eval(&i+1);
%end;
%do i=1 %to &N;
	proc export data=&&TableName&i.
	outfile="F:\Workspace\risk\chenjunfang\dashboard\ht_&day..xlsx" 
		dbms=xlsx label replace ;
		SHEET="&&TableName&i.";
	run;
%end;
%mend;
%output(loan_ht_3)