SET mapreduce.job.queuename=etl-dw;
SET mapreduce.job.name=IDW_DIM_DES_MAIN_01;
SET hive.exec.parallel=TRUE ;

INSERT OVERWRITE TABLE   IDW.DIM_DES_MAIN  
SELECT   USER_ID, bp_id ,
MAX(CASE WHEN data_no='auditAmt' THEN data_value END)  AS auditAmt
,MAX(CASE WHEN data_no='contactMobileHitTongDunLoanBlackIntermediary' THEN data_value END)  AS contactMobileHitTongDunLoanBlackIntermediary
,MAX(CASE WHEN data_no='faceSimilarPercent' THEN data_value END)  AS faceSimilarPercent
,MAX(CASE WHEN data_no='finalDes' THEN data_value END)  AS finalDes
,MAX(CASE WHEN data_no='hitTongDunRepeateLoanOneMonth' THEN data_value END)  AS hitTongDunRepeateLoanOneMonth
,MAX(CASE WHEN data_no='hitTongDunRepeateLoansixMonth' THEN data_value END)  AS hitTongDunRepeateLoansixMonth
,MAX(CASE WHEN data_no='idCardSimilarPercent' THEN data_value END)  AS idCardSimilarPercent
,MAX(CASE WHEN data_no='idHitOurBlackList' THEN data_value END)  AS idHitOurBlackList
,MAX(CASE WHEN data_no='idHitTongDunCourtBlackList' THEN data_value END)  AS idHitTongDunCourtBlackList
,MAX(CASE WHEN data_no='idHitTongDunCourtExecuteList' THEN data_value END)  AS idHitTongDunCourtExecuteList
,MAX(CASE WHEN data_no='idHitTongDunCrimeBlackList' THEN data_value END)  AS idHitTongDunCrimeBlackList
,MAX(CASE WHEN data_no='idHitTongDunLegalPersonBlackList' THEN data_value END)  AS idHitTongDunLegalPersonBlackList
,MAX(CASE WHEN data_no='idHitTongDunLoanBlackList' THEN data_value END)  AS idHitTongDunLoanBlackList
,MAX(CASE WHEN data_no='idHitTongDunLostContactList' THEN data_value END)  AS idHitTongDunLostContactList
,MAX(CASE WHEN data_no='idNameHitTongDunFuzzyCourtBlackList' THEN data_value END)  AS idNameHitTongDunFuzzyCourtBlackList
,MAX(CASE WHEN data_no='idNameHitTongDunFuzzyCourtExecuteList' THEN data_value END)  AS idNameHitTongDunFuzzyCourtExecuteList
,MAX(CASE WHEN data_no='idNameHitTongDunFuzzyLoanBlackList' THEN data_value END)  AS idNameHitTongDunFuzzyLoanBlackList
,MAX(CASE WHEN data_no='immediateFamilyMobileHitOurBlackList' THEN data_value END)  AS immediateFamilyMobileHitOurBlackList
,MAX(CASE WHEN data_no='isJxhj' THEN data_value END)  AS isJxhj
,MAX(CASE WHEN data_no='isNeedTelephoneAudit' THEN data_value END)  AS isNeedTelephoneAudit
,MAX(CASE WHEN data_no='isNewUser' THEN data_value END)  AS isNewUser
,MAX(CASE WHEN data_no='isRetainedUser' THEN data_value END)  AS isRetainedUser
,MAX(CASE WHEN data_no='lastLoanAmt' THEN data_value END)  AS lastLoanAmt
,MAX(CASE WHEN data_no='lastLoanTime' THEN data_value END)  AS lastLoanTime
,MAX(CASE WHEN data_no='latestRtnLoanDate' THEN data_value END)  AS latestRtnLoanDate
,MAX(CASE WHEN data_no='loanAmt' THEN data_value END)  AS loanAmt
,MAX(CASE WHEN data_no='loanApplyDate' THEN data_value END)  AS loanApplyDate
,MAX(CASE WHEN data_no='loanStatusNormal' THEN data_value END)  AS loanStatusNormal
,MAX(CASE WHEN data_no='loanStatusOverdue' THEN data_value END)  AS loanStatusOverdue
,MAX(CASE WHEN data_no='maxOverDueDays' THEN data_value END)  AS maxOverDueDays
,MAX(CASE WHEN data_no='mobileHitOurBlackList' THEN data_value END)  AS mobileHitOurBlackList
,MAX(CASE WHEN data_no='mobileHitTongDunLegalPersonBlackList' THEN data_value END)  AS mobileHitTongDunLegalPersonBlackList
,MAX(CASE WHEN data_no='mobileHitTongDunLoanBlackIntermediary' THEN data_value END)  AS mobileHitTongDunLoanBlackIntermediary
,MAX(CASE WHEN data_no='mobileHitTongDunLoanBlackList' THEN data_value END)  AS mobileHitTongDunLoanBlackList
,MAX(CASE WHEN data_no='mobileHitTongDunLostContactList' THEN data_value END)  AS mobileHitTongDunLostContactList
,MAX(CASE WHEN data_no='overDue30Days1Times' THEN data_value END)  AS overDue30Days1Times
,MAX(CASE WHEN data_no='overDue7Days4Times' THEN data_value END)  AS overDue7Days4Times
,MAX(CASE WHEN data_no='overdueTerm' THEN data_value END)  AS overdueTerm
,MAX(CASE WHEN data_no='productId' THEN data_value END)  AS productId
,MAX(CASE WHEN data_no='rtnTerm' THEN data_value END)  AS rtnTerm
,MAX(CASE WHEN data_no='schoolAcademy' THEN data_value END)  AS schoolAcademy
,MAX(CASE WHEN data_no='scoreLevel' THEN data_value END)  AS scoreLevel
,MAX(CASE WHEN data_no='scoreResult' THEN data_value END)  AS scoreResult
,MAX(CASE WHEN data_no='studentEducation' THEN data_value END)  AS studentEducation
,MAX(CASE WHEN data_no='studentEduStartDate' THEN data_value END)  AS studentEduStartDate
,MAX(CASE WHEN data_no='studentGrade' THEN data_value END)  AS studentGrade
,MAX(CASE WHEN data_no='studentSchoolType' THEN data_value END)  AS studentSchoolType
,MAX(CASE WHEN data_no='studentTermProcess' THEN data_value END)  AS studentTermProcess
,MAX(CASE WHEN data_no='term' THEN data_value END)  AS term
,MAX(CASE WHEN data_no='tongdunFinalScore' THEN data_value END)  AS tongdunFinalScore
,MAX(CASE WHEN data_no='tongdunUuid' THEN data_value END)  AS tongdunUuid
,MAX(CASE WHEN data_no='userAge' THEN data_value END)  AS userAge
,MAX(CASE WHEN data_no='userCensusAddress' THEN data_value END)  AS userCensusAddress
,MAX(CASE WHEN data_no='userGender' THEN data_value END)  AS userGender
,MAX(CASE WHEN data_no='userIdNumber' THEN data_value END)  AS userIdNumber
,MAX(CASE WHEN data_no='userKinMobile' THEN data_value END)  AS userKinMobile
,MAX(CASE WHEN data_no='userMobile' THEN data_value END)  AS userMobile
,MAX(CASE WHEN data_no='userRiskBill' THEN data_value END)  AS userRiskBill
,MAX(CASE WHEN data_no='userSchoolProvince' THEN data_value END)  AS userSchoolProvince
,MAX(CASE WHEN data_no='vocationalSchoolThree' THEN data_value END)  AS vocationalSchoolThree
,MAX(CASE WHEN data_no='zhiMaScore' THEN data_value END)  AS zhiMaScore
,MAX(CASE WHEN data_no='zhimaUuid' THEN data_value END)  AS zhimaUuid

,'SYS' AS DW_CREATE_BY
        ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
        ,'SYS' AS DW_UPDATE_BY
        ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME

 FROM 
  (SELECT a.*
  FROM ODS.T_des_main_HIST a
  INNER JOIN 
  (-- 为什么要自关联？？？原因同一个申请BP_ID的同一个data_no会有对个值，取最新的
  SELECT a.bp_id,a.data_no,MAX(id) AS id
  FROM ODS.T_des_main_HIST a
  GROUP BY a.bp_id,a.data_no  
  )b
  ON a.id=b.id) C
  GROUP BY USER_ID,bp_id 
;
