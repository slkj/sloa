package cn.slkj.sloa.service;

import java.util.HashMap;
import java.util.List;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

import cn.slkj.sloa.entity.shfw.Fees;
import cn.slkj.sloa.entity.shfw.PayFees;
import cn.slkj.sloa.entity.vehicle.Vehicle;

public interface FeesService {

	public List<Fees> getAll(HashMap<String, Object> pageMap, PageBounds pageBounds);

	public List<Fees> listByCarNumber(HashMap<String, Object> pageMap, PageBounds pageBounds);

	public Fees queryOne(String id);

	public int insert(Fees fees);

	public int update(Fees fees);

	public int delete(String id);

	public int fees(HashMap<String, Object> map);

	public int pay(HashMap<String, Object> map);

	public int billing(HashMap<String, Object> map);

	public int updateVehicle(HashMap<String, Object> map);

	public Vehicle getFeesByCarNum(HashMap<String, Object> hashMap);

	public Fees getCarFeesByWx(HashMap<String, Object> map);

	/* 收费记录 */
	public List<PayFees> listPayFees(HashMap<String, Object> pageMap, PageBounds pageBounds);
	
	public int payFees(HashMap<String, Object> map);
}
