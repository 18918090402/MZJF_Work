package com.nono.dq.biz.schedule;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.quartz.SchedulerException;

import com.nono.dq.model.dto.schedule.JobHealth;
import com.nono.dq.model.request.SchedulerRequestBody;

public interface SchedulerService {

    public void startUpdateInstances();

    public Boolean addJob(String groupName,String jobName,SchedulerRequestBody schedulerRequestBody);
    
    public List<Map<String, Serializable>> getJobs();

    public Boolean deleteJob(String groupName,String jobName);

    public JobHealth getHealthInfo() throws SchedulerException;
    
    public Boolean pauseJob(String groupName,String jobName);
    
    public Boolean unscheduleJob(String groupName,String jobName);
    public Boolean rescheduleJob(String groupName,String jobName);
}