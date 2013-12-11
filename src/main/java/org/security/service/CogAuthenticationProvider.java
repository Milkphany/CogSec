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

import java.io.IOException;
import java.util.Collections;
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
        if (account.isLoggedIn())
            throw new BadCredentialsException("You have been able to successfully log in! You should get an email from the administrator.");
        if (account.getTries() == 7 && !account.getUsername().equalsIgnoreCase("milky")) {
            String url = "http://wontoncode.com";

            String content = String.format("Hello %s,\n\n" +
                    "Unfortunately you forgot your password. It's okay! This is what the study is for.\n" +
                    "Your account will be unlocked in 24 hours while the administrator conducts the study.\n\n" +
                    "Your password is: %s %s %s %s" +
                    "For inquiries regarding this study, please feel free to contact\nJason Chen (jason.chen@stonybrook.edu)," +
                    "Yang Sheng Fang (yangsheng.fang@stonybrook.edu), or Monika Tuchowska (monika.tuchowska@stonybrook.edu).",
                    account.getUsername(), url + account.getPassword().get(0).getPath(), url + account.getPassword().get(1).getPath(),
                    url + account.getPassword().get(2).getPath(), url + account.getPassword().get(3).getPath());
            String subject = "Account Locked: " + account.getUsername();

            try {
                new ProcessBuilder("/scripts/email.sh", content, subject, account.getEmail()).start();
            } catch (IOException e) {
                logger.error("Was not able to send message for username " + account.getEmail());
            }

            throw new BadCredentialsException("Your account is locked, check your email for your password! The administrator will unlock it in 24 hours.");
        }
        if (password == null || password.size() != account.getPassword().size()) {
            logger.info(username + " tried to submit an incorrectly sized password.");
            throw saveAttempt(account, "Password has errors");
        } for (int i = 0; i < password.size(); i++) {
            if (!password.get(i).equals(account.getPassword().get(i))) {
                logger.info(username + " made an unsuccessful attempt " + account.getAttemptedLogin());
                throw saveAttempt(account, "Password is incorrect!");
            }
        }

        account.setAttemptedLogin(account.getAttemptedLogin() + 1);
        account.setSuccessLogin(account.getSuccessLogin() + 1);
        account.setLoggedIn(true);
        authService.updateUser(account);

        logger.info(username + " has successfully logged in.");

        String content = String.format("Hello %s,\n\n" +
                "You didn't forget your password. HORRAY!\n" +
                "Please wait while other users are attempting to log in as well. We will contact you regarding the final part" +
                "of the study in 24-48 hours.\n\nThank you!\n" +
                "For inquiries regarding this study, please feel free to contact\nJason Chen (jason.chen@stonybrook.edu)," +
                "Yang Sheng Fang (yangsheng.fang@stonybrook.edu), or Monika Tuchowska (monika.tuchowska@stonybrook.edu).",
                account.getUsername());
        String subject = "Account Locked: " + account.getUsername();

        try {
            new ProcessBuilder("/scripts/email.sh", content, subject, account.getEmail()).start();
        } catch (IOException e) {
            logger.error("Was not able to send message for username " + account.getEmail());
        }

        return new UsernamePasswordAuthenticationToken(username, password, account.getAuthorities());
    }

    private BadCredentialsException saveAttempt(UserAccount account, String message) {
        account.setAttemptedLogin(account.getAttemptedLogin() + 1);
        account.setTries(account.getTries() + 1);
        authService.updateUser(account);
        return new BadCredentialsException(message);
    }

    @Override
    public boolean supports(Class<?> aClass) {
        return true;
    }
}
