package cn.slkj.sloa.exilve;

import java.io.IOException;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.http.Consts;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.conn.tsccm.ThreadSafeClientConnManager;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import cn.slkj.hbsl.util.JSONUtils;

/**
 * Created by maxh on 2016-11-15. 调用exlive平台数据接口
 */
public class ExliveAPI {
	// 登录
	private String sgUrl = "http://vip4.exlive.cn/synthReports/mobile_to_synth/zdyloginAction_autologin.action?";
	// 根据车牌号模糊查询
	private String veUrl = "http://vip4.exlive.cn/synthReports/mobile_to_synth/mobileTosynthAction_find.action?tableName=vehicle";
	// 查询客户列表
	private String clientUrl = "http://vip4.exlive.cn/synthReports/mobile_to_synth/mobileTosynthAction_find.action?tableName=client";
	// 查询分组列表
	private String groupUrl = "http://vip4.exlive.cn/synthReports/mobile_to_synth/mobileTosynthAction_find.action?tableName=group";
	// 添加车辆
	private String carAddUrl = "http://vip4.exlive.cn/synthReports/mobile_to_synth/mobileTosynthAction_add.action?tableName=vehicle";

	private String param = "";
	private List<NameValuePair> loginNvps;

	public ExliveAPI() {
	}

	public ExliveAPI(String serverId, String userName, String userPwd) {
		this.sgUrl = sgUrl + "puser.userName=" + userName + "&puser.userPwd=" + userPwd + "&puser.serverId=" + serverId + "&pt=1";
		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		nvps.add(new BasicNameValuePair("serverId", serverId));
		nvps.add(new BasicNameValuePair("userName", userName));
		nvps.add(new BasicNameValuePair("userPwd", userPwd));
		this.loginNvps = nvps;

	}

	public ExliveAPI(String serverId, String userName, String userPwd, String param) {
		this.sgUrl = sgUrl + "puser.userName=" + userName + "&puser.userPwd=" + userPwd + "&puser.serverId=" + serverId + "&pt=1";
		this.param = param;
	}

	/**
	 * 获取企业平台客戶数据
	 * 
	 * @return
	 */
	public String getClient() {
		try {
			return dyExlive(loginNvps, clientUrl, new ArrayList<NameValuePair>());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 获取企业平台分组数据
	 * 
	 * @return
	 */
	public String getGroup() {
		try {

			return dyExlive(loginNvps, groupUrl, new ArrayList<NameValuePair>());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public String getVehicle(String url) {
		try {
			// veUrl += "vehicle.ClientId="+ClientId+"&exkey=";
			veUrl += url;
			return toExlive(sgUrl, veUrl);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	private String dyExlive(List<NameValuePair> loginNvps, String dataUrl, List<NameValuePair> scNvps) throws Exception {
		String respContent = "通信失败"; // 响应内容
		DefaultHttpClient httpclient = new DefaultHttpClient(new ThreadSafeClientConnManager());
		try {

			HttpPost httpost = new HttpPost(sgUrl);
			// 登录添加参数
			// List<NameValuePair> nvps = new ArrayList<NameValuePair>();
			// 设置请求的编码格式
			httpost.setEntity(new UrlEncodedFormEntity(loginNvps, Consts.UTF_8));
			// 登录一遍
			HttpResponse response = httpclient.execute(httpost); // 执行GET请求
			HttpEntity entity = response.getEntity(); // 获取响应实体
			if (null != entity) {
				Charset respCharset = ContentType.getOrDefault(entity).getCharset();
				respContent = EntityUtils.toString(entity, respCharset);
				EntityUtils.consume(entity);
			}
			HashMap map = JSONUtils.toHashMap(respContent);
			// 然后再第二次请求普通的url即可。
			httpost = new HttpPost(dataUrl);
			scNvps.add(new BasicNameValuePair("exkey", map.get("exkey") + ""));
			httpost.setEntity(new UrlEncodedFormEntity(scNvps, Consts.UTF_8));
			BasicResponseHandler responseHandler = new BasicResponseHandler();
			return httpclient.execute(httpost, responseHandler);
		} finally {
			// 关闭请求
			httpclient.getConnectionManager().shutdown();
		}
	}

	/**
	 * @param keyUrl
	 *            获取登录exkey
	 * @param dataUrl
	 *            获取数据url
	 * @return 字符串
	 * @throws Exception
	 */
	private String toExlive(String keyUrl, String dataUrl) throws Exception {
		String respContent = "通信失败"; // 响应内容
		DefaultHttpClient httpclient = new DefaultHttpClient(new ThreadSafeClientConnManager());
		try {

			HttpPost httpost = new HttpPost(keyUrl);
			// 添加参数
			List<NameValuePair> nvps = new ArrayList<NameValuePair>();
			// 设置请求的编码格式
			httpost.setEntity(new UrlEncodedFormEntity(nvps, Consts.UTF_8));
			// 登录一遍
			HttpResponse response = httpclient.execute(httpost); // 执行GET请求
			HttpEntity entity = response.getEntity(); // 获取响应实体
			if (null != entity) {
				Charset respCharset = ContentType.getOrDefault(entity).getCharset();
				respContent = EntityUtils.toString(entity, respCharset);
				EntityUtils.consume(entity);
			}
			HashMap map = JSONUtils.toHashMap(respContent);
			// 然后再第二次请求普通的url即可。
			httpost = new HttpPost(dataUrl + "&exkey=" + map.get("exkey"));
			BasicResponseHandler responseHandler = new BasicResponseHandler();
			return httpclient.execute(httpost, responseHandler);
		} finally {
			// 关闭请求
			httpclient.getConnectionManager().shutdown();
		}
	}

	public String carAdd2Exlive(List<NameValuePair> nvps) throws ClientProtocolException, IOException {
		String respContent = "通信失败"; // 响应内容
		DefaultHttpClient httpclient = new DefaultHttpClient(new ThreadSafeClientConnManager());
		try {

			HttpPost httpost = new HttpPost(sgUrl);
			// 添加参数
			// List<NameValuePair> nvps = new ArrayList<NameValuePair>();
			// 设置请求的编码格式
			httpost.setEntity(new UrlEncodedFormEntity(new ArrayList<NameValuePair>(), Consts.UTF_8));
			// 登录一遍
			HttpResponse response = httpclient.execute(httpost); // 执行GET请求
			HttpEntity entity = response.getEntity(); // 获取响应实体
			if (null != entity) {
				Charset respCharset = ContentType.getOrDefault(entity).getCharset();
				respContent = EntityUtils.toString(entity, respCharset);
				EntityUtils.consume(entity);
			}
			HashMap map = JSONUtils.toHashMap(respContent);

			// 然后再第二次请求普通的url即可。
			httpost = new HttpPost(carAddUrl);
			nvps.add(new BasicNameValuePair("exkey", map.get("exkey") + ""));
			httpost.setEntity(new UrlEncodedFormEntity(nvps, Consts.UTF_8));
			BasicResponseHandler responseHandler = new BasicResponseHandler();
			return httpclient.execute(httpost, responseHandler);
		} finally {
			// 关闭请求
			httpclient.getConnectionManager().shutdown();
		}
	}

}
