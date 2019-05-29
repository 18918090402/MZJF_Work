package com.nono.dq.dao.local.metadata;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.nono.dq.model.bo.SystemSms;
import com.nono.dq.model.dto.metadata.DqConfSms;

@Repository
public interface DqConfSmsRepo extends CrudRepository<DqConfSms, Integer> {
 
	/**
	 * 保存待发送的消息到表中
	 * @param sms
	 */
	@Modifying
	@Query(value="insert into risk.System_Sms_Log (content,mobile_num,kind) "
			+ " values (:#{#data.content},:#{#data.mobileNum},:#{#data.kind} )"
			,nativeQuery=true)
	void saveSms(@Param("data")SystemSms sms);
}