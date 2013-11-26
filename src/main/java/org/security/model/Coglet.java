package org.security.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

/**
 * User: Milky
 * Date: 11/25/13
 * Time: 5:59 PM
 */
@Entity
@Table(name = "Coglet", uniqueConstraints = @UniqueConstraint(columnNames = "path"))
public class Coglet {

    @Id
    private String path;

    public Coglet() {
    }

    public Coglet(String path) {
        this.path = path;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }
}
