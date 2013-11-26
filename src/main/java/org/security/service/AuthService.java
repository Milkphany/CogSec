package org.security.service;

import org.security.dao.CogletDao;
import org.security.dao.UserDao;
import org.security.exception.InsertExistException;
import org.security.exception.PasswordUnsetException;
import org.security.model.Coglet;
import org.security.model.UserAccount;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
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

    @Autowired
    private CogletDao cogletDao;

    public void addUser(String username) throws InsertExistException {
        if (getUser(username) == null) {
            UserAccount userAccount = new UserAccount();
            List<Coglet> password = cogletDao.getDefaultCoglets();

            userAccount.setUsername(username);
            userAccount.setPassword(password);
            userDao.addUser(userAccount);
        } else
            throw new InsertExistException();
    }

    public List<Coglet> getDefaultPassword() {
        return cogletDao.getDefaultCoglets();
    }

    public void addUser(UserAccount userAccount) throws InsertExistException, PasswordUnsetException {
        if (userAccount.getPassword() == null)
            throw new PasswordUnsetException();
        else
            userDao.addUser(userAccount);
    }

    public UserAccount getUser(String username) {
        return userDao.getUserByUsername(username);
    }

    public List<UserAccount> getAllUsers() {
        return userDao.getAllUsers();
    }

    public void addCoglet(String imagePath) throws InsertExistException {
        if (cogletDao.getImage(imagePath) == null)
            cogletDao.addImage(imagePath);
        else
            throw new InsertExistException();
    }

    public List<Coglet> getAllCoglets() {
        return cogletDao.getAllImages();
    }

}
