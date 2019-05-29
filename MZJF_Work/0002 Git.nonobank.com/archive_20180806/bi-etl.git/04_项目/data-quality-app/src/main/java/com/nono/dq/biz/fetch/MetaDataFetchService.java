package com.nono.dq.biz.fetch;

import java.util.Collection;
import java.util.List;

import com.nono.dq.model.QualityQuery;
import com.nono.dq.model.dto.metadata.DataSourceResult;
import com.nono.dq.model.dto.metadata.DqColumnCompare;
import com.nono.dq.model.dto.metadata.DqColumnResult;
import com.nono.dq.model.dto.metadata.DqCompareResult;
import com.nono.dq.model.dto.metadata.DqConfSms;
import com.nono.dq.model.dto.metadata.DqDataSource;
import com.nono.dq.model.dto.metadata.DqDatasourceColumn;
import com.nono.dq.model.dto.metadata.DqRuleAe;
import com.nono.dq.model.dto.metadata.DqJdbcMetadata;

public interface MetaDataFetchService {
	
	/**
	 * 根据id查询
	 * @param data
	 * @return
	 */
	List<DqDataSource> listDqDataSource(QualityQuery data);
	
	/**
	 * 根据columnId查询
	 * @param columnId
	 * @return
	 */
	DqDataSource getDqDataSource(Integer columnId);
	
	DqJdbcMetadata getJdbcMetadata(DqDataSource dqDataSource);
	/**
	 * 根据dsId查询数据
	 * @param tableId
	 * @return
	 */
	List<DqDatasourceColumn> listDqDatasourceColumnByDsId(Integer tableId);
	
	/**
	 * 根据id查询
	 * @param id
	 * @return
	 */
	List<DqDatasourceColumn> listDqDatasourceColumnById(Collection<Integer> id);
	/**
	 * 根据batchId columnId查询
	 * @param statDate
	 * @param columnId
	 * @return
	 */
	List<DqColumnResult> listDqColumnResultByBatchId(String batchId,List<Integer> columnId);
	/**
	 * 根据batchId、columnId查询
	 * @param statDate
	 * @param columnId
	 * @return
	 */
	DqColumnResult getDqColumnResultByBatchId(String batchId,Integer columnId);
	
	/**
	 * 根据batchId、columnId 、statDate查询
	 * @param statDate
	 * @param columnId
	 * @return
	 */
	List<DqColumnResult> listDqColumnResultLaster(QualityQuery data,List<Integer> columnId);
	
	
	/**
	 * 根据dataSource ID查询
	 * @param data
	 * @return
	 */
	List<DqColumnCompare> listDqColumnCompareByDsId(QualityQuery data);
	
	
	DqCompareResult getDqCompareResult(String statDate,Integer columnId);
	
	DqRuleAe getDqRuleAeById(Integer id);
	
	/**
	 * 从DQ_COMPARE_RESULT表里统计本batchId的结果
	 * @param data
	 * @return
	 */
	List<DataSourceResult> listFromColumnResult(QualityQuery data);
	
	String stats(QualityQuery data);
	
	List<DqConfSms> listAllDqConfSms();
}