package cn.slkj.sloa.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.slkj.sloa.entity.vehicle.Insurance;
import cn.slkj.sloa.mapper.InsuranceMapper;
import cn.slkj.sloa.service.InsuranceService;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

@Service
@Transactional
public class InsuranceServiceImpl implements InsuranceService {
	@Resource
	private InsuranceMapper insuranceMapper;
	/**
	 * 查询
	 */
	public List<Insurance> getList(HashMap<String, Object> hashMap, PageBounds pageBounds){
		return insuranceMapper.getList(hashMap, pageBounds);
	}
	/**
	 * 查询根据车牌号
	 */
	public List<Insurance> getListByCarNumber(HashMap<String, Object> hashMap, PageBounds pageBounds){
		return insuranceMapper.getListByCarNumber(hashMap, pageBounds);
	}
	/**
	 * 查询单条
	 */
	public Insurance queryOne(HashMap<String, Object> map){
		return insuranceMapper.queryOne(map);
	}
	/**
	 * 添加
	 */
	@Override
	public int save(Insurance insurance) {
		return insuranceMapper.save(insurance);
	}
	/**
	 * 编辑
	 */
	public int edit(Insurance insurance){
		return insuranceMapper.edit(insurance);
	}
	/**
	 * 删除
	 */
	public int delete(String id){
		return insuranceMapper.delete(id);
	}
	
}
