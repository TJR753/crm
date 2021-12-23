package com.example.crm.settings.service;

import com.example.crm.settings.domain.User;

import java.util.List;

public interface UserService {
    List<User> selectAll();
}
