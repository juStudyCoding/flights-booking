package com.erp.app.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class CommonInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		boolean result = true;
        String uri = request.getRequestURI().toString().trim();
        
        try {     
        	// 세션이 유지될 경우
        	if (uri.equals("/") || uri.equals("/login") || uri.equals("/signUp") || uri.equals("/navercallback")|| uri.equals("/naverInfo")){
        		if(request.getSession().getAttribute("LoginInfo") != null ){

                    response.sendRedirect("/main");  
                    result =  false;
                }else{ 
                    result =  true;
                }
        	}
        	else if(uri.equals("/findUserInfo")) {
                result =  true;
        	}
            //세션값이 널일경우
            else if(request.getSession().getAttribute("LoginInfo") == null ){
        		
                response.sendRedirect("/");  
                result =  false;
                 
            }else{ 
                result =  true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            result = false;
        }   
        return result;
	}


}
