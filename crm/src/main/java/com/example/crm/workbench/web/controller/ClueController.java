package com.example.crm.workbench.web.controller;

import com.example.crm.settings.domain.User;
import com.example.crm.utils.DateTimeUtil;
import com.example.crm.utils.GetJson;
import com.example.crm.utils.UUIDUtil;
import com.example.crm.workbench.domain.Clue;
import com.example.crm.workbench.service.ClueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/workbench/clue")
public class ClueController {
    @Autowired
    private ClueService clueService;

    @RequestMapping("/getUserList.do")
    public String getUserList(){
        List<User> userList=clueService.getUserList();
        String json = GetJson.getJson(userList);
        return json;
    }
    @RequestMapping("/saveClue.do")
    public String saveClue(Clue clue){
        clue.setId(UUIDUtil.getUUID());
        clue.setCreateTime(DateTimeUtil.getSysTime());
        boolean flag=clueService.saveClue(clue);
        String flag1 = GetJson.getFlag(flag);
        return flag1;
    }
}
