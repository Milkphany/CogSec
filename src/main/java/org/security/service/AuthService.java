package org.security.service;

import org.security.dao.CogletDao;
import org.security.dao.UserDao;
import org.security.exception.InsertExistException;
import org.security.exception.PasswordUnsetException;
import org.security.model.Coglet;
import org.security.model.UserAccount;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
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
        if (getUser(username) == null) {
            UserAccount userAccount = new UserAccount();
            List<Coglet> password = new ArrayList<Coglet>();

            password.add(new Coglet("/images/default1.jpg"));
            password.add(new Coglet("/images/default2.jpg"));
            password.add(new Coglet("/images/default3.jpg"));
            password.add(new Coglet("/images/default4.jpg"));

            userAccount.setUsername(username);
            userAccount.setPassword(password);
            userDao.addUser(userAccount);
        } else
            throw new InsertExistException();
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
