package com.haoche.bos.config.security;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ImportResource;
import org.springframework.security.web.context.AbstractSecurityWebApplicationInitializer;
import org.springframework.stereotype.Component;

// TODO  <import resource="classpath:spring-security.xml" />
// 删除此文件
//@Configuration
@Component
@ImportResource({"classpath:/spring-security.xml"})
public class SecurityConfig {


}
