package com.test;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.util.Iterator;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.food.bean.Student;
import com.github.pagehelper.PageInfo;

/**
 * 使用Spring单元测试提供的测试请求功能测试crud
 * @author 12547
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
//引入spring和springmvc的配置文件,若配置文件不再累路径下则用“file:src/.../*.xml”
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:springmvc.xml"})
@WebAppConfiguration
public class MVCTest {
	
//	传入springmvc的ioc，注意此处不是spring的ioc
	@Autowired   //注入ioc自己需要 @WebAppConfiguration 注解
	WebApplicationContext context;
	
//	虚拟mvc请求，获取处理结果,前提是需要初始化
	MockMvc mockMvc;
	
	@Before //使用before，在每次测试之前初始化一下
	public void initMockMvc() {
//		创建MockMvc
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	@Test
	public void testPage() throws Exception {
		//模拟请求拿到返回值
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/studs").param("pn", "4")).andReturn();
		
		//请求成功后，请求域里会有pageInfo，我么可以用pageInfo进行测试
		MockHttpServletRequest request = result.getRequest();
		PageInfo<Student> pageInfo = (PageInfo<Student>) request.getAttribute("pageInfo");
		
		System.out.println("当前页："+pageInfo.getPageNum());
		System.out.println("总页："+pageInfo.getPages());
		System.out.println("总记录："+pageInfo.getTotal());
		System.out.println("在页面需要连续显示的页码：");
		int[] nums = pageInfo.getNavigatepageNums();
		for(int i:nums) {
			System.out.println(i);
		}
		List<Student> list = pageInfo.getList();
		System.out.println(list);
		for(Student s:list) {
			System.out.println(s.getGrade());
		}
		
	}

}
