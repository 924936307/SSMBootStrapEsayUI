package com.ifox.controller;

import com.ifox.entity.Ticketorder;
import com.ifox.entity.User;
import com.ifox.service.TicketOrderService;
import com.ifox.service.UserService;
import com.ifox.util.CookiesUtil;
import com.ifox.util.ResponseUtil;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @Author:zhongchao
 * @Organization: ifox
 * @Description:
 * @Date:Created in16:27 2018/4/10
 * @Modified By:
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Resource
    private UserService userService;

    @Resource
    private TicketOrderService ticketOrderService;

    private User user;
    private Integer currentUserId;
    private List<Ticketorder> ticketorderList;
    private CookiesUtil cookiesUtil = new CookiesUtil();
    private String cookieName = "token";


    @RequestMapping("/test")
    public String test() {
        return "list";
    }

    @RequestMapping("/index")
    public String index() {
        return "login";
    }

    @RequestMapping("/login")
    public String login(User user, HttpServletRequest request, HttpServletResponse response) throws Exception {
        user = userService.login(user);
        JSONObject result = new JSONObject();
        boolean flag = false;
        if (user != null) {
            request.getSession().setAttribute("currentUser", user.getUsername());
            setCurrentUserId(user.getId());
            cookiesUtil.addcookie("token", user.getUsername(), 1800, response);
            flag = true;
        } else {
            request.getSession().setAttribute("message", "用户名或密码有误！！！");
            System.out.println(user.getUsername());
        }
        result.put("success", flag);
        return "main";

       // ResponseUtil.write(response, result);
      //  return "main";
    }

    @RequestMapping("/showUserInfo")
    public String showUserInfo(HttpServletRequest request) {
        HttpSession session = request.getSession();
        Integer currentUserId = getCurrentUserId();
        User userById = userService.getUserById(currentUserId);
        session.setAttribute("user", userById);
        request.setAttribute("mainPage", "userCenter/userInfo.jsp");
        return "main_userCenter";
    }

    @RequestMapping("/save")
    public String save(User user, HttpServletResponse response, HttpServletRequest request) throws Exception {
        System.out.println("user----save-----");
        JSONObject result = new JSONObject();
        String id = request.getParameter("id");
        boolean flag = false;
        Integer i;
        if (id == null) {//添加操作
            i = userService.insertSelective(user);
        } else {//修改操作
            i = userService.updateByPrimaryKeySelective(user);
        }
        if (i > 0) {
            flag = true;
        }
        result.put("success", flag);
        ResponseUtil.write(response, result);
        return null;
    }

    @RequestMapping("/deleteUser")
    public String deleteUser(HttpServletResponse response, HttpServletRequest request) {
        String ids = request.getParameter("ids");
        String[] split = ids.split(",");
        JSONObject result = new JSONObject();
        String message = "用户有订单,不能进行删除操作！";
        String userID = "";
        boolean flag = false;
        int count = 0;
        try {
            for (String i : split) {
                ticketorderList = ticketOrderService.selectListByUserId(Integer.parseInt(i));
                if (ticketorderList.size() > 0) {
                    userID = userID + i + ",";
                    continue;
                } else {
                    Integer integer = userService.deleteByPrimaryKey(Integer.parseInt(i));
                    count++;
                }
            }
            if (count == split.length) {
                flag = true;
                message = "数据已成功删除！";
            } else {
                message = "用户id为" + userID.substring(0, userID.length() - 1) + message;
            }
            result.put("success", flag);
            result.put("message", message);
            ResponseUtil.write(response, result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    @RequestMapping("/userCenter")
    public String userCenter() {
        return "main_userCenter";
    }


    @RequestMapping("/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
        JSONObject result = new JSONObject();
        HttpSession session = request.getSession();
        session.removeAttribute("currentUser");
        session.invalidate();
        cookiesUtil.deleteCookies(cookieName,request, response);
        result.put("success", true);
        ResponseUtil.write(response, result);
        return "main";
    }

    @RequestMapping("/adminManagerPage")
    public String managerList() {
        return "admin/userManage";
    }


    @RequestMapping("/search")
    public String search() {
        return "login";
    }

    public Integer getCurrentUserId() {
        return currentUserId;
    }

    public void setCurrentUserId(Integer currentUserId) {
        this.currentUserId = currentUserId;
    }
}
