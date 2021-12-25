package com.example.crm.workbench.web.controller;

import com.example.crm.settings.domain.User;
import com.example.crm.settings.service.UserService;
import com.example.crm.utils.DateTimeUtil;
import com.example.crm.utils.UUIDUtil;
import com.example.crm.workbench.domian.Activity;
import com.example.crm.workbench.service.ActivityService;
import com.example.crm.utils.GetJson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class ActivityController {
    @Autowired
    private UserService userService;
    @Autowired
    private ActivityService activityService;

    @ResponseBody
    @RequestMapping("/workbench/activity/getUserList.do")
    public String getUserList(){
        List<User> userList=userService.getUserList();
        String json = GetJson.getJson(userList);
        return json;
    }

    @ResponseBody
    @RequestMapping("/workbench/activity/saveActivity.do")
    public String saveActivity(Activity activity){
        String id= UUIDUtil.getUUID();
        activity.setId(id);
        String createTime= DateTimeUtil.getSysTime();
        activity.setCreateTime(createTime);
//        activity.setEditTime("");
//        activity.setEditBy("");
        //返回值，"success":true/false
        String json=activityService.saveActivity(activity);
        return json;
    }

}
