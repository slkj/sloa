package cn.slkj.sloa.service;

import java.util.HashMap;
import java.util.List;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

import cn.slkj.hbsl.util.PageData;
import cn.slkj.sloa.entity.system.User;

public interface UserService {
	User userLogin(PageData pd);

	List<User> getAllUsers(HashMap<String, Object> hashMap, PageBounds pageBounds);
	
	List<User> queryAll(HashMap<String, Object> hashMap);

	public User queryOne(HashMap<String, Object> hashMap);

	public int save(User user);

	public int edit(User user);

	public int delete(String id);

	public User goDingLogin(String userid);
}
