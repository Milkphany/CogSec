package org.security.domain;

import org.security.model.UserAccount;
import org.security.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
    public String addUser(RedirectAttributes attributes) {

        authService.addUser("Robert Paulson");

        UserAccount userAccount = authService.getUser("Robert Paulson");

        attributes.addFlashAttribute("useraccount", userAccount);

        return "redirect:/";
    }
}