package com.example.crm.settings.web.controller;

import com.example.crm.exception.LoginException;
import com.example.crm.settings.domain.User;
import com.example.crm.settings.service.UserService;
import com.example.crm.utils.MD5Util;
import com.example.crm.utils.PrintJson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;

@Controller
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping("/settings/user/login.do")
    public void login(HttpServletRequest request, HttpServletResponse response){
        String loginAct = request.getParameter("loginAct");
        String loginPwd = request.getParameter("loginPwd");
        //账号密码加密
        loginPwd = MD5Util.getMD5(loginPwd);
        //map值:{"success":true/false,"msg":"错误信息"}
        String ip = request.getRemoteAddr();
        System.out.println(ip);
        try {
            User user = userService.login(loginAct, loginPwd, ip);
            //代码执行到这里说明没有抛出任何异常
            request.getSession().setAttribute("user",user);
            PrintJson.printJsonFlag(response,true);
        } catch (LoginException e) {
            e.printStackTrace();
            //到这里说明抛出了异常
            String msg = e.getMessage();
            HashMap<String, Object> map = new HashMap<>();
            map.put("msg",msg);
            map.put("success",false);
            PrintJson.printJsonObj(response,map);
        }
    }
}
