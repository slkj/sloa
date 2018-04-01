package cn.slkj.sloa.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

import cn.slkj.sloa.entity.shfw.Repair;

/**
 * 
 * @ClassName: RepairService
 * @Description:
 * @author xiaotianliang
 *
 */
public interface RepairService {

	public List<Repair> getAll(Map<String, Object> pageMap, PageBounds pageBounds);

	public Repair queryOne(Repair repair);

	/**
	 * 添加
	 */
	public int save(Repair repair);

	/**
	 * 编辑
	 */
	public int edit(Repair repair);

	/**
	 * 删除
	 */
	public int delete(String id);

	/**
	 * 
	 */
	public int isLook(Map<String, Object> map);
	/**
	 * 
	 */
	public int isOutcome(HashMap<String, Object> map);
	/**
	 * 
	 */
	public int saveByRNum(Repair repair);
}
