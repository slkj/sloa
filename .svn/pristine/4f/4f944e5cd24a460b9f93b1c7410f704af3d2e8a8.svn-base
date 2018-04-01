package cn.slkj.sloa.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.slkj.sloa.entity.system.Department;
import cn.slkj.sloa.mapper.DepartmentMapper;
import cn.slkj.sloa.service.DepartmentService;
@Service
@Transactional
public class DepartmentServiceImpl implements DepartmentService {
	@Autowired
	private DepartmentMapper mapper;

	@Override
	public List<Department> queryList(HashMap<String, Object> map) {
		return mapper.queryList(map);
	}

	@Override
	public int save(Department department) {
		return mapper.save(department);
	}

	@Override
	public int edit(Department department) {
		return mapper.edit(department);
	}

	@Override
	public int delete(String id) {
		return mapper.delete(id);
	}

	@Override
	public Department queryOne(String id) {
		return mapper.queryOne(id);
	}

}
