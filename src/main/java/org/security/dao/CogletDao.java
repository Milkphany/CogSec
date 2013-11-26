package org.security.dao;


import org.security.model.Coglet;

import java.util.List;

/**
 * User: Milky
 * Date: 11/25/13
 * Time: 7:22 PM
 */
public interface CogletDao {

    public void addImage(String imagePath);

    public Coglet getImage(String imagePath);

    public List<Coglet> getAllImages();

    public List<Coglet> getDefaultCoglets();
}
