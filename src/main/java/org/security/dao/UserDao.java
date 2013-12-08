package org.security.dao;

import org.security.model.Survey;
import org.security.model.UserAccount;

import java.util.List;

/**
 * User: Milky
 * Date: 11/25/13
 * Time: 4:19 PM
 */
public interface UserDao {

    public UserAccount getUserByUsername(String username);
    public void addUser(UserAccount userAccount);
    public List<UserAccount>  getAllUsers();
    public void updateUser(UserAccount account);
    public Survey saveSurvey(Survey survey);
}
