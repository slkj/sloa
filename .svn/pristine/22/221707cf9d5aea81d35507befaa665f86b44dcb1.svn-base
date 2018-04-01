package cn.slkj.sloa.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.slkj.sloa.entity.vehicle.Transfer;
import cn.slkj.sloa.mapper.TransferMapper;
import cn.slkj.sloa.service.TransferService;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

@Service
@Transactional
public class TransferServiceImpl implements TransferService {
	@Resource
	private TransferMapper transferMapper;
	/**
	 * 查询
	 */
	public List<Transfer> getList(HashMap<String, Object> hashMap, PageBounds pageBounds){
		return transferMapper.getList(hashMap, pageBounds);
	}
	/**
	 * 查询单条
	 */
	public Transfer queryOne(HashMap<String, Object> map){
		return transferMapper.queryOne(map);
	}
	/**
	 * 添加
	 */
	@Override
	public int save(Transfer transfer) {
		return transferMapper.save(transfer);
	}
	/**
	 * 编辑
	 */
	public int edit(Transfer transfer){
		return transferMapper.edit(transfer);
	}
	/**
	 * 删除
	 */
	public int delete(String id){
		return transferMapper.delete(id);
	}
	
}
