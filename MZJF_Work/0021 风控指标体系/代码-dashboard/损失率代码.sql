options mstored sasmstore= risk;
data _null_;
call symput('day',put(date()-1,yymmddn8.));
run;
data loss;
set risk.loss;
loss_mark=1;
loss_mob=intck("month", disbursed_date, loss_date);
if loss_mob le 6 then
floss_mark=1;
run;
data recovery;
set risk.recovery;
recovery_mark=1;
run;
data loan_jt;
set risk.loan_&day;
disbursed_date_new= datepart(disbursed_date) ;
format disbursed_date_new date9.;
drop disbursed_date;
ym_disbursed=year(disbursed_date_new)*100+month(disbursed_date_new);
run;
/*匹配损失表*/
%HashJoin(loan_jt,apply_no,work.loss,apply_no,0,,loan_loss);
/*匹配回收表*/
%HashJoin(work.loan_loss,apply_no,work.recovery,apply_no,0,,loan_loss_rcv);
data llr;
length product_L $40.;
 set work.loan_loss_rcv;
	if loss_mark=1 then
		do;
			loss_amt=loss_amt;
			loss_n=1;
		end;
	else
		do;
			loss_amt=0;
			loss_n=0;
		end;
	if floss_mark=1 then
		do;
			floss_amt=loss_amt;
			floss_n=loss_n;
			frecovery_amt=recovery_amt;
		end;
	net_loss_amt=sum(loss_amt,-recovery_amt);
	net_floss_amt=sum(floss_amt,-frecovery_amt);
where ym_disbursed ge 201701 and product in ("白领包","应届贷" ,"社保贷" ,"其他大额贷" ,"消费贷" ,"学历贷" ,"本科包","名校贷应急包","专科包") ;
if product in ("白领包","应届贷" ,"社保贷") then product_L="白领贷";
else if product in ("其他大额贷" ,"消费贷" ,"学历贷") then product_L="麦子借款";
else if product in ("本科包","名校贷应急包","专科包") then product_L="信用贷";
run;
proc tabulate data=llr out=llr_1(drop=_TYPE_ _PAGE_ _TABLE_ );
class ym_disbursed product_L product;
var loss_amt net_loss_amt net_floss_amt OUTSTANDING_AMT;
tables (product_L='' all  product ='') * (loss_amt net_loss_amt net_floss_amt OUTSTANDING_AMT),ym_disbursed;
run;
data llr_2;
length cate $40.;
retain cate
loss_amt_sum net_loss_amt_sum net_floss_amt_sum OUTSTANDING_AMT_sum
loss_ratio net_loss_ratio net_floss_ratio;
set llr_1;
cate=compress(product_L||product);
if cate="" then cate="all";
loss_ratio=loss_amt_sum/OUTSTANDING_AMT_sum;
net_loss_ratio=net_loss_amt_sum/OUTSTANDING_AMT_sum;
net_floss_ratio=net_floss_amt_sum/OUTSTANDING_AMT_sum;
run;
proc sort data=llr_2;
by cate ym_disbursed;
run;
proc transpose data=llr_2(drop=loss_amt_sum net_loss_amt_sum net_floss_amt_sum OUTSTANDING_AMT_sum) out=lr_3;
by cate;
id ym_disbursed;
run;