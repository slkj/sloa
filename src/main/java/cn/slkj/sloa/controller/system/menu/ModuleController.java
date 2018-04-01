package cn.slkj.sloa.controller.system.menu;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.slkj.hbsl.util.AppUtil;
import cn.slkj.hbsl.util.Const;
import cn.slkj.hbsl.util.PageData;
import cn.slkj.sloa.controller.system.base.BaseController;
import cn.slkj.sloa.entity.system.Module;
import cn.slkj.sloa.entity.system.User;
import cn.slkj.sloa.service.ModuleService;
import cn.slkj.sloa.util.easyuiUtil.Tree;

@Controller
@RequestMapping("/module")
public class ModuleController extends BaseController {
	private static Logger log = LoggerFactory.getLogger(ModuleController.class);
	@Autowired
	private ModuleService moduleService;

	@RequestMapping("/menusPage")
	public String toMenusPage() {
		return "system/menus/menus";
	}
	@RequestMapping("/menusInfo")
	public String toMenusInfo() {
		return "system/menus/menusInfo";
	}

	/**
	 * 根据id查询
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/queryOne/{id}")
	@ResponseBody
	public Module queryOne(@PathVariable String id) {
		return moduleService.queryOne(id);
	}

	/**
	 * 
	 * @return
	 */
	@RequestMapping(value = "/listByUser")
	@ResponseBody
	public List<Module> listByUser(HttpServletRequest request) {
		String userid = "";
		HashMap<String, Object> map = new HashMap<String, Object>();
		// 获取用户部门编码
		User user = (User) request.getSession().getAttribute(Const.SESSION_USER);
		userid = user.getId();
		map.put("userid", userid);
		List<Module> list = moduleService.getModuleByUserId(map);
		return queryMenuListTree(list);
	}

	/**
	 * 
	 * @return
	 */
	@RequestMapping(value = "/list")
	@ResponseBody
	public List<Module> list() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<Module> list = moduleService.getAll(map);
		return makeTree(list);
	}

	/**
	 * 添加菜单 or 按钮
	 * 
	 * @param module
	 * @return
	 */
	@RequestMapping(value = "/addModule", method = { RequestMethod.POST })
	@ResponseBody
	public Object addModule(Module module) {
		Map<String, String> map = new HashMap<String, String>();
		String errInfo = "";
//		module.setId(this.get32UUID());
		try {
			int i = moduleService.insert(module);
			if (i > 0) {
				errInfo = "success";
			}
			errInfo = "error";
		} catch (Exception e) {
			e.printStackTrace();
			errInfo = "error";
		}
		map.put("result", errInfo);
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 编辑菜单 or 按钮
	 * 
	 * @param module
	 * @return
	 */
	@RequestMapping(value = "/editModule", method = { RequestMethod.POST })
	@ResponseBody
	public boolean editModule(Module module) {
		int i = moduleService.update(module);
		if (i > 0) {
			return true;
		} else {
			return false;
		}

	}

	/**
	 * 删除菜单
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/delModule")
	@ResponseBody
	public Object delModule(String id) {
		Map<String, String> map = new HashMap<String, String>();
		String errInfo = "";
		try {
			int i = moduleService.delete(id);
			if (i > 0) {
				errInfo = "success";
			}
		} catch (Exception e) {
			e.printStackTrace();
			errInfo = "error";
		}
		map.put("result", errInfo);
		return AppUtil.returnObject(new PageData(), map);
	}

	@RequestMapping(value = "/getUserModule")
	@ResponseBody
	public List<Tree> getUserModule(String userid) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("userid", userid);
		List<Module> allList = moduleService.getAll(map);
		List<Module> checkList = moduleService.getModuleByUserId(map);
		return initCheckBoxTree(allList, "0", checkList);
	}

	@RequestMapping(value = "/getCombotree")
	@ResponseBody
	public List<Tree> getCombotree() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("priority", 3);
		List<Module> list = moduleService.getAll(map);
		return toTree(list, "0");
	}

	/**
	 * 保存用户和资源之间的关系
	 * 
	 * @param member
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/saveRoleRes", method = RequestMethod.POST)
	private boolean intoRole(@RequestParam(required = false, defaultValue = "") String userid, @RequestParam(value = "ids[]") String[] ids) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("ids", ids);
		map.put("userid", userid);
		if (StringUtils.isNotBlank(userid)) {
			int i = moduleService.saveUserRes(map);
			if (i != -1) {
				return true;
			}
		}
		return false;
	}

	private List<Tree> toTree(List<Module> list, String code) {
		List<Tree> trees = new ArrayList<Tree>();
		for (Module m : list) {
			Tree t = new Tree();
			t.setId(m.getId() + "");
			t.setText(m.getName());
			// t.setState();
			// t.setChecked();
			if (code.equals(m.getP_id())) {
				t.setChildren(toTree(list, m.getId()));
				trees.add(t);
			}

		}
		return trees;
	}

	@RequestMapping(value = "/role2Module")
	@ResponseBody
	public List<Tree> role2Module(String roleId) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("roleid", roleId);
		List<Module> allList = moduleService.getAll(map);
		List<Module> checkList = moduleService.getModuleByRoleId(map);
		return initCheckBoxTree(allList, "0", checkList);
	}

	@RequestMapping(value = "/getRolePer")
	@ResponseBody
	public List<Module> getRolePer(HttpServletRequest request, String mid) {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute(Const.SESSION_USER);
		String roleid = user.getRoleId();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("roleid", roleid);
		map.put("modlueid", mid);
		return moduleService.getRolePer(map);
	}

	public List<Module> queryMenuListTree(List<Module> rootModule) {
		// 最后的结果
		List<Module> menuList = new ArrayList<Module>();
		// 先找到所有的一级菜单
		for (int i = 0; i < rootModule.size(); i++) {
			// 一级菜单没有parentId
			if ("1".equals(rootModule.get(i).getP_id())) {
				menuList.add(rootModule.get(i));
			}
		}
		// 为一级菜单设置子菜单，getChild是递归调用的
		for (Module module : menuList) {
			module.setChildren(getChild(module.getId(), rootModule));
		}
		return menuList;
	}

	/**
	 * 递归查找子菜单
	 * 
	 * @param id
	 *            当前菜单id
	 * @param rootMenu
	 *            要查找的列表
	 * @return
	 */
	private List<Module> getChild(String id, List<Module> rootMenu) {
		// 子菜单
		List<Module> childList = new ArrayList<Module>();
		for (Module menu : rootMenu) {
			// 遍历所有节点，将父菜单id与传过来的id比较
			if (StringUtils.isNotBlank(menu.getP_id())) {
				if (menu.getP_id().equals(id)) {
					childList.add(menu);
				}
			}
		}
		// 把子菜单的子菜单再循环一遍
		for (Module menu : childList) {// 没有url子菜单还有子菜单
			if (StringUtils.isBlank(menu.getUrl())) {
				// 递归
				menu.setChildren(getChild(menu.getId(), rootMenu));
			}
		} // 递归退出条件
		if (childList.size() == 0) {
			return null;
		}
		return childList;
	}

	/**
	 * 组装树形列表 treegrid
	 * 
	 * @param list
	 * @return
	 */
	private List<Module> makeTree(List<Module> list) {
		List<Module> parent = new ArrayList<Module>();
		for (Module e : list) {
			if (e.getP_id().equals("0")) {
				e.setChildren(new ArrayList<Module>(0));
				parent.add(e);
			}
		}
		list.removeAll(parent);
		makeChildren(parent, list);
		return parent;
	}

	private void makeChildren(List<Module> parent, List<Module> children) {
		if (children.isEmpty()) {
			return;
		}
		List<Module> tmp = new ArrayList<Module>();
		for (Module c1 : parent) {
			for (Module c2 : children) {
				c2.setChildren(new ArrayList<Module>(0));
				if (c1.getId().equals(c2.getP_id())) {
					c1.getChildren().add(c2);
					if (!c1.getP_id().equals("0")) {
						c1.setState("closed");
					}
					tmp.add(c2);
				}
			}
		}
		children.removeAll(tmp);
		makeChildren(tmp, children);
	}

	// 将list转换为需要的json格式
	private List<Tree> initCheckBoxTree(List<Module> list, String id, List<Module> list1) {
		List<Tree> trees = new ArrayList<Tree>();
		for (Module menus : list) {
			Tree node = new Tree();
			node.setId(menus.getId());
			node.setText(menus.getName());
			// node.setIconCls(menus.getRes_icon());
			if (list1 != null) {
				// 循环判断该角色拥有的资源，如果拥有的话，设置为选择中
				for (int i = 0; i < list1.size(); i++) {
					String oid = list1.get(i).getId();
					String nid = menus.getId();
					if (oid.equals(nid)) {
						node.setChecked(true);
					}
				}
			}
			if (id.equals(menus.getP_id())) {
				node.setChildren(initCheckBoxTree(list, node.getId(), list1));
				if (!node.getChildren().isEmpty()) {
					node.setChecked(false);
				}

				trees.add(node);
			}
		}
		return trees;
	}
}
