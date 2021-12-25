package com.example.crm.workbench.service.impl;

import com.example.crm.utils.GetJson;
import com.example.crm.workbench.dao.ActivityDao;
import com.example.crm.workbench.domian.Activity;
import com.example.crm.workbench.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ActivityServiceImpl implements ActivityService {
    @Autowired
    private ActivityDao activityDao;

    @Override
    public String saveActivity(Activity activity) {
        int i=activityDao.saveActivity(activity);
        String json=null;
        if(i==1){
            json = GetJson.getFlag(true);
        }else{
            json = GetJson.getFlag(false);
        }
        return json;
    }
}
