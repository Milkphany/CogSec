package org.security.model;

import javax.persistence.*;
import java.io.Serializable;

/**
 * User: Milky
 * Date: 12/7/13
 * Time: 5:34 PM
 */
@Entity
@Table(name = "Survey")
public class Survey implements Serializable {

    @Id
    @GeneratedValue
    private Integer id;

    private String difficultyCreate;
    private String difficultyLogin;
    private Integer age;
    private String major;

    @OneToOne(cascade = CascadeType.PERSIST)
    private UserAccount userAccount;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDifficultyLogin() {
        return difficultyLogin;
    }

    public void setDifficultyLogin(String login) {
        this.difficultyLogin = login;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    public String getDifficultyCreate() {
        return difficultyCreate;
    }

    public void setDifficultyCreate(String create) {
        this.difficultyCreate = create;
    }

    public UserAccount getUserAccount() {
        return userAccount;
    }

    public void setUserAccount(UserAccount user) {
        this.userAccount = user;
    }
}
