package com.example.crm.settings.service;

import com.example.crm.exception.LoginException;
import com.example.crm.settings.domain.User;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface UserService {

    User login(String loginAct, String loginPwd, String ip) throws LoginException;

    List<User> getUserList();
}
