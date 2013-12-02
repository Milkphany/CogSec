package org.security.dao;


import org.security.model.Cogleter;

import java.util.List;

/**
 * User: Milky
 * Date: 11/25/13
 * Time: 7:22 PM
 */
public interface CogletDao {

    public void addCoglet(Cogleter coglet);

    public Cogleter getCoglet(Cogleter coglet);

    public List<Cogleter> getAllImages();

    public List<Cogleter> getDefaultCoglets();

}
