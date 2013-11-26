package org.security.service;

import org.security.dao.CogletDao;
import org.security.dao.UserDao;
import org.security.exception.InsertExistException;
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

    private UserDao userDao;
    private CogletDao cogletDao;

    @Autowired
    public AuthService(UserDao userDao, CogletDao cogletDao) {
        this.userDao = userDao;
        this.cogletDao = cogletDao;
    }

    public void addUser(String username) throws InsertExistException {
        if (getUser(username) == null)
            userDao.addUser(username);
        else
            throw new InsertExistException();
    }

    public void addUser(UserAccount userAccount) throws InsertExistException {
        addUser(userAccount.getUsername());
    }

    public UserAccount getUser(String username) {
        return userDao.getUserByUsername(username);
    }

    public List<UserAccount> getAllUsers() {
        return userDao.getAllUsers();
    }

    public void addCoglet(String imagePath) throws InsertExistException {
        if (cogletDao.getImage(imagePath) != null)
            cogletDao.addImage(imagePath);
        else
            throw new InsertExistException();
    }
}
