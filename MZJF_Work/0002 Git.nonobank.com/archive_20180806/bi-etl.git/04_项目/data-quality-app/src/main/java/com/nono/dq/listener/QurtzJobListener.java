package com.nono.dq.listener;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.JobListener;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.nono.dq.dao.local.metadata.QrtzJobLogRepo;
import com.nono.dq.model.dto.schedule.QrtzJobLog;

public class QurtzJobListener implements JobListener {

	private static final Logger LOGGER = LoggerFactory.getLogger(QurtzJobListener.class);

	private QrtzJobLogRepo qrtzJobLogRepo;

	private String name;

	public QurtzJobListener(String name, QrtzJobLogRepo qrtzJobLogRepo) {
		this.name = name;
		this.qrtzJobLogRepo = qrtzJobLogRepo;
	}

	@Override
	public String getName() {
		// TODO Auto-generated method stub
		return this.name;
	}

	/**
	 * 任务执行之前执行
	 */
	@Override
	public void jobToBeExecuted(JobExecutionContext context) {
		// TODO Auto-generated method stub
		QrtzJobLog jobLog = new QrtzJobLog();
		jobLog.setId(context.getFireInstanceId());
		jobLog.setGroupName(context.getJobDetail().getKey().getGroup());
		jobLog.setJobName(context.getJobDetail().getKey().getName());
		jobLog.setFireTime(context.getFireTime());
		jobLog.setScheduledTime(context.getScheduledFireTime());
		jobLog.setRunTime(context.getJobRunTime());
		jobLog.setRunStatus(1L);
		qrtzJobLogRepo.save(jobLog);
	}

	@Override
	public void jobExecutionVetoed(JobExecutionContext context) {
		// TODO Auto-generated method stub
	}

	/**
	 * 任务执行完成后执行 jobException如果它不为空则说明任务在执行过程中出现了异常
	 */
	@Override
	public void jobWasExecuted(JobExecutionContext context, JobExecutionException jobException) {
		// TODO Auto-generated method stub
		QrtzJobLog jobLog = new QrtzJobLog();
		jobLog.setId(context.getFireInstanceId());
		jobLog.setGroupName(context.getJobDetail().getKey().getGroup());
		jobLog.setJobName(context.getJobDetail().getKey().getName());
		jobLog.setFireTime(context.getFireTime());
		jobLog.setScheduledTime(context.getScheduledFireTime());
		jobLog.setRunTime(context.getJobRunTime() / 1000);
		if (jobException != null) {
			jobLog.setRunStatus(3L);
			jobLog.setErrorMsg(
					jobException.getMessage() != null ? jobException.getMessage() : jobException.getLocalizedMessage());
		}else{
			jobLog.setRunStatus(2L);
		}
		qrtzJobLogRepo.save(jobLog);
	}
}