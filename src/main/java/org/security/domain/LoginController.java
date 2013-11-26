package org.security.domain;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;

/**
 * User: Milky
 * Date: 11/26/13
 * Time: 11:39 AM
 */
@Controller
@RequestMapping(value = "login")
public class LoginController {

    @RequestMapping(method = RequestMethod.GET)
    public String getLogin(ModelMap modelMap) {
        return "/home/login";
    }

    @RequestMapping("failed")
    public String failedLogin(ModelMap map) {;
        return "home/login";
    }

    @RequestMapping("success")
    public String successLogin(Principal principal, RedirectAttributes redirectAttributes) {
        return "home/home";
    }
}
