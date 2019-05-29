package com.nono.dq.model.response;

import java.util.Date;
import java.util.Map;

/**
 * 
 */
public class ResponseResult {

    protected Integer status;
    protected String message;
    protected Map<String, Object> extendedProperties;
    protected Object ext;
    protected String callback;
    protected String messageToUser;
    protected Date returnTime=new Date();
    public ResponseResult() {
        this(0, "请求成功");
    }

    public Date getReturnTime() {
		return returnTime;
	}

	public void setReturnTime(Date returnTime) {
		this.returnTime = returnTime;
	}

	public ResponseResult(Integer status, String message) {
        this.status = status;
        this.message = message;
    }
    
    public Map<String, Object> getExtendedProperties() {
        return extendedProperties;
    }

    public void setExtendedProperties(Map extendedProperties) {
        this.extendedProperties = extendedProperties;
    }

    public String getCallback() {
        return callback;
    }

    public void setCallback(String callback) {
        this.callback = callback;
    }

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	/**
	 * @return the messageToUser
	 */
	public String getMessageToUser() {
		return messageToUser;
	}

	/**
	 * @param messageToUser the messageToUser to set
	 */
	public void setMessageToUser(String messageToUser) {
		this.messageToUser = messageToUser;
	}

	public Object getExt() {
		return ext;
	}

	public void setExt(Object ext) {
		this.ext = ext;
	}
}




