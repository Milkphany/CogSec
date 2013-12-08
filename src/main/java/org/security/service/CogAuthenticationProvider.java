package org.security.service;

import org.jboss.logging.Logger;
import org.security.model.Coglet;
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

    private static final Logger logger = Logger.getLogger(CogAuthenticationProvider.class);

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        String username = authentication.getName();
        List<Coglet> password = (List<Coglet>)authentication.getCredentials();

        UserAccount account = authService.getUser(username);

        if (account == null)
            throw new BadCredentialsException("Username not found");
        if (password == null || password.size() != account.getPassword().size()) {
            logger.error(username + " tried to submit an incorrectly sized password.");
            throw saveAttempt(account, "Password has errors");
        } for (int i = 0; i < password.size(); i++) {
            if (!password.get(i).equals(account.getPassword().get(i))) {
                logger.info(username + " made an unsuccessful attempt " + account.getAttemptedLogin());
                throw saveAttempt(account, "Password is incorrect!");
            }
        }

        account.setAttemptedLogin(account.getAttemptedLogin() + 1);
        account.setSuccessLogin(account.getSuccessLogin() + 1);
        authService.updateUser(account);


        logger.info(username + " has successfully logged in.");

        return new UsernamePasswordAuthenticationToken(username, password, account.getAuthorities());
    }

    private BadCredentialsException saveAttempt(UserAccount account, String message) {
        account.setAttemptedLogin(account.getAttemptedLogin() + 1);
        return new BadCredentialsException(message);
    }

    @Override
    public boolean supports(Class<?> aClass) {
        return true;
    }
}
