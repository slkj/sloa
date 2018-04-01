package cn.slkj.sloa.controller.vehicle;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.slkj.hbsl.util.Const;
import cn.slkj.sloa.controller.system.base.BaseController;
import cn.slkj.sloa.entity.system.User;
import cn.slkj.sloa.entity.vehicle.Insurance;
import cn.slkj.sloa.entity.vehicle.License;
import cn.slkj.sloa.service.LicenseService;
import cn.slkj.sloa.util.easyuiUtil.EPager;
import cn.slkj.sloa.util.easyuiUtil.JsonResult;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;

/**
 * 
 * @ClassName: LicenseController
 * @Description: 证件业务
 * @author wangling
 * @date 2017年5月4日下午5:17:04
 */
@Controller
@RequestMapping(value = "/license")
public class LicenseController extends BaseController {
	@Resource
	private LicenseService licenseService;
	/* 跳转列表页面 */
	@RequestMapping("/licenseList")
	public String toListPage() {
		return "vehicle/license/licenseList";
	}
	/* 跳转添加页面 */
	@RequestMapping("/licenseAdd")
	public String toAddPage() {
		return "vehicle/license/licenseAdd";
	}
	
	/**
	 * 查询车辆列表，返回easyUI数据格式
	 */
	@ResponseBody
	@RequestMapping(value = "/list", method = { RequestMethod.POST })
	public EPager<License> getList(HttpServletRequest request, HttpSession session, @RequestParam(required = false, defaultValue = "1") Integer page, // 第几页
			@RequestParam(required = false, defaultValue = "15") Integer rows) {
		String sortString = "riqi.desc";
		String carNumber = request.getParameter("carNumber");
		String licenseNo = request.getParameter("licenseNo");
		String endDate1 = request.getParameter("endDate1");
		String endDate2 = request.getParameter("endDate2");
		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("carNumber", carNumber);
		hashMap.put("licenseNo", licenseNo);
		hashMap.put("endDate1", endDate1);
		hashMap.put("endDate2", endDate2);
		User u = (User) session.getAttribute(Const.SESSION_USER);
		String depId = u.getDepartcode();
		hashMap.put("depId", depId);
		PageBounds pageBounds = new PageBounds(page, rows, Order.formString(sortString));
		List<License> list = licenseService.getList(hashMap, pageBounds);
		PageList pageList = (PageList) list;
		return new EPager<License>(pageList.getPaginator().getTotalCount(), list);
	}
	/**
	 * 根据车牌号查询办证记录
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/listByCarNumber", method = { RequestMethod.POST })
	public @ResponseBody EPager<License> listByCarNumber(HttpServletRequest request) {
		HashMap<String, Object> pageMap = new HashMap<String, Object>();
		int page = Integer.parseInt(request.getParameter("page"));
		int rows = Integer.parseInt(request.getParameter("rows"));
		String vId = request.getParameter("vId");
		pageMap.put("vId", vId);
		// 排序
		String sortString = "endTime.desc";
		PageBounds pageBounds = new PageBounds(page, rows, Order.formString(sortString));
		List<License> list = licenseService.getListByCarNumber(pageMap, pageBounds);
		PageList pageList = (PageList) list;
		return new EPager<License>(pageList.getPaginator().getTotalCount(), list);
	}
	/**
	 * 查询单条信息
	 */
	@ResponseBody
	@RequestMapping(value = "/queryOne", method = { RequestMethod.POST })
	public License queryOne(String id) {
		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("id", id);
		License license = licenseService.queryOne(hashMap);
		return license;
	}
	
	/**
	 * 保存车辆信息
	 * @param vehicle
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public JsonResult save(License license) {
		try {
			int i = -1;
			
				license.setId(this.get32UUID());
				i = licenseService.save(license);
			
			if (i != -1) {
				return new JsonResult(true, "添加成功。");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new JsonResult(false, "系统异常，添加失败！");
		}
		return new JsonResult(false, "添加失败！");
	}

	/**
	 * 编辑信息
	 * @param vehicle
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public JsonResult editLicense(License license) {
		try {
			int i = -1;
			i = licenseService.edit(license);
			if (i != -1) {
				
				return new JsonResult(true, "操作成功。");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new JsonResult(false, "操作异常！");
		}
		return new JsonResult(false, "操作失败！");
	}

	/**
	 * 删除车辆信息
	 * 
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/delete")
	public JsonResult deletes(String id) {
		int i = licenseService.delete(id);
		try {
			if (i > 0) {
				return new JsonResult(true, "删除成功。");
			} else {
				return new JsonResult(false, "删除失败。");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new JsonResult(false, "操作异常。");
		}
	}
}
