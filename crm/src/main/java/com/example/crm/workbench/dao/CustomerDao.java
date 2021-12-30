package com.example.crm.workbench.dao;

import com.example.crm.workbench.domain.Customer;

public interface CustomerDao {

    Customer getCustomerByCompany(String company);

    int save(Customer customer);
}
