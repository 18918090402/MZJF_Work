options mstored sasmstore=risk;
/*申请表保留评分*/
data _null_;
call symput('day',put(date()-1,yymmddn8.));
run;
data apply(keep=apply_no product score pj apply_Date );
set risk.apply_&day ;
if LEVEL in ("A","B") then pj="A+B";
else if LEVEL in ("C","D") then pj="C+D";
else if LEVEL in ("E","F") then pj="E+F";
else pj=LEVEL;
where product in ("白领包","应届贷" ,"社保贷" ,"其他大额贷" ,"消费贷" ,"学历贷" ,"本科包","名校贷应急包","专科包")
and LEVEL in ("A","B","C","D","E","F") and SCORE ne .;
run;
data loan_pre;
set junfang.loan_prem4plus;
  where 201701 le ym_disbursed le 201809;
  if product in ("白领包","应届贷" ,"社保贷" ,"其他大额贷" ,"消费贷" ,"学历贷" ,"本科包","名校贷应急包","专科包");
  if OVERDUE_DAY ge 90 then OUTSTANDING_AMT_new=OUTSTANDING_AMT;
  else OUTSTANDING_AMT_new=0;
run;
%HashJoin(loan_pre,apply_no,apply,apply_no,0,,loan_pre_1);
%macro nloss_vintage (ds= ,base1= , base2=, time_level=);

	proc sql;
		create table all as 
			select * ,max(disbursed_date) as max_disbursed_date
				from &ds
					group by &time_level;
	quit;
		proc sql;
		create table all_1 as 
			select * ,max(file_date) as max_file_date
				from all
					group by help;
	quit;
data loan_pre_2;
set all_1;
format max_disbursed_date date9.;
format max_file_date date9.;
actual_mob=intck("month",max_disbursed_date,max_file_date);
run;
	/*准备好的基础表*/
proc tabulate data= loan_pre_2 out=deno_amt1 (drop= _TYPE_ _PAGE_	_TABLE_);
		class &base1 &base2 &time_level;
		var disbursed_amt_new;
		tables &base1 =""*&base2=""*&time_level="",disbursed_amt_new*f=18.0;
	run;
			/*分母表排序*/
proc sort data=deno_amt1;
		by &base1 &base2 &time_level;
	run;
/*金额分子部分,毛损失*/
proc tabulate data= loan_pre_2 out=num_amt1(drop= _TYPE_	_PAGE_	_TABLE_);
where mob le actual_mob;
class &base1 &base2 &time_level mob/missing;
var OUTSTANDING_AMT_new;
tables &base1 =""*&base2=""*&time_level="",mob=''*OUTSTANDING_AMT_new="" *f=18.0;
run;
	/*分子表排序*/
		proc sort data=num_amt1;
		by &base1 &base2 &time_level mob;
	run;
		/*先竖着处理*/
	data   union_amt;
		merge        deno_amt1      (in=a)
			num_amt1           (in=b);
		by &base1 &base2 &time_level;
	run;
	data union_amt_1;
		set union_amt;
		rate=OUTSTANDING_AMT_new_sum/disbursed_amt_new_sum;
	run;
data union_amt_2;
set union_amt_1;
keep &base1 &base2 &time_level mob rate disbursed_amt_new_sum ;
run;
proc sort data=  union_amt_2;
by &base1 &base2 &time_level disbursed_amt_new_sum mob;
run;
	proc transpose data=union_amt_2    out=v_&base1&base2  (drop=_name_) prefix=mob;
		by &base1 &base2 &time_level disbursed_amt_new_sum;
		id  mob;
		var  rate;
		format rate percent8.1;
	run;
	%mend;
%nloss_vintage (ds=loan_pre_1, base1=product ,base2=pj ,time_level=quarter );
%nloss_vintage (ds=loan_pre_1, base1=product_title ,base2=pj ,time_level=quarter );