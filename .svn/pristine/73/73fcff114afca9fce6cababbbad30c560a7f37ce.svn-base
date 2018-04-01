package cn.slkj.sloa.controller.stock;

import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import cn.slkj.hbsl.util.Const;
import cn.slkj.hbsl.util.javaUtil.StringUtil;
import cn.slkj.hbsl.util.javaUtil.UUIDUtils;
import cn.slkj.hbsl.util.javaUtil.date.DateUtil;
import cn.slkj.sloa.entity.stock.Devices;
import cn.slkj.sloa.entity.stock.Devices_record;
import cn.slkj.sloa.entity.system.User;
import cn.slkj.sloa.service.DevicesService;
import cn.slkj.sloa.service.ProveService;
import cn.slkj.sloa.util.easyuiUtil.EPager;
import cn.slkj.sloa.util.easyuiUtil.JsonResult;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;

@Controller
@RequestMapping("/devices")
public class DevicesController {
	@Autowired
	private DevicesService service;
	@Autowired
	private ProveService proveService;

	@RequestMapping("/toChuKu")
	public String toChuKu() {
		return "stock/devices/ChuKu";
	}
	@RequestMapping("/toBack")
	public String toBack() {
		return "stock/devices/Back";
	}
	@RequestMapping("/toEdit")
	public String toEdit() {
		return "stock/devices/edit";
	}

	@RequestMapping("/toDevicesPage")
	public String toDevicesPage() {
		return "stock/devices/devices";
	}
	@RequestMapping("/toDevicesPageDaili")
	public String toDevicesPageDaili() {
		return "stock/daili/devices";
	}

	@RequestMapping("/toDeviceAdd")
	public String toDeviceAdd() {
		return "stock/devices/deviceAdd";
	}

	@RequestMapping("/toDeviceTest")
	public String toDeviceTest() {
		return "stock/devices/test";
	}

	@RequestMapping("/toDetails")
	public String toDetails() {
		return "stock/devices/details";
	}

	@RequestMapping("/toTestPage")
	public String toTestPage() {
		return "stock/devices/testing";
	}

	@RequestMapping("/toRecord")
	public String toRecord() {
		return "stock/devices/record";
	}

	/**
	 * 查询所有设备列表
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	@ResponseBody
	public EPager<Devices> getAll(HttpServletRequest request) throws Exception {
		Map<String, Object> pageMap = new HashMap<String, Object>();
		int page = Integer.parseInt(request.getParameter("page"));
		int rows = Integer.parseInt(request.getParameter("rows"));
		pageMap.put("rktime", request.getParameter("rktime"));
		pageMap.put("rktime1", request.getParameter("rktime1"));
		pageMap.put("lytime", request.getParameter("lytime"));
		pageMap.put("lytime1", request.getParameter("lytime1"));
		pageMap.put("fhtime", request.getParameter("fhtime"));
		pageMap.put("fhtime1", request.getParameter("fhtime1"));
		pageMap.put("state", request.getParameter("state"));
		pageMap.put("ustate", request.getParameter("ustate"));
		pageMap.put("lyr", request.getParameter("lyr"));
		pageMap.put("firm", request.getParameter("firm"));
		pageMap.put("listnum", request.getParameter("listnum"));
		pageMap.put("carNumber", request.getParameter("carNumber"));
		pageMap.put("model", request.getParameter("model"));
		pageMap.put("simNumber", request.getParameter("simNumber"));
		pageMap.put("inspector", request.getParameter("inspector"));
		String department = request.getParameter("department");
		// 获取用户部门编码
		if (StringUtil.isEmpty(department)) {
			User user = (User) request.getSession().getAttribute(
					Const.SESSION_USER);
			department = user.getDepartcode();
		}
		pageMap.put("department", department);
		pageMap.put("test", request.getParameter("test"));
		String packBm = request.getParameter("packBm");
		if (!StringUtil.isEmpty(packBm)) {
			String[] temp = packBm.trim().toUpperCase().split(",");
			pageMap.put("packBm", temp);
		}

		// 排序
		String sort = request.getParameter("sort");
		String order = request.getParameter("order");
		String sortString = "";

		if (!StringUtil.isEmpty(sort) && !StringUtil.isEmpty(order)) {
			sortString = sort + "." + order;
		}
		if (StringUtil.isEmpty(sortString)) {
			sortString = "listnum.asc";
			// packbm.desc,cstime.desc,firm.asc,
		}
		PageBounds pageBounds = new PageBounds(page, rows,
				Order.formString(sortString));
		List<Devices> list = service.getAll(pageMap, pageBounds);
		PageList<Devices> pageList = (PageList<Devices>) list;
		return new EPager<Devices>(pageList.getPaginator().getTotalCount(),
				list);
	}

	/**
	 * 查询设备出口记录
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/getListRecd")
	@ResponseBody
	public List<Devices_record> getListRecd(HttpServletRequest request) {
		String listnum = request.getParameter("listnum");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("listnum", listnum);
		return service.getListRecd(map);
	}

	/**
	 * 根据编号查询
	 * 
	 * @param listnum
	 * @return
	 */
	@RequestMapping("/queryOne")
	@ResponseBody
	public Devices queryOne(String listnum) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("listnum", listnum);
		return service.queryOne(map);
	}

	/**
	 * 设备添加
	 * 
	 * @param devices
	 * @return
	 */
	@RequestMapping(value = "/addDevices", method = { RequestMethod.POST })
	@ResponseBody
	public JsonResult addDevices(Devices devices) {
		int i = 0;
		try {
			if (devices.getAddType() == 1) {
				// List<Devices> lists = new ArrayList<Devices>();
				int begin = Integer.parseInt(devices.getListnum_begin());
				int end = Integer.parseInt(devices.getListnum_end());
				for (int j = begin; j <= end; j++) {
					Devices dev = new Devices();
					dev.setId(UUIDUtils.uuid());
					StringBuilder sb = new StringBuilder();
					sb.append(devices.getListNo());
					// 0 代表前面补充0
					// 4 代表长度为4
					// d 代表参数为正数型
					String str = String.format("%04d", j);
					sb.append(str);
					dev.setListnum(sb.toString());
					dev.setState(devices.getState());
					dev.setFirm(devices.getFirm());// 设备厂商
					dev.setPack(devices.getPack());// 设备包装
					dev.setRktime(devices.getRktime());
					dev.setModel(devices.getModel());// 厂牌型号
					dev.setDepartment(devices.getDepartment());// 所属部门
					i += service.insert(dev);
				}
			} else {
				devices.setId(UUIDUtils.uuid());
				i = service.insert(devices);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new JsonResult(true, "系统异常。");
		}
		if (i > 0) {
			return new JsonResult(true, "创建成功。");
		} else {
			return new JsonResult(false, "该设备号码已经存在。");
		}
	}

	/**
	 * 编辑设备信息
	 * 
	 * @param devices
	 * @return
	 */
	@RequestMapping(value = "/editDevices", method = { RequestMethod.POST })
	@ResponseBody
	public boolean editDevices(Devices devices) { 
		devices.setId(devices.getId());
		devices.setPackBm(devices.getPackBm());
		devices.setState(devices.getState());
		devices.setUstate(devices.getUstate());
		devices.setListnum(devices.getListnum());
		devices.setSimNumber(devices.getSimNumber());
		devices.setDepartment(devices.getDepartment()); 
		devices.setTest(devices.getTest());
		devices.setUstype(devices.getUstype());
		devices.setLyr(devices.getLyr());
		devices.setLytime(devices.getLytime());
		devices.setRemark(devices.getRemark());
		int i = service.edit(devices);
		if (i > 0) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 删除设备
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(value = "/deletes")
	@ResponseBody
	public boolean deletes(@RequestParam(value = "ids[]") String[] ids) {
		int i = service.deletes(ids);
		if (i > 0) {
			return true;
		} else {
			return false;
		}
	}
	/**
	 * 出库
	 * 
	 * @param ids
	 * @param department
	 * @param lyr
	 * @param lytime
	 * @param remark
	 * @return
	 */
	@RequestMapping(value = "/outRep")
	@ResponseBody
	public boolean outRep(@RequestParam(value = "ids[]") String[] ids,
			String state, String site, String department, String lyrid,
			String lyr, String lytime, String remark) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("ids", ids);
		map.put("site", site);
		map.put("state", state);
		map.put("department", department);
		map.put("lyr", lyr);
		map.put("lytime", lytime);
		map.put("remark", remark);
		map.put("lyrid", lyrid);
		int i = service.outRepertory(map);
		if (i > 0) {
			// 保存出入库记录
			service.insert_recordList(map);
			// HashMap<String, Object> maps = new HashMap<String, Object>();
			// maps.put("ids", ids);
			// maps.put("lyr", lyr);
			// maps.put("outtime", lytime);
			// maps.put("remark", remark);
			// maps.put("department", department);
			// simService.useByDevices(maps);
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 测试设备
	 * 
	 * @param ids
	 * @param cstime
	 * @param tresult
	 * @param remark
	 * @param inspector
	 * @param packBm
	 * @param ustype
	 * @return
	 */
	@RequestMapping(value = "/testing", method = { RequestMethod.POST })
	@ResponseBody
	public boolean testing(@RequestParam(value = "ids[]") String[] ids,
			String cstime, String tresult, String remark, String inspector,
			String packBm, String ustype, String simNumber) {
		if (ids.length <= 0) {
			return false;
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ids", ids);
		map.put("cstime", cstime);
		map.put("tresult", tresult);
		map.put("remark", remark);
		map.put("inspector", inspector);
		map.put("ustype", ustype);
		map.put("simNumber", simNumber);
		if (!StringUtil.isEmpty(packBm)) {
			map.put("packBm", packBm.trim().toUpperCase());
		}
		int i = service.testing(map);
		if (i > 0) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 打包设备
	 * 
	 * @param ids
	 * @param packBm
	 * @return
	 */
	@RequestMapping(value = "/pack", method = { RequestMethod.POST })
	@ResponseBody
	public boolean pack(@RequestParam(value = "ids[]") String[] ids,
			String packBm) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ids", ids);
		map.put("packBm", packBm.trim().toUpperCase());
		int i = service.pack(map);
		if (i > 0) {
			return true;
		} else {
			return false;
		}
	}

	@RequestMapping(value = "/packList", method = { RequestMethod.POST })
	@ResponseBody
	public boolean packList(String firm, String cstime, String tresult,
			String remark, String inspector, String packBm, String ustype,
			String listNumber) {
		System.out.println(listNumber);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cstime", cstime);
		map.put("tresult", tresult);
		map.put("remark", remark);
		map.put("inspector", inspector);
		map.put("ustype", ustype);
		map.put("firm", firm);
		if (!StringUtil.isEmpty(packBm)) {
			map.put("packBm", packBm.trim().toUpperCase());
		}
		map.put("rktime", DateUtil.getDate(new Date()));

		String[] temp = listNumber.split("/");
		for (String string : temp) {
			map.put("listNumber", string);
			service.packList(map);
		}
		return true;
	}

	/**
	 * 出入库记录
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/recordList")
	@ResponseBody
	public EPager<Devices_record> getAllRecord(HttpServletRequest request) {
		Map<String, Object> pageMap = new HashMap<String, Object>();
		int page = Integer.parseInt(request.getParameter("page"));
		int rows = Integer.parseInt(request.getParameter("rows"));
		pageMap.put("dev_id", request.getParameter("dev_id"));
		pageMap.put("department", request.getParameter("department"));
		String sortString = " CKTIME.DESC";
		PageBounds pageBounds = new PageBounds(page, rows,
				Order.formString(sortString));
		List<Devices_record> list = service.getAllRecord(pageMap, pageBounds);
		PageList<Devices_record> pageList = (PageList<Devices_record>) list;
		return new EPager<Devices_record>(pageList.getPaginator()
				.getTotalCount(), list);
	}

	/**
	 * 撤回数据
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(value = "/revoke")
	@ResponseBody
	public boolean revoke(HttpServletRequest request,
			@RequestParam(value = "ids[]") String[] ids) {
		User user = (User) request.getSession()
				.getAttribute(Const.SESSION_USER);
		String department = user.getDepartcode();

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("ids", ids);
		map.put("department", department);
		int i = service.revoke(map);
		if (i > 0) {
			return true;
		} else {
			return false;
		}
	}

	@RequestMapping(value = "/isReceive")
	@ResponseBody
	public boolean isReceive(@RequestParam(value = "ids[]") String[] ids,
			HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("ids", ids);
		map.put("receive", "1");
		User user = (User) request.getSession()
				.getAttribute(Const.SESSION_USER);
		map.put("recipient", user.getRealname());
		map.put("receiveTime", DateUtil.getDate(new Date()));
		int i = service.isReceive(map);
		if (i > 0) {
			service.insert_recordList(map);
			return true;
		} else {
			return false;
		}
	}
	
	
}
