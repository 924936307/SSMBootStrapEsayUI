package com.ifox.service.impl;

import com.ifox.dao.TicketOrderDao;
import com.ifox.entity.Ticketorder;
import com.ifox.service.TicketOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author:zhongchao
 * @Organization: ifox
 * @Description:
 * @Date:Created in16:22 2018/4/10
 * @Modified By:
 */

@Service("ticketOrderService")
public class ITicketOrderService implements TicketOrderService {

    @Autowired
    private TicketOrderDao ticketOrderDao;

    @Override
    public int deleteByPrimaryKey(Integer id) {
        return ticketOrderDao.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(Ticketorder record) {
        return ticketOrderDao.insert(record);
    }

    @Override
    public int insertSelective(Ticketorder record) {
        return ticketOrderDao.insertSelective(record);
    }

    @Override
    public int updateByPrimaryKeySelective(Ticketorder record) {
        return ticketOrderDao.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(Ticketorder record) {
        return ticketOrderDao.updateByPrimaryKey(record);
    }

    @Override
    public int getCount(Ticketorder record) {
        return ticketOrderDao.getCount(record);
    }

    @Override
    public List<Ticketorder> getList(Ticketorder record) {
        return ticketOrderDao.getList(record);
    }

    @Override
    public List<Ticketorder> getTicketOrderByUserName(String userName) {
        return ticketOrderDao.getTicketOrderByUserName(userName);
    }

    @Override
    public Ticketorder selectByPrimaryKey(Integer id) {
        return ticketOrderDao.selectByPrimaryKey(id);
    }

    @Override
    public List<Ticketorder> selectListByUserId(Integer userId) {
        return ticketOrderDao.selectListByUserId(userId);
    }

    @Override
    public List<Ticketorder> selectListByFlightId(Integer flightId) {
        return ticketOrderDao.selectListByFlightId(flightId);
    }
}
