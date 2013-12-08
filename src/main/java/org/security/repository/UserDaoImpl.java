package org.security.repository;

import org.hibernate.SessionFactory;
import org.security.dao.UserDao;
import org.security.model.UserAccount;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * User: Milky
 * Date: 11/25/13
 * Time: 4:20 PM
 */
@Repository
@Transactional
public class UserDaoImpl implements UserDao {

    @Autowired
    private SessionFactory sessionFactory;

    public UserAccount getUserByUsername(String username) {
        return (UserAccount) sessionFactory.getCurrentSession()
                .createQuery("from UserAccount where username = :username")
                .setString("username", username)
                .uniqueResult();
    }

    public void addUser(UserAccount userAccount) {
        sessionFactory.getCurrentSession().save(userAccount);
    }

    @SuppressWarnings("unchecked")
    public List<UserAccount> getAllUsers() {
        return sessionFactory.getCurrentSession()
                .createQuery("from UserAccount").list();
    }

    @Override
    public void updateUser(UserAccount account) {
        sessionFactory.getCurrentSession().update(account);
    }
}
