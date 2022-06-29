package com.kiku.springmall.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kiku.springmall.service.MemberDTO;

public class CartInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		
		MemberDTO member = (MemberDTO)session.getAttribute("member");
		
		if(member == null) {
			response.sendRedirect("/login.do");
			return false;
		} else {
			return true;
		}
	}
	
}
