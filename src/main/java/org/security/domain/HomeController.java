package org.security.domain;

import org.security.exception.InsertExistException;
import org.security.exception.PasswordUnsetException;
import org.security.model.Role;
import org.security.model.UserAccount;
import org.security.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
        modelMap.addAttribute("coglets", authService.getAllCoglets());
        //modelMap.addAttribute("categories", authService.getAllCogtags());

        modelMap.addAttribute("specific", authService.getCogletWithCogtag("admin"));

		return "home/home";
	}

    @RequestMapping(value = "new", method = RequestMethod.POST)
    public String addUser(@ModelAttribute("userAccount") UserAccount userAccount,
                          RedirectAttributes attributes) {

        try {
            userAccount.setPassword(authService.getDefaultPassword());
            userAccount.setRole(new Role("ROLE_ADMIN"));

            authService.addUser(userAccount);
            attributes.addFlashAttribute("newuser", userAccount);
        } catch (InsertExistException e) {
            attributes.addFlashAttribute("error", userAccount.getUsername()
                    + " already exist, was not added to system");
        } catch (PasswordUnsetException e) {
            attributes.addFlashAttribute("error", userAccount.getUsername()
                    + " password not correct issue");
        }

        return "redirect:/";
    }

    @RequestMapping(value ="test",method = RequestMethod.GET)
    public String getTest(ModelMap modelMap) {

        return "/home/test";
    }

    @RequestMapping(value ="login",method = RequestMethod.GET)
    public String getLogin(ModelMap modelMap) {

        return "/home/login";
    }

    @RequestMapping(value ="login2",method = RequestMethod.GET)
    public String getNextLogin(ModelMap modelMap) {

        return "/home/login2";
    }
}