package cn.slkj.sloa.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import cn.slkj.sloa.datasource.DataSourceContextHolder;
import cn.slkj.sloa.datasource.DataSourceType;
import cn.slkj.sloa.entity.system.Module;
import cn.slkj.sloa.mapper.ModuleMapper;
import cn.slkj.sloa.service.ModuleService;

@Repository
public class ModuleServiceImpl implements ModuleService {
	@Autowired
	private ModuleMapper mapper;

	@Override
	public List<Module> getAll(HashMap<String, Object> map) {
		return mapper.getAll(map);
	}

	@Override
	public Module queryOne(String id) {
		// TODO Auto-generated method stub
		//DataSourceContextHolder.setDbType(DataSourceType.SOURCE_SLOA);
		return mapper.queryOne(id);
	}

	@Override
	public int insert(Module module) {
		try {
			return mapper.insert(module);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public int update(Module module) {
		try {
			return mapper.update(module);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public int delete(String id) {
		try {
			return mapper.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public List<Module> getModuleByRoleId(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return mapper.getModuleByRoleId(map);
	}

	@Override
	public List<Module> getModuleByUserId(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return mapper.getModuleByUserId(map);
	}

	@Override
	public int saveUserRes(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return mapper.saveUserRes(map);
	}

	@Override
	public List<Module> getRolePer(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return mapper.getRolePer(map);
	}

}
