package com.vikram.customers.Models;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
public class Customer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer id;

    public Customer(String f_name, String l_name) {
        this.f_name = f_name;
        this.l_name = l_name;
    }

    @Column(name = "f_name")
    String f_name;
    @Column(name = "l_name")
    String l_name;
    @Transient
    long totalRewardsPoints = 0;

    public Customer() {

    }
}
