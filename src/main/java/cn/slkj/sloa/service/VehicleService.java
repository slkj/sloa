package cn.slkj.sloa.service;

import java.util.HashMap;
import java.util.List;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

import cn.slkj.hbsl.util.PageData;
import cn.slkj.sloa.entity.system.User;
import cn.slkj.sloa.entity.vehicle.Vehicle;

public interface VehicleService {
	public List<Vehicle> getList(HashMap<String, Object> hashMap, PageBounds pageBounds);
	
	public Vehicle queryOne(HashMap<String, Object> map);
	
	public int save(Vehicle vehicle);

	public int edit(Vehicle vehicle);
	
	public int editSeasonExam(Vehicle vehicle);
	
	public int editYearExam(Vehicle vehicle);

	public int delete(String id);

	public int sfbz(Vehicle vehicle);
}
