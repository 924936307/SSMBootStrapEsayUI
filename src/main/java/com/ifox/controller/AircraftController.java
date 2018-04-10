package com.ifox.controller;

import com.ifox.entity.Aircraft;
import com.ifox.entity.Flight;
import com.ifox.service.AircraftService;
import com.ifox.service.FlightService;
import com.ifox.util.DateUtil;
import com.ifox.util.ResponseUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;

/**
 * @Author:zhongchao
 * @Organization: ifox
 * @Description:
 * @Date:Created in16:45 2018/4/10
 * @Modified By:
 */
@Controller
@RequestMapping("/aircraft")
public class AircraftController {

    @Resource
    private AircraftService aircraftService;

    @Resource
    private FlightService flightService;

    private List<Flight> flightList;

    // 定义转换日期类型的输出格式
    private String format = "yyyy-MM-dd";
    private boolean flag = false;
//  private Aircraft aircraft;

    @RequestMapping("/adminAircraftPage")
    public String aircraftList() {
        return "admin/aircraftManage";
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Date.class, new DateUtil());
    }


    @RequestMapping("/save")
    @ResponseBody
    public Object save(Aircraft aircraft, HttpServletResponse response, HttpServletRequest request) {
        JSONObject result = new JSONObject();
        // String id = request.getParameter("id");
        String buyDate = request.getParameter("buyDate");
        String useDate = request.getParameter("useDate");
        //String name = request.getParameter("name");
        // String remark = request.getParameter("remark");
        DateUtil dateUtil = new DateUtil();
        aircraft.setBuydate(dateUtil.formatString(buyDate, format));
        aircraft.setUsedate(dateUtil.formatString(useDate, format));
        // aircraft.setName(name);
        //  aircraft.setRemark(remark);
        Integer i = 0;
        try {
            if (aircraft.getId() == null) {
                i = aircraftService.insertSelective(aircraft);
            } else {
                i = aircraftService.updateByPrimaryKeySelective(aircraft);
            }
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
     * 获得客机的名称
     *
     * @param response
     * @return
     */

    @RequestMapping("/comboList")
    public String comboList(HttpServletResponse response) {
        JSONArray jsonArray = new JSONArray();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", "");
        jsonObject.put("name", "请选择...");
        jsonArray.add(jsonObject);
        List<Aircraft> aircraftList = aircraftService.getAircraftList(new Aircraft());
        JsonConfig jsonConfig = new JsonConfig();
        JSONArray rows = JSONArray.fromObject(aircraftList, jsonConfig);
        jsonArray.addAll(rows);
        ResponseUtil.write(response, jsonArray);
        return null;
    }
}
