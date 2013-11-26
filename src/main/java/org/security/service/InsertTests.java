package org.security.service;

import org.security.exception.InsertExistException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.ServletContextAware;

import javax.servlet.ServletContext;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 * User: Milky
 * Date: 11/25/13
 * Time: 7:32 PM
 */
public class InsertTests implements ServletContextAware {

    @Autowired
    private AuthService authService;

    private ServletContext servletContext;

    public void addImages() {
        try {
            authService.addCoglet("/images/default1.jpg");
            authService.addCoglet("/images/default2.jpg");
            authService.addCoglet("/images/default3.jpg");
            authService.addCoglet("/images/default4.jpg");
            authService.addCoglet("/images/cbar.jpg");
            authService.addCoglet("/images/env.jpg");
        } catch (InsertExistException e) {
            System.out.println("Images already exist wtf you doing?");
        }
    }

    public void addPeople() {
        try {
            authService.addUser("Baby");
            authService.addUser("Mommy");
            authService.addUser("Tester");
            authService.addUser("jaschen");
            authService.addUser("Robert Paulson");

        } catch (InsertExistException e) {
            System.out.println("User already exists!!");
        }
    }

    private void createSymLink() {
        Path rootPath = Paths.get("/images");
        Path webPath = Paths.get(servletContext.getRealPath("/") + "resources/images");

        System.err.println(rootPath);
        System.err.println(webPath);
        try {
            Files.createSymbolicLink(webPath, rootPath);
        } catch (IOException e) {
            System.out.println("Were not able to create symbolic path due to io error");
        } catch (UnsupportedOperationException e) {
            System.out.println("Were not able to create symbolic path idk why");
        }
    }

    public void initData(){
        addImages();
        addPeople();
        createSymLink();
    }

    @Override
    public void setServletContext(ServletContext servletContext) {
        this.servletContext = servletContext;
    }
}
