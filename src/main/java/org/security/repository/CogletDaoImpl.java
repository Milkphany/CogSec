package org.security.repository;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.security.dao.CogletDao;

import org.security.model.Coglet;
import org.security.model.Cogtag;
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
    public void addCoglet(Coglet coglet) {
        sessionFactory.getCurrentSession().save(coglet);
    }

    @Override
    public void addCogtag(Cogtag cogtag) {
        sessionFactory.getCurrentSession().save(cogtag);
    }

    @Override
    public Coglet getCoglet(Coglet coglet) {
        return (Coglet) sessionFactory.getCurrentSession()
                .get(Coglet.class, coglet.getPath());
    }

    @SuppressWarnings("unchecked")
    public List<Coglet> getTopFiftyImages() {
        return (List<Coglet>) sessionFactory.getCurrentSession()
                .createQuery("from Coglet")
                .setMaxResults(50)
                .list();
    }

    @Override
    public List<Cogtag> getAllTags() {
        return sessionFactory.getCurrentSession()
                .createQuery("from Cogtag")
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

    @Override
    public List<Coglet> getCogletsCategory(Cogtag cogtag) {
        List<Coglet> coglets = sessionFactory.getCurrentSession()
                .createQuery("from Coglet as cg where :cogtag in elements(cg.tags)")
                .setString("cogtag", cogtag.getTagName())
                .list();
        return coglets;
    }

    @Override
    public Integer getNumCogletCategory(Cogtag cogtag) {
        return ((Long) sessionFactory.getCurrentSession()
                .createQuery("select count(*) from Coglet as cg where :cogtag in elements(cg.tags)")
                .setString("cogtag", cogtag.getTagName())
                .uniqueResult()).intValue();
    }


    public List<Coglet> getCogletsTagConditions(boolean lessThan, int upper, int num) {
        String symbol = lessThan ? " < " : " > ";

        List<Coglet> coglets = sessionFactory.getCurrentSession()
                .createQuery("from Coglet as cg where cg.tags.size " + symbol + upper)
                .setFirstResult(0)
                .setMaxResults(num)
                .list();
        return coglets;
    }

    @Override
    public Coglet getCogletWithCategoryPosition(Cogtag cogtag, Integer pos) {
        return (Coglet) sessionFactory.getCurrentSession()
                .createQuery("from Coglet as cg where :cogtag in elements(cg.tags)")
                .setString("cogtag", cogtag.getTagName())
                .setFirstResult(pos)
                .setMaxResults(1)
                .uniqueResult();
    }

    @Override
    public void updateCoglet(Coglet coglet) {
        sessionFactory.getCurrentSession().saveOrUpdate(coglet);
    }

    @Override
    public Cogtag getCogtag(Cogtag cogtag) {
        return (Cogtag) sessionFactory.getCurrentSession()
                .createQuery("from Cogtag where tagName = :tag")
                .setString("tag", cogtag.getTagName())
                .uniqueResult();
    }
}
