package cn.slkj.sloa.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

import cn.slkj.sloa.entity.shfw.Repair;
import cn.slkj.sloa.mapper.RepairMapper;
import cn.slkj.sloa.service.RepairService;

/**
 * 
 * @ClassName: RepairService
 * @Description:
 * @author xiaotianliang
 *
 */
@Repository
public class RepairServiceImpl implements RepairService {
	@Autowired
	private RepairMapper mapper;

	@Override
	public List<Repair> getAll(Map<String, Object> pageMap, PageBounds pageBounds) {
		return mapper.getAll(pageMap, pageBounds);
	}

	@Override
	public Repair queryOne(Repair repair) {

		if (repair == null) {
			return null;
		}
		try {
			return mapper.queryOne(repair);
		} catch (Exception e) {
			return null;
		}
	}

	@Override
	public int save(Repair repair) {
		return mapper.save(repair);
	}

	@Override
	public int edit(Repair repair) {
		return mapper.edit(repair);
	}

	@Override
	public int delete(String id) {
		try {

			return mapper.delete(id);
		} catch (Exception e) {
			return -1;
		}
	}

	@Override
	public int isLook(Map<String, Object> map) {
		return mapper.isLook(map);
	}
	@Override
	public int isOutcome(HashMap<String, Object> map) {
		return mapper.isOutcome(map);
	}
	@Override
	public int saveByRNum(Repair repair) {
		return mapper.saveByRNum(repair);
	}
}
