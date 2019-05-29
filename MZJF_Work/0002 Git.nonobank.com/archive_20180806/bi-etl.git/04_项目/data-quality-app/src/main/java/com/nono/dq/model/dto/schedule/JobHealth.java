package com.nono.dq.model.dto.schedule;

public class JobHealth {
	private int runing;
	private int invalid;
	private int jobCount;

	public int getRuning() {
		return runing;
	}

	public void setRuning(int runing) {
		this.runing = runing;
	}

	public int getInvalid() {
		return invalid;
	}

	public void setInvalid(int invalid) {
		this.invalid = invalid;
	}

	public int getJobCount() {
		return jobCount;
	}

	public void setJobCount(int jobCount) {
		this.jobCount = jobCount;
	}

	public JobHealth(int runing, int invalid, int jobCount) {
		this.runing = runing;
		this.invalid = invalid;
		this.jobCount = jobCount;
	}
}