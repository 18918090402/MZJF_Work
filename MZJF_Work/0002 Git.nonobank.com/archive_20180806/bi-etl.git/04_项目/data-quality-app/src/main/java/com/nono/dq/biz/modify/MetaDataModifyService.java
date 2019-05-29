package com.nono.dq.biz.modify;

import java.util.List;

import com.nono.dq.model.dto.metadata.DataSourceResult;
import com.nono.dq.model.dto.metadata.DqColumnResult;
import com.nono.dq.model.dto.metadata.DqCompareResult;

public interface MetaDataModifyService {
	 
	 /**
	  * 根据STAT_DATE、COLUMN_ID merge
	  * @param dqCompareResult
	  */
	 public void mergeDqCompareResult(List<DqCompareResult> dqCompareResult);
	 
	 /**
	  * 根据STAT_DATE、COLUMN_ID merge
	  * @param dqCompareResult
	  */
	 public void mergeDqColumnResult(List<DqColumnResult> dqResult);
	 
	 /**
	  * 根据STAT_DATE、tableid merge
	  * @param dqCompareResult
	  */
	 public void mergeDqDataSourceResult(String batchId,List<DataSourceResult> dqResult);
}