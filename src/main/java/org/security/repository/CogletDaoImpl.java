package org.security.repository;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.security.dao.CogletDao;

import org.security.model.Cogleter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;


/**
 * User: Milky
 * Date: 11/25/13
 * Time: 7:22 PM
 */
@Repository
@Transactional
public class CogletDaoImpl implements CogletDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void addCoglet(Cogleter coglet) {
        sessionFactory.getCurrentSession().save(coglet);
    }

    @Override
    public Cogleter getCoglet(Cogleter coglet) {
        return (Cogleter) sessionFactory.getCurrentSession()
                .get(Cogleter.class, coglet.getPath());
    }

    @SuppressWarnings("unchecked")
    public List<Cogleter> getAllImages() {
        return (List<Cogleter>) sessionFactory.getCurrentSession()
                .createQuery("from Cogleter")
                .list();
    }

    public List<Cogleter> getDefaultCoglets() {
        Session session = sessionFactory.getCurrentSession();
        List<Cogleter> defaultCogs = new ArrayList<Cogleter>();
        defaultCogs.add((Cogleter) session.createQuery("from Cogleter where path = '/images/default1.jpg'").uniqueResult());
        defaultCogs.add((Cogleter) session.createQuery("from Cogleter where path = '/images/default2.jpg'").uniqueResult());
        defaultCogs.add((Cogleter) session.createQuery("from Cogleter where path = '/images/default3.jpg'").uniqueResult());
        defaultCogs.add((Cogleter) session.createQuery("from Cogleter where path = '/images/default4.jpg'").uniqueResult());

        return defaultCogs;
    }

}
