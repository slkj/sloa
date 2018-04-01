package cn.slkj.sloa.service;

import java.util.HashMap;
import java.util.List;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

import cn.slkj.hbsl.util.PageData;
import cn.slkj.sloa.entity.system.User;
import cn.slkj.sloa.entity.vehicle.Insurance;
import cn.slkj.sloa.entity.vehicle.Transfer;
import cn.slkj.sloa.entity.vehicle.Vehicle;

public interface TransferService {
	public List<Transfer> getList(HashMap<String, Object> hashMap, PageBounds pageBounds);

	public Transfer queryOne(HashMap<String, Object> map);
	
	public int save(Transfer transfer);

	public int edit(Transfer transfer);

	public int delete(String id);
}
