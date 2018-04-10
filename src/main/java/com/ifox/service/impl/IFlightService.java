package com.ifox.service.impl;

import com.ifox.dao.FlightDao;
import com.ifox.entity.Flight;
import com.ifox.service.FlightService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author:zhongchao
 * @Organization: ifox
 * @Description:
 * @Date:Created in16:23 2018/4/10
 * @Modified By:
 */
@Service("flightService")
public class IFlightService implements FlightService {

    @Autowired
    private FlightDao flightDao;

    @Override
    public void update(Flight flight) {

    }

    @Override
    public void add(Flight flight) {

    }

    @Override
    public List<Flight> getIndexList(Flight flight) {
        return flightDao.getIndexList(flight);
    }

    @Override
    public List<Flight> selectListByAircraftId(Integer aircraftId) {
        return flightDao.selectListByAircraftId(aircraftId);
    }

    @Override
    public int deleteByPrimaryKey(Integer id) {
        return flightDao.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(Flight record) {
        return flightDao.insert(record);
    }


    @Override
    public int insertSelective(Flight record) {
        return flightDao.insertSelective(record);
    }

    @Override
    public Flight selectByPrimaryKey(Integer id) {
        return flightDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(Flight record) {
        return flightDao.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(Flight record) {
        return flightDao.updateByPrimaryKey(record);
    }

    @Override
    public Integer getCount(Flight flight) {
        return flightDao.getCount(flight);
    }
}
