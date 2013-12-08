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
public class Role implements GrantedAuthority, Comparable<Role> {

    @Id
    private String role;

    public Role() {
    }

    public Role(String role) {
        this.role = role;
    }

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

    @Override
    public int compareTo(Role o) {
        return role.compareTo(o.getRole());
    }
}
