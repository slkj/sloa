package cn.slkj.sloa.mapper;

import java.util.HashMap;
import java.util.List;

import cn.slkj.sloa.entity.vehicle.Transfer;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

public interface TransferMapper {

	public List<Transfer> getList(HashMap<String, Object> hashMap, PageBounds pageBounds);

	public Transfer queryOne(HashMap<String, Object> map);
	
	public int save(Transfer transfer);

	public int edit(Transfer transfer);

	public int delete(String id);

}