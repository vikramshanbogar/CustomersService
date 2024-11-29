package com.vikram.customers.config;


import org.springframework.context.annotation.Configuration;

import com.amazonaws.xray.jakarta.servlet.AWSXRayServletFilter;
import com.amazonaws.xray.strategy.SegmentNamingStrategy;

import org.springframework.context.annotation.Bean;
import jakarta.servlet.Filter;

@Configuration
public class WebConfig {
    @Bean
    Filter TracingFilter() {
        return (Filter)new AWSXRayServletFilter(SegmentNamingStrategy.dynamic("Scorekeep"));
    }
}