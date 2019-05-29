package com.nono.dq.dao.local.metadata;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.nono.dq.model.dto.schedule.QrtzJobLog;

@Repository
public interface QrtzJobLogRepo extends CrudRepository<QrtzJobLog,String>{
 
}