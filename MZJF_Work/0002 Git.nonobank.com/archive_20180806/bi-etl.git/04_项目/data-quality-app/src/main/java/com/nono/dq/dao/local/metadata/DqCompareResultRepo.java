package com.nono.dq.dao.local.metadata;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.nono.dq.model.dto.metadata.DqCompareResult;

@Repository
public interface DqCompareResultRepo extends CrudRepository<DqCompareResult, Integer> {
	
	public DqCompareResult findByStatDateAndCompareId(String statDate,Integer compareId);
}