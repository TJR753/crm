package com.example.crm.workbench.service.impl;

import com.example.crm.settings.domain.User;
import com.example.crm.workbench.dao.ClueDao;
import com.example.crm.workbench.domain.Clue;
import com.example.crm.workbench.service.ClueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ClueServiceImpl implements ClueService {
    @Autowired
    private ClueDao clueDao;
    @Override
    public List<User> getUserList() {
        List<User> userList=clueDao.getUserList();
        return userList;
    }

    @Override
    public boolean saveClue(Clue clue) {
        int i=clueDao.saveClue(clue);
        if(i==1){
            return true;
        }
        return false;
    }
}


