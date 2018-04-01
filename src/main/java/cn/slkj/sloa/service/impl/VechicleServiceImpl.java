package cn.slkj.sloa.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

import cn.slkj.sloa.entity.vehicle.Vehicle;
import cn.slkj.sloa.mapper.VehicleMapper;
import cn.slkj.sloa.service.VehicleService;

@Service
@Transactional
public class VechicleServiceImpl implements VehicleService {
	@Resource
	private VehicleMapper vehicleMapper;

	/**
	 * 查询
	 */
	public List<Vehicle> getList(HashMap<String, Object> hashMap, PageBounds pageBounds) {
		return vehicleMapper.getList(hashMap, pageBounds);
	}

	/**
	 * 查询单条
	 */
	public Vehicle queryOne(HashMap<String, Object> map) {
		return vehicleMapper.queryOne(map);
	}

	/**
	 * 添加
	 */
	@Override
	public int save(Vehicle vehicle) {
		return vehicleMapper.save(vehicle);
	}

	/**
	 * 编辑
	 */
	public int edit(Vehicle vehicle) {
		return vehicleMapper.edit(vehicle);
	}

	/**
	 * 编辑季审
	 */
	public int editSeasonExam(Vehicle vehicle) {
		return vehicleMapper.editSeasonExam(vehicle);
	}

	/**
	 * 编辑年审
	 */
	public int editYearExam(Vehicle vehicle) {
		return vehicleMapper.editYearExam(vehicle);
	}

	/**
	 * 删除
	 */
	public int delete(String id) {
		return vehicleMapper.delete(id);
	}

	@Override
	public int sfbz(Vehicle vehicle) {
		return vehicleMapper.sfbz(vehicle);
	}

}
