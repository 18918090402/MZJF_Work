package com.nono.dq.model.dto.schedule;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "QRTZ_JOB_LOG")
public class QrtzJobLog {

	@Id
	@Column(name = "ID", nullable = false, unique = true)
	String id;
	String groupName;
	String jobName;
	Date fireTime;
	Date scheduledTime;
	long runTime;
	String errorMsg;
	Long runStatus;
	
	
	public Long getRunStatus() {
		return runStatus;
	}
	public void setRunStatus(Long runStatus) {
		this.runStatus = runStatus;
	}
	public String getErrorMsg() {
		return errorMsg;
	}
	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public String getJobName() {
		return jobName;
	}
	public void setJobName(String jobName) {
		this.jobName = jobName;
	}
	public Date getFireTime() {
		return fireTime;
	}
	public void setFireTime(Date fireTime) {
		this.fireTime = fireTime;
	}
	public Date getScheduledTime() {
		return scheduledTime;
	}
	public void setScheduledTime(Date scheduledTime) {
		this.scheduledTime = scheduledTime;
	}
	public long getRunTime() {
		return runTime;
	}
	public void setRunTime(long runTime) {
		this.runTime = runTime;
	}

}