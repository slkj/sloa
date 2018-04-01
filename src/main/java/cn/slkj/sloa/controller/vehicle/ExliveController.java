package cn.slkj.sloa.controller.vehicle;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.message.BasicNameValuePair;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.slkj.sloa.entity.system.Company;
import cn.slkj.sloa.entity.system.Group;
import cn.slkj.sloa.exilve.ExliveAPI;
import cn.slkj.sloa.util.easyuiUtil.JsonResult;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/exlive")
public class ExliveController {
	@ResponseBody
	@RequestMapping(value = "/getGroup")
	public Map<String, Object> getGroup(String serverId, String userName, String userPwd) {
		List<Company> listCom = new ArrayList<>();
		List<Group> listGroup = new ArrayList<>();
		// 调用接口获取企业平台数据，用户登录初始化，获取exkey
		ExliveAPI exliveAPI = new ExliveAPI(serverId, userName, userPwd);
		// 返回客户数据
		String clientString = exliveAPI.getClient();
		JSONObject object = JSONObject.fromObject(clientString);
		String json = object.getString("data");
		JSONArray myJsonArray = JSONArray.fromObject(json);

		for (int i = 0; i < myJsonArray.size(); i++) {
			// 获取每一个JsonObject对象
			JSONObject myjObject = myJsonArray.getJSONObject(i);
			// 获取数组中对象的对象
			int id = myjObject.getInt("id");
			String name = myjObject.getString("compyname");
			Company company = new Company();
			company.setId(id + "");
			company.setCompName(name);
			listCom.add(company);
		}

		// 调用接口获取企业平台数据，用户登录初始化，获取exkey
		ExliveAPI exliveAPI1 = new ExliveAPI(serverId, userName, userPwd);
		// 返回客户数据
		String clientString1 = exliveAPI1.getGroup();
		JSONObject object1 = JSONObject.fromObject(clientString1);
		String json1 = object1.getString("data");
		JSONArray myJsonArray1 = JSONArray.fromObject(json1);

		for (int i = 0; i < myJsonArray1.size(); i++) {
			// 获取每一个JsonObject对象
			JSONObject myjObject = myJsonArray1.getJSONObject(i);
			// 获取数组中对象的对象
			int id = myjObject.getInt("id");
			String name = myjObject.getString("groupName");
			Group group = new Group();
			group.setId(id);
			group.setName(name);
			listGroup.add(group);
		}
		Map<String, Object> modelMap = new HashMap<String, Object>(3);
		modelMap.put("msg", "");
		modelMap.put("success", "true");
		modelMap.put("listCom", listCom);
		modelMap.put("listGroup", listGroup);
		return modelMap;
	}

	@ResponseBody
	@RequestMapping(value = "/addToExlive")
	public JsonResult addToExlive(String serverId, String userName, String userPwd, String carName, String gprs, String cpys, String sim, String clientID, String mobileId, String vehicleTypeId, String goupListPage) throws ClientProtocolException, IOException {
	 
		String param = "&goupListPage=" + goupListPage;
		// 调用接口获取企业平台数据，用户登录初始化，获取exkey
		ExliveAPI exliveAPI = new ExliveAPI(serverId, userName, userPwd, param);

		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		nvps.add(new BasicNameValuePair("vehicel.carName", carName));
		nvps.add(new BasicNameValuePair("vehicel.clientID", clientID));
		nvps.add(new BasicNameValuePair("vehicel.gprs", gprs));
		nvps.add(new BasicNameValuePair("vehicel.sim", sim));
		nvps.add(new BasicNameValuePair("vehicel.mobileId", mobileId));
		nvps.add(new BasicNameValuePair("vehicel.vehicleTypeId", vehicleTypeId));
		// nvps.add(new BasicNameValuePair("vehicel.overduetime", "2018-08-08 12:12:22"));
		// nvps.add(new BasicNameValuePair("vehicel.colorId", colorId));
		nvps.add(new BasicNameValuePair("vehicel.vhcofflinemin", "10"));
		nvps.add(new BasicNameValuePair("sccj", "10"));
		nvps.add(new BasicNameValuePair("cpys", cpys));
		
		nvps.add(new BasicNameValuePair("goupListPage", goupListPage));
		// 返回客户数据    
		String clientString = exliveAPI.carAdd2Exlive(nvps);
		JSONObject object = JSONObject.fromObject(clientString);
		String msg = object.getString("msg");
		boolean flag = object.getBoolean("flag");
		if (flag) {
			return new JsonResult(true, msg);
		}

		return new JsonResult(false, msg);
	}

}
