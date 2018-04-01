package cn.slkj.sloa.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.slkj.sloa.entity.vehicle.Insurance;
import cn.slkj.sloa.entity.vehicle.License;
import cn.slkj.sloa.mapper.LicenseMapper;
import cn.slkj.sloa.service.LicenseService;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

@Service
@Transactional
public class LicenseServiceImpl implements LicenseService {
	@Resource
	private LicenseMapper licenseMapper;
	/**
	 * 查询
	 */
	public List<License> getList(HashMap<String, Object> hashMap, PageBounds pageBounds){
		return licenseMapper.getList(hashMap, pageBounds);
	}
	/**
	 * 查询根据车牌号
	 */
	public List<License> getListByCarNumber(HashMap<String, Object> hashMap, PageBounds pageBounds){
		return licenseMapper.getListByCarNumber(hashMap, pageBounds);
	}
	/**
	 * 查询单条
	 */
	public License queryOne(HashMap<String, Object> map){
		return licenseMapper.queryOne(map);
	}
	/**
	 * 添加
	 */
	@Override
	public int save(License license) {
		return licenseMapper.save(license);
	}
	/**
	 * 编辑
	 */
	public int edit(License license){
		return licenseMapper.edit(license);
	}
	/**
	 * 删除
	 */
	public int delete(String id){
		return licenseMapper.delete(id);
	}
	
}
