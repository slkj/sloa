package cn.slkj.sloa.mapper;

import java.util.HashMap;
import java.util.List;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

import cn.slkj.hbsl.util.PageData;
import cn.slkj.sloa.entity.system.User;

public interface UserMapper {

	public User userLogin(PageData pd);

	public List<User> getAllUsers(HashMap<String, Object> hashMap, PageBounds pageBounds);
	
	public List<User> queryAll(HashMap<String, Object> hashMap);

	public User queryOne(HashMap<String, Object> map);

	public int save(User user);

	public int edit(User user);

	public int delete(String id);

	public User goDingLogin(String userid);

}