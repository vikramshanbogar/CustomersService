package com.vikram.customers;

import com.vikram.customers.Models.Customer;
import com.vikram.customers.Repos.CustomerRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.web.client.RestTemplate;

@SpringBootApplication
public class CustomersApplication implements CommandLineRunner {

    public static void main(String[] args) {
        SpringApplication.run(CustomersApplication.class, args);
    }

    @Autowired
    CustomerRepo customerRepo;


    @Override
    public void run(String... args) throws Exception {
        customerRepo.save(new Customer("John", "Smith"));
        customerRepo.save(new Customer("Jane", "Doe"));
        customerRepo.save(new Customer("Bob", "Smith"));
        customerRepo.save(new Customer("Freds", "Tred"));
    }
}
