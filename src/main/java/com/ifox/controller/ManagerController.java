package com.ifox.controller;

import com.ifox.entity.*;
import com.ifox.service.*;
import com.ifox.util.CookiesUtil;
import com.ifox.util.DateUtil;
import com.ifox.util.JsonDateValueProcessor;
import com.ifox.util.ResponseUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

/**
 * @Author:zhongchao
 * @Organization: ifox
 * @Description:
 * @Date:Created in16:36 2018/4/10
 * @Modified By:
 */
@Controller
@RequestMapping("/manager")
public class ManagerController {
    @Resource
    private ManagerService managerService;

    @Resource
    private UserService userService;

    @Resource
    private FlightService flightService;

    @Resource
    private TicketOrderService ticketOrderService;

    @Resource
    private AircraftService aircraftService;


    private String loginPage = "admin/adminLogin";
    private String format = "yyyy-MM-dd HH:mm:ss";
    private String cookieName = "adminToken";

    private List<Ticketorder> ticketorderList;
    private List<Flight> flightList;

    private CookiesUtil cookiesUtil = new CookiesUtil();

    @RequestMapping("/login")
    public String login(Manager manager, HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        Manager managerUser = managerService.ManagerLogin(manager);
        if (managerUser != null) {
            session.setAttribute("adminUser", managerUser.getUsername());
            session.setAttribute("currentUser", managerUser);
            cookiesUtil.addcookie(cookieName, managerUser.getUsername(), 1800, response);
        } else {
            session.setAttribute("message", "用户名或密码有误！！！");
            return loginPage;
        }
        return "admin/main";
    }


    @RequestMapping("/adminIndex")
    public String adminIndex() {
        return "admin/main";
    }


    @RequestMapping("/logout")
    public String logout(HttpServletResponse response, HttpServletRequest request) {
        JSONObject result = new JSONObject();
        HttpSession session = request.getSession();
        session.invalidate();
        cookiesUtil.deleteCookies(cookieName,request,response);
        result.put("success", true);
        ResponseUtil.write(response, result);
        return null;
    }


    @RequestMapping("/modifyPassword")
    public String modifyPassword(Manager manager, HttpServletRequest request, HttpServletResponse response) {
        JSONObject result = new JSONObject();
        boolean flag = false;
        int i = managerService.modifyPassword(manager.getId());
        if (i > 0) {
            flag = true;
        }
        result.put("success", flag);
        ResponseUtil.write(response, result);
        return null;
    }


    @RequestMapping("/adminUserList")
    public String adminUserList(User user, HttpServletResponse response, HttpServletRequest request) throws Exception {
        PageBean pageBean = new PageBean();
        String page = request.getParameter("page");
        String rows = request.getParameter("rows");
        if (rows != null) {
            pageBean.setPageSize(Integer.parseInt(rows));
            user.setPageSize(pageBean.getPageSize());
        }
        if (page != null) {
            pageBean.setPage(Integer.parseInt(page));
            user.setPage(pageBean.getStart());
        }
        List<User> userList = userService.getUserList(user);
        Integer total = userService.getCount(user);
        JsonConfig jsonConfig = new JsonConfig();
        JSONArray array = JSONArray.fromObject(userList, jsonConfig);
        JSONObject result = new JSONObject();
        result.put("total", total);
        result.put("rows", array);
        ResponseUtil.write(response, result);
        return null;
    }


    @RequestMapping("/adminTicketOrderList")
    public String adminTicketOrderList(Ticketorder ticketorder, HttpServletResponse response, HttpServletRequest request) {
        PageBean pageBean = new PageBean();
        JSONObject result = new JSONObject();
        String page = request.getParameter("page");
        String rows = request.getParameter("rows");
        if (rows != null) {
            pageBean.setPageSize(Integer.parseInt(rows));
            ticketorder.setPageSize(pageBean.getPageSize());
        }
        if (page != null) {
            pageBean.setPage(Integer.parseInt(page));
            ticketorder.setPage(pageBean.getStart());
        }
        try {
            Integer count = ticketOrderService.getCount(ticketorder);
            ticketorderList = ticketOrderService.getList(ticketorder);
            JsonConfig jsonConfig = new JsonConfig();
            jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor(format));
            JSONArray array = JSONArray.fromObject(ticketorderList, jsonConfig);
            result.put("rows", array);
            result.put("total", count);
            ResponseUtil.write(response, result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    @RequestMapping("/adminDeleteTicketOrder")
    public String adminDeleteTicketOrder(HttpServletResponse response, HttpServletRequest request) {
        String ids = request.getParameter("ids");
        String[] split = ids.split(",");
        JSONObject result = new JSONObject();
        boolean flag = false;
        int count = 0;
        try {
            for (String i : split) {
                Integer integer = ticketOrderService.deleteByPrimaryKey(Integer.parseInt(i));
                count++;
            }
            if (count == split.length) {
                flag = true;
            }
            result.put("success", flag);
            ResponseUtil.write(response, result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    @RequestMapping("/adminFlightList")
    public String adminFlightList(HttpServletRequest request, Flight flight, HttpServletResponse response) {
        PageBean pageBean = new PageBean();
        JSONObject result = new JSONObject();
        String page = request.getParameter("page");
        String rows = request.getParameter("rows");
        if (rows != null) {
            pageBean.setPageSize(Integer.parseInt(rows));
            flight.setPageSize(pageBean.getPageSize());
        }
        if (page != null) {
            pageBean.setPage(Integer.parseInt(page));
            flight.setPage(pageBean.getStart());
        }
        if (flight.getFromTime() != null) {
            flight.setFromtime(DateUtil.formatString(flight.getFromTime() + " 00:00:00", format));
        }
        try {
            Integer count = flightService.getCount(flight);
            List<Flight> flightList = flightService.getIndexList(flight);
            JsonConfig jsonConfig = new JsonConfig();
            jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor(format));
            JSONArray array = JSONArray.fromObject(flightList, jsonConfig);
            result.put("rows", array);
            result.put("total", count);
            ResponseUtil.write(response, result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    @RequestMapping("/adminDeleteFlight")
    public String adminDeleteFlight(HttpServletResponse response, HttpServletRequest request) {
        String ids = request.getParameter("ids");
        String[] split = ids.split(",");
        JSONObject result = new JSONObject();
        boolean flag = false;
        String flightId = "";
        String message = "";
        int count = 0;
        try {
            for (String i : split) {
                ticketorderList = ticketOrderService.selectListByFlightId(Integer.parseInt(i));
                if (ticketorderList.size() > 0) {
                    flightId = flightId + i + ",";
                    continue;
                } else {
                    Integer integer = flightService.deleteByPrimaryKey(Integer.parseInt(i));
                    count++;
                }
            }
            if (count == split.length) {
                flag = true;
                message = "数据全部成功删除！";
            } else {
                message = "id为" + flightId.substring(0, flightId.length() - 1) + "的航班有订单任务,不可进行删除操作！";
            }
            result.put("success", flag);
            result.put("message", message);
            ResponseUtil.write(response, result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    @RequestMapping("/deleteAircraft")
    public String deleteAircraft(HttpServletResponse response, HttpServletRequest request) {
        String ids = request.getParameter("ids");
        String[] split = ids.split(",");
        JSONObject result = new JSONObject();
        boolean flag = false;
        String flightId = "";
        String message = "";
        int count = 0;
        try {
            for (String i : split) {
                flightList = flightService.selectListByAircraftId(Integer.parseInt(i));
                if (flightList.size() > 0) {
                    flightId = flightId + i + ",";
                    continue;
                } else {
                    Integer integer = aircraftService.deleteByPrimaryKey(Integer.parseInt(i));
                    count++;
                }
            }
            if (count == split.length) {
                flag = true;
                message = "数据全部成功删除！";
            } else {
                message = "id为" + flightId.substring(0, flightId.length() - 1) + "的客机有航班任务,不可进行删除操作！";
            }
            result.put("success", flag);
            result.put("message", message);
            ResponseUtil.write(response, result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    @RequestMapping("/adminAircraftList")
    public String adminAircraftList(HttpServletRequest request, Aircraft aircraft, HttpServletResponse response) {
        PageBean pageBean = new PageBean();
        JSONObject result = new JSONObject();
        String page = request.getParameter("page");
        String rows = request.getParameter("rows");
        if (rows != null) {
            pageBean.setPageSize(Integer.parseInt(rows));
            aircraft.setPageSize(pageBean.getPageSize());
        }
        if (page != null) {
            pageBean.setPage(Integer.parseInt(page));
            aircraft.setPage(pageBean.getStart());
        }
        try {
            Integer count = aircraftService.getCount(aircraft);
            List<Aircraft> aircraftList = aircraftService.getAircraftList(aircraft);
            JsonConfig jsonConfig = new JsonConfig();
            jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor(format));
            JSONArray array = JSONArray.fromObject(aircraftList, jsonConfig);
            result.put("rows", array);
            result.put("total", count);
            ResponseUtil.write(response, result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    @RequestMapping("/managerLoginPage")
    public String managerLoginPage() {
        return loginPage;
    }

}
