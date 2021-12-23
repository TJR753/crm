package com.example.crm.settings.web.controller;

import com.example.crm.settings.domain.User;
import com.example.crm.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping("/selectAll")
    public ModelAndView selectAll(){
        ModelAndView mv=new ModelAndView();
        List<User> userList = userService.selectAll();
        mv.addObject("userList",userList);
        mv.setViewName("show");
        return mv;
    }
}
