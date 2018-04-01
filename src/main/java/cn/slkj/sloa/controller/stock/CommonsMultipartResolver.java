package cn.slkj.sloa.controller.stock;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import cn.slkj.hbsl.util.Const;
import cn.slkj.hbsl.util.javaUtil.StringUtil;
import cn.slkj.sloa.entity.system.User;
import cn.slkj.sloa.service.DevicesService;
import cn.slkj.sloa.service.DispatchService;
import cn.slkj.sloa.service.ProveService;
import cn.slkj.sloa.service.SimService;
import cn.slkj.sloa.util.easyuiUtil.JsonResult;

@Controller
@RequestMapping("/excel")
public class CommonsMultipartResolver {
	@Autowired
	private DevicesService devicesService;
	@Autowired
	private ProveService proveService;
	@Autowired
	private SimService simService;
	@Autowired
	private DispatchService dispatchService;
	

	/**
	 * 导出设备汇总表
	 * 
	 * @param response
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/exporsb")
	public String exporsb(HttpServletResponse response, HttpServletRequest request) {
		response.setContentType("application/binary;charset=ISO8859_1");
		try {
			ServletOutputStream outputStream = response.getOutputStream();
			String fileName = new String(("设备汇总").getBytes(), "ISO8859_1");
			response.setHeader("Content-disposition", "attachment; filename=" + fileName + ".xlsx");// 组装附件名称和格式
			String[] titles = { "出库状态", "使用状态", "厂牌型号", "设备编号", "入库时间", "用途", "领用人", "领用部门", "领用时间", "车牌号", "安装人", "安装时间", "使用公司", "返还时间" };
			HashMap<String, Object> pageMap = new HashMap<String, Object>();
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
				User user = (User) request.getSession().getAttribute(Const.SESSION_USER);
				department = user.getDepartcode();
			}
			pageMap.put("department", department);
			pageMap.put("test", request.getParameter("test"));
			String packBm = request.getParameter("packBm");
			if (!StringUtil.isEmpty(packBm)) {
				String[] temp = packBm.trim().toUpperCase().split(",");
				pageMap.put("packBm", temp);
			}
			devicesService.exportExcel(pageMap, titles, outputStream);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 导出证明汇总表
	 * 
	 * @param response
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/exporzm")
	public String exporzm(HttpServletResponse response, HttpServletRequest request) {
		response.setContentType("application/binary;charset=ISO8859_1");
		try {
			ServletOutputStream outputStream = response.getOutputStream();
			String fileName = new String(("证明汇总").getBytes(), "ISO8859_1");
			response.setHeader("Content-disposition", "attachment; filename=" + fileName + ".xlsx");// 组装附件名称和格式
			String[] titles = { "出库状态", "使用状态", "领用部门", "使用类型", "编号", "出库日期", "领用人", "车牌号", "用途", "开票人", "开票时间", "服务期限", "金额", "备注" };
			HashMap<String, Object> pageMap = new HashMap<String, Object>();
			pageMap.put("number", request.getParameter("number"));
			String department = request.getParameter("department");

			// String state = request.getParameter("state");
			// 获取用户部门编码
			if (StringUtil.isEmpty(department)) {
				User user = (User) request.getSession().getAttribute(Const.SESSION_USER);
				department = user.getDepartcode();
				if ("38".equals(department)) {
					department = "5";
				}
			}
			pageMap.put("state", request.getParameter("state"));
			pageMap.put("department", department);
			pageMap.put("carNumber", request.getParameter("carNumber"));
			pageMap.put("usman", request.getParameter("usman"));
			pageMap.put("startTime", request.getParameter("startTime"));
			pageMap.put("endTime", request.getParameter("endTime"));
			pageMap.put("ustate", request.getParameter("ustate"));
			pageMap.put("ustype", request.getParameter("ustype"));

			proveService.exportExcel(pageMap, titles, outputStream);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 导出SIM汇总表
	 * 
	 * @param response
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/exsim")
	public String exsim(HttpServletResponse response, HttpServletRequest request) {
		response.setContentType("application/binary;charset=ISO8859_1");
		try {
			ServletOutputStream outputStream = response.getOutputStream();
			String fileName = new String(("SIM汇总").getBytes(), "ISO8859_1");
			response.setHeader("Content-disposition", "attachment; filename=" + fileName + ".xlsx");// 组装附件名称和格式
			String[] titles = { "出库状态", "使用状态", "领用部门", "运营商", "卡号", "出库日期", "领用人" };
			HashMap<String, Object> pageMap = new HashMap<String, Object>();
			pageMap.put("telnum", request.getParameter("telnum"));
			pageMap.put("state", request.getParameter("state"));
			pageMap.put("ustate", request.getParameter("ustate"));
			pageMap.put("lyr", request.getParameter("lyr"));
			simService.exportExcel(pageMap, titles, outputStream);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 导出派检单汇总表
	 * 
	 * @param response
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/expordis")
	public String expore(HttpServletResponse response, HttpServletRequest request) {
		response.setContentType("application/binary;charset=ISO8859_1");
		try {
			ServletOutputStream outputStream = response.getOutputStream();
			String fileName = new String(("派检单汇总").getBytes(), "ISO8859_1");
			response.setHeader("Content-disposition", "attachment; filename=" + fileName + ".xlsx");// 组装附件名称和格式
			String[] titles = { "类型","维修状态","派工单号","派修员","派检时间","维修员","维修员电话","车牌号","设备ID","卡号","业户姓名","联系电话","原因","收费" };
			HashMap<String, Object> pageMap = new HashMap<String, Object>();
			pageMap.put("type", request.getParameter("type"));
			pageMap.put("outcome", request.getParameter("outcome"));
			pageMap.put("dispatchNum", request.getParameter("dispatchNum"));
			pageMap.put("operator", request.getParameter("operator"));
			pageMap.put("repairTime", request.getParameter("repairTime"));
			pageMap.put("personnelName", request.getParameter("personnelName"));
			pageMap.put("personnelPhone", request.getParameter("personnelPhone"));
			pageMap.put("carNumber", request.getParameter("carNumber"));
			pageMap.put("deviceId", request.getParameter("deviceId"));
			pageMap.put("sim", request.getParameter("sim"));
			pageMap.put("owner", request.getParameter("owner"));
			pageMap.put("telephone", request.getParameter("telephone"));
			pageMap.put("causes", request.getParameter("causes"));
			pageMap.put("contact", request.getParameter("contact"));
			dispatchService.exportExcel(pageMap, titles, outputStream);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
/**
 * 导入设备
 * @param file
 * @param request
 * @param response
 * @return
 * @throws IOException
 */
	@RequestMapping(value = "/updevices",method = RequestMethod.POST)
	@ResponseBody
	public JsonResult updevices(@RequestParam("fileName")MultipartFile fileName, HttpServletRequest request, HttpServletResponse response) 
	throws IOException{
		if (fileName == null) {
			return null;
		}
		String name = fileName.getOriginalFilename();// 获取上传文件名,包括路径
		// name = name.substring(name.lastIndexOf("\\") + 1);// 从全路径中提取文件名
		long size = fileName.getSize();
		if ((name == null || name.equals("")) && size == 0)
			return null;
		InputStream in = fileName.getInputStream();
		
//		List<Devices> devicesList  = devicesExcelServiceservice.importBrandPeriodSort(in);		
//		int count = devicesList.size();
		int count = devicesService.importBrandPeriodSort(in);	
		
		String strAlertMsg = "";
		if (count != 0) {
			strAlertMsg = "成功导入" + count + "条！";
		} else {
			strAlertMsg = "导入失败！";
		}in.close();System.out.println(strAlertMsg);
		return new JsonResult(true, strAlertMsg);
//		return strAlertMsg;
	}

/**
 * 导入证明
 * @param file
 * @param request
 * @param response
 * @return
 * @throws IOException
 */
	@RequestMapping(value = "/upprove")
	@ResponseBody
	public JsonResult upprove(@RequestParam("file") MultipartFile file, HttpServletRequest request, HttpServletResponse response) 
	throws IOException{
		if (file == null) {
			return null;
		}
		String name = file.getOriginalFilename();// 获取上传文件名,包括路径
		// name = name.substring(name.lastIndexOf("\\") + 1);// 从全路径中提取文件名
		long size = file.getSize();
		if ((name == null || name.equals("")) && size == 0)
			return null;
		InputStream in = file.getInputStream();		
//		List<Prove> devicesList  = proveExcelService.importBrandPeriodSort(in);		
//		int count = devicesList.size();
		int count = proveService.importBrandPeriodSort(in);
		String strAlertMsg = "";
		if (count != 0) {
			strAlertMsg = "成功导入" + count + "条！";
		} else {
			strAlertMsg = "导入失败！";
		}in.close();
		return new JsonResult(true, strAlertMsg);
//		return strAlertMsg;
	}

/**
 * 导入SIM
 * @param excelfile
 * @param request
 * @param response
 * @return
 * @throws IOException
 */
	@RequestMapping(value = "/upsim", method = RequestMethod.POST)
	@ResponseBody
	public JsonResult saveOrUpdate(@RequestParam("file") MultipartFile excelfile, HttpServletRequest request, HttpServletResponse response) 
	throws IOException{
		if (excelfile == null) {
			return null;
		}
		String name = excelfile.getOriginalFilename();// 获取上传文件名,包括路径
		// name = name.substring(name.lastIndexOf("\\") + 1);// 从全路径中提取文件名
		long size = excelfile.getSize();
		if ((name == null || name.equals("")) && size == 0)
			return null;
		InputStream in = excelfile.getInputStream();		
//		List<Sim> simList  = simExcelService.importBrandPeriodSort(in);		
//		int count = simList.size();
		int count = simService.importBrandPeriodSort(in);		
		String strAlertMsg = "";
		if (count != 0) {
			strAlertMsg = "成功导入" + count + "条！";
		} else {
			strAlertMsg = "导入失败！";
		}in.close();System.out.println(strAlertMsg);
		return new JsonResult(true, strAlertMsg);
		//return strAlertMsg;
	}
}
