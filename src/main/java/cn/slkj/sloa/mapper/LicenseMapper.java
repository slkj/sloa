package cn.slkj.sloa.mapper;

import java.util.HashMap;
import java.util.List;

import cn.slkj.sloa.entity.vehicle.Insurance;
import cn.slkj.sloa.entity.vehicle.License;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

public interface LicenseMapper {

	public List<License> getList(HashMap<String, Object> hashMap, PageBounds pageBounds);
	
	public List<License> getListByCarNumber(HashMap<String, Object> hashMap, PageBounds pageBounds);

	public License queryOne(HashMap<String, Object> map);
	
	public int save(License license);

	public int edit(License license);

	public int delete(String id);

}