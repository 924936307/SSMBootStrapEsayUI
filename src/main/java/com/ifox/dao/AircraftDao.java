package com.ifox.dao;

import com.ifox.entity.Aircraft;

import java.util.List;

/**
 * @Author:zhongchao
 * @Organization: ifox
 * @Description:
 * @Date:Created in16:18 2018/4/10
 * @Modified By:
 */
public interface AircraftDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Aircraft record);

    int insertSelective(Aircraft record);

    int updateByPrimaryKeySelective(Aircraft record);

    int updateByPrimaryKey(Aircraft record);

    Aircraft selectByPrimaryKey(Integer id);

    List<Aircraft> getAircraftList(Aircraft aircraft);

    Integer getCount(Aircraft aircraft);
}
