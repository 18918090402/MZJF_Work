package com.nono.dq.model.request;

public class SchedulerRequestBody {
	String jobType;
	String dataId;
	String dataStartTimestamp;
	String jobStartTime;
	String periodTime;

	public String getJobType() {
		return jobType;
	}

	public void setJobType(String jobType) {
		this.jobType = jobType;
	}

	public String getDataId() {
		return dataId;
	}

	public void setDataId(String dataId) {
		this.dataId = dataId;
	}

	public String getDataStartTimestamp() {
		return dataStartTimestamp;
	}

	public void setDataStartTimestamp(String dataStartTimestamp) {
		this.dataStartTimestamp = dataStartTimestamp;
	}

	public String getJobStartTime() {
		return jobStartTime;
	}

	public void setJobStartTime(String jobStartTime) {
		this.jobStartTime = jobStartTime;
	}

	public String getPeriodTime() {
		return periodTime;
	}

	public void setPeriodTime(String periodTime) {
		this.periodTime = periodTime;
	}

	public SchedulerRequestBody(String jobType, String dataId, String dataStartTimestamp, String jobStartTime,
			String periodTime) {
		this.jobType = jobType;
		this.dataId = dataId;
		this.dataStartTimestamp = dataStartTimestamp;
		this.jobStartTime = jobStartTime;
		this.periodTime = periodTime;
	}

	public SchedulerRequestBody() {
	}

	@Override
	public boolean equals(Object o) {
		if (this == o)
			return true;
		if (o == null || getClass() != o.getClass())
			return false;

		SchedulerRequestBody that = (SchedulerRequestBody) o;

		if (jobType != null ? !jobType.equals(that.jobType) : that.jobType != null)
			return false;
		if (dataId != null ? !dataId.equals(that.dataId) : that.dataId != null)
			return false;
		if (dataStartTimestamp != null ? !dataStartTimestamp.equals(that.dataStartTimestamp)
				: that.dataStartTimestamp != null)
			return false;
		if (jobStartTime != null ? !jobStartTime.equals(that.jobStartTime) : that.jobStartTime != null)
			return false;
		return periodTime != null ? periodTime.equals(that.periodTime) : that.periodTime == null;
	}

	@Override
	public int hashCode() {
		int result = jobType != null ? jobType.hashCode() : 0;
		result = 31 * result + (dataId != null ? dataId.hashCode() : 0);
		result = 31 * result + (dataStartTimestamp != null ? dataStartTimestamp.hashCode() : 0);
		result = 31 * result + (jobStartTime != null ? jobStartTime.hashCode() : 0);
		result = 31 * result + (periodTime != null ? periodTime.hashCode() : 0);
		return result;
	}

	@Override
	public String toString() {
		return "SchedulerRequestBody [jobType=" + jobType + ", dataId=" + dataId + ", dataStartTimestamp="
				+ dataStartTimestamp + ", jobStartTime=" + jobStartTime + ", periodTime=" + periodTime + "]";
	}

}