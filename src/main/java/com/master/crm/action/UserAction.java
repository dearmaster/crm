package com.master.crm.action;

import com.master.crm.model.Credential;
import com.master.crm.model.User;
import com.master.crm.service.UserService;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.Set;

@Component("userAction")
@Scope("prototype")
public class UserAction extends ActionSupport implements ServletRequestAware {

    private static final Logger logger = Logger.getLogger(UserAction.class);

    @Autowired
    private UserService userService;

    private User user;

    private Credential credential;

    private HttpServletRequest request;

    @Override
    public String execute() throws Exception {
        return SUCCESS;
    }

    public String registerUser() throws Exception {
        userService.register(user, credential);
        return SUCCESS;
    }

    public String deleteUser() throws Exception {
        userService.del(user);
        return SUCCESS;
    }

    public String loadAllUser() throws Exception {
        Set<User> users = userService.loadAll();
        System.out.println(users);
        return SUCCESS;
    }

    @Override
    public void setServletRequest(HttpServletRequest request) {
        this.request = request;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Credential getCredential() {
        return credential;
    }

    public void setCredential(Credential credential) {
        this.credential = credential;
    }
}
