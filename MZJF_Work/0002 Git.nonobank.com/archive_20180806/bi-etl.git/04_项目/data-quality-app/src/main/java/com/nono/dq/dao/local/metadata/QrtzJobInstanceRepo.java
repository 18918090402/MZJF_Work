package com.nono.dq.dao.local.metadata;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.nono.dq.model.dto.schedule.QrtzJobInstance;

@Repository
public interface QrtzJobInstanceRepo extends CrudRepository<QrtzJobInstance,Long>{
    @Query("select s from QrtzJobInstance s " +
            "where s.groupName= ?1 and s.jobName=?2 "/*+
            "order by s.timestamp desc"*/)
    List<QrtzJobInstance> findByGroupNameAndJobName(String group, String name, Pageable pageable);

    @Query("select s from QrtzJobInstance s " +
            "where s.groupName= ?1 and s.jobName=?2 ")
    List<QrtzJobInstance> findByGroupNameAndJobName(String group, String name);

    @Query("select DISTINCT s.groupName, s.jobName from QrtzJobInstance s")
    List<Object> findGroupWithJobName();

    @Transactional
    @Modifying
    @Query("update QrtzJobInstance s "+
            "set s.state= ?2, s.appId= ?3 where s.id= ?1")
    void setFixedStateAndappIdFor(Long Id, String state, String appId);

    @Transactional(propagation=Propagation.REQUIRED)
    @Modifying
    @Query("delete from QrtzJobInstance s " +
            "where s.groupName= ?1 and s.jobName=?2 ")
    void deleteInGroupAndjobName(String groupName, String jobName);
}