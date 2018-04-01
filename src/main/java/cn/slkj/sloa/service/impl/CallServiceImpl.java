package cn.slkj.sloa.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Repository;

import cn.slkj.sloa.entity.shfw.Call;
import cn.slkj.sloa.mapper.CallMapper;
import cn.slkj.sloa.service.CallService;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

/**
 * 客服来电
 * 
 * @author xiaotianliang
 *
 */
@Repository
public class CallServiceImpl implements CallService {
	@Autowired
	private CallMapper mapper;

	@Override
	public List<Call> getAll(Map<String, Object> map, PageBounds pageBounds) {
		return mapper.getAll(map, pageBounds);
	}

	@Override
	public int insert(Call call) {
		return mapper.insert(call);
	}
}
