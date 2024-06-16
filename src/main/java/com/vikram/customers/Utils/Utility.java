package com.vikram.customers.Utils;


import com.vikram.customers.Models.Customer;

import java.lang.reflect.Field;

public class Utility {

    public static void customerPatcher(Customer existingCustomer, Customer incompleteCustomer) throws IllegalAccessException {

        //GET THE COMPILED VERSION OF THE CLASS
        Class<?> CustomerClass= Customer.class;
        Field[] CustomerFields=CustomerClass.getDeclaredFields();
        System.out.println(CustomerFields.length);
        for(Field field : CustomerFields){
            System.out.println(field.getName());
            //CANT ACCESS IF THE FIELD IS PRIVATE
            field.setAccessible(true);

            //CHECK IF THE VALUE OF THE FIELD IS NOT NULL, IF NOT UPDATE EXISTING Customer
            Object value=field.get(incompleteCustomer);
            if(value!=null){
                field.set(existingCustomer,value);
            }
            //MAKE THE FIELD PRIVATE AGAIN
            field.setAccessible(false);
        }
    }

}
