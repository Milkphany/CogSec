package org.security.service;

import org.security.dao.CogletDao;
import org.security.dao.UserDao;
import org.security.exception.InsertExistException;
import org.security.exception.PasswordUnsetException;
import org.security.model.Cogleter;
import org.security.model.Cogtager;
import org.security.model.Role;
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

    @Autowired
    private UserDao userDao;

    @Autowired
    private CogletDao cogletDao;

    public void addDefaultUser(String username) throws InsertExistException {
        if (getUser(username) == null) {
            UserAccount userAccount = new UserAccount();
            List<Cogleter> password = cogletDao.getDefaultCoglets();
            Role role = new Role("ROLE_ADMIN");

            userAccount.setUsername(username);
            userAccount.setPassword(password);
            userAccount.setRole(role);
            userDao.addUser(userAccount);
        } else
            throw new InsertExistException();
    }

    public List<Cogleter> getDefaultPassword() {
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

    public void addCoglet(Cogleter coglet) throws InsertExistException {
        if (cogletDao.getCoglet(coglet) == null)
            cogletDao.addCoglet(coglet);
        else
            throw new InsertExistException();
    }

    public void addCoglet(String imagePath, String[] tags) throws InsertExistException {
        Cogleter coglet = new Cogleter(imagePath);

        List<Cogtager> cogTags = new ArrayList<Cogtager>();
        for (String tag : tags)
            cogTags.add(new Cogtager(tag));

        coglet.setTags(cogTags);
        addCoglet(coglet);
    }

    public List<Cogleter> getAllCoglets() {
        return cogletDao.getAllImages();
    }

}
