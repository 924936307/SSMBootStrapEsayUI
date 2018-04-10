package com.ifox.dao;

import com.ifox.entity.User;

import java.util.List;

/**
 * @Author:zhongchao
 * @Organization: ifox
 * @Description:
 * @Date:Created in16:16 2018/4/10
 * @Modified By:
 */
public interface IUserDao {
    User login(User user);

    User selectByPrimaryKey(Integer id);

    List<User> getUserList(User user);

    Integer getCount(User user);

    User getUserByName(String username);

    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    int insertSelective(User record);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);


}
