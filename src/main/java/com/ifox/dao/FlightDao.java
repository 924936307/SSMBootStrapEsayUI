package com.ifox.dao;

import com.ifox.entity.Flight;

import java.util.List;

/**
 * @Author:zhongchao
 * @Organization: ifox
 * @Description:
 * @Date:Created in16:17 2018/4/10
 * @Modified By:
 */
public interface FlightDao {
    void update(Flight flight);

    void add(Flight flight);

    Integer getCount(Flight flight);

    List<Flight> getIndexList(Flight flight);

    List<Flight> selectListByAircraftId(Integer aircraftId);

    int deleteByPrimaryKey(Integer id);

    int insert(Flight record);

    int insertSelective(Flight record);

    Flight selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Flight record);

    int updateByPrimaryKey(Flight record);
}
