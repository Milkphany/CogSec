package org.security.service;

import org.security.dao.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * User: Milky
 * Date: 11/25/13
 * Time: 4:22 PM
 */
@Service
public class AuthService {

    @Autowired
    private UserDao userDao;


}
