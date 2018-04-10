package com.ifox.service;

import com.ifox.entity.Manager;

/**
 * @Author:zhongchao
 * @Organization: ifox
 * @Description:
 * @Date:Created in16:13 2018/4/10
 * @Modified By:
 */
public interface ManagerService {
    Manager ManagerLogin(Manager manager);

    int deleteByPrimaryKey(Integer id);

    int insert(Manager record);

    int insertSelective(Manager record);

    Manager selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Manager record);

    int updateByPrimaryKey(Manager record);

    int modifyPassword(Integer id);

}
