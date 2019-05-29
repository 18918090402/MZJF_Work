%let product_select="白领包","应届贷" ,"社保贷" ,"其他大额贷" ,"消费贷" ,"学历贷" ,"本科包","名校贷应急包","专科包";
data loan_fx ;
set junfang.loan_prem4plus;
where product in ( &product_select.) and ym_file ge 201701;
run;
%macro fengxian (ds= , base= ,time_level= );
proc tabulate data= &ds out=table1 (drop=_page_ _table_ _type_);
class  &base &time_level ;
var daiyu_n outstanding_amt cunliang_amt loss_n loss_amt recovery_amt net_loss_amt net_floss_amt 
m1_amt m2_amt m3_amt m2p_amt m4p_amt m2p_vin_amt
m0_qx_amt m1_qx_amt m2_qx_amt m3_qx_amt m4_qx_amt m5p_qx_amt;
tables (&base ='' all)*(daiyu_n outstanding_amt cunliang_amt loss_n loss_amt recovery_amt net_loss_amt net_floss_amt 
m1_amt m2_amt m3_amt m2p_amt m4p_amt m2p_vin_amt
m0_qx_amt m1_qx_amt m2_qx_amt m3_qx_amt m4_qx_amt m5p_qx_amt),&time_level;
run;
proc sort data=table1   ;
by &base &time_level;
run;
data table2;
set table1 ;
by &base;
if &base="" then &base="0000all";
/*迁徙率*/
M0_qx_amt_sum_lag=lag(M0_qx_amt_sum);
M1_qx_amt_sum_lag=lag(M1_qx_amt_sum);
M2_qx_amt_sum_lag=lag(M2_qx_amt_sum);
M3_qx_amt_sum_lag=lag(M3_qx_amt_sum);
if first.&base then do; 
M0_qx_amt_sum_lag=.;
M1_qx_amt_sum_lag=.;
M2_qx_amt_sum_lag=.;
M3_qx_amt_sum_lag=.;
end;
M0_M1=M1_qx_amt_sum/M0_qx_amt_sum_lag;
M1_M2=M2_qx_amt_sum/M1_qx_amt_sum_lag;
M2_M3=M3_qx_amt_sum/M2_qx_amt_sum_lag;
M3_M4=M4_qx_amt_sum/M3_qx_amt_sum_lag;
M0_M4=M3_M4*LAG(M2_M3)*LAG2(M1_M2)*LAG3(M0_M1);
if _n_ in (1,2,3,4) then M0_M4=.;
/*对于迁徙率超过1的手动调为1*/
if M0_M1 gt 1 then M0_M1=1;
if M1_M2 gt 1 then M1_M2=1;
if M2_M3 gt 1 then M2_M3=1;
if M3_M4 gt 1 then M3_M4=1;
if M0_M4 gt 1 then M0_M4=1;
/*逾期率*/
m1_ratio	=	m1_qx_amt_Sum	/	outstanding_amt_sum	;	
m2_ratio	=	M2_qx_amt_sum	/	outstanding_amt_sum	;	
m3_ratio	=	M3_qx_amt_sum	/	outstanding_amt_sum	;	
m2p_ratio	=	m2p_vin_amt_sum	/	outstanding_amt_sum	;	
m4p_ratio=m4p_amt_sum/outstanding_amt_sum;
annual_loss_ratio=LOSS_AMT_Sum/outstanding_amt_sum*12;
annual_net_loss_ratio=net_loss_amt_Sum/outstanding_amt_sum*12;
annual_net_floss_ratio=net_floss_amt_Sum/outstanding_amt_sum*12;
/*去除不需要的变量*/
drop cunliang_amt_sum 
m1_amt_Sum
m2_amt_Sum
m3_amt_Sum
m2p_amt_Sum
m4p_amt_sum
m2p_vin_amt_sum
M0_qx_amt_sum_lag
M1_qx_amt_sum_lag
M2_qx_amt_sum_lag
M3_qx_amt_sum_lag;
run;
/*以上为第一部分，主要是正常的风险状况和迁徙率*/
/*加入新增首逾和7天首逾数据*/
data _null_;
call symput('day',put(date()-1,yymmddn8.));
run;
data loan_one_seven;
set risk.loan_&day ;
length  product_title $40.;
where product in ( &product_select.);
if product in ('本科包' ,'名校贷应急包' ,'专科包') then product_title='01-信用贷' ;
else if product in ('白领包',"社保贷","应届贷","按揭贷") then product_title='02-白领贷';
else if product in ("闪电借","其他大额贷","消费贷","学历贷") then product_title='04-麦子借款';
else product_title='08-其他';
/*此处定义ym_file为放款的下一个月*/
ym_file=year(intnx("month",datepart(disbursed_date),1,"sameday"))*100+month(intnx("month",datepart(disbursed_date),1,"sameday"));
year_file=year(intnx("month",datepart(disbursed_date),1,"sameday"));
if 201701 le ym_file le year(intnx("month",date(),-1))*100+month(intnx("month",date(),-1));
/*此步骤保证首逾只统计到上一月，去除当天的一些新月份个别件*/
if flag_7=1 then flag_7_amt=OUTSTANDING_AMT;/*修改为剩余本金*/
if fpd_flag=1 then flag_1_amt=OUTSTANDING_AMT;/*修改为剩余本金*/
run;

/*一天首逾*/
proc tabulate data=loan_one_seven  out=flag_1_1  (drop=_page_ _table_ _type_);
where repay_begin_day le sum(date(),-1);
/*确保走过表现期*/
class  &base &time_level ;
var  flag_1_amt disbursed_amt;
tables  (&base="" all)*( flag_1_amt disbursed_amt),&time_level="" ;
run;
data flag_1_2;
set flag_1_1;
flag_1_rate=flag_1_amt_sum/disbursed_amt_Sum;
if &base="" then &base="0000all";
drop disbursed_amt_sum;
run;

/*7天首逾*/
proc tabulate data=loan_one_seven  out=flag_7_1  (drop=_page_ _table_ _type_);
where repay_begin_day le sum(date(),-8);
/*确保走过表现期*/
class  &base &time_level ;
var  flag_7_amt disbursed_amt;
tables  (&base="" all)*( flag_7_amt disbursed_amt),&time_level="" ;
run;
data flag_7_2;
set flag_7_1;
flag_7_rate=flag_7_amt_sum/disbursed_amt_Sum;
if &base="" then &base="0000all";
drop disbursed_amt_sum;
run;

/*把风险表、首逾、七天首逾表合并起来*/
proc sort data=table2   ;
by &base &time_level;
run;
proc sort data=flag_1_2   ;
by &base &time_level;
run;
proc sort data=flag_7_2   ;
by &base &time_level;
run;
data   union_fx_1  ;
merge    table2          
            flag_1_2       
			flag_7_2;
	 by &base &time_level;
	 run;

/*用retain排序，并并剔除不需要的变量*/
data union_fx_2;
retain &base daiyu_n_Sum
outstanding_amt_Sum

flag_1_amt_sum
flag_1_rate

flag_7_amt_sum
flag_7_rate

m0_qx_amt_Sum
m1_qx_amt_Sum
m2_qx_amt_Sum
m3_qx_amt_Sum
m4_qx_amt_Sum
m5p_qx_amt_Sum

m1_ratio
m2_ratio
m3_ratio
m2p_ratio
m4p_ratio
M0_M1 M1_M2 M2_M3 M3_M4 M0_M4
loss_n_Sum
LOSS_AMT_Sum
annual_loss_ratio
RECOVERY_AMT_Sum
net_loss_amt_Sum
annual_net_loss_ratio
net_floss_amt_Sum
annual_net_floss_ratio;
set union_fx_1;
run;

/*排序，并转置*/
proc sort data=union_fx_2   ;
by &base &time_level;
run;
proc transpose data=union_fx_2    out=&time_level._&base.;
by &base  ;
id  &time_level;
/*var   ;*/
run;
%mend;
%fengxian (ds=loan_fx  , base=product ,time_level= year_file);
%fengxian (ds=loan_fx  , base=product_title ,time_level= year_file);

%fengxian (ds=loan_fx  , base=product ,time_level= ym_file);
%fengxian (ds=loan_fx  , base=product_title ,time_level= ym_file);

/*以下为export表到Excel中*/
%macro output(Table_List);
data _null_;
call symput('day',put(date()-1,yymmddn8.));
run;
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
	outfile="F:\Workspace\risk\chenjunfang\dashboard_fx_&day. .xlsx" 
		dbms=xlsx label replace ;
		SHEET="&&TableName&i.";
	run;
%end;
%mend;
%output( year_file_product
year_file_product_title
ym_file_product
ym_file_product_title
) ;