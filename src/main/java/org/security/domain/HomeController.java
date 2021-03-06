package org.security.domain;

import org.jboss.logging.Logger;
import org.security.exception.CogtagExistException;
import org.security.exception.InsertExistException;
import org.security.exception.PasswordUnsetException;
import org.security.model.*;
import org.security.service.AuthService;
import org.security.service.CogAuthenticationProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.access.prepost.PreAuthorize;
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
import java.io.IOException;
import java.util.*;

@Controller
@RequestMapping("/")
public class HomeController {

    @Autowired
    private AuthService authService;

    @Autowired
    @Qualifier("cogAuthenticationProvider")
    private CogAuthenticationProvider authenticationProvider;

    private Logger logger = Logger.getLogger(HomeController.class);

	@RequestMapping(method = RequestMethod.GET)
	public String printWelcome(ModelMap modelMap) {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();

        if (auth.getPrincipal().equals("anonymousUser"))
            return "home/home";

        if (auth.getAuthorities().contains(new Role("ROLE_USER")))
            modelMap.addAttribute("logUser", authService.getUser(auth.getName()));

        if (auth.getAuthorities().contains(new Role("ROLE_ADMIN"))) {
            modelMap.addAttribute("users", authService.getAllUsers());
            modelMap.addAttribute("coglets", authService.getAllCoglets());
        }
        modelMap.addAttribute("tags", authService.getAllCogtags());

        return "home/home";
	}

    @PreAuthorize("hasRole('ROLE_ADMIN')")
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

        if (!userAccount.getEmail().isEmpty()) {
            String content = String.format("Hello %s,\n\n" +
                    "Thank you for signing up to participate in this study.\nIf you have not yet done so, " +
                    "please complete Part 1 by logging back into your account at http://wontoncode.com/login\n\n" +
                    "We will contact you this week to schedule an appointment for completing Part 2 of the study, in which we will test your ability " +
                    "to guess another participant's password based on their description of the images.\n\n" +
                    "For inquiries regarding this study, please feel free to contact\nJason Chen (jason.chen@stonybrook.edu)," +
                    "Yang Sheng Fang (yangsheng.fang@stonybrook.edu), or Monika Tuchowska (monika.tuchowska@stonybrook.edu).",
                    userAccount.getUsername());
            String subject = "Participation confirmed for " + userAccount.getUsername();

            try {
                new ProcessBuilder("/scripts/email.sh", content, subject, userAccount.getEmail()).start();
            } catch (IOException e) {
                logger.error("Was not able to send message for username " + userAccount.getEmail());
            }
        }

        RedirectView view = new RedirectView("/surveys");
        view.setExposeModelAttributes(false);

        return new ModelAndView(view);
    }

    @RequestMapping(value = "taken", method = RequestMethod.GET)
    public @ResponseBody String getError() {
        return "User name is already taken";
    }

    @PreAuthorize("hasRole('ROLE_ADMIN')")
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

            survey.setUserAccount(account);
            account.setSurvey(survey);
            authService.updateUser(account);

            attributes.addFlashAttribute("loginMessage", "Thank you for completing the survey. You will receive a confirmation email at: " + account.getEmail() +
                    "<br>Please log in to make sure your password is working correctly.");


            new SecurityContextLogoutHandler().logout(request, response, auth);
        }

        SecurityContextHolder.getContext().setAuthentication(null);

        return "redirect:/login";
    }

    @RequestMapping(value ="login",method = RequestMethod.GET)
    public String getLogin(ModelMap modelMap) {
        return "/home/login";
    }

    @RequestMapping(value ="tag",method = RequestMethod.GET)
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String tagImages (@RequestParam(required = false, defaultValue = "2") Integer tagReq, ModelMap modelMap) {
        List<Coglet> coglets = authService.getCogletsTagConditions(true, tagReq, 100);
        modelMap.addAttribute("coglets",coglets);
        modelMap.addAttribute("editable", true);

        return "/home/img-tag";
    }

    @RequestMapping(value = "tagged", method = RequestMethod.GET)
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String taggedImages (@RequestParam(required = false, defaultValue = "1") Integer tagReq, ModelMap modelMap) {
        List<Coglet> coglets = authService.getCogletsTagConditions(false, tagReq, 10000);
        modelMap.addAttribute("coglets", coglets);
        modelMap.addAttribute("editable", false);

        return "/home/img-tag";
    }

    @PreAuthorize("hasAnyRole({'ROLE_USER', 'ROLE_ADMIN'})")
    @RequestMapping(value = "tagwith", method = RequestMethod.GET)
    public String taggedWith(@RequestParam(required = false) String[] taglist,
                             @RequestParam(required = false) String[] untaglist,
                             ModelMap modelMap) {
        Set<Coglet> coglets = authService.getCogletWithCogtags(taglist, untaglist);

        modelMap.addAttribute("coglets", coglets);
        return "pagefrags/img-tag-with";
    }

    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @RequestMapping(value="ajax", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    public @ResponseBody String tagImg (@RequestParam String cogId,
                                        @RequestParam String[] tags)  {

        Coglet coglet = authService.getCogletById(cogId);
        if (coglet == null)
            return "Image was not found on database";

        int initSize = coglet.getTags().size();

        List<Cogtag> cogtags = new ArrayList<Cogtag>(tags.length);
        cogtags.addAll(coglet.getTags());

        for (int i = 0; i < tags.length; i++) {
            if (tags[i].isEmpty()) {
                tags[i] = "<font color=\"orange\">Tag was empty</font>";
                continue;
            }

            Cogtag tag = new Cogtag(tags[i]);
            try {

                authService.addCogtag(tag);
                cogtags.add(tag);
                tags[i] = tags[i] + " was added successfully.";
            } catch (CogtagExistException e) {
                tags[i] = "<font color=\"red\">" + tags[i] + " was not added because it already exists.</font>";
                cogtags.add(tag);
            }
        }

        coglet.setTags(cogtags);
        if (initSize != cogtags.size())
            authService.updateCoglet(coglet);

        StringBuilder builder = new StringBuilder();
        for (String tagMsg : tags)
            builder.append(tagMsg + " ");

        return "<b>Tags have been added to image. " + builder.toString() + "</b>";
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

        modelMap.addAttribute("tries", userAccount.getTries());
        modelMap.addAttribute("loginMessage", "You have failed too hard");
        modelMap.addAttribute("passwordSelection", passwords);
        return "/home/login2";
    }
}