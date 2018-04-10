package com.ifox.dao;

import com.ifox.entity.Manager;

/**
 * @Author:zhongchao
 * @Organization: ifox
 * @Description:
 * @Date:Created in16:16 2018/4/10
 * @Modified By:
 */
public interface ManagerDao {
    Manager ManagerLogin(Manager manager);

    int deleteByPrimaryKey(Integer id);

    int insert(Manager record);

    int insertSelective(Manager record);

    Manager selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Manager record);

    int updateByPrimaryKey(Manager record);

    int modifyPassword(Integer id);
}
