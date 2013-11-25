package org.security.domain;

import org.security.model.UserAccount;
import org.security.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/")
public class HomeController {

    @Autowired
    private AuthService authService;

	@RequestMapping(method = RequestMethod.GET)
	public String printWelcome() {
		return "home/home";
	}

    @RequestMapping(value = "new", method = RequestMethod.GET)
    public String addUser(ModelMap model) {

        authService.addUser("Bob");

        UserAccount userAccount = authService.getUser("Bob");

        model.addAttribute("useraccount", userAccount);

        return "home/home";
    }
}