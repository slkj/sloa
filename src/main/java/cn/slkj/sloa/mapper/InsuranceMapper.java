package cn.slkj.sloa.mapper;

import java.util.HashMap;
import java.util.List;

import cn.slkj.sloa.entity.vehicle.Insurance;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

public interface InsuranceMapper {

	public List<Insurance> getList(HashMap<String, Object> hashMap, PageBounds pageBounds);
	
	public List<Insurance> getListByCarNumber(HashMap<String, Object> hashMap, PageBounds pageBounds);

	public Insurance queryOne(HashMap<String, Object> map);
	
	public int save(Insurance insurance);

	public int edit(Insurance insurance);

	public int delete(String id);

}