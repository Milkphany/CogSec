package org.security.model;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
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
public class UserAccount {

    @Id
    private String username;

    private String email;

    @ManyToMany(cascade = CascadeType.MERGE)
    @Column(nullable = false)
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<Coglet> password;

    @ManyToOne(cascade = CascadeType.ALL)
    private Role role;

    @OneToOne(mappedBy = "userAccount", cascade = CascadeType.ALL)
    @PrimaryKeyJoinColumn
    private Survey survey;

    private Integer attemptedLogin = 0;

    private Integer successLogin = 0;

    public UserAccount() {
    }

    public UserAccount(String username, List<Coglet> password) {
        this.username = username;
        this.password = password;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getUsername() {
        return username;
    }

    public List<Coglet> getPassword() {
        return password;
    }

    public void setPassword(List<Coglet> password) {
        this.password = password;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getAttemptedLogin() {
        return attemptedLogin;
    }

    public void setAttemptedLogin(Integer attemptedLogin) {
        this.attemptedLogin = attemptedLogin;
    }

    public Integer getSuccessLogin() {
        return successLogin;
    }

    public void setSuccessLogin(Integer successLogin) {
        this.successLogin = successLogin;
    }

    public Survey getSurvey() {
        return survey;
    }

    public void setSurvey(Survey survey) {
        this.survey = survey;
    }

    public Collection<? extends GrantedAuthority> getAuthorities() {
        List<GrantedAuthority> roles = new ArrayList<GrantedAuthority>();
        roles.add(role);
        return roles;
    }
}
