package cn.slkj.sloa.service;

import java.util.HashMap;
import java.util.List;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

import cn.slkj.hbsl.util.PageData;
import cn.slkj.sloa.entity.system.User;
import cn.slkj.sloa.entity.vehicle.Insurance;
import cn.slkj.sloa.entity.vehicle.Vehicle;

public interface InsuranceService {
	public List<Insurance> getList(HashMap<String, Object> hashMap, PageBounds pageBounds);
	
	public List<Insurance> getListByCarNumber(HashMap<String, Object> hashMap, PageBounds pageBounds);

	public Insurance queryOne(HashMap<String, Object> map);
	
	public int save(Insurance insurance);

	public int edit(Insurance insurance);

	public int delete(String id);
}
