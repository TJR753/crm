package com.example.crm.workbench.service;

import com.example.crm.workbench.domian.Activity;
import org.springframework.stereotype.Service;

@Service
public interface ActivityService {

    String saveActivity(Activity activity);
}
