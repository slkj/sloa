package cn.slkj.sloa.controller.system.role;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;

import cn.slkj.sloa.entity.system.Role;
import cn.slkj.sloa.service.RoleService;
import cn.slkj.sloa.util.easyuiUtil.EPager;

/**
 * 
 * @ClassName: RoleController
 * @Description: 角色管理控制类
 * @author maxh
 *
 */
@Controller
@RequestMapping(value = "/role")
public class RoleController {
	private static Logger log = LoggerFactory.getLogger(RoleController.class);
	@Resource
	private RoleService service;

	/** 跳转页面**/
	//角色管理页面
	@RequestMapping("/rolePage")
	public String toRolePage() {
		return "system/role/role";
	}
	//角色信息
	@RequestMapping("/roleInfo")
	public String roleInfoPage() {
		return "system/role/roleInfo";
	}
	//角色菜单权限
	@RequestMapping("/allotRes")
	public String allotRes() {
		return "system/role/allotRes";
	}
	//角色用户列表
	@RequestMapping("/allotUser")
	public String allotUser() {
		return "system/role/allotUser";
	}
	@RequestMapping("/list")
	@ResponseBody
	public EPager<Role> getAll(HttpServletRequest request) throws Exception {
		Map<String, Object> pageMap = new HashMap<String, Object>();
		int page = Integer.parseInt(request.getParameter("page"));
		int rows = Integer.parseInt(request.getParameter("rows"));
		PageBounds pageBounds = new PageBounds(page, rows);
		List<Role> list = service.getAll(pageMap, pageBounds);
		PageList<Role> pageList = (PageList<Role>) list;
		return new EPager<Role>(pageList.getPaginator().getTotalCount(), list);
	}

	@RequestMapping("/queryAll")
	@ResponseBody
	public List<Role> queryAll(HttpServletRequest request) throws Exception {
		Map<String, Object> pageMap = new HashMap<String, Object>();
		List<Role> list = service.queryAll(pageMap);
		return list;
	}

	@ResponseBody
	@RequestMapping(value = "/queryOne")
	public Role queryOne(String id) {
		return service.queryByid(id);
	}

	@ResponseBody
	@RequestMapping(value = "/save", method = { RequestMethod.POST })
	public boolean save(Role role) throws Exception {
		try {
			int i = service.saveRole(role);
			if (i > 0) {
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	@ResponseBody
	@RequestMapping(value = "/edit")
	public boolean edit(Role role) throws Exception {
		try {
			int i = service.editRole(role);
			if (i > 0) {
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	@ResponseBody
	@RequestMapping(value = "/delete")
	public boolean deletes(String id) {
		int i = service.deleteRole(id);
		try {
			if (i > 0) {
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	/**
	 * 保存角色和资源之间的关系
	 * 
	 * @param member
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/saveRoleRes", method = RequestMethod.POST)
	private boolean intoRole(@RequestParam(required = false, defaultValue = "") String roleid, @RequestParam(value = "ids[]") String[] ids) {
		if (StringUtils.isNotBlank(roleid)) {
			service.deleteRoleRes(roleid, ids);
			int i = service.saveRoleRes(roleid, ids);
			if (i != -1) {
				return true;
			}
		}
		log.debug("{}，角色id为空");
		return false;
	}

	/**
	 * 保存角色 菜单 下操作按钮
	 * 
	 * @param roleid
	 * @param ids
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/saveRolePer", method = RequestMethod.POST)
	private boolean saveRolePer(@RequestParam(required = false, defaultValue = "") String roleid, @RequestParam(required = false, defaultValue = "") String modlueid, @RequestParam(value = "ids[]") String[] ids) {
		if (StringUtils.isNotBlank(roleid)) {
			service.deleteRolePer(roleid, modlueid, ids);
			int i = service.saveRolePer(roleid, modlueid, ids);
			if (i != -1) {
				return true;
			}
		}
		return false;
	}

}
