package com.example.crm.workbench.service;

import com.example.crm.settings.domain.User;
import com.example.crm.workbench.domain.Customer;
import com.example.crm.workbench.domain.Tran;
import com.example.crm.workbench.domain.TranHistory;

import java.util.List;

public interface TranService {
    List<User> getUseList();

    List<String> getCustomerName(String name);

    boolean save(Tran tran);

    Tran getTranById(String id);

    List<TranHistory> getTranHistory(String tranId);
}
