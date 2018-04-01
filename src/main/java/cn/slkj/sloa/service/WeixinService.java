package cn.slkj.sloa.service;
 
import java.util.List;
import java.util.Map;

import cn.slkj.sloa.entity.shfw.Weixin;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

public interface WeixinService {

	public List<Weixin> getAll(Map<String, Object> map, PageBounds pageBounds);

	public int updateSfbz(Map<String, Object> map); 

	public int pay(Map<String, Object> map);

	public int add(Map<String, Object> map);

	public int editSate(Map<String, Object> map);
}
