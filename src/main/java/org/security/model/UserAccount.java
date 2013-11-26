package org.security.model;

import javax.persistence.*;
import java.util.List;

/**
 * User: Milky
 * Date: 11/25/13
 * Time: 3:33 PM
 */
@Entity
@Table(name = "UserAccount")
public class UserAccount {

    @Id
    private String username;

    @OneToMany
    private List<Coglet> password;

    public UserAccount() {
    }

    public UserAccount(String username, List<Coglet> password) {
        this.username = username;
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public List<Coglet> getPassword() {
        return password;
    }

    public void setPassword(List<Coglet> password) {
        this.password = password;
    }
}
