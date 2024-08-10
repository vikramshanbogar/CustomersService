package com.vikram.customers;

import com.fasterxml.jackson.databind.util.BeanUtil;
import com.vikram.customers.Models.Customer;
import org.junit.jupiter.api.Test;
import org.springframework.beans.BeanUtils;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class TEst {


    @Test
    void testObjectMapper() {
        Customer customer1 = new Customer("John", "Smith");
        Customer customer2 = new Customer("Jane", "Doe");
        Customer customer3 = new Customer("Bob", "Smith");
        Customer customer4 = new Customer("Freds", "Tred");
        List<Customer> customers = Arrays.asList(customer1, customer2, customer3, customer4);
        List<Customer> customerslist = customers.stream()
                .collect(Collectors.mapping(source -> mapper(source, new Customer()), Collectors.toList()));
        customerslist.forEach(System.out::println);
    }

    public <D> D mapper(Object source, Object target) {
        BeanUtils.copyProperties(source, target);
        return (D) target;
    }
}
