package cn.slkj.sloa.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

import cn.slkj.hbsl.util.PageData;
import cn.slkj.sloa.entity.system.User;
import cn.slkj.sloa.mapper.UserMapper;
import cn.slkj.sloa.service.UserService;

@Service
@Transactional
public class UserServiceImpl implements UserService {
	@Resource
	private UserMapper userMapper;

	/*
	 * 登录判断
	 */
	@Override
	public User userLogin(PageData pd) {
		// TODO Auto-generated method stub
		return userMapper.userLogin(pd);
	}

	@Override
	public List<User> getAllUsers(HashMap<String, Object> hashMap, PageBounds pageBounds) {
		// TODO Auto-generated method stub
		return userMapper.getAllUsers(hashMap, pageBounds);
	}
	@Override
	public List<User> queryAll(HashMap<String, Object> hashMap) {
		// TODO Auto-generated method stub
		return userMapper.queryAll(hashMap);
	}

	@Override
	public User queryOne(HashMap<String, Object> hashMap) {
		return userMapper.queryOne(hashMap);
	}

	@Override
	public int save(User user) {
		return userMapper.save(user);
	}

	@Override
	public int edit(User user) {
		return userMapper.edit(user);
	}

	@Override
	public int delete(String id) {
		return userMapper.delete(id);
	}

	@Override
	public User goDingLogin(String userid) {
		return userMapper.goDingLogin(userid);
	}

}
