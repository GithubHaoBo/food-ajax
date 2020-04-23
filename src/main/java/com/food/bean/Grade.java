package com.food.bean;

public class Grade {
	private Integer gid;

	private String gname;

	public Grade() {
		super();
	}

	public Grade(Integer gid, String gname) {
		super();
		this.gid = gid;
		this.gname = gname;
	}

	public Integer getGid() {
		return gid;
	}

	public void setGid(Integer gid) {
		this.gid = gid;
	}

	public String getGname() {
		return gname;
	}

	public void setGname(String gname) {
		this.gname = gname == null ? null : gname.trim();
	}

	@Override
	public String toString() {
		return "Grade [gid=" + gid + ", gname=" + gname + "]";
	}
	
}