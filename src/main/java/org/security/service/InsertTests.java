package org.security.service;

import org.security.exception.InsertExistException;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * User: Milky
 * Date: 11/25/13
 * Time: 7:32 PM
 */
public class InsertTests implements InitializingBean {

    @Autowired
    private AuthService authService;

    public void addImages() {
        try {
            authService.addCoglet("/images/cbar.jpg");
            authService.addCoglet("/images/env.jpg");
            authService.addCoglet("/images/topstudents.jpg");
        } catch (InsertExistException e) {
            System.out.println("Images already exist wtf you doing?");
        }
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        addImages();
    }
}
