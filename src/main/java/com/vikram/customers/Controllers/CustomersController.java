package com.vikram.customers.Controllers;

import com.vikram.customers.Models.Customer;
import com.vikram.customers.Services.CustomerService;
import com.vikram.customers.Utils.Utility;
import com.vikram.customers.exceptions.CustomerNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/customers")
public class CustomersController {

    @Autowired
    CustomerService customerService;

    @GetMapping
    List<Customer> getCustomers() {
        return customerService.getAllCustomers();
    }

    @GetMapping("/{id}")
    Customer getCustomerById(@PathVariable int id) throws CustomerNotFoundException {
        Optional<Customer> customerOptional = customerService.getCustomerDetails(id);
        if (customerOptional.isPresent())
           return customerOptional.get();
        else
            throw new CustomerNotFoundException("No Data", null);
    }

    @PostMapping
    String insertData(@RequestBody Customer customer) throws InterruptedException {
     //insert 100 customers
        for (int i = 0; i < 100; i++) {
            Customer customer1 = new Customer("f_name" + i, "l_name" + i);
            Thread.sleep(10000);
            customerService.insertData(customer1);
        }

        // customerService.insertData(customer);
        return "Data inserted successfully";
    }

    @PutMapping
    String updateData(@RequestBody Customer customer) {
        if (customer == null) {
            return "Data not inserted successfully";
        }
        //  collageService.insertData(collage);
        if (customer.getId() != null && customerService.getCustomerDetails(customer.getId()).isPresent()) {
            customerService.insertData(customer);
            return "Data Updated successfully";
        } else {
            return "Data not inserted successfully, Create before updating";
        }
    }

    @PatchMapping
    String updateDataPatch(@RequestBody Customer customer) throws Exception {
        Optional<Customer> customerOptional = customerService.getCustomerDetails(customer.getId());
        if (!customerOptional.isPresent()) {
            throw new CustomerNotFoundException("No Data", null);
        }


        try {
            Utility.customerPatcher(customerOptional.get(), customer);
            customerService.insertData(customerOptional.get());
        } catch (IllegalAccessException e) {
            throw new RuntimeException(e);
        }
        return "Data patched successfully";
    }
    @RequestMapping(value = "/", method = RequestMethod.OPTIONS)
    ResponseEntity<?> getOptions() {
        return ResponseEntity
                .ok()
                .allow(HttpMethod.GET, HttpMethod.DELETE, HttpMethod.PUT, HttpMethod.POST, HttpMethod.PATCH, HttpMethod.OPTIONS, HttpMethod.HEAD)
                .build();
    }


    @DeleteMapping("/{id}")
    String deleteCustomerById(@PathVariable int id) {
        if (customerService.getCustomerDetails(id).isPresent()) {
            customerService.deleteCustomer(id);
            return "Customer deleted successfully";
        }
        return "Failed to Delete the customer, Pls check the id";
    }
}