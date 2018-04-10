package com.ifox.filter;


import javax.servlet.*;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
/**
 * @Author:zhongchao
 * @Organization: ifox
 * @Description:
 * @Date:Created in16:05 2018/4/10
 * @Modified By:
 */
public class CookiesFilter implements Filter {
    public void destroy() {

    }


    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        System.out.println(request.getRequestURI());
        String requestURI = request.getRequestURI();
        if (!(requestURI.indexOf("/manager/") > -1)) {
            chain.doFilter(request, response);
            return;
        } else {
            if (requestURI.indexOf("/manager/managerLoginPage") > -1 || requestURI.indexOf("/manager/login") > -1) {
                chain.doFilter(request, response);
                return;
            }
            if (request.getCookies() != null) {
                Cookie[] cs = request.getCookies();
                System.out.println(cs.length);
                if (cs != null && cs.length > 0) {
                    for (Cookie c : cs) {
                        String cName = c.getName();
                        System.out.println(cName);
                        if (cName.equals("adminToken")) {
                            chain.doFilter(request, response);
                            return;
                        }
                    }
                }
            }
        }
        response.sendRedirect("/MavenDemo/manager/managerLoginPage");
    }

    public void init(FilterConfig arg0) throws ServletException {

    }
}
