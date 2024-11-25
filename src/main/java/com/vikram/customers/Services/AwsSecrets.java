package com.vikram.customers.Services;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AwsSecrets {

    private String username;
    private String password;
    private String DB_HOST;
    private String engine;
    private String PORT;
    private String dbInstanceIdentifier;
}
