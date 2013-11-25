package org.security.dao;

import org.security.model.UserAccount;

/**
 * User: Milky
 * Date: 11/25/13
 * Time: 4:19 PM
 */
public interface UserDao {

    public UserAccount getUserByUsername(String username);
    public void addUser(String username);
}
