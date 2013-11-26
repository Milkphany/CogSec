package org.security.repository;

import org.security.model.Coglet;
import org.security.model.UserAccount;
import org.security.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * User: Milky
 * Date: 11/26/13
 * Time: 12:36 PM
 */
@Repository
public class CogAuthenticationProvider implements AuthenticationProvider {

    @Autowired
    private AuthService authService;

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        String username = authentication.getName();
        List<Coglet> password = (List<Coglet>)authentication.getCredentials();

        UserAccount account = authService.loadUserByUsername(username);

        if (account == null)
            throw new BadCredentialsException("Username not found");
        for (int i = 0; i < password.size(); i++)
            if (!password.get(i).equals(account.getCogPassword().get(i)))
                throw new BadCredentialsException("Coglet password is wrong");

        return new UsernamePasswordAuthenticationToken(username, password, account.getAuthorities());
    }

    @Override
    public boolean supports(Class<?> aClass) {
        return true;
    }
}
