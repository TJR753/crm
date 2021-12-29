package com.example.crm.workbench.dao;


import com.example.crm.settings.domain.User;
import com.example.crm.workbench.domain.Clue;

import java.util.List;

public interface ClueDao {


    List<User> getUserList();

    int saveClue(Clue clue);
}
