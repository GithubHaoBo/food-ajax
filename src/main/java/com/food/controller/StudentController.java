package com.food.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.food.bean.Msg;
import com.food.bean.Student;
import com.food.service.StudentService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 处理员工增删改查
 * 
 * 指定REST风格的URL
 	/studs		:GET	查多个
 	/studs/{sid}:GET	查单个
 	/studs		:POST	增
 	/studs/{sid}:PUT	改
 	/studs/{sid}:DELETE	删
 * @author 12547
 *
 */

@Controller
public class StudentController {
	
	@Autowired
	StudentService studentService;
	
	/**
	 * 登录验证
	 * @param username
	 * @param password
	 * @return
	 */
	@RequestMapping(value = "/loginValid",method = RequestMethod.POST )
	@ResponseBody
	public Msg loginValid(@RequestParam("username")String username,@RequestParam("password")String password) {
		System.out.println("111");
		System.out.println(username+password);
		int i = studentService.loginValid(username,password);
		if (i>=1) {
			return Msg.success();
		}else {
			return Msg.fail();
		}
		
		
	}
	
	/**
	 * 删除单个或多个
	 * @param sid
	 * @return
	 */
	@RequestMapping(value = "/studs/{sid}",method = RequestMethod.DELETE)
	@ResponseBody
	public Msg delStuById(@PathVariable("sid")String sid) {
		System.out.println(sid);
		if (sid.contains("-")) {
			List<Integer> sids = new ArrayList<Integer>();
			String[] strs = sid.split("-");
			for(String id:strs) {
				sids.add(Integer.parseInt(id));
			}
			studentService.delBatch(sids);
		} else {
			studentService.delStuById(Integer.parseInt(sid));
		}
		return Msg.success();
	}
	
	/**
	 * 修改信息
	 * @param student
	 * @return
	 */
	@RequestMapping(value = "/studs/{sid}",method = RequestMethod.PUT)
	@ResponseBody
	public Msg updStuById(Student student) {
		
		studentService.updStuById(student);
		System.out.println(studentService.getOneStu(student.getSid()));
		return Msg.success();
	}
	
	
	/**
	 *	查询单个学生信息
	 * @return
	 */
	@RequestMapping(value = "/studs/{sid}",method = RequestMethod.GET)
	@ResponseBody
	public Msg getOneStu(@PathVariable("sid")Integer sid) {
		
		Student student = studentService.getOneStu(sid);
		
		return Msg.success().add("student", student);
	}
	
	/**
	 * 查询学生姓名是否在存在
	 * @param sname
	 * @return
	 */
	@RequestMapping(value = "/checkStu")
	@ResponseBody
	public Msg checkStuName(@RequestParam(value = "sname")String sname) {
		
		boolean b = studentService.checkStuName(sname);
		if (b) {
			return Msg.success();
		} else {
			return Msg.fail();
		}
	}
	
	/**
	 * 添加学生
	 * @param student
	 * @return
	 */
	@RequestMapping(value = "/studs",method = RequestMethod.POST)
	@ResponseBody
	public Msg addStu(Student student) {
		
		studentService.addStu(student);
		
		return Msg.success();
	}

	
	@RequestMapping(value = "/studs")
	// @ResponseBody 借助Jackson包
	@ResponseBody()
	private Msg getAllStudentWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {

//		引入pagehelper的分页插件
//		查询之前调用分页startPage，得到所要查询第几页（参数一：页码，参数二：每页几条数据）
		PageHelper.startPage(pn, 5);
//		startPage后面紧跟的查询就是分页查询，查出当前页的list
		List<Student> all = studentService.getAll();
//		使用pageInfo包装查询后的结果，pageInfo里面的数据更详细(参数一：分页的列表，参数二：连续显示的页码数)
		PageInfo<Student> info = new PageInfo<Student>(all, 5);
		
//		把对象返回，会自动转化为json
		return Msg.success().add("pageInfo", info);
	}

	/**
	 * 查询所有学生（分页查询） 调用service层获取数据
	 * 
	 * @RequestParam 传入查询第几页,不传默认为1 Model model 将得到的结果传给页面
	 * @return
	 */
//	@RequestMapping(value = "/studs")
	public String getAllStudent(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {

//		引入pagehelper的分页插件
//		查询之前调用分页startPage，得到所要查询第几页（参数一：页码，参数二：每页几条数据）
		PageHelper.startPage(pn, 5);
//		startPage后面紧跟的查询就是分页查询，查出当前页的list
		List<Student> all = studentService.getAll();
//		使用pageInfo包装查询后的结果，pageInfo里面的数据更详细(参数一：分页的列表，参数二：连续显示的页码数)
		PageInfo<Student> info = new PageInfo<Student>(all, 5);

		// 将数据传给页面
		model.addAttribute("pageInfo", info);

		return "list";
	}

}
