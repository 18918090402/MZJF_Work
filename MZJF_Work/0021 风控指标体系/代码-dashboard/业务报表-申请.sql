data _null_;
call symput('day',put(date()-1,yymmddn8.));
run;
%macro apply_base (time_level=);
/*审批表*/
data approval;
set risk.APPROVAL_&day.;
run;
/*申请表*/
data apply;
length product_L $40.;
set risk.APPLY_&day.(keep=apply_no apply_date product apply_amt apply_term fraud_flag approve_result refuse_reason auto_decision auto_decision_date video_flag level score);
where product in ("白领包","应届贷" ,"社保贷" ,"其他大额贷" ,"消费贷" ,"学历贷" ,"本科包","名校贷应急包","专科包");
if product in ("白领包","应届贷" ,"社保贷") then product_L="白领贷";
else if product in ("其他大额贷" ,"消费贷" ,"学历贷") then product_L="麦子借款";
else if product in ("本科包","名校贷应急包","专科包") then product_L="信用贷";
run;
proc sort data= apply;
by apply_no;
run;
/*测试表*/
data list_test;
set risk.list_test;
run;
proc sort data=list_test;
by apply_no;
run;
/*前期剔除测试数据*/
data apply_notest;
merge apply(in=a)
       list_test(in=b);
by apply_no;
if a and not b;
ym_apply=year(datepart(apply_date))*100+month(datepart(apply_date));
help=1;
run;
data apply_back;
set apply_notest;
where 201701 <= ym_apply < year(date())*100+month(date());
amt_term=apply_term*apply_amt;
year_apply=year(datepart(apply_date))*100;
/*通过*/
/*不通过的金额为缺失，不能为0，因为要取平均*/
if approve_result in ('终审通过（还未放款）' ,'终审通过已放款' ,'待放款' ,"审批通过" ,"已放款" ,"已结清") and apply_no ne 0 
then do pass=1;
pass_amt=apply_amt;
end;

else do ;
pass=.;
pass_amt=.;
end;
/*拒绝*/
if approve_result in ('初审拒绝' ,'终审拒绝' ,'审核不通过') then refuse=1;
else refuse=.;
/*取消*/
if index(approve_result, "取消") ge 1 then cancel=1;
else cancel=.;

/*欺诈*/
if sum(index(refuse_reason, "盗用"), 
       index(refuse_reason, "造假"),
       index(refuse_reason, "虚假"),
       index(refuse_reason, "诈骗"),
       index(refuse_reason, "套现"),
 index(refuse_reason, "CD12：网贷黑名单用户"),
 index(refuse_reason, "ZD12：网贷黑名单用户")
) ge 1 then fraud=1 ;
else fraud=.;
/*通过的平均期限*/
if pass=1 then amt_term_pass=amt_term;
else amt_term_pass=.;
if pass=1 then apply_amt_weight_pass=apply_amt;
else apply_amt_weight_pass=.;
run;
/*整体处理,出报表*/
proc tabulate data= apply_back out=apply_table_1 (drop=_TYPE_ _PAGE_ _TABLE_ );
class   &time_level. product_L product;
var help amt_term apply_amt amt_term_pass apply_amt_weight_pass  pass pass_amt cancel refuse fraud;
tables (product_L='' all  product ='') * (help apply_amt*mean amt_term apply_amt amt_term_pass apply_amt_weight_pass pass pass_amt*mean cancel refuse fraud ),&time_level.='';
run;
data apply_table_2;
set apply_table_1;
cate=compress(product_L||product);
if cate="" then cate="all";
apply_term_avg=amt_term_Sum/apply_amt_Sum;
pass_apply_term_avg=amt_term_pass_sum/apply_amt_weight_pass_sum;
refuse_ratio=refuse_sum/help_Sum;
pass_ratio=pass_sum/help_Sum;
cancel_ratio=cancel_sum/help_Sum;
fraud_ratio=fraud_sum/help_Sum;	
run;
data apply_table_3;
set apply_table_2;
retain cate
apply_amt_Sum
help_Sum
apply_amt_mean
apply_term_avg

refuse_sum
refuse_ratio

apply_amt_weight_pass_Sum
pass_sum
pass_ratio
pass_amt_mean
pass_apply_term_avg

cancel_sum
cancel_ratio

fraud_sum
fraud_ratio;
run;
proc sort data= apply_table_3 nodupkey  ;
by 
cate
&time_level.;
run;
proc transpose data= apply_table_3 (drop=amt_term_Sum
amt_term_pass_Sum
)  out=f_&time_level.;

by  cate  ;
id  &time_level. ;
/*var   ;*/
run;
%mend;
%apply_Base (time_level=ym_apply);
%apply_Base (time_level=year_apply);

/*以下为export表到Excel中*/
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
	outfile="F:\Workspace\risk\chenjunfang\dashboard\f_ym_apply&day..xlsx f_year_apply&day..xlsx " 
		dbms=xlsx label replace ;
		SHEET="&&TableName&i.";
	run;
%end;
%mend;
%output(f_ym_apply f_year_apply) ;
/*算时效问题*/
data pass;
set apply_back (keep=apply_no product pass product_L ym_apply);
where pass=1;
run;
proc sort data=pass;
by apply_no;
run;
proc sort data= approval ;
by apply_no process_begin_time;
run;
/*申请通过表关联审批表*/
data pass_approval;
merge pass (in=a)
approval (in=b);
by apply_no;
if a;
drop process_end_time;
/*where ym_apply=201502;*/
run;
data pa1;
set pass_approval;
if process_name in ("提交申请","预发标时间","签约完成") then delete;
run;
proc sort data=pa1   ;
by apply_no process_begin_time;
run;
data pa_final;
set pa1;
by apply_no;
if first.apply_no or last.apply_no;
run;
proc sort data= pa_final  ;
by apply_no PROCESS_BEGIN_TIME;
run;
data counttime;
  set pa_final;
  by apply_no;
  retain PROCESS_END_TIME;
if first.apply_no or last.apply_no;
if FIRST.apply_no then PROCESS_END_TIME=PROCESS_BEGIN_TIME;
minute=intck("minute",PROCESS_END_TIME,PROCESS_begin_TIME);
hour=minute/60;
if minute=0 then delete;
format hour 4.2 PROCESS_END_TIME datetime19. ;
/*where ym_apply=201502;*/
run;
proc tabulate data= counttime out=pass_time;
class  ym_apply product_L product;
var hour;
tables    ((product_L='' all) product ='' )*hour*mean="" ,ym_apply='';
run;
data pass_time_2;
set pass_time (drop=_TYPE_ _PAGE_ _TABLE_ );
cate=compress(product_L||product);
if cate="" then cate="all";
run;
proc sort data= pass_time_2 nodupkey  ;
by 
cate
ym_apply
;
run;
proc transpose data= pass_time_2 out=pass_time_3;

by  cate  ;
id  ym_apply ;
/*var   ;*/
run;
/*分产品小类-通过等级占比&各等级通过率*/
%macro pingji (time_level=);
proc format ;
picture pctfmt low-high="009.9%";
run;
/*通过的等级占比*/
data with_level;
set apply_back;
where  level ne "" and SCORE ne .;
if level="-1" then delete;
help=1;
year_apply=year(datepart(apply_date))*100;
ym_apply=year(datepart(apply_date))*100+month(datepart(apply_date));
run;
data with_leveltg;
set with_level;
run;
proc tabulate data=with_level;
where pass=1;
class  &time_level. product_L  product level ;
var help ;
tables   (product_L=""*product=""*level=""*help="")*pctsum<level>*f=pctfmt.,&time_level.="";
run;
/*算各等级的通过率*/
proc tabulate data=with_leveltg out=table1 (drop=_TYPE_ _PAGE_ _TABLE_ );
where level ne "F";
class level &time_level.    product;
var  pass help;
tables  (product="" *level="")* (pass help), &time_level.="" ;
run;
data table2;
set table1;
pass_rate =pass_sum/help_sum;
drop pass_sum  help_sum;
run;
proc sort data=table2   ;
by  product level;
run;
proc transpose data= table2   out=table3_&time_level.;
by  product level  ;
id &time_level.  ;
/*var   ;*/
run;
%mend;
%pingji (time_level=ym_apply);
%pingji (time_level=year_apply);
/*分产品大类-通过等级占比&各等级通过率（重新跑本段）*/
%macro pingji (time_level=);
proc format ;
picture pctfmt low-high="009.9%";
run;
/*通过的等级占比*/
data with_level;
set apply_back;
where  level ne "" and SCORE ne .;
if level="-1" then delete;
help=1;
year_apply=year(datepart(apply_date))*100;
ym_apply=year(datepart(apply_date))*100+month(datepart(apply_date));
run;
data with_leveltg;
set with_level;
run;
proc tabulate data=with_level;
where pass=1;
class  &time_level. product_L   level ;
var help ;
tables   ((product_L="" all)*level=""*help="")*pctsum<level>*f=pctfmt.,&time_level.="";
run;
/*算各等级的通过率*/
proc tabulate data=with_leveltg out=table1 (drop=_TYPE_ _PAGE_ _TABLE_ );
where level ne "F";
class level &time_level.    product_L;
var  pass help;
tables  ((product_L="" all) *level="")* (pass help), &time_level.="" ;
run;
data table2;
set table1;
pass_rate =pass_sum/help_sum;
drop pass_sum  help_sum;
run;
proc sort data=table2   ;
by  product_L level;
run;
proc transpose data= table2   out=table3_&time_level.;
by  product_L level  ;
id &time_level.  ;
/*var   ;*/
run;
%mend;
%pingji (time_level=ym_apply);
%pingji (time_level=year_apply);