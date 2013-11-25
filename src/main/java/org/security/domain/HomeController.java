package org.security.domain;

import org.security.model.UserAccount;
import org.security.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/")
public class HomeController {

    @Autowired
    private AuthService authService;

	@RequestMapping(method = RequestMethod.GET)
	public String printWelcome(ModelMap modelMap) {
        modelMap.addAttribute("user", new UserAccount());
        modelMap.addAttribute("users", authService.getAllUsers());

		return "home/home";
	}

    @RequestMapping(value = "new", method = RequestMethod.POST)
    public String addUser(@ModelAttribute("userAccount") UserAccount userAccount,
                          RedirectAttributes attributes) {

        if (authService.getUser(userAccount.getUsername()) == null) {
            authService.addUser(userAccount);
            attributes.addFlashAttribute("newuser", userAccount);
        }
        else
            attributes.addFlashAttribute("error", userAccount.getUsername()
                    + " already exist, was not added to system");

        return "redirect:/";
    }
}