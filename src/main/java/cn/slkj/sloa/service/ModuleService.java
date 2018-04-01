package cn.slkj.sloa.service;

import java.util.HashMap;
import java.util.List;

import cn.slkj.sloa.entity.system.Module;

public interface ModuleService {

	public List<Module> getAll(HashMap<String, Object> map);

	public Module queryOne(String id);

	public int insert(Module module);

	public int update(Module module);

	public int delete(String id);

	public List<Module> getModuleByRoleId(HashMap<String, Object> map);

	public List<Module> getModuleByUserId(HashMap<String, Object> map);

	public int saveUserRes(HashMap<String, Object> map);

	public List<Module> getRolePer(HashMap<String, Object> map);
}
