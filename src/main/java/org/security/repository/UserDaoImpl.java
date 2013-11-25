package org.security.repository;

import org.hibernate.SessionFactory;
import org.security.dao.UserDao;
import org.security.model.UserAccount;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 * User: Milky
 * Date: 11/25/13
 * Time: 4:20 PM
 */
@Repository
public class UserDaoImpl implements UserDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Transactional
    public UserAccount getUserByUsername(String username) {
        return (UserAccount) sessionFactory.getCurrentSession()
                .createQuery("from UserAccount where username = :username")
                .uniqueResult();
    }

    @Transactional
    public void addUser(String username) {
        UserAccount account = new UserAccount();
        account.setUsername(username);

        sessionFactory.getCurrentSession().save(account);
    }


}
