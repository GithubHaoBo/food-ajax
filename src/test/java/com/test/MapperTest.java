package com.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.food.bean.Grade;
import com.food.bean.Student;
import com.food.dao.GradeMapper;
import com.food.dao.StudentMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class MapperTest {

	@Autowired
	StudentMapper studentMapper;
	@Autowired
	GradeMapper gradeMapper;
	@Autowired
	SqlSession sqlsession;

	@Test
	public void testCRUD() {

		System.out.println(studentMapper);
		System.out.println(gradeMapper);
		
		
//		有选择性的插入字段
//		gradeMapper.insertSelective(new Grade(null, "大一"));
//		gradeMapper.insertSelective(new Grade(null, "大二"));
//		gradeMapper.insertSelective(new Grade(null, "大三"));
		
//		插入员工
//		studentMapper.insertSelective(new Student(null, "123", "男", 22, 1));
		
		//用sqlsession可批量执行类里面的方法
		StudentMapper mapper = sqlsession.getMapper(StudentMapper.class);
		for (int i = 0; i < 10; i++) {
//			生成UUID,截取前5位
			String uid = UUID.randomUUID().toString().substring(0,5);
			mapper.insertSelective(new Student(null, uid, "男", 20, 1));
		}

	}

}
