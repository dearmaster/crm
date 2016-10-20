package com.master.crm.action;

import com.master.crm.enums.UserStatusType;
import com.master.crm.model.Credential;
import com.master.crm.model.User;
import com.opensymphony.xwork2.ActionProxy;
import org.apache.log4j.Logger;
import org.apache.struts2.StrutsSpringTestCase;
import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import java.util.Date;

public class UserActionTest extends StrutsSpringTestCase {

    private static final Logger logger = Logger.getLogger(UserActionTest.class);

    private ActionProxy proxy;
    private UserAction userAction;

    private static final User user;
    private static final Credential credential;

    static {
        credential = new Credential("dear", "master", UserStatusType.FROZEN, new Date());
        user = new User("lily", "女", "Shanghai", "lily.h@fox.com", null, new Date());

    }

    @Before
    public void setUp() throws Exception {
        try {
            super.setUp();
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setParameter("user.name", user.getName());
        request.setParameter("user.gender", user.getGender());
        request.setParameter("user.address", user.getAddress());
        request.setParameter("user.mail", user.getMail());
        request.setParameter("user.phone", user.getPhone());

        request.setParameter("credential.username", credential.getUsername());
        request.setParameter("credential.password", credential.getPassword());
    }

    @After
    public void tearDown() throws Exception {

    }

    @Test
    public void testRegisterUser() throws Exception {

        proxy = getActionProxy("/user/registerUser.do");
        userAction = (UserAction) proxy.getAction();

        String result = proxy.execute();
        Assert.assertEquals("success", result);
    }

    @Test
    public void testDeleteUser() throws Exception {

        proxy = getActionProxy("/user/delete");
        userAction = (UserAction) proxy.getAction();

        String result = proxy.execute();
        Assert.assertEquals("success", result);
    }

    public void testLoadAll() throws Exception {
        proxy = getActionProxy("/user/loadAll.do");
        userAction = (UserAction) proxy.getAction();

        String result = proxy.execute();
        Assert.assertEquals("success", result);
    }

    public void testValidateUsername() throws Exception {
        proxy = getActionProxy("/user/isUsernameValid.do");
        userAction = (UserAction) proxy.getAction();

        String result = proxy.execute();
        Assert.assertEquals("success", result);
    }
}