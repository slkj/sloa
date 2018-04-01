package cn.slkj.sloa.controller.shfw.call;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;

import cn.slkj.hbsl.util.Const;
import cn.slkj.hbsl.util.javaUtil.StringUtil; 
import cn.slkj.sloa.entity.shfw.Call;
import cn.slkj.sloa.entity.system.User;
import cn.slkj.sloa.service.CallService;
import cn.slkj.sloa.util.easyuiUtil.EPager;
import cn.slkj.sloa.util.easyuiUtil.JsonResult;

/**
 * 客服来电
 * 
 * @author xiaotianliang
 *
 */
@Controller
@RequestMapping("/call")
public class CallController {
	@Autowired
	private CallService callService;

	@RequestMapping("/toCallPage")
	public String toCallPage() {
		return "shfw/call/call";
	}

	@RequestMapping("/toCallAdd")
	public String toCallAdd() {
		return "shfw/call/callAdd";
	}

	/**
	 * 查询客服来电信息列表
	 */
	@RequestMapping("/list")
	@ResponseBody
	public EPager<Call> getAll(HttpServletRequest request) throws Exception {
		Map<String, Object> pageMap = new HashMap<String, Object>();
		int page = Integer.parseInt(request.getParameter("page"));
		int rows = Integer.parseInt(request.getParameter("rows"));
		pageMap.put("askName", request.getParameter("askName"));
		pageMap.put("number", request.getParameter("number"));
		pageMap.put("callTime", request.getParameter("callTime"));
		pageMap.put("conversation", request.getParameter("conversation"));
		pageMap.put("answerName", request.getParameter("answerName"));
		pageMap.put("transferName", request.getParameter("transferName"));
		pageMap.put("department", request.getParameter("department"));
//		String department = request.getParameter("department");
//		// 获取用户部门编码
//		if (StringUtil.isEmpty(department)) {
//			User user = (User) request.getSession().getAttribute(
//					Const.SESSION_USER);
//			department = user.getDepartcode();
//		}
//		pageMap.put("department", department);
		PageBounds pageBounds = new PageBounds(page, rows);
		List<Call> list = callService.getAll(pageMap, pageBounds);
		PageList<Call> pageList = (PageList<Call>) list;
		return new EPager<Call>(pageList.getPaginator().getTotalCount(), list);
	}

	/**
	 * 信息添加
	 * 
	 * @param call
	 * @return
	 */
	@RequestMapping(value = "/addCall", method = { RequestMethod.POST })
	@ResponseBody
	public JsonResult addCall(Call call) {
		int i = 0;
		try {
//			Map<String, Object> pageMap = new HashMap<String, Object>(); 
//			pageMap.put("department", request.getParameter("companyName")); 
			i += callService.insert(call);
		} catch (Exception e) {
			e.printStackTrace();
			return new JsonResult(true, "系统异常。");
		}
		if (i > 0) {
			return new JsonResult(true, "添加成功。");
		} else {
			return new JsonResult(false, "该信息已经存在。");
		}
	}

}
