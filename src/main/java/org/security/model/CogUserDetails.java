package org.security.model;

import org.springframework.security.core.userdetails.UserDetails;

import java.util.List;

/**
 * User: Milky
 * Date: 11/26/13
 * Time: 12:19 PM
 */
public interface CogUserDetails extends UserDetails {

    public List<Coglet> getCogPassword();
}
