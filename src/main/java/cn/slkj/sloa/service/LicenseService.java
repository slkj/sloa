package cn.slkj.sloa.service;

import java.util.HashMap;
import java.util.List;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

import cn.slkj.hbsl.util.PageData;
import cn.slkj.sloa.entity.system.User;
import cn.slkj.sloa.entity.vehicle.Insurance;
import cn.slkj.sloa.entity.vehicle.License;
import cn.slkj.sloa.entity.vehicle.Vehicle;

public interface LicenseService {
	public List<License> getList(HashMap<String, Object> hashMap, PageBounds pageBounds);
	
	public List<License> getListByCarNumber(HashMap<String, Object> hashMap, PageBounds pageBounds);

	public License queryOne(HashMap<String, Object> map);
	
	public int save(License license);

	public int edit(License license);

	public int delete(String id);
}
