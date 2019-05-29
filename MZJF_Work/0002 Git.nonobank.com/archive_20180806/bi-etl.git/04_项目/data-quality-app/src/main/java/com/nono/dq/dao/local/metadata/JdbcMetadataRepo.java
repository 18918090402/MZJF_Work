package com.nono.dq.dao.local.metadata;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.nono.dq.model.dto.metadata.DqDataSource;
import com.nono.dq.model.dto.metadata.DqJdbcMetadata;

@Repository
public interface JdbcMetadataRepo extends CrudRepository<DqJdbcMetadata, Integer> {
	 //?#{[0]}、:paramName
	@Query(value = " SELECT  id,jndi_name,:#{#data.jdbcType} as jdbc_type,"
		   +" AES_DECRYPT(UNHEX(D.JNDI_1),'VC5310*||*') AS host,"
		   +" AES_DECRYPT(UNHEX(D.JNDI_2),'VC5310*||*') AS port,"
		   +" AES_DECRYPT(UNHEX(D.JNDI_3),'VC5310*||*') AS db_name,"
		   +" AES_DECRYPT(UNHEX(D.JNDI_4),'VC5310*||*') AS user_name,"
		   +" AES_DECRYPT(UNHEX(D.JNDI_5),'VC5310*||*') AS password"
		   +" FROM DQ_JDBC D"
		   +" where id=:#{#data.jdbcId}", nativeQuery = true)
	public DqJdbcMetadata getJdbcMetadataByID(@Param("data")DqDataSource dqDataSource);
}