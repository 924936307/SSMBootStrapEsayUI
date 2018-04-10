package com.ifox.controller;

import com.ifox.entity.Ticketorder;
import com.ifox.service.TicketOrderService;
import com.ifox.util.JsonDateValueProcessor;
import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

/**
 * @Author:zhongchao
 * @Organization: ifox
 * @Description:
 * @Date:Created in16:43 2018/4/10
 * @Modified By:
 */
@Controller
@RequestMapping("/ticketOrder")
public class TicketOrderController {
    @Resource
    private TicketOrderService ticketOrderService;

    private String format = "yyyy-MM-dd HH:mm:ss";
    private JsonDateValueProcessor jsonDateValueProcessor = new JsonDateValueProcessor(format);


    @RequestMapping("/adminTicketOrderPage")
    public String aircraftList() {
        return "admin/ticketOrderManage";
    }


    @RequestMapping("/myTicketOrderList")
    public ModelAndView myTicketOrderList(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        String currentUser = request.getSession().getAttribute("currentUser").toString();
        List<Ticketorder> ticketOrderList = ticketOrderService.getTicketOrderByUserName(currentUser);
        JsonConfig jsonConfig = new JsonConfig();
        jsonConfig.registerJsonValueProcessor(Date.class, jsonDateValueProcessor);
        JSONArray array = JSONArray.fromObject(ticketOrderList, jsonConfig);
        mav.addObject("ticketOrderList", array);
        mav.setViewName("main_userCenter");
        request.setAttribute("mainPage", "ticket/myTicketOrderList.jsp");
        return mav;
    }
}
