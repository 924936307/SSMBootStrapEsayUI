package com.ifox.service;

import com.ifox.entity.Aircraft;

import java.util.List;

/**
 * @Author:zhongchao
 * @Organization: ifox
 * @Description:
 * @Date:Created in16:14 2018/4/10
 * @Modified By:
 */
public interface AircraftService {

    int deleteByPrimaryKey(Integer id);

    int insert(Aircraft record);

    int insertSelective(Aircraft record);

    int updateByPrimaryKeySelective(Aircraft record);

    int updateByPrimaryKey(Aircraft record);

    Integer getCount(Aircraft aircraft);

    Aircraft selectByPrimaryKey(Integer id);

    List<Aircraft> getAircraftList(Aircraft aircraft);
}
