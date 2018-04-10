package com.ifox.dao;

import com.ifox.entity.Ticketorder;

import java.util.List;

/**
 * @Author:zhongchao
 * @Organization: ifox
 * @Description:
 * @Date:Created in16:17 2018/4/10
 * @Modified By:
 */
public interface TicketOrderDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Ticketorder record);

    int insertSelective(Ticketorder record);

    int updateByPrimaryKeySelective(Ticketorder record);

    int updateByPrimaryKey(Ticketorder record);

    int getCount(Ticketorder record);

    List<Ticketorder> getList(Ticketorder record);

    List<Ticketorder> getTicketOrderByUserName(String userName);

    Ticketorder selectByPrimaryKey(Integer id);

    List<Ticketorder> selectListByUserId(Integer userId);

    List<Ticketorder> selectListByFlightId(Integer flightId);
}
