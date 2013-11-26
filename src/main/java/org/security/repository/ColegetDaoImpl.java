package org.security.repository;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.security.dao.CogletDao;

import org.security.model.Coglet;
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
public class ColegetDaoImpl implements CogletDao {

    @Autowired
    private SessionFactory sessionFactory;

    public void addImage(String imagePath) {
        Coglet coglet = new Coglet();
        coglet.setPath(imagePath);

        sessionFactory.getCurrentSession().save(coglet);
    }

    public Coglet getImage(String imagePath) {
        return (Coglet) sessionFactory.getCurrentSession()
                .createQuery("from Coglet where id = :imagePath")
                .setString("imagePath", imagePath)
                .uniqueResult();
    }

    @SuppressWarnings("unchecked")
    public List<Coglet> getAllImages() {
        return (List<Coglet>) sessionFactory.getCurrentSession()
                .createQuery("from Coglet")
                .list();
    }

    public List<Coglet> getDefaultCoglets() {
        Session session = sessionFactory.getCurrentSession();
        List<Coglet> defaultCogs = new ArrayList<Coglet>();
        defaultCogs.add((Coglet) session.createQuery("from Coglet where path = '/images/default1.jpg'").uniqueResult());
        defaultCogs.add((Coglet) session.createQuery("from Coglet where path = '/images/default2.jpg'").uniqueResult());
        defaultCogs.add((Coglet) session.createQuery("from Coglet where path = '/images/default3.jpg'").uniqueResult());
        defaultCogs.add((Coglet) session.createQuery("from Coglet where path = '/images/default4.jpg'").uniqueResult());

        return defaultCogs;
    }
}
