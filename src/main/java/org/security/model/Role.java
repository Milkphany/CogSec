package org.security.model;

import org.springframework.security.core.GrantedAuthority;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * User: Milky
 * Date: 11/26/13
 * Time: 11:52 AM
 */
@Entity
@Table(name = "Role")
public class Role implements GrantedAuthority {

    @Id
    private String role;

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public String getAuthority() {
        return role;
    }
}
