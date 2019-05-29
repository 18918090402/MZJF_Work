package com.nono.dq.biz.schedule;
import static org.quartz.JobBuilder.newJob;
import static org.quartz.JobKey.jobKey;
import static org.quartz.TriggerBuilder.newTrigger;
import static org.quartz.TriggerKey.triggerKey;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.quartz.JobDetail;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SimpleScheduleBuilder;
import org.quartz.Trigger;
import org.quartz.TriggerKey;
import org.quartz.impl.matchers.GroupMatcher;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.google.common.collect.Collections2;
import com.nono.dq.dao.local.metadata.QrtzJobInstanceRepo;
import com.nono.dq.model.dto.schedule.JobHealth;
import com.nono.dq.model.request.SchedulerRequestBody;
import com.nono.dq.util.DateUtil;

@Service
public class SchedulerServiceImpl implements SchedulerService{

    private static final Logger LOGGER = LoggerFactory.getLogger(SchedulerServiceImpl.class);

    @Autowired
    private Scheduler scheduler;
    
    @Autowired
    private QrtzJobInstanceRepo jobInstanceRepo;

    public static final String ACCURACY_BATCH_GROUP = "BA";



    public SchedulerServiceImpl(){
    	
    }

    @Override
    public List<Map<String, Serializable>> getJobs(){
        //Scheduler scheduler = factory.getObject();
        List<Map<String, Serializable>> list = new ArrayList<>();
        try{
	        for (String groupName : scheduler.getJobGroupNames()) {
	            for (JobKey jobKey : scheduler.getJobKeys(GroupMatcher.jobGroupEquals(groupName))) {
	                setJobsByKey(list,scheduler, jobKey);
	            }
	        }
        }catch (Exception e) {
			// TODO: handle exception
        	LOGGER.error("{}",e);
		}
        return list;
    }

    public void setJobsByKey(List<Map<String, Serializable>> list,Scheduler scheduler, JobKey jobKey) throws SchedulerException {
        //List<Trigger> triggers = (List<Trigger>) scheduler.getTriggersOfJob(jobKey);
        //if (triggers.size() > 0) {
            //always get next run
            Map<String, Serializable> map = new HashMap<>();
            setMap(map,scheduler,jobKey);
            list.add(map);
        //}
    }


    public void setMap(Map<String, Serializable> map,Scheduler scheduler,JobKey jobKey) throws SchedulerException {
    	JobDetail jd = scheduler.getJobDetail(jobKey);
    	Trigger.TriggerState triggerState=null;
    	Date nextFireTime=null;
    	Date previousFireTime=null;
        List<Trigger> triggers = (List<Trigger>) scheduler.getTriggersOfJob(jobKey);
        if(!CollectionUtils.isEmpty(triggers)){
        	nextFireTime = triggers.get(0).getNextFireTime();
            previousFireTime=triggers.get(0).getPreviousFireTime();
            triggerState=scheduler.getTriggerState(triggers.get(0).getKey());
        }

        map.put("jobName", jobKey.getName());
        map.put("groupName", jobKey.getGroup());
        if (nextFireTime!=null){
            map.put("nextFireTime", nextFireTime.getTime());
        }
        else {
            map.put("nextFireTime", -1);
        }
        if (previousFireTime!=null) {
            map.put("previousFireTime", previousFireTime.getTime());
        }
        else {
            map.put("previousFireTime", -1);
        }
        map.put("triggerState",triggerState);
        map.put("measure", jd.getJobDataMap().getString("measure"));
        map.put("sourcePat",jd.getJobDataMap().getString("sourcePat"));
        map.put("targetPat",jd.getJobDataMap().getString("targetPat"));
        if(StringUtils.isNotEmpty(jd.getJobDataMap().getString("dataStartTimestamp"))) {
            map.put("dataStartTimestamp", jd.getJobDataMap().getString("dataStartTimestamp"));
        }
        map.put("jobStartTime",jd.getJobDataMap().getString("jobStartTime"));
        map.put("periodTime",jd.getJobDataMap().getString("periodTime"));
    }


    public void setJobStartTime(Date jobStartTime,int periodTime){
        long currentTimestamp=System.currentTimeMillis();
        long jobstartTimestamp=jobStartTime.getTime();
        LOGGER.trace("jobStartTime:{}",DateUtil.formatStr(jobStartTime, "yyyy-MM-dd HH:mm:ss"));
        //if jobStartTime is before currentTimestamp, set it as the latest trigger time in the future
        if(jobStartTime.before(new Date(currentTimestamp))){
            long n=(currentTimestamp-jobstartTimestamp)/(long)(periodTime*1000);
            jobstartTimestamp=jobstartTimestamp+(n+1)*(long)(periodTime*1000);
            jobStartTime.setTime(jobstartTimestamp);
        }
    }

    public void setJobDetail(JobDetail jobDetail,SchedulerRequestBody schedulerRequestBody,String groupName,String jobName){
        jobDetail.getJobDataMap().put("jobType", schedulerRequestBody.getJobType());
        jobDetail.getJobDataMap().put("dataId", schedulerRequestBody.getDataId());
        jobDetail.getJobDataMap().put("dataStartTimestamp", schedulerRequestBody.getDataStartTimestamp());
        jobDetail.getJobDataMap().put("jobStartTime", schedulerRequestBody.getJobStartTime());
        jobDetail.getJobDataMap().put("periodTime", schedulerRequestBody.getPeriodTime());
        jobDetail.getJobDataMap().put("lastTime", "");
        jobDetail.getJobDataMap().put("groupName",groupName);
        jobDetail.getJobDataMap().put("jobName",jobName);
    }

    @Transactional(propagation=Propagation.REQUIRED)
    @Override
    public Boolean deleteJob(String group, String name) {
        try {
            //Scheduler scheduler = factory.getObject();
            scheduler.deleteJob(new JobKey(name, group));
            jobInstanceRepo.deleteInGroupAndjobName(group,name);
            return true;
        } catch (SchedulerException e) {
            LOGGER.error(e.getMessage());
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return false;
        }
    }

    @Override
    @Scheduled(fixedDelayString = "${jobInstance.fixedDelay.in.milliseconds}")
    public void startUpdateInstances(){
    	LOGGER.info("****************START**********");
        List<Object> groupJobList=jobInstanceRepo.findGroupWithJobName();
        for (Object groupJobObj : groupJobList){
            try{
                Object[] groupJob=(Object[])groupJobObj;
                if (groupJob!=null && groupJob.length==2){
                   // updateInstances(groupJob[0].toString(),groupJob[1].toString());
                }
            }catch (Exception e){
                LOGGER.error(""+e);
            }
        }
    }

    @Override
    public JobHealth getHealthInfo() throws SchedulerException {
        //Scheduler scheduler=factory.getObject();
        int jobCount=0;
        int invalid=0;
        int runing= scheduler.getCurrentlyExecutingJobs().size();
        for (String groupName : scheduler.getJobGroupNames()){
            for (JobKey jobKey : scheduler.getJobKeys(GroupMatcher.jobGroupEquals(groupName))){
            	TriggerKey triggerKey = triggerKey(jobKey.getName(), jobKey.getGroup());
            	//没有调度
            	if(scheduler.getTrigger(triggerKey) ==null ){
            		invalid++;
            	}
            	jobCount++;
            }
        }
        JobHealth jobHealth=new JobHealth(runing,invalid,jobCount);
        return jobHealth;
    }
    
    
    /***
     * 增加JOB，如果已经存在，会根据信息更新调度、JOB Detail
     */
    @Override
    public Boolean addJob(String groupName, String jobName, SchedulerRequestBody schedulerRequestBody) {
        int periodTime = 0;
        Date jobStartTime=null;
//        SimpleDateFormat format=new SimpleDateFormat("yyyyMMdd HH:mm:ss");
        try{
            periodTime = Integer.parseInt(schedulerRequestBody.getPeriodTime());
            jobStartTime=new Date(Long.parseLong(schedulerRequestBody.getJobStartTime()));
            setJobStartTime(jobStartTime,periodTime);
        }catch (Exception e){
            LOGGER.info("jobStartTime or periodTime format error! "+e);
            return false;
        }
        try {
            //Scheduler scheduler = factory.getObject();
            TriggerKey triggerKey = triggerKey(jobName, groupName);
            if (scheduler.checkExists(triggerKey)) {
                scheduler.unscheduleJob(triggerKey);
            }
            JobKey jobKey = jobKey(jobName, groupName);
            JobDetail jobDetail;
            if (scheduler.checkExists(jobKey)) {
                jobDetail = scheduler.getJobDetail(jobKey);
                setJobDetail(jobDetail,schedulerRequestBody,groupName,jobName);
                scheduler.addJob(jobDetail, true);
            } else {
                jobDetail = newJob(SubmitJob.class)
                        .storeDurably()
                        .withIdentity(jobKey)
                        .build();
                //set JobDetail
                setJobDetail(jobDetail,schedulerRequestBody,groupName,jobName);
                scheduler.addJob(jobDetail, false);
            }
            Trigger trigger = newTrigger()
                    .withIdentity(triggerKey)
                    .forJob(jobDetail)
//					.withSchedule(CronScheduleBuilder.cronSchedule("0 0/1 0 * * ?"))
                    .withSchedule(SimpleScheduleBuilder.simpleSchedule()
                            .withIntervalInSeconds(periodTime)
                            .repeatForever())
                    .startAt(jobStartTime)
                    .build();
            //scheduler.getListenerManager().addJobListener(jobListener);
            scheduler.scheduleJob(trigger);
            return true;
        } catch (SchedulerException e) {
            LOGGER.error("", e);
            return false;
        }
    }
    
	@Override
	public Boolean pauseJob(String groupName, String jobName) {
		// TODO Auto-generated method stub
		JobKey jobKey = jobKey(jobName, groupName);
		try {
			scheduler.pauseJob(jobKey);
			return true;
		} catch (SchedulerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			LOGGER.error("", e);
			return false;
		}
	}

	/**
	 * 只取消调度，不删job
	 */
	@Override
	public Boolean unscheduleJob(String groupName, String jobName) {
		// TODO Auto-generated method stub
		TriggerKey triggerKey = triggerKey(jobName, groupName);
		try {
			scheduler.unscheduleJob(triggerKey);
			return true;
		} catch (SchedulerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
	
	/**
	 * 重置job
	 */
	@Override
	public Boolean rescheduleJob(String groupName, String jobName) {
		// TODO Auto-generated method stub
		TriggerKey triggerKey = triggerKey(jobName, groupName);
		try {
			scheduler.rescheduleJob(triggerKey, null);
			return true;
		} catch (SchedulerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
}