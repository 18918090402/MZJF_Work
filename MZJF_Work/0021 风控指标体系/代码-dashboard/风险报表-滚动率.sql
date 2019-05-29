/*libname dongle BASE "F:\WORKSPACE\RISK\hudongle";
proc freq data=junfang.loan_prem4plus;
table file_date;
RUN;*/

/*滚动率*/
data loan;
set junfang.loan_prem4plus (keep=apply_no product disbursed_date status overdue_day outstanding_Amt ym_file product_title);
where product in ("白领包","应届贷" ,"社保贷" ,"其他大额贷" ,"消费贷" ,"学历贷" ,"本科包","名校贷应急包","专科包")
and  ym_file ge 201612;
/*不能随意剔除结清，因为会使得分母变少*/
help=1;
run;

/*算各种各样的逾期率*/
%macro roll_rate (base=);
data with_m;
set loan;
if overdue_day=0 or overdue_day=. then level="m0";
else if 1 le overdue_day le 29 then level="m1";
else if 30 le overdue_day le 59 then level="m2";
else if 60 le overdue_day le 89 then level="m3";
else if 90 le overdue_day le 119 then level="m4";
else level="m5+";
run;

proc sort data=with_m   ;
by apply_no;
run;

data bb;
set with_m;
by apply_no;
level_lag=lag(level);
outstanding_amt_lag=lag(outstanding_amt);
if first.apply_no then
   do
   level_lag=.;
   outstanding_amt_lag=.;
   end;

if level_lag="m0" and level="m1" then roll_level='m0_m1';
else if level_lag="m1" and level="m2" then roll_level='m1_m2';
else if level_lag="m2" and level="m3" then roll_level='m2_m3';
else if level_lag="m3" and level="m4" then roll_level='m3_m4';
else roll_level='other';

if roll_level='m0_m1' then m0_m1_amt=outstanding_amt;
if roll_level='m1_m2' then m1_m2_amt=outstanding_amt;
if roll_level='m2_m3' then m2_m3_amt=outstanding_amt;
if roll_level='m3_m4' then m3_m4_amt=outstanding_amt;

if level_lag="m0" then m0_amt_lag=outstanding_amt_lag;
if level_lag="m1" then m1_amt_lag=outstanding_amt_lag;
if level_lag="m2" then m2_amt_lag=outstanding_amt_lag;
if level_lag="m3" then m3_amt_lag=outstanding_amt_lag;

run;

proc tabulate data=bb out=table1 (drop=_page_ _table_ _type_);
class &base ym_file ;
var m0_amt_lag m1_amt_lag m2_amt_lag m3_amt_lag m0_m1_amt m1_m2_amt m2_m3_amt m3_m4_amt;
tables (&base="" all)*(m0_amt_lag m1_amt_lag m2_amt_lag m3_amt_lag m0_m1_amt m1_m2_amt m2_m3_amt m3_m4_amt)  ,ym_file="" ;
run;

proc sort data= table1  ;
by &base ym_file;
run;

data table2;
set table1;
by &base;
if &base="" then &base="总";
M0_M1_roll=m0_m1_amt_sum/m0_amt_lag_sum;
M1_M2_roll=m1_m2_amt_sum/m1_amt_lag_sum;
M2_M3_roll=m2_m3_amt_sum/m2_amt_lag_sum;
M3_M4_roll=m3_m4_amt_sum/m3_amt_lag_sum;
M0_M4_roll=M3_M4_roll*LAG(M2_M3_roll)*LAG2(M1_M2_roll)*LAG3(M0_M1_roll);
if _n_ in (1,2,3,4) then M0_M4_roll=.;
run;

proc sort data=table2 nodupkey;
by &base ym_file ;
run;

proc transpose data= table2   out=table3&base;
by  &base  ;
id  ym_file ;
var  M0_M1_roll M1_M2_roll M2_M3_roll M3_M4_roll M0_M4_roll;
run;
%mend;
%roll_rate (base=product_title);
%roll_rate (base=product);