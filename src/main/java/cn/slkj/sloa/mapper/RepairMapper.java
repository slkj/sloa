package cn.slkj.sloa.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

import cn.slkj.sloa.entity.shfw.Repair;

/**
 * 
 * @ClassName: RepairMapper
 * @Description:
 * @author xiaotianliang
 *
 */
@Repository
public interface RepairMapper {

	List<Repair> getAll(Map<String, Object> pageMap, PageBounds pageBounds);

	public Repair queryOne(Repair repair);

	/**
	 * 添加
	 * 
	 * @param repair
	 * @return
	 */
	public int save(Repair repair);

	/**
	 * 编辑
	 * 
	 * @param repair
	 * @return
	 */
	public int edit(Repair repair);

	/**
	 * 删除
	 * 
	 * @param repair
	 * @return
	 */
	public int delete(String id);

	// 审核方法
	public int isLook(Map<String, Object> pageMap);
	public int isOutcome(HashMap<String, Object> map);
	public int saveByRNum(Repair repair);

}
