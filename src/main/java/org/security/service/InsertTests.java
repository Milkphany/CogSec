package org.security.service;

import org.security.exception.InsertExistException;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;

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
public class InsertTests implements InitializingBean {

    @Autowired
    private AuthService authService;

    @Autowired
    private ServletContext servletContext;


    public void addImages() {
        try {
            authService.addCoglet("/images/default1.jpg", new String[]{"natures", "faces"});
            authService.addCoglet("/images/default2.jpg", new String[]{"natures"});
            authService.addCoglet("/images/default3.jpg", new String[]{"natures", "faces"});
            authService.addCoglet("/images/default4.jpg", new String[]{"natures"});
        } catch (InsertExistException e) {
            System.out.println("Images already exist wtf you doing?");
        }
    }

    public void addPeople() {
        try {
            authService.addDefaultUser("milky");

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

    @Override
    public void afterPropertiesSet() throws Exception {
        addImages();
        addPeople();
        createSymLink();
    }
}
