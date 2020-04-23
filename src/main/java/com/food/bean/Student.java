package com.food.bean;

import javax.validation.constraints.Max;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Range;

public class Student {
	private Integer sid;

	@Pattern(regexp = "(^[a-zA-Z0-9_-]{3,8})|(^[\\u2E80-\\u9FFF]{2,4})$",message = "请输入3-8位数字和字母或2-4汉字j")
	private String sname;

	private String sex;

//	@Max
	@Range(max = 31,min = 10,message = "输入合适范围")
	private Integer age;

	private Integer gid;

	private Grade grade;

	public Student() {
		super();
	}

	public Student(Integer sid, String sname, String sex, Integer age, Integer gid) {
		super();
		this.sid = sid;
		this.sname = sname;
		this.sex = sex;
		this.age = age;
		this.gid = gid;
	}

	public Grade getGrade() {
		return grade;
	}

	public void setGrade(Grade grade) {
		this.grade = grade;
	}

	public Integer getSid() {
		return sid;
	}

	public void setSid(Integer sid) {
		this.sid = sid;
	}

	public String getSname() {
		return sname;
	}

	public void setSname(String sname) {
		this.sname = sname == null ? null : sname.trim();
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex == null ? null : sex.trim();
	}

	public Integer getAge() {
		return age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}

	public Integer getGid() {
		return gid;
	}

	public void setGid(Integer gid) {
		this.gid = gid;
	}

	@Override
	public String toString() {
		return "Student [sid=" + sid + ", sname=" + sname + ", sex=" + sex + ", age=" + age + ", gid=" + gid
				+ ", grade=" + grade + "]";
	}
	
}