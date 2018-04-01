package cn.slkj.sloa.controller.shfw.repair;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;

import cn.slkj.hbsl.util.Const;
import cn.slkj.hbsl.util.javaUtil.date.DateStyle;
import cn.slkj.hbsl.util.javaUtil.date.DateUtil;
import cn.slkj.sloa.entity.shfw.Repair;
import cn.slkj.sloa.entity.stock.Devices;
import cn.slkj.sloa.entity.stock.Sim;
import cn.slkj.sloa.entity.system.User;
import cn.slkj.sloa.entity.vehicle.Transfer;
import cn.slkj.sloa.service.DevicesService;
import cn.slkj.sloa.service.SimService;
import cn.slkj.sloa.service.impl.RepairServiceImpl;
import cn.slkj.sloa.util.easyuiUtil.EPager;
import cn.slkj.sloa.util.easyuiUtil.JsonResult;

/**
 * 
 * @ClassName: RepairController
 * @Description: 工单审核 控制器
 * @author xiaotianliang
 */
@Controller
@RequestMapping(value = "/repair")
public class RepairController {

	@Autowired
	private RepairServiceImpl repairservice;
	@Autowired
	private DevicesService deviceService;
	@Autowired
	private SimService simService;

	@RequestMapping("/toRepairPage")
	public String toRepairPage() {
		return "shfw/repair/repair";
	}
	@RequestMapping("/toRepairPageEX")
	public String toRepairPageEX() {
		return "shfw/repair/repairEX";
	}
	@RequestMapping("/toRepairAdd")
	public String toRepairAdd() {
		return "shfw/repair/repairAdd";
	}

	@RequestMapping("/list")
	@ResponseBody
	public EPager<Repair> getAll(HttpServletRequest request, HttpSession session, @RequestParam(required = false, defaultValue = "1") Integer page, // 第几页
			@RequestParam(required = false, defaultValue = "15") Integer rows) throws Exception {
		String sortString = "id.desc";
		Map<String, Object> pageMap = new HashMap<String, Object>();
		pageMap.put("carNumber", request.getParameter("carNumber"));
		pageMap.put("guyName", request.getParameter("guyName"));
		pageMap.put("wxTime", request.getParameter("wxTime"));
		pageMap.put("wxTime1", request.getParameter("wxTime1"));
		pageMap.put("department", request.getParameter("department"));
		pageMap.put("outcome", request.getParameter("outcome"));
		pageMap.put("isLook", request.getParameter("isLook"));
		PageBounds pageBounds = new PageBounds(page, rows, Order.formString(sortString));
		List<Repair> list = repairservice.getAll(pageMap, pageBounds);
		PageList pageList = (PageList) list;
		return new EPager<Repair>(pageList.getPaginator().getTotalCount(), list);
	}

	/**
	 * 获取实体
	 * 
	 * @param insurance
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/queryOne")
	public Repair queryOne(String id) {
		Repair repair = new Repair();
		repair.setId(id);
		return repairservice.queryOne(repair);
	}
	@ResponseBody
	@RequestMapping(value = "/save", method = { RequestMethod.POST })
	public JsonResult save(Repair repair, HttpServletRequest request) {
		// User user = (User)
		// request.getSession().getAttribute(Const.SESSION_USER);
		if (repair.getWxTime().isEmpty()) {
			return new JsonResult(false, "信息保存异常。");
		}
		int i;
		try {
			repair.setOutcome("0");
			if (!repair.getRepairNum().isEmpty()) {
				i = repairservice.saveByRNum(repair);
			} else {
				i = repairservice.save(repair);
			}

			if (i != -1) {
				return new JsonResult(true, "保存成功。");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new JsonResult(false, "保存失败！");
	}
//	@ResponseBody
//	@RequestMapping(value = "/save", method = { RequestMethod.POST })
//	public JsonResult save(Repair repair, HttpServletRequest request) {
//		User user = (User) request.getSession().getAttribute(Const.SESSION_USER);
//		if (repair.getWxTime().isEmpty()) {
//			return new JsonResult(false, "信息保存异常。");
//		}
//		int i;
//		try {
//			//repair.setOutcome("0");
//			repair.setDepartment(user.getDepartcode());
//			repair.setOperator(user.getRealname());
//			repair.setOperatorTime(DateUtil.DateToString(new Date(), DateStyle.YYYY_MM_DD_HH_MM_SS));
//			i = repairservice.save(repair);
//			if (i != -1) {
//				if(repair.getEquitment1()!=null&repair.getEquitment1()!=""){
//				Devices d=new Devices();
//				d.setListnum(repair.getEquitment1());
//				d.setState(1);
//				d.setUstate(1);
//				d.setCarNumber(repair.getCarNumber());
//				d.setInstallers(repair.getGuyName());
//				d.setInstalltime(repair.getWxTime());
//				deviceService.editbyNum(d);
//				Devices d1=new Devices();
//				d1.setListnum(repair.getEquitment());
//				d1.setState(3);
//				d1.setUstate(0);
//				deviceService.editbyNum(d1);
//				}
//			if(repair.getSimNumber1()!=null&repair.getSimNumber1()!=""){
//					Sim s=new Sim();
//					s.setTelnum(repair.getSimNumber1());
//					s.setUstate(1);
//					s.setState(1);
//					s.setCarNumber(repair.getCarNumber());
//					s.setLyr(repair.getGuyName());
//					s.setOuttime(repair.getWxTime());
//					simService.editByNum(s);
//					Sim s1=new Sim();
//					s1.setTelnum(repair.getSimNumber());
//					s1.setUstate(2);
//					s1.setState(0);
//					simService.editByNum(s1);
//					}
//				return new JsonResult(true, "保存成功。");
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return new JsonResult(false, "保存失败！");
//	}
	/**
	 * 编辑维修信息
	 * @param repair
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public JsonResult edit(Repair repair) {
		try {
			int i = -1;
			i = repairservice.edit(repair);
			if (i != -1) {
				if(repair.getEquitment1()!=null&repair.getEquitment1()!=""){
					Devices d=new Devices();
					d.setListnum(repair.getEquitment1());
					d.setState(1);
					d.setUstate(1);
					d.setCarNumber(repair.getCarNumber());
					d.setInstallers(repair.getGuyName());
					d.setInstalltime(repair.getWxTime());
					deviceService.editbyNum(d);
					Devices d1=new Devices();
					d1.setListnum(repair.getEquitment());
					d1.setState(3);
					d1.setUstate(0);
					deviceService.editbyNum(d1);
					}
				if(repair.getSimNumber1()!=null&repair.getSimNumber1()!=""){
						Sim s=new Sim();
						s.setTelnum(repair.getSimNumber1());
						s.setUstate(1);
						s.setState(1);
						s.setCarNumber(repair.getCarNumber());
						s.setLyr(repair.getGuyName());
						s.setOuttime(repair.getWxTime());
						simService.editByNum(s);
						Sim s1=new Sim();
						s1.setTelnum(repair.getSimNumber());
						s1.setUstate(2);
						s1.setState(0);
						simService.editByNum(s1);
						}
				return new JsonResult(true, "操作成功。");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new JsonResult(false, "操作异常！");
		}
		return new JsonResult(false, "操作失败！");
	}
	/** 单条删除 */
	@ResponseBody
	@RequestMapping(value = "/delete")
	public JsonResult delete(String id) {
		int i = repairservice.delete(id);
		if (i > 0) {
			return new JsonResult(true, "");
		}
		return new JsonResult(false, "删除失败！");
	}

	 
	/**
	 * 
	 * @Title: isLook
	 * @Description:审核
	 * @param repair
	 * @param request
	 * @return JsonResult
	 * @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/isLook", method = { RequestMethod.POST })
	public JsonResult isLook(@RequestParam(value = "ids[]") String[] ids,
			String isLook, HttpServletRequest request) {
		User user = (User) request.getSession()
				.getAttribute(Const.SESSION_USER);
		try {
			int i = -1;
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("ids", ids);
			map.put("isLook", isLook);
			map.put("lookTime", DateUtil.DateToString(new Date(),
					DateStyle.YYYY_MM_DD_HH_MM_SS));
			map.put("looker", user.getRealname());
			i = repairservice.isLook(map);
			if (i != -1) {
				return new JsonResult(true, "操作成功。");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new JsonResult(false, "操作失败！");
	}

	/**
	 * 
	 * @Title: isLook
	 * @Description:审核
	 * @param repair
	 * @param request
	 * @return JsonResult
	 * @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/isOutcome", method = { RequestMethod.POST })
	public JsonResult isOutcome(@RequestParam(value = "ids[]") String[] ids,
			String outcome, HttpServletRequest request) {
		User user = (User) request.getSession()
				.getAttribute(Const.SESSION_USER);
		try {
			int i = -1;
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("ids", ids);
			map.put("outcome", outcome);
			map.put("operatorTime", DateUtil.DateToString(new Date(),
					DateStyle.YYYY_MM_DD_HH_MM_SS));
			map.put("operator", user.getRealname());
			i = repairservice.isOutcome(map);
			if (i != -1) {
				return new JsonResult(true, "操作成功。");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new JsonResult(false, "操作失败！");
	}
	

}
