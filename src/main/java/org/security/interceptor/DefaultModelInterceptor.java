package org.security.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.LinkedHashMap;
import java.util.Properties;

/**
 * Created with IntelliJ IDEA.
 * User: milky
 * Date: 10/20/13
 * Time: 9:23 PM
 */
public class DefaultModelInterceptor extends HandlerInterceptorAdapter {

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response,
                           Object o, ModelAndView modelAndView) throws Exception {

        if (SecurityContextHolder.getContext() == null)
            return;

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (!(principal instanceof String && principal.equals("anonymousUser")))
            modelAndView.addObject("currentUser", principal);
    }
}
