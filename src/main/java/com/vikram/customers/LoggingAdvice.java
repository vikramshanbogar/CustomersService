package com.vikram.customers;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.databind.ObjectMapper;

@Aspect
@Component
public class LoggingAdvice {

    Logger log = LoggerFactory.getLogger(LoggingAdvice.class);

    @Pointcut(value = "execution(* com.vikram.customers.*.*(..) )")
    public void myPointcut() {

    }

    @Pointcut(value = "execution(* com.vikram.customers.*.*(..) )")
    public void myPointcut123() {

    }

    @Around("myPointcut()")
    public Object applicationLogger(ProceedingJoinPoint pjp) throws Throwable {
        ObjectMapper mapper = new ObjectMapper();
        String methodName = pjp.getSignature().getName();
        String className = pjp.getTarget().getClass().toString();
        Object[] array = pjp.getArgs();
        log.info("method invoked " + className + " : " + methodName + " () " + " arguments : "
                + mapper.writeValueAsString(array));
        Object object = pjp.proceed();
        log.info(className + " : " + methodName + " () " + "Response : "
                + mapper.writeValueAsString(object));
        return object;
    }

    @Before("myPointcut()")
    public void beforeAdvice(JoinPoint jp) {
        log.info("in method : {}", jp.getSignature().getName());
    }

    @After("myPointcut()")
    public void afterAdvise(JoinPoint jp) {
        log.info("completed method : {}", jp.getSignature().getName());
        log.info(jp.getTarget().getClass().toString());
    }

}