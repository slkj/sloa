package cn.slkj.sloa.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import cn.slkj.hbsl.util.Const;
import cn.slkj.sloa.entity.system.User;

public class LoginHandlerInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		// TODO Auto-generated method stub

//		if (request.getHeader("x-requested-with") != null 
//				&& request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")) {
//			response.setHeader("sessionstatus", "timeout");// 在响应头设置session状态
//			response.getWriter().print("timeout"); // 打印一个返回值，
//			return true;
//		}
		
		 

		String path = request.getServletPath();
		if (path.matches(Const.NO_INTERCEPTOR_PATH) || path.isEmpty()) {
			return true;
		} else {
			HttpSession session = request.getSession(true);
			User user = (User) session.getAttribute(Const.SESSION_USER);
			if (user == null) {
				// 登陆过滤
				response.sendRedirect(request.getContextPath() + Const.LOGIN);
			}
			return true;
		}
	}

}
