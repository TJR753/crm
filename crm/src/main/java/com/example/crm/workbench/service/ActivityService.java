package com.example.crm.workbench.service;

import com.example.crm.workbench.domain.Activity;
import com.example.crm.workbench.domain.vo.PageVo;
import org.springframework.stereotype.Service;

import java.util.HashMap;

@Service
public interface ActivityService {

    String saveActivity(Activity activity);

    PageVo<Activity> getPageList(HashMap<String, Object> map);

    boolean deleteActivity(String[] ids);

    Activity getActivityById(String id);
}
