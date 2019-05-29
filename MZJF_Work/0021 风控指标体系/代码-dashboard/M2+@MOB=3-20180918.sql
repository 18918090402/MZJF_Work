/*申请表保留当前省份&城市*/
data _null_;
call symput('day',put(date()-1,yymmddn8.));
run;
data apply(keep=apply_no product CURRENT_PROVINCE_new CURRENT_CITY_new  apply_Date );
set risk.apply_&day ;
if CURRENT_PROVINCE ne "" then CURRENT_PROVINCE_new=CURRENT_PROVINCE;
else CURRENT_PROVINCE_new="缺失";
if CURRENT_CITY ne "" then CURRENT_CITY_new=CURRENT_CITY;
else CURRENT_CITY_new="缺失";
where product in ("白领包","应届贷" ,"社保贷" ,"其他大额贷" ,"消费贷" ,"学历贷" ,"本科包","名校贷应急包","专科包");
run;
data loan;
set junfang.loan_prem4plus;
  where 201701 le ym_disbursed le 201809
  and product in ("白领包","应届贷" ,"社保贷" ,"其他大额贷" ,"消费贷" ,"学历贷" ,"本科包","名校贷应急包","专科包");
run;
proc sql;
create table loan_1 as select loan.*,apply.*
from work.loan left join work.apply
on loan.apply_no=apply.apply_no;
quit;
%macro M2plus (base1= ,time_level=);
	proc tabulate data= loan_1 out=loan_deno (drop= _TYPE_ _PAGE_	_TABLE_);
		class &base1 &time_level;
		var disbursed_amt_new;
		tables &base1 =""*&time_level="",disbursed_amt_new*f=18.0;
	run;
	proc sort data=loan_deno;
	by &base1 &time_level;
proc tabulate data= loan_1 out=loan_put(drop= _TYPE_	_PAGE_	_TABLE_);
where mob=3 and OVERDUE_DAY ge 30;
class &base1 &time_level mob;
var OUTSTANDING_AMT;
tables &base1 =""*&time_level="",mob=''*OUTSTANDING_AMT="" *f=18.0;
run;
proc sort data=loan_put;
by &base1 &time_level;
	/*先竖着处理*/
	data   loan_put_1;
		merge        loan_deno      (in=a)
			loan_put           (in=b);
		by &base1  &time_level;
	run;
data loan_put_2;
set loan_put_1;
rate_30plus=OUTSTANDING_AMT_sum/disbursed_amt_new_sum;
format rate_30plus percent8.1;
run;
	proc transpose data=loan_put_2 (drop=mob)  out=M2plus_&base1;
		by &base1  ;
		id  &time_level ;
	run;
	%mend;
%M2plus (base1=product,time_level=month );
%M2plus (base1=product_title,time_level=month );
%M2plus (base1=CURRENT_PROVINCE_new,time_level=month );
%M2plus (base1=CURRENT_CITY_new,time_level=month );