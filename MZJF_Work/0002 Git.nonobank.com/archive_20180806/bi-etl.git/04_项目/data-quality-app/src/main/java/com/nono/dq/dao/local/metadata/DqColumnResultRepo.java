package com.nono.dq.dao.local.metadata;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.nono.dq.model.dto.metadata.DqColumnResult;

@Repository
public interface DqColumnResultRepo extends CrudRepository<DqColumnResult, Integer> {
	
	public List<DqColumnResult> findByIsLastAndStatDateAndColumnId(Integer isLast,String statDate,Integer columnId);
	
	public DqColumnResult findByBatchIdAndColumnId(String batchId,Integer columnId);
	
	public List<DqColumnResult> findByBatchIdAndColumnIdIn(String batchId,List<Integer> columnId);
	
	public List<DqColumnResult> findByIsLastAndStatDateAndColumnIdIn(Integer isLast,String statDate,List<Integer> columnId);
}