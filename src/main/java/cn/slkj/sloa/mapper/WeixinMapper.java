package cn.slkj.sloa.mapper;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

import cn.slkj.sloa.entity.shfw.Weixin;

public interface WeixinMapper {

	List<Weixin> getAll(Map<String, Object> map, PageBounds pageBounds);

	int update(Map<String, Object> map);

	int pay(Map<String, Object> map);

	int add(Map<String, Object> map);
}
