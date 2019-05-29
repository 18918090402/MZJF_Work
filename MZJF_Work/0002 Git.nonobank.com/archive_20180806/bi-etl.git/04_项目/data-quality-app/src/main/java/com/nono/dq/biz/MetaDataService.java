package com.nono.dq.biz;

import com.nono.dq.model.QualityQuery;

public interface MetaDataService {
	
	/**
	 * 计算规则的列值 DQ_COLUMN_RULE-->DQ_COMPARE_RESULT
	 * @param data
	 * @throws Exception
	 */
	 void calculateColumn(final QualityQuery data) throws Exception;
	
	/**
	 * 对计算后的列的值进行校验 DqColumnCompare & DqColumnResult ->DQ_COMPARE_RESULT
	 * @param data
	 * @throws Exception
	 */
	 void compareColumn(final QualityQuery data) throws Exception;
	 
	 void compareDataSource(final QualityQuery data) throws Exception;

	 String qualifyDatasources(final QualityQuery data) throws Exception;

	 String stats(final QualityQuery data) throws Exception;
	 
	 void sms(final QualityQuery data) throws Exception;
}