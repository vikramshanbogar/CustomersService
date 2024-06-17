package com.vikram.customers.Models;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
public class Customer extends BaseEntity {

    @Column(name = "first_name")
    String firstName;
    @Column(name = "last_name")
    String lastName;

    public Customer(String firstName, String lastName) {
        super();
        this.firstName = firstName;
        this.lastName = lastName;
    }
    public Customer(int id,String firstName, String lastName) {
        super(id);
        this.firstName = firstName;
        this.lastName = lastName;
    }
}
