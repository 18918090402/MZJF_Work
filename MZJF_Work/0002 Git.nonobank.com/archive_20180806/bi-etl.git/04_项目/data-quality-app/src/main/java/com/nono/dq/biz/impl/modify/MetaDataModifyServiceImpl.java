package com.nono.dq.biz.impl.modify;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.nono.dq.biz.modify.MetaDataModifyService;
import com.nono.dq.dao.local.metadata.DqCompareResultRepo;
import com.nono.dq.dao.local.metadata.DqDatasourceResultRepo;
import com.nono.dq.dao.local.metadata.DqColumnResultRepo;
import com.nono.dq.model.dto.metadata.DataSourceResult;
import com.nono.dq.model.dto.metadata.DqColumnResult;
import com.nono.dq.model.dto.metadata.DqCompareResult;
import com.nono.dq.model.dto.metadata.DqDatasourceResult;

@Service
@Transactional(propagation = Propagation.REQUIRED)
public class MetaDataModifyServiceImpl implements MetaDataModifyService {

	@Autowired
	private DqCompareResultRepo dqCompareResultRepo;
	@Autowired
	private DqColumnResultRepo dqColumnResultRepo;
	
	@Autowired
	private DqDatasourceResultRepo dqDatasourceResultRepo;
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void mergeDqCompareResult(List<DqCompareResult> dqCompareResult) {
		// TODO Auto-generated method stub
		for (DqCompareResult result : dqCompareResult) {
			DqCompareResult hintReulst = dqCompareResultRepo.findByStatDateAndCompareId(result.getStatDate(),
					result.getCompareId());
			if (hintReulst != null) {
				result.setId(hintReulst.getId());
			}
			dqCompareResultRepo.save(result);
		}
	}
	
	/**
	 * 之前的isLast更新成 0
	 */
	@Override
	public void mergeDqColumnResult(List<DqColumnResult> dqColumnResult) {
		// TODO Auto-generated method stub
		for (DqColumnResult result : dqColumnResult) {
			List<DqColumnResult> hintReulst = dqColumnResultRepo.findByIsLastAndStatDateAndColumnId(1,result.getStatDate(),
					result.getColumnId());
			//更新之前的数据
			if (CollectionUtils.isNotEmpty(hintReulst)) {
				hintReulst.stream().forEach(p ->p.setIsLast(0));
				dqColumnResultRepo.save(hintReulst);
			}
			dqColumnResultRepo.save(result);
		}
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void mergeDqDataSourceResult(String batchId,List<DataSourceResult> resultList) {
		// TODO Auto-generated method stub
		List<DqDatasourceResult> qdsresult = new ArrayList<DqDatasourceResult>();
		for(DataSourceResult dsResult:resultList) {
			DqDatasourceResult  result = new DqDatasourceResult();
			qdsresult.add(result);
			result.setLevel(dsResult.getLevel());
			result.setTableId(dsResult.getTableId());
			result.setNotes(dsResult.getNotes());
			result.setStatDate(dsResult.getStatDate());
			
			result.setBatchId(batchId);
			DqDatasourceResult hint = dqDatasourceResultRepo.findByStatDateAndTableId(dsResult.getStatDate(), dsResult.getTableId());
			if(hint!=null) {
				result.setId(hint.getId());
			}
			
		}
		dqDatasourceResultRepo.save(qdsresult);
	}
}