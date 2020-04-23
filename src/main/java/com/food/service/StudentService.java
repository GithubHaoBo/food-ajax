package com.food.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.food.bean.Student;
import com.food.bean.StudentExample;
import com.food.bean.StudentExample.Criteria;
import com.food.dao.StudentMapper;

@Service
public class StudentService {

//	service层需要调用dao层获取数据
	@Autowired
	StudentMapper studentMapper;

	/**
	 * 查询所有
	 * 
	 * @return
	 */
	public List<Student> getAll() {
//		查询所有时传入参数为null
		List<Student> list = studentMapper.selectByExampleWithGrade(null);
		return list;
	}

	/**
	 * 添加单个
	 * @param student
	 */
	public void addStu(Student student) {
		studentMapper.insertSelective(student);
	}

	/**
	 * 查询姓名是否存在
	 */
	public boolean checkStuName(String sname) {
		//创建规则对象
		StudentExample example = new StudentExample();
		//创建查询规则
		Criteria criteria = example.createCriteria();
		//拼装具体规则:姓名是否等于sname
		criteria.andSnameEqualTo(sname);
		//得到符合规则的数据有多少
		long count = studentMapper.countByExample(example);
		//返回查到的数据是否=0
		return count==0;
	}

	
	/**
	 * 	查询一个学生
	 * @param sid
	 * @return
	 */
	public Student getOneStu(Integer sid) {
		return studentMapper.selectByPrimaryKey(sid);
	}

	/**
	 * 修改学生信息
	 * @param student
	 */
	public int updStuById(Student student) {
		System.out.println(student);
		return studentMapper.updateByPrimaryKeySelective(student);
		
	}

	/**
	 * 删除单个
	 * @param sid
	 */
	public int delStuById(Integer sid) {
		return studentMapper.deleteByPrimaryKey(sid);
	}

	/**
	 * 批量删除
	 */
	public void delBatch(List<Integer> sids) {
		
		StudentExample example = new StudentExample();
		Criteria criteria = example.createCriteria();
		criteria.andSidIn(sids);
		
		studentMapper.deleteByExample(example);
	}

	/**
	 * 登录验证
	 * @param username
	 * @param password
	 */
	public int loginValid(String username, String password) {
		
		StudentExample example = new StudentExample();
		Criteria criteria = example.createCriteria();
		criteria.andSnameEqualTo(username);
		criteria.andAgeEqualTo(Integer.parseInt(password));
		
		List<Student> list = studentMapper.selectByExample(example);
		
		return list.size();
	}

}
