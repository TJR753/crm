package com.example.crm.workbench.dao;

import com.example.crm.workbench.domain.Tran;

public interface TranDao {

    int save(Tran tran);

    Tran getTranById(String id);
}
