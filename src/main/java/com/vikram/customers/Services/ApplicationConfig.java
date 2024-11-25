package com.vikram.customers.Services;


import com.google.gson.Gson;
import org.springframework.context.annotation.Configuration;
import software.amazon.awssdk.auth.credentials.ProfileCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.secretsmanager.SecretsManagerClient;
import software.amazon.awssdk.services.secretsmanager.model.GetSecretValueRequest;
import software.amazon.awssdk.services.secretsmanager.model.GetSecretValueResponse;
import software.amazon.awssdk.services.secretsmanager.model.SecretsManagerException;

@Configuration
public class ApplicationConfig {
//    @Value("${cloud.aws.credentials.access-key}")
//    private String accessKey;
//    @Value("${cloud.aws.credentials.secret-key}")
//    private String secretkey;

    private Gson gson = new Gson();

//    @Bean
//    public DataSource dataSource() {
////        AwsSecrets secrets = getSecret();
////        return DataSourceBuilder
////                .create()
////                //  .driverClassName("com.mysql.cj.jdbc.driver")
////                .url("jdbc:" + secrets.getEngine() + "://" + secrets.getHost() + ":" + secrets.getPort() + "/javatechie")
////                .username(secrets.getUsername())
////                .password(secrets.getPassword())
////                .build();
//    }


    public static void getSecret() {

        Region region = Region.of("us-east-1");

        // Create a Secrets Manager client
        SecretsManagerClient client = SecretsManagerClient.builder()
                .region(region).credentialsProvider(ProfileCredentialsProvider.create("aurora"))
                .build();

        try {
            GetSecretValueRequest valueRequest = GetSecretValueRequest.builder()
                    .secretId("dev/mysql")
                    .build();

            GetSecretValueResponse valueResponse = client.getSecretValue(valueRequest);
            String secret = valueResponse.secretString();
            System.out.println(secret);

        } catch (SecretsManagerException e) {
            System.err.println(e.awsErrorDetails().errorMessage());
            System.exit(1);
        }
    }

}
