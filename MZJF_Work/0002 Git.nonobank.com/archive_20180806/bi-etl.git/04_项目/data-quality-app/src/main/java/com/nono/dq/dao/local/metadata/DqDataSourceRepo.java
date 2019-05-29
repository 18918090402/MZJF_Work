package com.nono.dq.dao.local.metadata;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.nono.dq.model.dto.metadata.DqDataSource;

@Repository
public interface DqDataSourceRepo extends CrudRepository<DqDataSource, Integer> {
	public List<DqDataSource> findByIsValid(Integer isvalid);
	
	public List<DqDataSource> findByIdInAndIsValid(List<Integer> id,Integer isvalid);
	
	@Query("select s from DqDataSource s,DqDatasourceColumn t " +
            "where s.id= t.tableId"
            + " and t.id in (?1) ")
	public DqDataSource getByColumnId(Integer columnId);
}