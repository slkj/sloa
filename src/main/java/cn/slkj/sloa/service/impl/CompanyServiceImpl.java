package cn.slkj.sloa.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

import cn.slkj.sloa.entity.system.Company;
import cn.slkj.sloa.mapper.CompanyMapper;
import cn.slkj.sloa.service.CompanyService;

@Service
@Transactional
public class CompanyServiceImpl implements CompanyService {
	@Autowired
	private CompanyMapper mapper;

	@Override
	public List<Company> getAll(HashMap<String, Object> map, PageBounds pageBounds) {
		return mapper.queryList(map, pageBounds);
	}

	@Override
	public List<Company> queryComList(HashMap<String, Object> map) {
		return mapper.queryComList(map);
	}

	@Override
	public int save(Company company) {
		return mapper.save(company);
	}

	@Override
	public int edit(Company company) {
		return mapper.edit(company);
	}

	@Override
	public int delete(String id) {
		return mapper.delete(id);
	}

	@Override
	public Company queryOne(String id) {
		return mapper.queryOne(id);
	}

	@Override
	public int sfbz(Company company) {
		return mapper.sfbz(company);
	}

	 
}
