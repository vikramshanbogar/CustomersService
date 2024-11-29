//package com.vikram.customers.config;
//
//import com.amazonaws.xray.entities.Subsegment;
//import org.aspectj.lang.ProceedingJoinPoint;
//import org.aspectj.lang.annotation.Aspect;
//import org.aspectj.lang.annotation.Pointcut;
//import org.springframework.stereotype.Component;
//
//import java.util.Map;
//
//@Aspect
//@Component
//public class XRayInspector extends BaseAbstractXRayInterceptor {
//    @Override
//    protected Map<String, Map<String, Object>> generateMetadata(ProceedingJoinPoint proceedingJoinPoint, Subsegment subsegment) throws Exception {
//        return super.generateMetadata(proceedingJoinPoint, subsegment);
//    }
//
//  @Override
//  @Pointcut("@within(com.amazonaws.xray.spring.aop.XRayEnabled) && bean(*Controller)")
//  public void xrayEnabledClasses() {}
//
//}