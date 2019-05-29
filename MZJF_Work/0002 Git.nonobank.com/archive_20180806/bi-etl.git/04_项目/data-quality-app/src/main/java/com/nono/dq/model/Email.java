package com.nono.dq.model;

import java.util.ArrayList;
import java.util.List;

import javax.activation.FileTypeMap;

public class Email {

	public Email() {
	}

	private String content;
	// 主题
	private String subject;
	private String from;
	private String text;
	private FileTypeMap fileTypeMap;
	//收件人
	private List<String> toList = new ArrayList<String>();
	//抄送
	private List<String> ccList = new ArrayList<String>();
	//密送
	private List<String> bccList = new ArrayList<String>();

	public void addTo(String to) {
		toList.add(to);
	}

	public void addCc(String cc) {
		ccList.add(cc);
	}

	public void addBcc(String bcc) {
		bccList.add(bcc);
	}

	public String[] getToArray() {
		return toList.toArray(new String[toList.size()]);
	}

	public String[] getCcArray() {
		return ccList.toArray(new String[toList.size()]);
	}

	public String[] getBccArray() {
		return bccList.toArray(new String[toList.size()]);
	}

	public String getContent() {
		return content;
	}

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public FileTypeMap getFileTypeMap() {
		return fileTypeMap;
	}

	public void setFileTypeMap(FileTypeMap fileTypeMap) {
		this.fileTypeMap = fileTypeMap;
	}

	public List<String> getToList() {
		return toList;
	}

	public void setToList(List<String> toList) {
		this.toList = toList;
	}

	public List<String> getCcList() {
		return ccList;
	}

	public void setCcList(List<String> ccList) {
		this.ccList = ccList;
	}

	public List<String> getBccList() {
		return bccList;
	}

	public void setBccList(List<String> bccList) {
		this.bccList = bccList;
	}

	@Override
	public String toString() {
		return "Email [ subject=" + subject + ", text=" + text + ", fileTypeMap=" + fileTypeMap + ", toList=" + toList
				+ ", ccList=" + ccList + ", bccList=" + bccList + "]";
	}

}
