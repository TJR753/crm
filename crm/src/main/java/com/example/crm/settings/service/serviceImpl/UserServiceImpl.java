package com.example.crm.settings.service.serviceImpl;

import com.example.crm.settings.dao.UserDao;
import com.example.crm.settings.domain.User;
import com.example.crm.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;

    @Override
    public List<User> selectAll() {
        List<User> userList = userDao.selectAll();
        return userList;
    }
}
