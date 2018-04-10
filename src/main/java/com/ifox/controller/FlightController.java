package com.ifox.controller;

import com.ifox.entity.Flight;
import com.ifox.entity.PageBean;
import com.ifox.entity.Ticketorder;
import com.ifox.service.FlightService;
import com.ifox.util.DateUtil;
import com.ifox.util.PageUtil;
import com.ifox.util.ResponseUtil;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * @Author:zhongchao
 * @Organization: ifox
 * @Description:
 * @Date:Created in16:41 2018/4/10
 * @Modified By:
 */

@Controller
@RequestMapping("/flight")
public class FlightController {

    private HttpServletRequest request;
    private HttpServletResponse response;
    private List<Flight> flightList;
    private List<Ticketorder> ticketorderList;
    private List<Flight> flightList1; // 国内航班
    private List<Flight> flightList2; // 国际航班
    private Flight search_flight;
    private Flight list_flight;
    private Flight index_flight;
    private String flightType1 = "国内航班";
    private String flightType2 = "国际航班";
    private String viewName = "main";
    private String page = null;
    private Integer pageCount;
    private String pageLi2 = "页</a></li>";
    private String pageCode;
    //private PageBean pageBean;
    private PageUtil pageUtil = new PageUtil();
    private String format = "yyyy-MM-dd HH:mm:ss";
    private boolean flag = false;

    @Resource
    private FlightService flightService;


    @RequestMapping("/indexList")
    public ModelAndView indexList() {
        ModelAndView mav = new ModelAndView();
        PageBean pageBean = new PageBean(1, 5);
        index_flight = getFlight(pageBean);
        index_flight.setFlighttype(flightType1);
        flightList1 = flightService.getIndexList(index_flight);
        index_flight.setFlighttype(flightType2);
        flightList2 = flightService.getIndexList(index_flight);
        mav.addObject("flightList1", flightList1);
        mav.addObject("flightList2", flightList2);
        mav.setViewName(viewName);
        return mav;
    }

    @RequestMapping("/search")
    public ModelAndView search(Flight flight, HttpServletRequest request) {
        String page = request.getParameter("page");
        if (page == null) {
            page = "1";
        }
        PageBean pageBean = new PageBean(Integer.parseInt(page), 10);
        flight.setPage(pageBean.getStart());
        flight.setPageSize(pageBean.getPageSize());
        Integer count = flightService.getCount(flight);
        flightList = flightService.getIndexList(flight);
        // getPageNum(count, pageBean);
        ModelAndView mav = getPageCode(count, pageBean, request);
        return mav;
    }


    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest request) {
        PageBean pageBean = null;
        Flight flight = new Flight();
        String page = request.getParameter("page");
        if (page != null) {
            pageBean = new PageBean(Integer.parseInt(page), 10);
        }
        flight.setPage(pageBean.getStart());
        flight.setPageSize(pageBean.getPageSize());
        Integer count = flightService.getCount(flight);
        flightList = flightService.getIndexList(flight);
        // getPageNum(count, pageBean);
        ModelAndView mav = getPageCode(count, pageBean, request);
        return mav;
    }


    @RequestMapping("/save")
    @ResponseBody
    public Object save(Flight flight, HttpServletResponse response, HttpServletRequest request) {
        JSONObject result = new JSONObject();
        String fromTime = request.getParameter("fromTime");
        String toTime = request.getParameter("toTime");
        DateUtil dateUtil = new DateUtil();
        flight.setFromtime(dateUtil.formatString(fromTime, format));
        flight.setTotime(dateUtil.formatString(toTime, format));

        Integer i = 0;
        System.out.println("=========" + flight.getId());
        try {
            if (flight.getId() == null) {//用户添加
                String fcTicketTotal = request.getParameter("fctickettotal");
                String ecTicketTotal = request.getParameter("ectickettotal");
                flight.setEcticketremain(Integer.parseInt(ecTicketTotal));
                flight.setFcticketremain(Integer.parseInt(fcTicketTotal));
                i = flightService.insertSelective(flight);
            } else {//用户修改
                i = flightService.updateByPrimaryKeySelective(flight);
            }
            System.out.println("====flight====updateOrAdd===" + i);
            if (i > 0) {
                flag = true;
            }
            result.put("success", flag);
            ResponseUtil.write(response, result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 获得分页的信息
     *
     * @param total
     * @param pageBean
     * @param request
     * @return
     */

    private ModelAndView getPageCode(Integer total, PageBean pageBean, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        pageCount = total % pageBean.getPageSize() == 0 ? total / pageBean.getPageSize()
                : total / pageBean.getPageSize() + 1;
        request.setAttribute("mainPage", "flight/flightList.jsp");
        pageCode = PageUtil.genPaginationNoParam(request.getContextPath() + "/flight/list", total, pageBean.getPage(),
                pageBean.getPageSize()).toString();
        mav.addObject("flightList", flightList);
        mav.addObject("pageCode", pageCode + pageCount + pageLi2);
        mav.setViewName(viewName);
        return mav;
    }

    /**
     * 获得实体
     *
     * @param pageBean
     * @return
     */

    private Flight getFlight(PageBean pageBean) {
        Flight flight = new Flight();
        flight.setPage(pageBean.getStart());
        flight.setPageSize(pageBean.getPageSize());
        return flight;
    }


    @RequestMapping("/adminFlightPage")
    public String adminFlightPage() {
        return "admin/flightManage";
    }

}
