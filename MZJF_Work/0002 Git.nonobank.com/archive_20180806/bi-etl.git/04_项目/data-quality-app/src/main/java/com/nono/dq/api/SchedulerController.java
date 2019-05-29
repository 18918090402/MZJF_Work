package com.nono.dq.api;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.quartz.SchedulerException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.nono.dq.biz.schedule.SchedulerService;
import com.nono.dq.model.dto.schedule.JobHealth;
import com.nono.dq.model.request.SchedulerRequestBody;
import com.nono.dq.model.response.ResultObject;

@RestController
@RequestMapping("/api/jobs")
public class SchedulerController {
	private static final Logger LOGGER = LoggerFactory.getLogger(SchedulerController.class);

	@Autowired
	SchedulerService schedulerService;

	@RequestMapping({"/statics","/",""})
	public ResultObject<JobHealth> getHealthInfo() throws SchedulerException {
		ResultObject<JobHealth> result = new ResultObject<JobHealth>();
		result.setDomain(schedulerService.getHealthInfo());
		return result;
	}
	
	@RequestMapping("/all")
    public ResultObject<List<Map<String, Serializable>>> getJobs(){
		ResultObject<List<Map<String, Serializable>>> result = new ResultObject<List<Map<String, Serializable>>>();
		result.setDomain(schedulerService.getJobs());
		return result;
    }
	
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public ResultObject<Boolean> addJob(@RequestParam(required = true) String groupName,
			@RequestParam(required = true) String jobName,
			@RequestBody(required = false) SchedulerRequestBody schedulerRequestBody) {
		 ResultObject<Boolean> result = new ResultObject<Boolean>();
		LOGGER.debug("groupName:{},jobName:{},dataSourceId:{},schedulerRequestBody:{}", groupName, jobName,schedulerRequestBody);
		result.setDomain(schedulerService.addJob(groupName, jobName,schedulerRequestBody));
		return result;
	}
	
	@RequestMapping(value = "/del", method = {RequestMethod.DELETE,RequestMethod.GET})
    public ResultObject<Boolean> deleteJob(@RequestParam(name="groupName") String groupName, @RequestParam("jobName") String jobName) {
		 ResultObject<Boolean> result = new ResultObject<Boolean>();
         result.setDomain(schedulerService.deleteJob(groupName,jobName));
         return result;
    }
	
	/**
	 * 取消调度，不再执行调度
	 * @param groupName
	 * @param jobName
	 * @return
	 */
	@RequestMapping(value = "/unschedule", method = RequestMethod.GET)
    public ResultObject<Boolean> unscheduleJob(@RequestParam(name="groupName") String groupName, @RequestParam("jobName") String jobName) {
		 ResultObject<Boolean> result = new ResultObject<Boolean>();
         result.setDomain(schedulerService.unscheduleJob(groupName,jobName));
         return result;
    }
	/**
	 * 暂停正在执行的JOB
	 * @param groupName
	 * @param jobName
	 * @return
	 */
	@RequestMapping(value = "/pause", method = RequestMethod.GET)
	public ResultObject<Boolean> pauseJob(@RequestParam(name="groupName") String groupName
			, @RequestParam("jobName") String jobName){
		ResultObject<Boolean> result = new ResultObject<Boolean>();
		result.setDomain(schedulerService.pauseJob(groupName, jobName));
		return result;
	}
}