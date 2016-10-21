package com.haoche.bos.service;

import com.haoche.bos.config.security.EmpInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

@Service("sessionService")
public class SessionService {

    @Autowired
    private AuthenticationManager authenticationManager;

    public EmpInfo keep(String mobile, String password) {
        UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(mobile, password);
        Authentication authentication = authenticationManager.authenticate(authenticationToken);
        SecurityContextHolder.getContext().setAuthentication(authentication);
        return (EmpInfo) authentication.getPrincipal();
    }
}
