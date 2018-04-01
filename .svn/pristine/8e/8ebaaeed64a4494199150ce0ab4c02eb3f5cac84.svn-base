package cn.slkj.sloa.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

import cn.slkj.sloa.entity.shfw.Fees;
import cn.slkj.sloa.entity.vehicle.Vehicle;
import cn.slkj.sloa.mapper.FeesMapper;
import cn.slkj.sloa.service.FeesService;

@Repository
public class FeesServiceImpl implements FeesService {
	@Autowired
	private FeesMapper mapper;

	@Override
	public List<Fees> getAll(HashMap<String, Object> pageMap, PageBounds pageBounds) {
		return mapper.getAll(pageMap, pageBounds);
	}
	@Override
	public List<Fees> listByCarNumber(HashMap<String, Object> pageMap, PageBounds pageBounds) {
		return mapper.listByCarNumber(pageMap, pageBounds);
	}
	@Override
	public Fees queryOne(String id) {
		return mapper.queryOne(id);
	}

	@Override
	public int insert(Fees fees) {
		return mapper.insert(fees);
	}

	@Override
	public int update(Fees fees) {
		return mapper.update(fees);
	}

	@Override
	public int delete(String id) {
		return mapper.delete(id);
	}

	@Override
	public int fees(HashMap<String, Object> map) {
		return mapper.fees(map);
	}

	@Override
	public int pay(HashMap<String, Object> map) {
		return mapper.pay(map);
	}

	@Override
	public int billing(HashMap<String, Object> map) {
		return mapper.billing(map);
	}

	@Override
	public int updateVehicle(HashMap<String, Object> map) {
		return mapper.updateVehicle(map);
	}
	@Override
	public Vehicle getFeesByCarNum(HashMap<String, Object> hashMap) {
		return mapper.getFeesByCarNum(hashMap);
	}
	@Override
	public Fees getCarFeesByWx(HashMap<String, Object> map) {
		return mapper.getCarFeesByWx(map);
	}

}
