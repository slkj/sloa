package cn.slkj.sloa.service;

import java.util.HashMap;
import java.util.List;

import cn.slkj.sloa.entity.system.Department;

public interface DepartmentService {

	public List<Department> queryList(HashMap<String, Object> map);

	/**
	 * 添加
	 */
	public int save(Department department);

	/**
	 * 编辑
	 */
	public int edit(Department department);

	/**
	 * 根据id 批量记录
	 */
	public int delete(String id);

	/**
	 * 根据id查询
	 * 
	 * @param id
	 * @return
	 */
	public Department queryOne(String id);
}
