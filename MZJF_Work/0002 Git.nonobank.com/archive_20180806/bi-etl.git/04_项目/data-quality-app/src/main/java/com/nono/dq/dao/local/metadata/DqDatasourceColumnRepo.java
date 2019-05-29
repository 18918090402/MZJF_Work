package com.nono.dq.dao.local.metadata;

import java.util.Collection;
import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.nono.dq.model.dto.metadata.DqDatasourceColumn;

@Repository
public interface DqDatasourceColumnRepo extends CrudRepository<DqDatasourceColumn, Integer> {
	public List<DqDatasourceColumn> findByIsValidAndTableId(Integer isValid,Integer tableId);
	
	public List<DqDatasourceColumn> findByIsValidAndIdIn(Integer isValid,Collection<Integer> id);
}