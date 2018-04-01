package cn.slkj.sloa.controller.system.login;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.ParseException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import cn.slkj.hbsl.util.AppUtil;
import cn.slkj.hbsl.util.Const;
import cn.slkj.hbsl.util.PageData;
import cn.slkj.hbsl.util.Tools;
import cn.slkj.sloa.controller.system.base.BaseController;
import cn.slkj.sloa.entity.system.User;
import cn.slkj.sloa.service.UserService;
import net.sf.json.JSONObject;

@Controller
//@SessionAttributes(Const.SESSION_USER)
public class LoginController extends BaseController {

	@Resource
	private UserService userService;

	@RequestMapping("/login_toLogin")
	public String toLogin(HttpServletRequest request) { 
		return "login";
	}
	@RequestMapping("/Welcome")
	public String Welcome(HttpServletRequest request) { 
		return "Welcome";
	}
	/**
	 * 
	 * @param code
	 * @param modelMap
	 * @return
	 * @throws ParseException
	 * @throws URISyntaxException
	 * @throws ClientProtocolException
	 * @throws IOException
	 */
	@ResponseBody
	@RequestMapping(value = "/goDingLogin")
	public boolean goDingLogin(String code, HttpSession session) throws ParseException, IOException, URISyntaxException {
		// 3.获取了code后，根据code和access_token来获取钉钉用户的个人信息，用下面的方法获取token
		String token = getToken();// 获取token
		// 获取用户信息
		HttpClient httpClient = new DefaultHttpClient();
		URI url = new URI("https://oapi.dingtalk.com/user/getuserinfo?access_token=" + token + "&code=" + code);
		HttpGet get = new HttpGet(url);
		HttpResponse response = httpClient.execute(get);
		HttpEntity entity = response.getEntity();
		if (entity != null) {
			JSONObject jsonObject = JSONObject.fromObject(EntityUtils.toString(entity));
			if (null != jsonObject.getString("userid")) {
				User user = userService.goDingLogin(jsonObject.getString("userid"));
				if (user != null) {
					System.out.println("-----------------" + user.toString());
					session.removeAttribute(Const.SESSION_USER);
					session.setAttribute(Const.SESSION_USER, user);
					return true;
				} else {
					return false;
				}
			}
		}
		return false;
	}

	// 获取token的方法
	public static String getToken() throws URISyntaxException, ClientProtocolException, IOException {
		HttpClient httpClient = new DefaultHttpClient();
		URI url = new URI("https://oapi.dingtalk.com/gettoken?corpid=ding7265dba91f03ed02&corpsecret=j9tFTUwPqrHoqawQfV_AoTskGBOsH62sgTpEVZCI8Sf63anOUZMAcBd4LZlN1L94");
		HttpGet get = new HttpGet(url);
		HttpResponse response = httpClient.execute(get);
		HttpEntity entity = response.getEntity();
		if (entity != null) {
			JSONObject jsonObject = JSONObject.fromObject(EntityUtils.toString(entity));
			if (jsonObject.getInt("errcode") == 0) {
				return jsonObject.getString("access_token").toString();
			}
		}
		return null;
	}

	/**
	 * 请求登录，验证用户
	 */
	@RequestMapping(value = "/login_login")
	@ResponseBody
	public Object login(HttpSession session) {
		String errInfo = "";

		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("username", pd.getString("username"));
		pd.put("password", pd.getString("password"));
		User user = userService.userLogin(pd);

		if (user != null) {
			System.out.println("-----------------" + user.toString());
			session.removeAttribute(Const.SESSION_USER);
			session.setAttribute(Const.SESSION_USER, user);
			// session.removeAttribute(Const.SESSION_SECURITY_CODE);
		} else {
			errInfo = "usererror"; // 用户名或密码有误
		}

		if (Tools.isEmpty(errInfo)) {
			errInfo = "success"; // 验证成功
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("result", errInfo);
		return AppUtil.returnObject(new PageData(), map);
	}

	@RequestMapping("/index")
	public String index() {
		return "index";
	}

	/**
	 * 用户注销
	 * 
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/logout")
	public ModelAndView logout(HttpSession session) {
		ModelAndView mv = this.getModelAndView();
		session.removeAttribute(Const.SESSION_USER);
		mv.setViewName("login");
		return mv;
	}
}