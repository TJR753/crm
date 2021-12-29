package com.example.crm.workbench.service;

import com.example.crm.settings.domain.User;
import com.example.crm.workbench.domain.Clue;

import java.util.List;

public interface ClueService {
    List<User> getUserList();

    boolean saveClue(Clue clue);
}
