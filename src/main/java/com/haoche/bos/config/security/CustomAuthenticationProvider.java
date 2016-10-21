package com.haoche.bos.config.security;

import com.haoche.bos.service.EmpService;
import com.haoche.bos.service.PermissionsService;
import com.haoche.remoting.dto.EmpListDTO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component("customAuthenticationProvider")
public class CustomAuthenticationProvider implements AuthenticationProvider {


    @Autowired
    private EmpService empStaffService;

    @Autowired
    private PermissionsService permissionsService;

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        EmpInfo empInfo = new EmpInfo();
        try{
            EmpListDTO empListDTO = empStaffService.login(authentication.getPrincipal().toString(), authentication.getCredentials().toString());
            BeanUtils.copyProperties(empListDTO,empInfo);
            empInfo.setActionDTOs(permissionsService.empActions(empInfo.getId()));
        }catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        }
        List<GrantedAuthority> grantedAuths = new ArrayList<GrantedAuthority>();
        return new UsernamePasswordAuthenticationToken(empInfo, null, grantedAuths);
    }

    @Override
    public boolean supports(Class<?> authentication) {
        return authentication.equals(UsernamePasswordAuthenticationToken.class);
    }
}
