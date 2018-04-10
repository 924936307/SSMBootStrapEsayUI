package com.ifox.service.impl;

import com.ifox.dao.ManagerDao;
import com.ifox.entity.Manager;
import com.ifox.service.ManagerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Author:zhongchao
 * @Organization: ifox
 * @Description:
 * @Date:Created in16:21 2018/4/10
 * @Modified By:
 */
@Service("managerService")
public class IManagerService implements ManagerService {

    @Autowired
    private ManagerDao managerDao;

    @Override
    public Manager ManagerLogin(Manager manager) {
        return managerDao.ManagerLogin(manager);
    }

    @Override
    public int deleteByPrimaryKey(Integer id) {
        return 0;
    }

    @Override
    public int insert(Manager record) {
        return 0;
    }

    @Override
    public int insertSelective(Manager record) {
        return 0;
    }

    @Override
    public Manager selectByPrimaryKey(Integer id) {
        return null;
    }

    @Override
    public int updateByPrimaryKeySelective(Manager record) {
        return 0;
    }

    @Override
    public int updateByPrimaryKey(Manager record) {
        return 0;
    }

    @Override
    public int modifyPassword(Integer id) {
        return managerDao.modifyPassword(id);
    }
}
