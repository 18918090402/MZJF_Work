package com.nono.dq.biz.impl;

import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.stream.Collectors;

import org.apache.commons.collections.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.nono.dq.aop.SystemServiceLog;
import com.nono.dq.biz.MetaDataService;
import com.nono.dq.biz.fetch.MetaDataFetchService;
import com.nono.dq.biz.modify.MetaDataModifyService;
import com.nono.dq.biz.sms.SmsService;
import com.nono.dq.common.Constant;
import com.nono.dq.dao.local.manager.BaseSqlManager;
import com.nono.dq.factory.SqlManagerFactory;
import com.nono.dq.model.QualityQuery;
import com.nono.dq.model.bo.SystemSms;
import com.nono.dq.model.dto.metadata.DataSourceResult;
import com.nono.dq.model.dto.metadata.DqColumnCompare;
import com.nono.dq.model.dto.metadata.DqColumnResult;
import com.nono.dq.model.dto.metadata.DqCompareResult;
import com.nono.dq.model.dto.metadata.DqConfSms;
import com.nono.dq.model.dto.metadata.DqDataSource;
import com.nono.dq.model.dto.metadata.DqDatasourceColumn;
import com.nono.dq.model.dto.metadata.DqJdbcMetadata;
import com.nono.dq.model.dto.metadata.DqRuleAe;
import com.nono.dq.util.RegexUtils;
import com.nono.dq.util.ScriptEngineUtil;

@Service
@Transactional
public class MetaDataServiceImpl implements MetaDataService {
	private final Logger LOGGER = LoggerFactory.getLogger(MetaDataServiceImpl.class);

	private DecimalFormat decimalFormat= new DecimalFormat("#.##");
	
	@Autowired
	private MetaDataFetchService metaDataFetchService;

	@Autowired
	private MetaDataModifyService metaDataModifyService;

	@Autowired
	private MetaDataService metaDataService;
	
	@Autowired
	private SmsService smsService;
	/***
	 * 保证每次都写入到数据库
	 */
	@SystemServiceLog(description = "计算列")
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor= {Exception.class})
	public void calculateColumn(final QualityQuery data) throws Exception {
		List<DqDataSource> dsList = metaDataFetchService.listDqDataSource(data);
		Map<DqDataSource, HashSet<DqDatasourceColumn>> dsColumnMap = new HashMap<>();
		for (DqDataSource ds : dsList) {
			List<DqDatasourceColumn> columnList = metaDataFetchService
					.listDqDatasourceColumnByDsId(ds.getId());
			if (CollectionUtils.isEmpty(columnList)) {
				continue;
			}
			HashSet<DqDatasourceColumn> columnSet = new HashSet<>();
			for(DqDatasourceColumn e:columnList) {
				columnSet.add(e);
			}
			dsColumnMap.put(ds, columnSet);
		}
		//查询依赖的计算项
		if(data.getDepends()) {
			List<DqColumnCompare>  compareList = metaDataFetchService.listDqColumnCompareByDsId(data);
			Set<Integer> columnIdSet = new HashSet<Integer>();
			for(DqColumnCompare e:compareList) {
				columnIdSet.addAll(RegexUtils.extractInteger(e.getTargetColumns()));
			}
			List<DqDatasourceColumn> dependsColumn = metaDataFetchService.listDqDatasourceColumnById(columnIdSet);
			//查询DS
			for(DqDatasourceColumn e:dependsColumn) {
				DqDataSource ds = metaDataFetchService.getDqDataSource(e.getId());
				HashSet<DqDatasourceColumn> columnSet = dsColumnMap.get(ds);
				if(CollectionUtils.isEmpty(columnSet)) {
					columnSet = new HashSet<>();
				}
				columnSet.add(e);
				dsColumnMap.put(ds, columnSet);
			}
		}
		for(Entry<DqDataSource, HashSet<DqDatasourceColumn>> entry:dsColumnMap.entrySet()) {
			List<DqColumnResult> resultList = new ArrayList<>();
			DqJdbcMetadata jdbcMetadata = metaDataFetchService.getJdbcMetadata(entry.getKey());
			BaseSqlManager manager = SqlManagerFactory.getInstance(jdbcMetadata);
			
			try {
				resultList.addAll(calculateColumnExpression(entry.getValue(), manager, entry.getKey(),data));
				resultList.addAll(calculateColumnScript(entry.getValue(), manager, entry.getKey(),data));
				metaDataModifyService.mergeDqColumnResult(resultList);
			}catch (Exception e) {
				// TODO: handle exception
				LOGGER.trace("{}",e);
				throw new Exception(Constant.RES_ERROR_MSG_CALC);
			} finally {
				manager.close();
			}
		}
	}

	/**
	 * 脚本计算
	 * 
	 * @param listALLColumn
	 * @param manager
	 * @param dqDataSource
	 * @return
	 * @throws Exception
	 */
	private List<DqColumnResult> calculateColumnScript(HashSet<DqDatasourceColumn> listALLColumn, BaseSqlManager manager,
			DqDataSource dqDataSource,QualityQuery data) throws Exception {
		List<DqColumnResult> columnResultList = new ArrayList<>();
		if (CollectionUtils.isEmpty(listALLColumn)) {
			return columnResultList;
		}
		List<DqDatasourceColumn> listColumn = listALLColumn.stream().filter(p -> p.getStaticalMode().equals("2"))
				.collect(Collectors.toList());
		if (CollectionUtils.isEmpty(listColumn)) {
			return columnResultList;
		}
		for (DqDatasourceColumn column : listColumn) {
			ResultSet resultSet = manager.validExpressionScript(column, dqDataSource);
			if (resultSet == null) {
				continue;
			}
			HashMap<String, Object> resultMap = manager.getColumnValues(resultSet);
			for (Entry<String, Object> entry : resultMap.entrySet()) {
				DqColumnResult result = new DqColumnResult();
				columnResultList.add(result);
				result.setColumnId(column.getId());
				result.setColumnName(column.getColumnName());
				result.setTableId(column.getTableId());
				result.setColumnValue(entry.getValue().toString());
				result.setStatDate(data.getStatDate());
				result.setBatchId(data.getBatchId());
				result.setIsLast(1);
			}
		}
		return columnResultList;
	}

	/**
	 * 列表达式
	 * 
	 * @param listALLColumn
	 * @param manager
	 * @param dqDataSource
	 * @return
	 * @throws Exception
	 */
	private List<DqColumnResult> calculateColumnExpression(HashSet<DqDatasourceColumn> listALLColumn,
			BaseSqlManager manager, DqDataSource dqDataSource,QualityQuery data) throws Exception {
		List<DqColumnResult> columnResultList = new ArrayList<>();
		if (CollectionUtils.isEmpty(listALLColumn)) {
			return columnResultList;
		}
		List<DqDatasourceColumn> listColumn = listALLColumn.stream().filter(p -> p.getStaticalMode().equals("1"))
				.collect(Collectors.toList());
		if (CollectionUtils.isEmpty(listColumn)) {
			return columnResultList;
		}
		ResultSet resultSet = manager.validExpressionColumn(listColumn, dqDataSource);
		HashMap<String, Object> resultMap = manager.getColumnValues(resultSet);
		for (Entry<String, Object> entry : resultMap.entrySet()) {
			DqColumnResult result = new DqColumnResult();
			columnResultList.add(result);
			result.setColumnId(Integer.valueOf(entry.getKey()));
			DqDatasourceColumn ruleColumn = listColumn.stream()
					.filter(p -> p.getId() == (Integer.valueOf(entry.getKey()))).findFirst().get();
			result.setColumnName(ruleColumn.getColumnName());
			result.setTableId(ruleColumn.getTableId());
			result.setColumnValue(entry.getValue().toString());
			result.setStatDate(data.getStatDate());
			result.setBatchId(data.getBatchId());
			result.setIsLast(1);
		}
		// metaDataModifyService.mergeDqColumnResult(columnResultList);
		return columnResultList;
	}

	/**
	 * DQ_COMPARE_RESULT表中数据需要先跑完
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void compareColumn(QualityQuery data) throws Exception {
		// TODO Auto-generated method stub
		List<DqColumnCompare> dqColumnCompareList = metaDataFetchService.listDqColumnCompareByDsId(data);
		List<DqCompareResult> dqCompareResultList = new ArrayList<>();
		
		for (DqColumnCompare compare : dqColumnCompareList) {
			// 获取每个列比较的目标列
			List<Integer> targetColumns = RegexUtils.extractInteger(compare.getTargetColumns());
			List<DqColumnResult> targetColumnResult = metaDataFetchService
					.listDqColumnResultByBatchId(data.getBatchId(), targetColumns);
			DqColumnResult sourceResult = metaDataFetchService.getDqColumnResultByBatchId(data.getBatchId(),
					compare.getColumnId());
			//查询之前计算的计算项
			if(!data.getDepends() && targetColumns.size()!=targetColumnResult.size()) {
				List<Integer> dependsColumn = new ArrayList<>();
				for(Integer columnId:targetColumns) {
					Boolean isExists=false;
					for(DqColumnResult result:targetColumnResult) {
						if(result.getColumnId()==columnId) {
							isExists=true;
							break;
						}
					}
					if(!isExists) {
						dependsColumn.add(columnId);
					}
				}
				if(CollectionUtils.isNotEmpty(dependsColumn)) {
					targetColumnResult.addAll(metaDataFetchService.listDqColumnResultLaster(data,dependsColumn));
				}
			}
			
			if(targetColumns.size()!=targetColumnResult.size()) {
				throw new Exception(Constant.RES_ERROR_MSG_MIS);
			}
			
			// 列的变量替换成变量值
			String targetVarStr = compare.getTargetColumns();
			for (DqColumnResult columnResult : targetColumnResult) {
				targetVarStr = RegexUtils.replaceInteger(targetVarStr, columnResult);
			}
			String targetValue = decimalFormat.format(ScriptEngineUtil.evalValue(targetVarStr));
			LOGGER.trace("{},{}",targetValue,targetVarStr);
			
			DqRuleAe ruleAe = metaDataFetchService.getDqRuleAeById(compare.getRuleId());
			Object compareResult = ScriptEngineUtil.evalValue(
					sourceResult.getColumnValue() + " " + ruleAe.getAeValue() + " " + targetValue);
			
			DqCompareResult result = new DqCompareResult();
			result.setCompareId(compare.getId());
			result.setTableId(sourceResult.getTableId());
			result.setColumnId(compare.getColumnId());
			result.setStatDate(data.getStatDate());
			result.setBatchId(data.getBatchId());
			result.setWarningEnable(compare.getWarningEnable());
			result.setWarningType(compare.getWarningType());
			result.setWarningStatus(1);
			result.setColumnValue(sourceResult.getColumnValue());
			result.setTargetValue(targetValue.toString());
			result.setLevel(compare.getLevel());
			if ("true".equals(compareResult.toString())) {
				result.setCompareResult(1);
			} else {
				result.setCompareResult(2);
			}

			dqCompareResultList.add(result);
		}
		metaDataModifyService.mergeDqCompareResult(dqCompareResultList);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public String qualifyDatasources(QualityQuery data) throws Exception {
		//新的事物，保证数据可以写进去
		metaDataService.calculateColumn(data);
		compareColumn(data);
		compareDataSource(data);
		String statsStr = metaDataFetchService.stats(data);
		return statsStr;
	}
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void compareDataSource(QualityQuery data) throws Exception {
		// TODO Auto-generated method stub
		List<DataSourceResult> resultList = metaDataFetchService.listFromColumnResult(data);
		metaDataModifyService.mergeDqDataSourceResult(data.getBatchId(), resultList);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public String stats(QualityQuery data) throws Exception {
		// TODO Auto-generated method stub
		return metaDataFetchService.stats(data);
	}

	/**
	 * 发送当天的统计短信
	 */
	@Override
	public void sms(QualityQuery data) throws Exception {
		// TODO Auto-generated method stub
		String statsStr = metaDataFetchService.stats(data);
		List<DqConfSms>  smsList = metaDataFetchService.listAllDqConfSms();
		for(DqConfSms confSms:smsList) {
			SystemSms sms  = new SystemSms();
			sms.setContent(statsStr);
			sms.setMobileNum(confSms.getMobileNum());
			sms.setKind(1);
			smsService.sendMsm(sms);
		}
	}
}