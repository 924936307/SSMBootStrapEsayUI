package com.ifox.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @Author:zhongchao
 * @Organization: ifox
 * @Description:
 * @Date:Created in16:07 2018/4/10
 * @Modified By:
 */
public class CookiesUtil {
    /**
     * 添加cookies
     *
     * @param key
     * @param value
     * @param time
     * @param response
     */
    public void addcookie(String key, String value, int time, HttpServletResponse response) {
        Cookie cookieToken = new Cookie(key, value);
        cookieToken.setMaxAge(time);
        cookieToken.setPath("/");
        response.addCookie(cookieToken);
    }

    /**
     * 删除对应的cookies信息
     *
     * @param request
     * @param response
     */
    public void deleteCookies(String cookieName, HttpServletRequest request, HttpServletResponse response) {
        Cookie[] cookies = request.getCookies();
        if (null == cookies) {
            System.out.println("没有cookie==============");
        } else {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(cookieName)) {
                    cookie.setValue(null);
                    cookie.setMaxAge(0);// 立即销毁cookie
                    cookie.setPath("/");
                    System.out.println("被删除的cookie名字为:" + cookie.getName());
                    response.addCookie(cookie);
                    break;
                }
            }
        }
    }
}
