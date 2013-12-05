package org.security.model;

import org.hibernate.annotations.IndexColumn;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

/**
 * User: Milky
 * Date: 11/25/13
 * Time: 5:59 PM
 */
@Entity
@Table(name = "Coglet", uniqueConstraints = @UniqueConstraint(columnNames = "path"))
public class Coglet implements Serializable {

    @Id
    private String path;

    @ManyToMany(cascade = CascadeType.ALL)
    @JoinColumn(name = "path")
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<Cogtag> tags;

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

    public List<Cogtag> getTags() {
        return tags;
    }

    public void setTags(List<Cogtag> tags) {
        this.tags = tags;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Coglet coglet = (Coglet) o;

        return this.path.equals(coglet.getPath());
    }

}
