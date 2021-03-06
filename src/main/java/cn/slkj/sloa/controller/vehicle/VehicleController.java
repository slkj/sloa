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
import org.springframework.web.bind.annotation.SessionAttributes;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;

import cn.slkj.hbsl.util.Const;
import cn.slkj.hbsl.util.javaUtil.StringUtil;
import cn.slkj.sloa.controller.system.base.BaseController;
import cn.slkj.sloa.entity.system.User;
import cn.slkj.sloa.entity.vehicle.Vehicle;
import cn.slkj.sloa.service.VehicleService;
import cn.slkj.sloa.util.easyuiUtil.EPager;
import cn.slkj.sloa.util.easyuiUtil.JsonResult;

/**
 * 
 * @ClassName: VehicleController
 * @Description: 车辆业务
 * @author wangling
 * @date 2017年5月1日上午9:53:52
 */
@Controller
@RequestMapping(value = "/vehicle")
@SessionAttributes("vehicleSession")
public class VehicleController extends BaseController {
	@Resource
	private VehicleService vehicleService;

	/* 跳转车辆收费标准设置列表页面 */
	@RequestMapping("/toSfbzLsit")
	public String toSfbzLsit() {
		return "vehicle/car/carSfbz";
	}

	/* 跳转车辆收费标准设置列表页面 */
	@RequestMapping("/toSfbzPage")
	public String toSfbzPage() {
		return "vehicle/car/sfbz";
	}

	/* 跳转季审列表页面 */
	@RequestMapping("/seasonExamList")
	public String toSeasonExamPage() {
		return "vehicle/seasonExam/seasonExamList";
	}

	/* 跳转年审列表页面 */
	@RequestMapping("/yearExamList")
	public String toYearExamPage() {
		return "vehicle/yearExam/yearExamList";
	}
	/* 跳转车辆列表页面 */
	@RequestMapping("/vehicleList")
	public String toListPage() {
		return "vehicle/vehicleList";
	}
	@RequestMapping("/vehicleAdd")
	public String toAddPage() {
		return "vehicle/vehicleForm";
	}

	@RequestMapping("/vehicleEdit")
	public String toEditPage(HttpServletRequest request) {
		return "vehicle/car/carEdit";
	}

	@RequestMapping("/vehicleInfo")
	public String toInfoPage(HttpServletRequest request) {
		return "vehicle/car/carInfo";
	}

	/* 跳转季审添加页面 */
	@RequestMapping("/seasonExamAdd")
	public String toSeasonExamAddPage() {
		return "vehicle/seasonExam/seasonExamAdd";
	}

	/* 跳转年审添加页面 */
	@RequestMapping("/yearExamAdd")
	public String toYearExamAddPage() {
		return "vehicle/yearExam/yearExamAdd";
	}

	@RequestMapping("/toSyncMain")
	public String toSyncMain() {
		return "vehicle/syncData/carList";
	}
	
	@RequestMapping("/toSyncPage")
	public String toSyncPage() {
		return "vehicle/syncData/syncData";
	}
	
	
	/**
	 * 查询车辆列表，返回easyUI数据格式
	 */
	@ResponseBody
	@RequestMapping(value = "/list", method = { RequestMethod.POST })
	public EPager<Vehicle> getList(HttpServletRequest request, HttpSession session, @RequestParam(required = false, defaultValue = "1") Integer page, // 第几页
			@RequestParam(required = false, defaultValue = "15") Integer rows) {
		String carNumber = request.getParameter("carNumber");
		String companyName = request.getParameter("companyName");
		String equitment = request.getParameter("equitment");
		String simNumber = request.getParameter("simNumber");
		String carOwner = request.getParameter("carOwner");
		String seasonExamE1 = request.getParameter("seasonExamE1");
		String seasonExamE2 = request.getParameter("seasonExamE2");
		String yearExamE1 = request.getParameter("yearExamE1");
		String yearExamE2 = request.getParameter("yearExamE2");
		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("carNumber", carNumber);
		hashMap.put("companyName", companyName);
		hashMap.put("equitment", equitment);
		hashMap.put("simNumber", simNumber);
		hashMap.put("carOwner", carOwner);
		hashMap.put("seasonExamE1", seasonExamE1);
		hashMap.put("seasonExamE2", seasonExamE2);
		hashMap.put("yearExamE1", yearExamE1);
		hashMap.put("yearExamE2", yearExamE2);
		User u = (User) session.getAttribute(Const.SESSION_USER);
		String depId = u.getDepartcode();
		hashMap.put("depId", depId);
		
		// 排序
		String sort = request.getParameter("sort");
		String order = request.getParameter("order");
		String sortString = "";

		if (!StringUtil.isEmpty(sort) && !StringUtil.isEmpty(order)) {
			sortString = sort + "." + order;
		}
		if (StringUtil.isEmpty(sortString)) {
			sortString = "keeptime.desc";
		}
		
		PageBounds pageBounds = new PageBounds(page, rows, Order.formString(sortString));
		List<Vehicle> list = vehicleService.getList(hashMap, pageBounds);
		PageList pageList = (PageList) list;
		return new EPager<Vehicle>(pageList.getPaginator().getTotalCount(), list);
	}

	/**
	 * 查询单条信息
	 */
	@ResponseBody
	@RequestMapping(value = "/queryOne", method = { RequestMethod.POST })
	public Vehicle queryOne(String id) {
		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("id", id);
		Vehicle vehicle = vehicleService.queryOne(hashMap);
		return vehicle;
	}

	/**
	 * 保存车辆信息
	 * 
	 * @param vehicle
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public JsonResult save(Vehicle vehicle, HttpServletRequest request) {
		try {
			int i = -1;
			/*
			 * HashMap<String, Object> hashMap = new HashMap<String, Object>();
			 * hashMap.put("username", user.getUsername().trim()); User u =
			 * userService.queryOne(hashMap); user.setPassword("000000");
			 * 
			 * if (u != null) { return new JsonResult(false, "用户已经存在，请重新填写。"); }
			 * else { user.setPassword("000000"); user.setId(this.get32UUID());
			 * user.setCreate_time(DateUtil.DateToString(new Date(),
			 * DateStyle.YYYY_MM_DD));
			 */
			HttpSession session = request.getSession();
			User u = (User) session.getAttribute(Const.SESSION_USER);
			String depId = u.getDepartcode();
			if (StringUtil.isEmpty(depId)) {
				depId = "5";
			}
			vehicle.setDepId(Integer.parseInt(depId));
			vehicle.setId(this.get32UUID());
			i = vehicleService.save(vehicle);
			// }
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
	 * 编辑车辆信息
	 * 
	 * @param vehicle
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public JsonResult editVehicle(Vehicle vehicle) {
		try {
			int i = -1;
			i = vehicleService.edit(vehicle);
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
	 * 编辑车辆季审信息
	 * 
	 * @param vehicle
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/editSeasonExam", method = RequestMethod.POST)
	public JsonResult editSeasonExam(Vehicle vehicle) {
		try {
			int i = -1;
			i = vehicleService.editSeasonExam(vehicle);
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
	 * 编辑车辆年审信息
	 * 
	 * @param vehicle
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/editYearExam", method = RequestMethod.POST)
	public JsonResult editYearExam(Vehicle vehicle) {
		try {
			int i = -1;
			i = vehicleService.editYearExam(vehicle);
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
		int i = vehicleService.delete(id);
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

	/** 编辑保存 */
	@ResponseBody
	@RequestMapping(value = "/sfbz")
	public boolean sfbz(Vehicle vehicle) throws Exception {
		try {
			int i = vehicleService.sfbz(vehicle);
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

}
