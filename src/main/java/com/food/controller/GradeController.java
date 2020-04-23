package com.food.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.food.bean.Msg;
import com.food.service.GradeService;

@Controller
public class GradeController {
	
	@Autowired
	GradeService gradeService;
	
	@RequestMapping(value = "/grades")
	@ResponseBody
	public Msg getAllGradeWithJson() {
		
		List list = gradeService.getAll();
		
		return Msg.success().add("grades", list);
	}

}
