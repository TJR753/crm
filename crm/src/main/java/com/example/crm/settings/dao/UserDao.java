package com.example.crm.settings.dao;

import com.example.crm.settings.domain.User;

import java.util.List;

public interface UserDao {
    List<User> selectAll();
}
