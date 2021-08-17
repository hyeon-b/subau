package com.subau.model;

import java.sql.Timestamp;

public class MailBoxVO {

	private String sender;
	private String recver;
	private Timestamp sndtime;
	private String user_nname;
	private String content;
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUser_nname() {
		return user_nname;
	}
	public void setUser_nname(String user_nname) {
		this.user_nname = user_nname;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getRecver() {
		return recver;
	}
	public void setRecver(String recver) {
		this.recver = recver;
	}
	public Timestamp getSndtime() {
		return sndtime;
	}
	public void setSndtime(Timestamp sndtime) {
		this.sndtime = sndtime;
	}
	
	@Override
	public String toString() {
		return "MailBoxVO [sender=" + sender + ", recver=" + recver + ", sndtime=" + sndtime + ", user_nname="
				+ user_nname + ", content=" + content + "]";
	}
	

	
   
}
