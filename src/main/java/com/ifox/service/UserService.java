package com.ifox.service;

import com.ifox.entity.User;

import java.util.List;

/**
 * @Author:zhongchao
 * @Organization: ifox
 * @Description:
 * @Date:Created in16:13 2018/4/10
 * @Modified By:
 */
public interface UserService {
    User login(User user);

    User getUserById(Integer id);

    List<User> getUserList(User user);

    Integer getCount(User user);

    User getUserByName(String username);

    void add(User user);

    void update(User user);

    Integer insertSelective(User user);

    Integer updateByPrimaryKeySelective(User user);

    Integer deleteByPrimaryKey(Integer id);
}
