package org.security.domain;

import org.security.exception.InsertExistException;
import org.security.exception.PasswordUnsetException;
import org.security.model.Coglet;
import org.security.model.Role;
import org.security.model.Survey;
import org.security.model.UserAccount;
import org.security.service.AuthService;
import org.security.service.CogAuthenticationProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

@Controller
@RequestMapping("/")
public class HomeController {

    @Autowired
    private AuthService authService;

    @Autowired
    @Qualifier("cogAuthenticationProvider")
    private CogAuthenticationProvider authenticationProvider;

	@RequestMapping(method = RequestMethod.GET)
	public String printWelcome(ModelMap modelMap) {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (!auth.getPrincipal().equals("anonymousUser") && auth.getAuthorities().contains(new Role("ROLE_ADMIN"))) {
            modelMap.addAttribute("users", authService.getAllUsers());
            modelMap.addAttribute("coglets", authService.getAllCoglets());
        }

        return "home/home";
	}

    @RequestMapping(method = RequestMethod.POST)
    public ModelAndView addUser(@ModelAttribute("userAccount") UserAccount userAccount,
                          HttpServletRequest request,
                          RedirectAttributes attributes) {

        try {
            List<Coglet> password = new ArrayList<Coglet>();
            for (String passfrag : request.getParameterValues("password"))
                password.add(authService.getCogletById(passfrag));

            userAccount.setPassword(password);
            userAccount.setRole(new Role("ROLE_USER"));

            authService.addUser(userAccount);
            attributes.addFlashAttribute("newuser", userAccount);
        } catch (InsertExistException e) {
            attributes.addFlashAttribute("error", userAccount.getUsername()
                    + " already exist, was not added to system");
        } catch (PasswordUnsetException e) {
            attributes.addFlashAttribute("error", userAccount.getUsername()
                    + " password not correct issue");
        }

        UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(
                userAccount.getUsername(), userAccount.getPassword());

        // generate session if one doesn't exist
        request.getSession();

        token.setDetails(new WebAuthenticationDetails(request));
        Authentication authenticatedUser = authenticationProvider.authenticate(token);

        SecurityContextHolder.getContext().setAuthentication(authenticatedUser);

        RedirectView view = new RedirectView("/surveys");
        view.setExposeModelAttributes(false);

        return new ModelAndView(view);
    }

    @RequestMapping(value = "taken", method = RequestMethod.GET)
    public @ResponseBody String getError() {
        return "User name is already taken";
    }

    @RequestMapping(value ="register-photos",method = RequestMethod.GET)
    public String getRegistrationPhotos(@RequestParam String username, ModelMap modelMap) {

        if (username.isEmpty() || authService.getUser(username) != null)
            return "forward:/taken";

        Random random = new Random();
        String category;

        switch(random.nextInt(3)) {
            case 0:
                category = "natures";
                break;
            case 1:
                category = "animals";
                break;
            default:
                category = "faces";
        }

        modelMap.addAttribute("specific", authService.getRandomCogletWithCogtag(category, 24, new Random()));
        modelMap.addAttribute("user", new UserAccount());
        return "home/register-photos";
    }

    @ModelAttribute("surveyForm")
    public Survey surveyForm() {
        return new Survey();
    }

    @RequestMapping(value ="surveys",method = RequestMethod.GET)
    public String getSurvey(ModelMap modelMap) {
        return "home/register-survey";
    }

    @RequestMapping(value ="consent",method = RequestMethod.GET)
    public String getConsent(ModelMap modelMap) {
        return "home/informed-consent";
    }

    @RequestMapping(value ="surveys", method = RequestMethod.POST)
    public String submitSurvey(@ModelAttribute Survey survey, RedirectAttributes attributes,
                               HttpServletRequest request, HttpServletResponse response) {


        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            UserAccount account = authService.getUser(auth.getName());
            account.setSurvey(survey);
            authService.saveSurvey(survey);
            authService.updateUser(account);
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        SecurityContextHolder.getContext().setAuthentication(null);

        attributes.addFlashAttribute("loginMessage", "Thank you for completing the survey.<br>Please log in to make sure your password is working correctly.");
        return "redirect:/login";
    }

    @RequestMapping(value ="login",method = RequestMethod.GET)
    public String getLogin(ModelMap modelMap) {

        return "/home/login";
    }

    @RequestMapping(value ="login2",method = RequestMethod.POST)
    public String getNextLogin(ModelMap modelMap, HttpServletRequest request) {
        String username = request.getParameter("username");
        modelMap.addAttribute("username", username);

        Random random = new Random(username.hashCode());

        UserAccount userAccount = authService.getUser(username);
        String category = userAccount.getPassword().get(0).getTags().get(0).getTagName();

        List<Coglet> passwords = authService.getRandomCogletWithCogtag(category, 20, random);
        for (Coglet pass : userAccount.getPassword())
            passwords.add(pass);

        Collections.shuffle(passwords);

        modelMap.addAttribute("passwordSelection", passwords);
        return "/home/login2";
    }
}