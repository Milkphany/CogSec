package org.security.model;

import org.springframework.security.core.GrantedAuthority;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * User: Milky
 * Date: 11/25/13
 * Time: 3:33 PM
 */
@Entity
@Table(name = "UserAccount")
public class UserAccount implements CogUserDetails {

    @Id
    private String username;

    @ManyToMany(cascade = CascadeType.PERSIST, fetch = FetchType.EAGER)
    @Column(nullable = false)
    private List<Coglet> cogPassword;

    @ManyToOne(cascade = CascadeType.PERSIST)
    private Role role;

    public UserAccount() {
    }

    public UserAccount(String username, List<Coglet> cogPassword) {
        this.username = username;
        this.cogPassword = cogPassword;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getUsername() {
        return username;
    }

    public List<Coglet> getCogPassword() {
        return cogPassword;
    }

    public void setCogPassword(List<Coglet> password) {
        this.cogPassword = password;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        List<GrantedAuthority> roles = new ArrayList<GrantedAuthority>();
        roles.add(role);
        return roles;
    }

    @Override
    public String getPassword() {
        return null;  //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public boolean isAccountNonExpired() {
        return false;
    }

    @Override
    public boolean isAccountNonLocked() {
        return false;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return false;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
