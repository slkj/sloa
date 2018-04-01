package cn.slkj.sloa.mapper;

/**
 * 派工登记  DAO层
 * 
 * @author xiaotianliang
 *
 */
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

import cn.slkj.sloa.entity.shfw.Dispatch;

@Repository
public interface DispatchMapper {

	/**
	 * 查询派工登记列表
	 * 
	 * @param map
	 * @return
	 */
	public List<Dispatch> getAll(HashMap<String, Object> map,
			PageBounds pageBounds);

	/**
	 * 添加
	 * 
	 * @param dispatch
	 * @return
	 */
	public int insert(Dispatch dispatch);

	/**
	 * 删除
	 * 
	 * @param dispatch
	 * @return
	 */
	public int delete(String id);

	/**
	 * 
	 * 
	 * @param
	 * @return
	 */
	public Dispatch queryOne(Map<String, Object> map);

}
