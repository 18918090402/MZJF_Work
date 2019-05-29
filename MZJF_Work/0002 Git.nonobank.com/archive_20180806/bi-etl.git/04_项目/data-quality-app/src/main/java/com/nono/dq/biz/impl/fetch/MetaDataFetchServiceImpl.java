package com.nono.dq.biz.impl.fetch;

import java.util.Collection;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.nono.dq.biz.fetch.MetaDataFetchService;
import com.nono.dq.dao.local.metadata.DatasourceResultRepo;
import com.nono.dq.dao.local.metadata.DqColumnCompareRepo;
import com.nono.dq.dao.local.metadata.DqColumnResultRepo;
import com.nono.dq.dao.local.metadata.DqCompareResultRepo;
import com.nono.dq.dao.local.metadata.DqConfSmsRepo;
import com.nono.dq.dao.local.metadata.DqDataSourceRepo;
import com.nono.dq.dao.local.metadata.DqDatasourceColumnRepo;
import com.nono.dq.dao.local.metadata.DqDatasourceResultRepo;
import com.nono.dq.dao.local.metadata.DqRuleAeRepo;
import com.nono.dq.dao.local.metadata.JdbcMetadataRepo;
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

@Service
@Transactional(propagation=Propagation.NOT_SUPPORTED)
public class MetaDataFetchServiceImpl implements MetaDataFetchService {
	@Autowired
	private JdbcMetadataRepo jdbcMetadataRepo;
	@Autowired
	private DqDataSourceRepo dqDataSourceRepo;
	@Autowired
	private DqColumnCompareRepo dqColumnCompareRepo;
	@Autowired
	private DqCompareResultRepo dqCompareResultRepo;
	@Autowired
	private DqRuleAeRepo dqRuleAeRepo;
	@Autowired
	private DqDatasourceColumnRepo dqDatasourceColumnRepo;
	
	@Autowired
	private DqColumnResultRepo dqDatasourceColumnResultRepo;
	
	@Autowired
	private DqDatasourceResultRepo dqDatasourceResultRepo;
	
	@Autowired
	private DatasourceResultRepo datasourceResultRepo;
	
	@Autowired
	private DqConfSmsRepo dqConfSmsRepo;
	
	@Override
	public DqJdbcMetadata getJdbcMetadata(DqDataSource dqDataSource) {
		return jdbcMetadataRepo.getJdbcMetadataByID(dqDataSource);
	}
	
	@Override
	public List<DqDataSource> listDqDataSource(QualityQuery data) {
		if(CollectionUtils.isEmpty(data.getItems())){
			return dqDataSourceRepo.findByIsValid(1);
		}else{
			return dqDataSourceRepo.findByIdInAndIsValid(data.getItems(),1);
		}
	}

	@Override
	public List<DqColumnCompare> listDqColumnCompareByDsId(QualityQuery data) {
		// TODO Auto-generated method stub
		if(CollectionUtils.isEmpty(data.getItems())){
			return dqColumnCompareRepo.findByIsValid(1);
		}else{
			return dqColumnCompareRepo.listByDsId(data.getItems());
		}
	}


	@Override
	public DqCompareResult getDqCompareResult(String statDate, Integer columnId) {
		// TODO Auto-generated method stub
		return dqCompareResultRepo.findByStatDateAndCompareId(statDate, columnId);
	}

	@Override
	public DqRuleAe getDqRuleAeById(Integer id) {
		// TODO Auto-generated method stub
		return dqRuleAeRepo.findOne(id);
	}

	@Override
	public List<DqDatasourceColumn> listDqDatasourceColumnByDsId(Integer tableId) {
		// TODO Auto-generated method stub
		return dqDatasourceColumnRepo.findByIsValidAndTableId(1,tableId);
	}
	
	@Override
	public List<DqColumnResult> listDqColumnResultByBatchId(String batchId, List<Integer> columnId) {
		// TODO Auto-generated method stub
		return dqDatasourceColumnResultRepo.findByBatchIdAndColumnIdIn(batchId, columnId);
	}

	@Override
	public DqColumnResult getDqColumnResultByBatchId(String batchId, Integer columnId) {
		// TODO Auto-generated method stub
		return dqDatasourceColumnResultRepo.findByBatchIdAndColumnId(batchId, columnId);
	}

	@Override
	public List<DqDatasourceColumn> listDqDatasourceColumnById(Collection<Integer> id) {
		// TODO Auto-generated method stub
		return dqDatasourceColumnRepo.findByIsValidAndIdIn(1, id);
	}

	@Override
	public DqDataSource getDqDataSource(Integer columnId) {
		// TODO Auto-generated method stub
		return dqDataSourceRepo.getByColumnId(columnId);
	}

	@Override
	public List<DqColumnResult> listDqColumnResultLaster(QualityQuery data,List<Integer> columnId) {
		// TODO Auto-generated method stub
		return dqDatasourceColumnResultRepo.findByIsLastAndStatDateAndColumnIdIn(1,data.getStatDate(), columnId);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public List<DataSourceResult> listFromColumnResult(QualityQuery data) {
		// TODO Auto-generated method stub
		return datasourceResultRepo.listFromColumnResult(data);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public String stats(QualityQuery data) {
		// TODO Auto-generated method stub
		//所有表的比较结果
		if(CollectionUtils.isEmpty(data.getItems())) {
			return dqDatasourceResultRepo.getStats(data.getStatDate());
		}else{
			return dqDatasourceResultRepo.getStats(data.getStatDate(),data.getItems());
		}
	}

	@Override
	public List<DqConfSms> listAllDqConfSms() {
		// TODO Auto-generated method stub
		return (List<DqConfSms>) dqConfSmsRepo.findAll();
	}
}