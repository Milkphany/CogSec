package org.security.service;

import org.security.dao.UserDao;
import org.security.model.UserAccount;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * User: Milky
 * Date: 11/25/13
 * Time: 4:22 PM
 */
@Service
public class AuthService {

    @Autowired
    private UserDao userDao;

    public void addUser(String username) {
        userDao.addUser(username);
    }

    public void addUser(UserAccount userAccount) {
        userDao.addUser(userAccount.getUsername());
    }

    public UserAccount getUser(String username) {
        return userDao.getUserByUsername(username);
    }

    public List<UserAccount> getAllUsers() {
        return userDao.getAllUsers();
    }
}
