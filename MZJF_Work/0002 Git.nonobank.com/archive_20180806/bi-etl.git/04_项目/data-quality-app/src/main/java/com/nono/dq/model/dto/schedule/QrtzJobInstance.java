package com.nono.dq.model.dto.schedule;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="QRTZ_JOB_INSTANCE")
public class QrtzJobInstance {

    @Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "ID", nullable = false, unique = true)
    Long id;
    String groupName;
    String jobName;
    int sessionId;
    String state;
    String appId;
    long timestamp;

    
    public Long getId() {
		return id;
	}

	public void setId(Long id) {
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

    public int getSessionId() {
        return sessionId;
    }

    public void setSessionId(int sessionId) {
        this.sessionId = sessionId;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getAppId() {
        return appId;
    }

    public void setAppId(String appId) {
        this.appId = appId;
    }

    public long getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(long timestamp) {
        this.timestamp = timestamp;
    }

    public QrtzJobInstance() {
    }

    public QrtzJobInstance(String groupName, String jobName, int sessionId, String state, String appId, long timestamp) {
        this.groupName = groupName;
        this.jobName = jobName;
        this.sessionId = sessionId;
        this.state = state;
        this.appId = appId;
        this.timestamp = timestamp;
    }
}