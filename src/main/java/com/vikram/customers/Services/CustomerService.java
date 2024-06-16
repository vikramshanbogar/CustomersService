package com.vikram.customers.Services;

import com.vikram.customers.Models.Customer;
import com.vikram.customers.Repos.CustomerRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CustomerService {
    @Autowired
    CustomerRepo customerRepo;

    public void insertData(Customer customer) {
        Customer c = customerRepo.save(customer);
    }

    public List<Customer> getAllCustomers() {
        List<Customer> customers = customerRepo.findAll();

        return customers;
    }

    public Optional<Customer> getCustomerDetails(Integer id) {
        return customerRepo.findById(id);
    }

    public void deleteCustomer(int id) {
        customerRepo.deleteById(id);
    }
}