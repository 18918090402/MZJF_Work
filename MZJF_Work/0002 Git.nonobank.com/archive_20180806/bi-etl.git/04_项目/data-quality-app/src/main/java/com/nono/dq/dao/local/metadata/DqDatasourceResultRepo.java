package com.nono.dq.dao.local.metadata;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.nono.dq.model.dto.metadata.DqDatasourceResult;

@Repository
public interface DqDatasourceResultRepo extends CrudRepository<DqDatasourceResult, Integer> {
	
	DqDatasourceResult findByStatDateAndTableId(String statDate,Integer tableId);
	//?#{[0]}、:paramName
	@Query(value="select group_concat(concat('[',IF(LEVEL=1,'ERROR','WARIN'),']表数量[',ct,']')) as notes " + 
			" FROM (SELECT LEVEL,COUNT(1) AS CT " + 
				" from DQ_DATASOURCE_RESULT " +
				 " where stat_date=?1" + 
				" GROUP BY LEVEL" + 
			" ) T "
			,nativeQuery=true)
	String getStats(String statDate);
	
	@Query(value="select group_concat(concat('[',IF(LEVEL=1,'ERROR','WARIN'),']表数量[',ct,']')) as notes " + 
			" FROM (SELECT LEVEL,COUNT(1) AS CT " + 
				" from DQ_DATASOURCE_RESULT " +
				 " where stat_date=?1 and TABLE_ID in (?2)" + 
				" GROUP BY LEVEL" + 
			" ) T "
			,nativeQuery=true)
	String getStats(String statDate,List<Integer> ids);
	
}