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

data loan_all;
	set risk.loan_all;
	ym_disbursed=year(disbursed_Date)*100+month(disbursed_Date);
	ym_file=year(file_Date)*100+month(file_Date);
	year_file=year(file_Date);

run;

/*匹配损失*/
proc sql;
	create table loan_loss as 
		select loan_all.* ,loss.*
			from work.loan_all left join work.loss
				on loan_all.apply_no=loss.apply_no;
quit;

/*匹配回收*/
proc sql;
	create table loan_loss_rcv as 
		select loan_loss.* ,recovery.*
			from work.loan_loss left join work.recovery
				on loan_loss.apply_no=recovery.apply_no and loan_loss.file_date=recovery.recovery_date;
quit;

proc sort data=loan_loss_rcv;
	by apply_no;
run;

data loan_loss_rcv_1;
	set loan_loss_rcv;
	by apply_no;

	length level $10. diya_flag $40. product_title $40. bl $10. bl_part $20.;
    if product="美呗分期（信）" then product="麦芽分期";

     if product in ("白领包","应届贷","社保贷") then bl="bl_noaj";
     else bl="other";

if product in ("白领包","应届贷","社保贷") then bl_part="白领无按揭";
else bl="其他";
	/*放款金额、个数只计算一次,用disbursed_amt_new,放款个数用disbursed_n_new*/
	if first.apply_no then
		do;
			disbursed_amt_new=disbursed_amt;
			disbursed_n_new=1;
		end;
	else
		do;
			disbursed_amt_new=0;
			disbursed_n_new=0;
		end;

    if outstanding_amt gt 0 then daiyu_n=1;
    /*贷余，含损失的那种*/

	/*等级分类,仅细分到M4*/
	if overdue_day=0 or overdue_day=. then
		level="m0";
	else if 1 le overdue_day le 29 then
		level="m1";
	else if 30 le overdue_day le 59 then
		level="m2";
	else if 60 le overdue_day le 89 then
		level="m3";
	else if 90 le overdue_day le 119 then
		level="m4";
	else  level="m5+";

	/*迁徙的金额*/
	if  overdue_day =0 then
		m0_qx_amt=outstanding_amt;
	else  m0_qx_amt=0;

	if 1 le overdue_day le 29 then
		m1_qx_amt=outstanding_amt;
	else  m1_qx_amt=0;

	if 30 le overdue_day le 59 then
		m2_qx_amt=outstanding_amt;
	else  m2_qx_amt=0;

	if 60 le overdue_day le 89 then
		m3_qx_amt=outstanding_amt;
	else  m3_qx_amt=0;

	if 90 le overdue_day le 119 then
		m4_qx_amt=outstanding_amt;
	else  m4_qx_amt=0;

	if 120 le overdue_day then
		m5p_qx_amt=outstanding_amt;
	else  m5p_qx_amt=0;
	/*算存量*/
	/*损失后的本金不在作为存量*/
	/*定义新的存量金额cunliang_amt与存量个数cunliang_n*/
	if loss_mark=1 and (loss_date le file_date) then
		do;
			cunliang_amt=0;
			cunliang_n=0;
		end;
	else
		do;
			cunliang_amt =outstanding_amt;
			cunliang_n=1;
		end;

	/*新增损失loss_amt与loss_n只计算一次*/
	if loss_mark=1 and (loss_date=file_date) then
		do;
			loss_amt=loss_amt;
			loss_n=1;
		end;
	else
		do;
			loss_amt=0;
			loss_n=0;
		end;

	/*欺诈损失floss_amt与floss_n只计算一次*/
	if floss_mark=1 then
		do;
			floss_amt=loss_amt;
			floss_n=loss_n;
			frecovery_amt=recovery_amt;
		end;

	/*	净损失与净欺诈损失*/
	net_loss_amt=sum(loss_amt,-recovery_amt);
	net_floss_amt=sum(floss_amt,-frecovery_amt);

	/*各等级逾期率，逾期以存量计算*/
	/*30+逾期*/
	if 30 le overdue_day le 89 then
		m2plus_amt=cunliang_amt;
	else m2plus_amt=0;

	if 1 le overdue_day le 29 then
		m1_amt=cunliang_amt;
	else  m1_amt=0;

	if 30 le overdue_day le 59 then
		m2_amt=cunliang_amt;
	else  m2_amt=0;

	if 60 le overdue_day le 89 then
		m3_amt=cunliang_amt;
	else  m3_amt=0;

	/*计算不良率所用项,不良率仍用剩余本金计算*/
	if 90 le overdue_day le 179 then
		bl_num_amt=outstanding_Amt;

	if 0 le overdue_day le 179 then
		bl_deno_amt=outstanding_Amt;
    /*M4+逾期率*/
	if overdue_day ge 90 then 
	m4p_amt=outstanding_Amt;
	else m4p_amt=0;
    /*计算M2+vintage所用的字段*/
	if overdue_day ge 30 then
		m2p_vin_amt=outstanding_amt;

    /*计算M1+vintage所用的字段*/
	if overdue_day ge 1 then
		m1p_vin_amt=outstanding_amt;


	/*数值辅助列*/
	help=1;

	/*文本辅助列*/
	bangzhu="A";


if product in ('本科包' ,'名校贷应急包' ,'专科包',
"白领包","应届贷","按揭贷","社保贷",
"麦芽分期","美呗分期（信）"
"闪电借","其他大额贷","消费贷","学历贷",
"美国名校贷","UniFi小额贷"
) then diya_flag="无抵押";
else diya_flag="有抵押";

if product in ('本科包' ,'名校贷应急包' ,'专科包') then product_title='01-信用贷' ;
else if product in ('白领包',"社保贷","应届贷","按揭贷") then product_title='02-白领贷';
else if product in ('麦芽分期',"美呗分期（信）") then product_title='03-麦芽';
else if product in ("闪电借","其他大额贷","消费贷","学历贷") then product_title='04-麦子借款';
else if product in ('UniFi小额贷','美国名校贷') then product_title='05-UniFi';
else if product='大房东' then product_title='06-大房东';
else if product='大车贷' then product_title='07-大车贷';
else product_title='08-其他';


year_file=year(file_Date);
main_p=product_title;
all=bangzhu;
run;


data junfang.loan_prem4plus (compress=yes);
set loan_loss_rcv_1;
run;
