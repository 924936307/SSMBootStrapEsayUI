package com.ifox.service;

import com.ifox.entity.Ticketorder;

import java.util.List;

/**
 * @Author:zhongchao
 * @Organization: ifox
 * @Description:
 * @Date:Created in16:13 2018/4/10
 * @Modified By:
 */
public interface TicketOrderService {
    int deleteByPrimaryKey(Integer id);

    int insert(Ticketorder record);

    int insertSelective(Ticketorder record);

    int updateByPrimaryKeySelective(Ticketorder record);

    int updateByPrimaryKey(Ticketorder record);

    int getCount(Ticketorder record);

    List<Ticketorder> getList(Ticketorder record);

    /**
     * 根据用户查询用户订单
     * @param userName
     * @return
     */
    List<Ticketorder> getTicketOrderByUserName(String userName);

    Ticketorder selectByPrimaryKey(Integer id);

    List<Ticketorder> selectListByUserId(Integer userId);

    List<Ticketorder> selectListByFlightId(Integer flightId);
}
