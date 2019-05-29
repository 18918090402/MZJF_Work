package com.nono.dq.dao.local.metadata;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.nono.dq.model.dto.metadata.DqColumnCompare;

@Repository
public interface DqColumnCompareRepo extends CrudRepository<DqColumnCompare, Integer> {
	
	List<DqColumnCompare> findByIsValid(Integer isValid);
	
	
	 @Query("select s from DqColumnCompare s,DqDatasourceColumn t " +
	            "where s.columnId= t.id"
	            + " and t.tableId in (?1) ")
	List<DqColumnCompare> listByDsId(List<Integer> ids);
}