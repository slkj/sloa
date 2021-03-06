package cn.slkj.sloa.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

import cn.slkj.sloa.entity.shfw.Dispatch;

public interface DispatchService {

	public List<Dispatch> getAll(HashMap<String, Object> map,
			PageBounds pageBounds);

	/**
	 * 添加
	 */
	public int insert(Dispatch dispatch);

	/**
	 * 删除
	 */
	public int delete(String id);

	/**
	 * 
	 * 
	 */
	public Dispatch queryOne(Map<String, Object> map);
	/**
	 * 导出Excel表
	 * 
	 */
	public void exportExcel(HashMap<String, Object> map, String[] titles, ServletOutputStream outputStream);

}
