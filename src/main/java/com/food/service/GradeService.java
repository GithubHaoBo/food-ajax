package com.food.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.food.dao.GradeMapper;

@Service
public class GradeService {
	
	@Autowired
	GradeMapper gradeMapper;
	
	public List getAll() {
		return gradeMapper.selectByExample(null);
	}

}
