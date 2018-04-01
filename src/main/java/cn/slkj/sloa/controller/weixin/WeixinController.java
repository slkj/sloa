package cn.slkj.sloa.controller.weixin;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.annotation.JSONField;
import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;

import cn.slkj.hbsl.util.javaUtil.date.DateStyle;
import cn.slkj.hbsl.util.javaUtil.date.DateUtil;
import cn.slkj.sloa.entity.shfw.Fees;
import cn.slkj.sloa.entity.shfw.Weixin;
import cn.slkj.sloa.entity.system.Company;
import cn.slkj.sloa.entity.vehicle.Vehicle;
import cn.slkj.sloa.service.CompanyService;
import cn.slkj.sloa.service.FeesService;
import cn.slkj.sloa.service.VehicleService;
import cn.slkj.sloa.service.WeixinService;
import cn.slkj.sloa.util.easyuiUtil.EPager;
import cn.slkj.sloa.util.easyuiUtil.JsonResult;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/weixin")
public class WeixinController {

	@Autowired
	private WeixinService weixinService;
	@Autowired
	private FeesService feesService;
	@Resource
	private VehicleService vehicleService;
	@Resource
	private CompanyService companyService;

	@RequestMapping("/order/toOrderPage")
	public String toFeesPage() {
		return "weixin/orders";
	}

	@RequestMapping("/order/toOrderAdd")
	public String toOrderAdd() {
		return "weixin/ordersAdd";
	}

	@RequestMapping("/order/toOrderEdit")
	public String toOrderEdit() {
		return "weixin/ordersEdit";
	}

	/**
	 * 微信订单列表
	 */
	@RequestMapping("/list")
	@ResponseBody
	public EPager<Weixin> getAll(HttpServletRequest request, HttpServletResponse response) throws Exception {

		Map<String, Object> pageMap = new HashMap<String, Object>();
		int page = Integer.parseInt(request.getParameter("page"));
		int rows = Integer.parseInt(request.getParameter("rows"));
		pageMap.put("orderNumber", request.getParameter("orderNumber"));
		pageMap.put("wx_type", request.getParameter("wx_type"));
		pageMap.put("carNumber", request.getParameter("carNumber"));
		pageMap.put("pay_riqiStart", request.getParameter("riqiStart"));
		pageMap.put("pay_riqiEnd", request.getParameter("riqiEnd"));

		pageMap.put("state", request.getParameter("state"));
		pageMap.put("type", request.getParameter("type"));
		PageBounds pageBounds = new PageBounds(page, rows);
		List<Weixin> list = weixinService.getAll(pageMap, pageBounds);
		PageList<Weixin> pageList = (PageList<Weixin>) list;
		return new EPager<Weixin>(pageList.getPaginator().getTotalCount(), list);
	}

	public static void main(String[] args) {
		try {

			String result = httpPostWithJSON("http://localhost:8080/sloa//weixin/getGroupBz");
			System.out.println(result);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public static String httpPostWithJSON(String url) throws Exception {

		HttpPost httpPost = new HttpPost(url);
		CloseableHttpClient client = HttpClients.createDefault();
		String respContent = null;
		// json方式
		JSONObject jsonParam = new JSONObject();
		// jsonParam.put("page", "1");
		jsonParam.put("compName", "NEW");
		// jsonParam.put("rows", "10");
		StringEntity entity = new StringEntity(jsonParam.toString(), "utf-8");// 解决中文乱码问题
		entity.setContentEncoding("UTF-8");
		entity.setContentType("application/json");
		httpPost.setEntity(entity);
		System.out.println();

		HttpResponse resp = client.execute(httpPost);
		if (resp.getStatusLine().getStatusCode() == 200) {
			HttpEntity he = resp.getEntity();
			respContent = EntityUtils.toString(he, "UTF-8");
		}
		return respContent;
	}

	/**
	 * 根据车牌号查询订单列表
	 */
	@RequestMapping("/getList")
	@ResponseBody
	public EPager<Weixin> getList(String carNumber, @RequestParam(required = false, defaultValue = "1") Integer page, // 第几页
			@RequestParam(required = false, defaultValue = "10") Integer rows) throws Exception {
		Map<String, Object> pageMap = new HashMap<String, Object>();
		pageMap.put("carNumber", carNumber);
		PageBounds pageBounds = new PageBounds(page, rows);
		List<Weixin> list = weixinService.getAll(pageMap, pageBounds);
		PageList<Weixin> pageList = (PageList<Weixin>) list;
		return new EPager<Weixin>(pageList.getPaginator().getTotalCount(), list);
	}
	@ResponseBody
	@RequestMapping(value = "/getGroupBz")
	public EPager<Company> list(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int page = Integer.parseInt(request.getParameter("page"));
		int rows = Integer.parseInt(request.getParameter("rows"));
		// String name
		// =EncodingTool.encodeStr(request.getParameter("compName"));
		String name = request.getParameter("compName");
		map.put("compName", name);

		String sortString = "compName.asc";
		PageBounds pageBounds = new PageBounds(page, rows, Order.formString(sortString));
		List<Company> list = companyService.getAll(map, pageBounds);
		PageList pageList = (PageList) list;
		return new EPager<Company>(pageList.getPaginator().getTotalCount(), list);
	}
	 
	 

	/**
	 * 查询车辆收费标准
	 */
	@RequestMapping(value = "/getCarFees")
	@ResponseBody
	public JSONObject getCarBz(HttpServletRequest request, HttpServletResponse response) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		String carNumber = request.getParameter("carNumber");
		map.put("carNumber", carNumber);
		Vehicle bean = vehicleService.queryOne(map);

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		if (bean == null) {
			jsonMap.put("msg", "未查询到该车辆新信息");
			jsonMap.put("success", false);
		} else {
			jsonMap.put("id", bean.getId());
			jsonMap.put("carNumber", bean.getCarNumber());
			jsonMap.put("companyId", bean.getCompanyId() == null ? "" : bean.getCompanyId());
			jsonMap.put("companyName", bean.getCompanyName() == null ? "" : bean.getCompanyName());
			jsonMap.put("carOwner", bean.getCarOwner() == null ? "" : bean.getCarOwner());
			jsonMap.put("contacts", bean.getContacts() == null ? "" : bean.getContacts());
			jsonMap.put("feeseEnd", bean.getFeeseEnd() == null ? "" : bean.getFeeseEnd());
			jsonMap.put("colAmounts", bean.getUprice());
		}
		JSONObject jsonObject = JSONObject.fromObject(jsonMap);
		return jsonObject;
	}

	/**
	 * 上传订单
	 * 
	 * @return
	 */
	@RequestMapping(value = "/uporder")
	@ResponseBody
	public JsonResult uporder(Integer id, Integer state, Integer type, String carNumber, String owner, String purpose, String phone, String deadline, String prove, String remark, String riqi, String orderNumber, String openId, String wx_type, String price) {
		int i = 0;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("state", state);
		map.put("type", type);
		map.put("carNumber", carNumber);
		map.put("owner", owner);
		map.put("purpose", purpose);
		map.put("phone", phone);
		map.put("deadline", deadline);
		map.put("prove", prove);
		map.put("remark", remark);
		map.put("riqi", riqi);
		map.put("openId", openId);
		map.put("wx_type", wx_type);

		map.put("price", price);
		map.put("orderNumber", orderNumber);
		i = weixinService.add(map);
		if (i > 0) {
			return new JsonResult(true, "操作成功。");
		} else {
			return new JsonResult(false, "失败！");
		}
	}

	@RequestMapping(value = "/updateSfbz")
	@ResponseBody
	public JsonResult updateSfbz(String orderNumber, Integer state, Integer type, String carNumber, String owner, String purpose, String phone, String deadline, String prove, String remark, Double colAmounts, String riqi, String payee, String qr_time) {
		int i = 0;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orderNumber", orderNumber);
		map.put("colAmounts", colAmounts);

		i = weixinService.updateSfbz(map);
		if (i > 0) {
			return new JsonResult(true, "修改成功。");
		} else {
			return new JsonResult(false, "失败！");
		}
	}

	/**
	 * 微信支付后修改支付状态
	 *
	 * @return
	 */
	@RequestMapping(value = "/pay")
	public @ResponseBody JsonResult pay(String orderNumber, Integer state, String pay_time, String tradeNo) {
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("orderNumber", orderNumber);
			map.put("state", state);
			map.put("tradeNo", tradeNo);
			String entryTime = DateUtil.DateToString(new Date(), DateStyle.YYYY_MM_DD_HH_MM_SS);
			map.put("pay_time", entryTime);
			int i = 0;
			i += weixinService.pay(map);
			if (i > 0) {

				return new JsonResult(true, "操作成功。");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new JsonResult(false, "系统异常，操作失败！");
		}
		return new JsonResult(false, "操作失败！");
	}

	/**
	 * 微信支付后修改支付状态
	 *
	 * @return
	 */
	@RequestMapping(value = "/editSate")
	public @ResponseBody JsonResult editSate(String orderNumber, Integer state, String price) {
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("orderNumber", orderNumber);
			map.put("state", state);
			map.put("price", price);
			int i = 0;
			i += weixinService.editSate(map);
			if (i > 0) {

				return new JsonResult(true, "操作成功。");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new JsonResult(false, "系统异常，操作失败！");
		}
		return new JsonResult(false, "操作失败！");
	}
}
