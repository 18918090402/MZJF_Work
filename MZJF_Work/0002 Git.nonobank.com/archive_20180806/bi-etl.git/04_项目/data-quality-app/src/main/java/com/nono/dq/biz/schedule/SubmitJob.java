package com.nono.dq.biz.schedule;

import java.util.Map.Entry;

import org.quartz.DisallowConcurrentExecution;
import org.quartz.Job;
import org.quartz.JobDetail;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.PersistJobDataAfterExecution;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.google.common.base.Strings;
import com.nono.dq.biz.MetaDataService;
import com.nono.dq.dao.local.metadata.QrtzJobInstanceRepo;
import com.nono.dq.model.QualityQuery;
import com.nono.dq.model.dto.schedule.QrtzJobInstance;

@PersistJobDataAfterExecution
@DisallowConcurrentExecution
public class SubmitJob implements Job {

	private static final Logger LOGGER = LoggerFactory.getLogger(SubmitJob.class);

	@Autowired
	MetaDataService metaDataService;

	@Autowired
	QrtzJobInstanceRepo qrtzJobInstanceRepo;

	public SubmitJob() {
		LOGGER.info("****SubmitJob INIT*******");
	}

	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		JobDetail jd = context.getJobDetail();
		String groupName = jd.getJobDataMap().getString("groupName");
		String jobName = jd.getJobDataMap().getString("jobName");
		String dataId = jd.getJobDataMap().getString("dataId");

		for (Entry entry : jd.getJobDataMap().entrySet()) {
			LOGGER.info("entry :[ {} - {} ]", entry.getKey(), entry.getValue());
		}
		LOGGER.info("jobData:{}", jd.getJobDataMap().keySet());
		QualityQuery data = new QualityQuery();
		if (!Strings.isNullOrEmpty(dataId)) {
			data.setItems(Integer.valueOf(dataId));
		}
		try {
			if (groupName.equals("dq_calculate")) {
				metaDataService.calculateColumn(data);
			}else if(groupName.equals("dq_compare")){
				metaDataService.compareColumn(data);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			LOGGER.error("EXECUTE ERROR:{}", e.getLocalizedMessage());
			// 手动抛出异常，否则监听器检查不到异常信息
			throw new JobExecutionException(e);
		}
	}

	public void saveJobInstance(String groupName, String jobName, String state) {
		// save JobInstance info into DataBase
		QrtzJobInstance jobInstance = new QrtzJobInstance();
		jobInstance.setGroupName(groupName);
		jobInstance.setJobName(jobName);
		try {
			jobInstance.setState(state);
		} catch (Exception e) {
			LOGGER.warn("jobInstance has null field. \n" + e);
		}
		jobInstance.setTimestamp(System.currentTimeMillis());
		qrtzJobInstanceRepo.save(jobInstance);
	}

}