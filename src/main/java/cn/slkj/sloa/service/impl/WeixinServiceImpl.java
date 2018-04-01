package cn.slkj.sloa.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

import cn.slkj.sloa.entity.shfw.Weixin;
import cn.slkj.sloa.mapper.WeixinMapper;
import cn.slkj.sloa.service.WeixinService;

@Repository
public class WeixinServiceImpl implements WeixinService {

	@Autowired
	private WeixinMapper mapper;

	@Override
	public List<Weixin> getAll(Map<String, Object> map, PageBounds pageBounds) {
		return mapper.getAll(map, pageBounds);
	}

	@Override
	public int updateSfbz(Map<String, Object> map) {
		return mapper.update(map);
	}
	@Override
	public int pay(Map<String, Object> map) {
		return mapper.pay(map);
	}

	@Override
	public int add(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return mapper.add(map);
	}

	@Override
	public int editSate(Map<String, Object> map) {
		return mapper.update(map);
	}
}
