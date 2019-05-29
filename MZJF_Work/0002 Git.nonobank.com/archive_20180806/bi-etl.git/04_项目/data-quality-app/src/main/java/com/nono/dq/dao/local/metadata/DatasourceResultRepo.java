package com.nono.dq.dao.local.metadata;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.nono.dq.model.QualityQuery;
import com.nono.dq.model.dto.metadata.DataSourceResult;

@Repository
public interface DatasourceResultRepo extends CrudRepository<DataSourceResult, Integer> {
	
	@Query(value="select STAT_DATE,TABLE_ID,MIN(LEVEL) as level,group_concat(concat('级别[',LEVEL,']字段数[',ct,']')) as notes " + 
			" from (" + 
				" select STAT_DATE,TABLE_ID,LEVEL,count(1) as ct" + 
				" from DQ_COMPARE_RESULT" +
				" where batch_id =:#{#data.batchId}" + 
				" group by STAT_DATE,TABLE_ID,LEVEL ) T" + 
			" group by STAT_DATE,TABLE_ID"
				,nativeQuery=true)
	List<DataSourceResult> listFromColumnResult(@Param("data")QualityQuery data);
}