package org.security.domain;

import org.security.exception.InsertExistException;
import org.security.model.UserAccount;
import org.security.service.AuthService;
import org.security.service.InsertTests;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@Controller
@RequestMapping("/")
public class HomeController implements ServletContextAware {

    @Autowired
    private AuthService authService;

    private ServletContext servletContext;

	@RequestMapping(method = RequestMethod.GET)
	public String printWelcome(ModelMap modelMap) {
        modelMap.addAttribute("user", new UserAccount());
        modelMap.addAttribute("users", authService.getAllUsers());
        modelMap.addAttribute("coglets", authService.getAllCoglets());

		return "home/home";
	}

    @RequestMapping(value = "new", method = RequestMethod.POST)
    public String addUser(@ModelAttribute("userAccount") UserAccount userAccount,
                          RedirectAttributes attributes) {

        try {
            authService.addUser(userAccount);
            attributes.addFlashAttribute("newuser", userAccount);
        } catch (InsertExistException e) {
            attributes.addFlashAttribute("error", userAccount.getUsername()
                    + " already exist, was not added to system");
        }

        return "redirect:/";
    }

    @PostConstruct
    private void createSymLink() {
        Path rootPath = Paths.get("/images");
        Path webPath = Paths.get(servletContext.getRealPath("/") + "resources/images");

        try {
            Files.createLink(webPath, rootPath);
        } catch (IOException e) {
            System.out.println("Were not able to create symbolic path due to io error");
        } catch (UnsupportedOperationException e) {
            System.out.println("Were not able to create symbolic path idk why");
        }
    }

    @Override
    public void setServletContext(ServletContext servletContext) {
        this.servletContext = servletContext;
    }
}