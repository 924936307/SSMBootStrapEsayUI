package com.ifox.service.impl;

import com.ifox.dao.IUserDao;
import com.ifox.entity.User;
import com.ifox.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author:zhongchao
 * @Organization: ifox
 * @Description:
 * @Date:Created in16:15 2018/4/10
 * @Modified By:
 */
@Service("userService")
public class IUserService implements UserService {

    @Autowired
    private IUserDao userDao;

    @Override
    public User login(User user) {
        return userDao.login(user);
    }

    @Override
    public User getUserById(Integer id) {
        return userDao.selectByPrimaryKey(id);
    }

    @Override
    public List<User> getUserList(User user) {
        return userDao.getUserList(user);
    }

    @Override
    public Integer getCount(User user) {
        return userDao.getCount(user);
    }

    @Override
    public User getUserByName(String username) {
        return null;
    }

    @Override
    public void add(User user) {

    }

    @Override
    public void update(User user) {

    }

    @Override
    public Integer insertSelective(User user){
        return userDao.insertSelective(user);
    }

    @Override
    public Integer updateByPrimaryKeySelective(User user) {
        return userDao.updateByPrimaryKeySelective(user);
    }

    @Override
    public Integer deleteByPrimaryKey(Integer id) {
        return userDao.deleteByPrimaryKey(id);
    }
}
