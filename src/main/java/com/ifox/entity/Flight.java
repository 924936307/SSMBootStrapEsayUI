package com.ifox.entity;

import java.util.Date;

/**
 * @Author:zhongchao
 * @Organization: ifox
 * @Description:
 * @Date:Created in16:03 2018/4/10
 * @Modified By:
 */
public class Flight {
    private Integer id;
    private Integer ecprice;
    private Integer ecticketremain;
    private Integer ectickettotal;
    private Integer fcprice;
    private Integer fcticketremain;
    private Integer fctickettotal;
    private String flighttype;
    private String fromcity;
    private Date fromtime;
    private String fromTime;
    private String name;
    private String tocity;
    private Date totime;
    private Integer aircraftid;//客机的id
    private String aircraftname;//客机的名称
    private Integer page;
    private Integer pageSize;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getEcprice() {
        return ecprice;
    }

    public void setEcprice(Integer ecprice) {
        this.ecprice = ecprice;
    }

    public Integer getEcticketremain() {
        return ecticketremain;
    }

    public void setEcticketremain(Integer ecticketremain) {
        this.ecticketremain = ecticketremain;
    }

    public Integer getEctickettotal() {
        return ectickettotal;
    }

    public void setEctickettotal(Integer ectickettotal) {
        this.ectickettotal = ectickettotal;
    }

    public Integer getFcprice() {
        return fcprice;
    }

    public void setFcprice(Integer fcprice) {
        this.fcprice = fcprice;
    }

    public Integer getFcticketremain() {
        return fcticketremain;
    }

    public void setFcticketremain(Integer fcticketremain) {
        this.fcticketremain = fcticketremain;
    }

    public Integer getFctickettotal() {
        return fctickettotal;
    }

    public void setFctickettotal(Integer fctickettotal) {
        this.fctickettotal = fctickettotal;
    }

    public String getFlighttype() {
        return flighttype;
    }

    public void setFlighttype(String flighttype) {
        this.flighttype = flighttype == null ? null : flighttype.trim();
    }

    public String getFromcity() {
        return fromcity;
    }

    public void setFromcity(String fromcity) {
        this.fromcity = fromcity == null ? null : fromcity.trim();
    }

    public Date getFromtime() {
        return fromtime;
    }

    public void setFromtime(Date fromtime) {
        this.fromtime = fromtime;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getTocity() {
        return tocity;
    }

    public void setTocity(String tocity) {
        this.tocity = tocity == null ? null : tocity.trim();
    }

    public Date getTotime() {
        return totime;
    }

    public void setTotime(Date totime) {
        this.totime = totime;
    }

    public Integer getAircraftid() {
        return aircraftid;
    }

    public void setAircraftid(Integer aircraftid) {
        this.aircraftid = aircraftid;
    }

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }


    public String getAircraftname() {
        return aircraftname;
    }

    public void setAircraftname(String aircraftname) {
        this.aircraftname = aircraftname;
    }

    public String getFromTime() {
        return fromTime;
    }

    public void setFromTime(String fromTime) {
        this.fromTime = fromTime;
    }
}
