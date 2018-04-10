package com.ifox.service.impl;

import com.ifox.dao.AircraftDao;
import com.ifox.entity.Aircraft;
import com.ifox.service.AircraftService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @Author:zhongchao
 * @Organization: ifox
 * @Description:
 * @Date:Created in16:25 2018/4/10
 * @Modified By:
 */
@Service("aircraft")
public class IAircraftService implements AircraftService {

    @Resource
    private AircraftDao aircraftDao;

    @Override
    public int deleteByPrimaryKey(Integer id) {
        return aircraftDao.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(Aircraft record) {
        return aircraftDao.insert(record);
    }

    @Override
    public int insertSelective(Aircraft record) {
        return aircraftDao.insertSelective(record);
    }

    @Override
    public int updateByPrimaryKeySelective(Aircraft record) {
        return aircraftDao.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(Aircraft record) {
        return aircraftDao.updateByPrimaryKey(record);
    }

    @Override
    public Integer getCount(Aircraft aircraft) {
        return aircraftDao.getCount(aircraft);
    }

    @Override
    public Aircraft selectByPrimaryKey(Integer id) {
        return aircraftDao.selectByPrimaryKey(id);
    }

    @Override
    public List<Aircraft> getAircraftList(Aircraft aircraft) {
        return aircraftDao.getAircraftList(aircraft);
    }
}
