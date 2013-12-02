package org.security.service;

import org.security.model.Cogleter;
import org.security.model.UserAccount;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * User: Milky
 * Date: 11/26/13
 * Time: 12:36 PM
 */
@Service
public class CogAuthenticationProvider implements AuthenticationProvider {

    @Autowired
    private AuthService authService;

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        String username = authentication.getName();
        List<Cogleter> password = (List<Cogleter>)authentication.getCredentials();

        UserAccount account = authService.getUser(username);

        if (account == null)
            throw new BadCredentialsException("Username not found");
        if (password == null || password.size() != account.getPassword().size())
            throw new BadCredentialsException("Password has errors");
        for (int i = 0; i < password.size(); i++)
            if (!password.get(i).equals(account.getPassword().get(i)))
                throw new BadCredentialsException("Cogleter password is wrong");

        return new UsernamePasswordAuthenticationToken(username, password, account.getAuthorities());
    }

    @Override
    public boolean supports(Class<?> aClass) {
        return true;
    }
}
