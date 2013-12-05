package org.security.model;

import org.hibernate.annotations.IndexColumn;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * User: Milky
 * Date: 12/2/13
 * Time: 4:08 PM
 */
@Entity
@Table(name = "CogTag")
public class Cogtag {

    public Cogtag() {
    }

    public Cogtag(String tagName) {
        this.tagName = tagName;
    }

    @Id
    private String tagName;

    public String getTagName() {
        return tagName;
    }

    public void setTagName(String tagName) {
        this.tagName = tagName;
    }

}
